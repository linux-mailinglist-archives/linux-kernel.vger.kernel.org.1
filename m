Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB582BB322
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgKTS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgKTS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:29:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12D8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:29:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t21so8011575pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N15Wx4yPAF1ZjMoXxRjftfe4swNFWdxESC1Deg9Y2g=;
        b=dOCe3Ipl/wx+Z3/+BY9rlRgUiTu5p2kfssR1hzyO8Eg5zF/5fkEvMF4KxSv+wpZl0i
         mG11B6mtrtXMHdELaCxdTmEB2ZjKL5HZWMsGbPBOgN7J8TEf48GZ4VUD+62LPZ+Pq98Q
         NDwx7CcEDt1vtCLIFe2THhT4bo4rWIOR1yk5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N15Wx4yPAF1ZjMoXxRjftfe4swNFWdxESC1Deg9Y2g=;
        b=CuzQtzgFDwJruznjt0+FGzXxXly2d1lL1HwV5bMAoNpa9zEdezghMcIA8L2G4MTYY+
         /Q0shI0XSAatJNiupIvJwXLa1rSqe22ol9QzspajJLvm0RlQ86xb42JDvRoBSid5R411
         FzDq2V/MuFNanNkGiez8oGZzEr3wt7/hISJpoBEKVTURMF62sxMFMmR3t+ytH7ovxntY
         +APuXSxK5gHb6+vrGqhrmHIy+GMC6WvyrHmdKyT/lAkp+4b7OO3t8eQqj9RoGdNIzoez
         9FKw+S/E/CnIi7ItXwrW+ERKyZjFII4O+JgSSSixWdic2AkjgHQ7RT6B6oW45ue+3FWP
         XL2Q==
X-Gm-Message-State: AOAM533S1joM/sDlKznDXdCtshJc58ISCnAHO93GIsuMcdC55qpc85jc
        qlBiIFk1W6Ut1kOsAsmLUCETXQ==
X-Google-Smtp-Source: ABdhPJzL6FUeUZfitrligElk2wS/ih4PFzTQOaPxcI+reGkSKaDgzUKQHt+QROgjwXYB4dS0ltqoMQ==
X-Received: by 2002:a65:6857:: with SMTP id q23mr14847335pgt.77.1605896986498;
        Fri, 20 Nov 2020 10:29:46 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id y188sm4515155pfy.98.2020.11.20.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:29:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
Date:   Fri, 20 Nov 2020 10:29:44 -0800
Message-Id: <20201120182944.543428-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DT property can be 0, 16, and then 64, but not 32. The math here
doesn't recognize this slight bump in the power of 2 numbers and
translates a DT property of 64 into the register value '3' when it
really should be '2'. Fix it by subtracting one more if the number being
translated is larger than 16.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
 * Changed ternary to consider 17 to 31 as the same as 16

 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..ee1b4ff05a37 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		if (ret)
 			break;
 
-		pos = min(max(ilog2(pos), 3), 10) - 3;
+		pos = min(max(ilog2(pos), 3), 11) - (pos >= 32 ? 4 : 3);
 		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
 					   pos);

base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d
-- 
https://chromeos.dev

