Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75BB2730F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgIURl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIURl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:41:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF78C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:41:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so13686697wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJBvE0A2W0OTlrwgVJMiJqMH1jsisTtDfheWFrFevdk=;
        b=Mk8oxXVjBWstfqcdMc09xnyHcvLWcVVP6apT0fZ1+4yYrhwoKhwzDa9YQjAGUQg6wc
         gzD2MJVvLIha2BK135+vhf61x4eXDPgmlYx814XNs4ISswVtaLiL725EYR+VvpzYU1A+
         D3IVBlwl6Ls7SwY1YGf/sb/guZ9JUOFpcVzjt9n8mQIjdqy1olRgJ8K2oiqb4Fx801Py
         /Us/GNHGpXw0iJZifaWZT7rLs5Xe91gVQeOAH0AfzbAvx1hmaI9ydMR5gCAvFqP2HfSn
         n7SSqNjhFRn6kBRwwJbyv33nlG3EEhavTKnT3cWTjmQQY0lHLzjT2fK137t6OMWdQamQ
         fbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJBvE0A2W0OTlrwgVJMiJqMH1jsisTtDfheWFrFevdk=;
        b=XOPWOKKhOFD6LQZmYEVtGM7lY7OADSoAwB6RoRMiFSjv7UgNWf8sR6KqByiK+cyJpN
         NoSCrIZBxJQJnnvo9ovRxV+BjbBvxFbBbGFi5hUTOlPQep0slPmW5H1aN+RI4A+X+2xA
         OBXyrXRZet1wG9eedDztlK9m8CsW0KNb4vHtH89rMsBsP0yFpThtekZiJoNV3KB5Vh05
         NCXsR9ykyMHOwViXN147L7rR5iEQAGyRXIPPyXqgv90WukutCyByts8izdYeIPHD1os8
         fY1CAZel8Objcg2n7CysupRZpCqBrzYZlZwRf54Juivf4h9sIxHXYIHUZfztdYB5kUEt
         3Wlg==
X-Gm-Message-State: AOAM533Hzwevb+k0jwtDz0gnMMcYX+t2wyomWXUqErBrbGdWpiZzVlx3
        vkwK7/GAm2fxaRDKpmzF53adlchHpTLGyc48
X-Google-Smtp-Source: ABdhPJwi8CT2p/h0YeQ/9XzCEQ0SA2fuzhmf1Pi11eB9RCogqPc9Nu/f21jLgoLwrKslTwMyKcgh6A==
X-Received: by 2002:adf:e289:: with SMTP id v9mr956308wri.14.1600710084399;
        Mon, 21 Sep 2020 10:41:24 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id b11sm21538674wrt.38.2020.09.21.10.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:41:23 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <a.dewar@sussex.ac.uk>
Cc:     Alex Dewar <a.dewar@sussex.ac.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: hikey9xx: Fix incorrect assignement
Date:   Mon, 21 Sep 2020 18:41:13 +0100
Message-Id: <20200921174113.19566-1-a.dewar@sussex.ac.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hi3670_phy_probe(), when reading property tx-vboost-lvl fails, its
default value is assigned to priv->eye_diagram_param, rather than
priv->tx_vboost_lvl. Fix this.

Fixes: 8971a3b880b2 ("staging: hikey9xx: add USB physical layer for Kirin 3670")
Addresses-Coverity: CID 1497107: Incorrect expression (COPY_PASTE_ERROR)
Signed-off-by: Alex Dewar <a.dewar@sussex.ac.uk>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 42dbc20a0b9a..4fc013911a78 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -640,7 +640,7 @@ static int hi3670_phy_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(dev->of_node, "hisilicon,tx-vboost-lvl",
 				 &priv->tx_vboost_lvl))
-		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
+		priv->tx_vboost_lvl = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
 	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
 	if (IS_ERR(phy))
-- 
2.28.0

