Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B22279C84
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIZU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIZU6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 16:58:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA439C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 13:58:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b19so5232533lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSixzCSVf28NxB381KlZA+nsw0dTwRpnXRNrARV7Z3k=;
        b=bDeeCKu+fnyDcFrcqmfb8fjrzmoODoOopSIagZR4qzOmd4DcrGAiEKbywnDVcvCQ9n
         CAkdpYJZ7TvMasls1vFrd3Is324oIXR7hJO4DpmHmSG1JlSz/KK2FBG3RAH5ubTvp6Ea
         0u6bY0kvF9DROsawBvZ4JgA8QIa6VDhdlNaW8JOuUnYJSlAxz/W4vVoJ/oV/1oO8S9RF
         tGoMU3v6gd1JOLAyEbTQ+MFw3Gsn+cR5mxyTqXx8LmbyjAziSSEqISXgwzZl0hMQGdii
         dmjDYKnh4Ae4YrkH36buakQOSsiLeLFRMo1zEqrIS8FvyNTvhXFFU6nRioO0YgVYFjWO
         axAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSixzCSVf28NxB381KlZA+nsw0dTwRpnXRNrARV7Z3k=;
        b=qnN5eRddaeD6jZc0RcvI3mK3GqTlACiKlGlRWt37pID+gzFcmJf87auv5XF2NaG8oA
         1L0oGvajU2+ydVSuBTyCh+AmoPfbvzkWDSQp4xUkeQv6YUwL4eEnWXb5KqLfXWceK06K
         Tn59pQKbuksjqtqFVH+NLOidKxNPKWTq9B9lFKa8SZ4jxe/Duy4nQLlSlnNben/lL/4/
         SSN1N+gSKEVshkkDO6p7uLI9lPXkjepYyUTIozQNgw6lrEUh2me2566ZZ+Xrm1Ce+CTU
         Ba9g00bNkqFteJx222CPaRhpWOTDunngp56uYkKoTWdnxkZeprqO6Tr4MLtNkqhfCh3+
         1RwQ==
X-Gm-Message-State: AOAM531x9iGqxQaQh6f3r1Y9vQlXedCdtwAvYnVNNiYk/VRq8yZX3/Yg
        CpVtk5r5MX5+vbN1Gw9WLts=
X-Google-Smtp-Source: ABdhPJw/RWxh9jYW490oL/7YNScw8E5Bk8K6AB62R64LPa2Xx8nsbKDezA7/oBYVv0zBHFEtSlHAbA==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr3326346ljk.9.1601153930192;
        Sat, 26 Sep 2020 13:58:50 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id b7sm2100775lfi.123.2020.09.26.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 13:58:49 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Jun <jun.li@nxp.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] phy: fsl-imx8mq-usb: Constify imx8mp_usb_phy_ops
Date:   Sat, 26 Sep 2020 22:58:44 +0200
Message-Id: <20200926205844.34218-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of imx8mp_usb_phy_ops is to assign its address to the
data field in the of_device_id struct, which is a const void pointer.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index 62d6d6849ad6..47a0c09bc9fa 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -131,7 +131,7 @@ static const struct phy_ops imx8mq_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static struct phy_ops imx8mp_usb_phy_ops = {
+static const struct phy_ops imx8mp_usb_phy_ops = {
 	.init		= imx8mp_usb_phy_init,
 	.power_on	= imx8mq_phy_power_on,
 	.power_off	= imx8mq_phy_power_off,
-- 
2.28.0

