Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A494E295FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506974AbgJVNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442635AbgJVNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:22:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3FAC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:22:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so2274464ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/457KlRttwTbzW2IPZucxg6Xez470vGxov79DYd6XzE=;
        b=DIYpmXMqF2xG6qhoXcFf/CXetkWZcoj4lqmNFIAU3y7IxDegLJsSR9LOgdUoOKNvdb
         dNIMvAjwEVKc3WOUY/6HQ5tmbGSkhyQYwaWwFcCuebtPfNKAjt3wGkgC451xlcPYcW33
         jNW8QdWzZE60r6fFIa+LR7kmOte3AtGpOPcINRaHktSigQaWCq1jFflisDVp5CMmaOg4
         clPmoyalzrgw2Bciu/nv6QF3tGgvJvy4hAYhpQn3oi0pQW34rFD5TKcnwoNYfqmj8Yhx
         jj3LGrkwsQUc3bYviYoBEvBn+MRSKEdAxaU0KTAnQY3suNH2sV7SiBTnbs8OspjKump6
         aYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/457KlRttwTbzW2IPZucxg6Xez470vGxov79DYd6XzE=;
        b=XXsRYPY4h7tj1yRYa7n0vF/IoWpUKpvEoiYzPV3rapVgn2hnX1co79JcwGC84PNLlq
         QZ/0YFIjoQgqi7KjyXE7/M3gxTo3Td2kjMp0m597cbSVAp+ni8NG2PBuuhhqjj/zMFFc
         0iV7RIlIjycz3VOoEVAuqWziqAodvcI3RbL5u1/Axcu01TmB8vjzsuJLmT0RT9MldoF0
         tqjHz66o4NbdRrpbiJlwP19fWqW1dolRGJ7YPsRdYSs2o11fn5C9G5CQP2KLLMPBOh5y
         Gs9OmTB9HR+mmLsBI0TJVSEldjRAsFWkOKgjs7EJ+OkQeDEHHdRRKmXw3/xui/IFZZvB
         YyMw==
X-Gm-Message-State: AOAM533ZSItEgC2sufNN0IyFYpDNa7rlpAY11wmF6s/hYqksYe1BJ0VO
        QaZu8Dog2LtQNOgZfqE6RmI=
X-Google-Smtp-Source: ABdhPJyf0SYXMG5Nh6sn3hgkUvvD/GfkrjrIskyaIJwYEVu2Fh8zj2L3JDitzFqucn0CN4+hwnbHIQ==
X-Received: by 2002:a17:906:3406:: with SMTP id c6mr2074952ejb.65.1603372941235;
        Thu, 22 Oct 2020 06:22:21 -0700 (PDT)
Received: from localhost.localdomain ([185.200.214.168])
        by smtp.gmail.com with ESMTPSA id ok21sm909368ejb.96.2020.10.22.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:22:20 -0700 (PDT)
From:   izabela.bakollari@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Izabela Bakollari <izabela.bakollari@gmail.com>
Subject: [PATCH] staging/wlan-ng: Fix line alignment
Date:   Thu, 22 Oct 2020 15:22:18 +0200
Message-Id: <20201022132218.235744-1-izabela.bakollari@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Izabela Bakollari <izabela.bakollari@gmail.com>

Fix code alignment. Issue reported by checkpatch.pl

Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index a908ff301707..1bd36dc2b7ff 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1198,8 +1198,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 			if (wlandev->netdev->type == ARPHRD_ETHER) {
 				/* Save macport 0 state */
 				result = hfa384x_drvr_getconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  &hw->presniff_port_type);
+								  HFA384x_RID_CNFPORTTYPE,
+								  &hw->presniff_port_type);
 				if (result) {
 					netdev_dbg
 					(wlandev->netdev,
-- 
2.18.4

