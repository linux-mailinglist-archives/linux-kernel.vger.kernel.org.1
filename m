Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDC2E354C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 10:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgL1JFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 04:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgL1JFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 04:05:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 01:04:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 30so2295798pgr.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4pAM+KZPcorEeEY52d8nlRr19UO6jcGAcFxkVXndac=;
        b=Q0q/Ga+Nxl+3FRZgGiLxoEgOGgwiSNoS3EbH3cbyl+E0gQ7GJLAkpv/ZNUp2DuRnZh
         c7JaTDTi6Jcrtdo5bby8PAXpJsATseq5v3CWrgtaVJNHH8vi4G/xtXPWxXhyjRWONizp
         6rFkdMqbF9G8k+I0VvApIg/HinLERWVH9zkTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4pAM+KZPcorEeEY52d8nlRr19UO6jcGAcFxkVXndac=;
        b=pnoPN3El3vehROK6avsMcHh7LTMGrNqsc46Nk1v9dTMS4fOvnIazPphkelwK/uqEUD
         rFU72ad8NQW8e3c4+5BpM5MU7knSCE5Z5/uJtHKdIe5fLJLsIlrjrpwSVkOTFdI/uYqJ
         Fv0WQJJpdlq62K2IPawYrk4eW9tIVOLBtuf6t4RwFGw3S255zmXrX4CgxsTsurhQI08a
         +TOcE5UX2Gj2kLK/SgxWN8chxQDxOCM/DJT+qHOgwRoNtd1xHXBCukArpDifRaFtNGC4
         H9azCtWnZ2k8FKSw45OmJymJXKNOn4fmC+p10FHkledl+sJFL5fOI4vp/MVXzL6YvFo5
         GQPQ==
X-Gm-Message-State: AOAM531dhvX8PStm5N3cDyB/QEBWscrymEjjp9DdUvZuRowctWSaPi0v
        +fg4L9NQSKhf8qRSp9Ir00/i5hdiNxsQUw==
X-Google-Smtp-Source: ABdhPJxt6FqRzO1S7YUjyHUwrV8TLbMVa6hCRDhCOqzEtTJ899Q8c45+FCd78FI7imT744QJSdl6hQ==
X-Received: by 2002:a63:e049:: with SMTP id n9mr42750637pgj.339.1609146270214;
        Mon, 28 Dec 2020 01:04:30 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id h10sm31496329pfn.213.2020.12.28.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 01:04:29 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] pinctrl: mediatek: Fix fallback call path
Date:   Mon, 28 Dec 2020 17:04:25 +0800
Message-Id: <20201228090425.2130569-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs, eg. mt8183, are using a pinconfig operation bias_set_combo.
The fallback path in mtk_pinconf_adv_pull_set() should also try this
operation.

Fixes: cafe19db7751 ("pinctrl: mediatek: Backward compatible to previous Mediatek's bias-pull usage")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 7aeb552d16ce9..72f17f26acd80 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -920,6 +920,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 			err = hw->soc->bias_set(hw, desc, pullup);
 			if (err)
 				return err;
+		} else if (hw->soc->bias_set_combo) {
+			err = hw->soc->bias_set_combo(hw, desc, pullup, arg);
+			if (err)
+				return err;
 		} else {
 			return -ENOTSUPP;
 		}
-- 
2.29.2.729.g45daf8777d-goog

