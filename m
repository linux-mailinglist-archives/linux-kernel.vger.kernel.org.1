Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D7B281B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbgJBTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:01:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E7C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:01:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so1452803pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qGhYscDpEEa9PdABAysmonDoSUGqxjnc8Si89+1YgF8=;
        b=UwJ1R9X9cruSJ100MEq4odEmrwwOPv4UU+KRVMz6xqhG9XYepjHn5l22WuSFvomDTU
         ItZyodn330C47DFgv5wnrXnwZP5nHCIXX/nOkD1Fpg/ZVyBh+6RJfNyCNBXarvyMER49
         rFwanOCk3QAIePhQsHU4RudtDnZt7YPePxzaXo72VQMBDnamxBxcN7K2NTkDcsP6Yjw1
         VlD18IPaTQA9I/umLwz3d+bHWjzJz/QH8Ht32fi5H3qir6SSmoPCt154Muv24szcrJOX
         yboP2w24NybGi4Ui7OkPq+xwl1cRWmTngUTyjokazHBqTXLZ8RzR2nttNGaQntE6qS+a
         bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qGhYscDpEEa9PdABAysmonDoSUGqxjnc8Si89+1YgF8=;
        b=PN4J3mRTn8FZjUHKzzitKGpm5Z4KDUbQkm9PKLwSGldiAZamJtO19v9VvgKZjtbPqm
         CMlKjgOusikVZKJWgVZPJqsgvytjniPGfEgVZ8JzPitpDNQaZNTmIUNytOykNKhJ80po
         SbhmWm08qVPwx2/x1rJWM/zk13jew0XKLQ+fW2sTKIkEA1IFcX9iIcL+xpEI+RJxxpjg
         A82uzrZ2+uFiPYUcNRuupoOKq50+Fk/WhpupAlm18l8h7GiTAhqgljOR59WiTDv0z/55
         RLzwgRIAI1NS8C40CcrgVA1PQLU11fry3WUGc1086P98inJdbbcNoDy8XDNWPz0IfKYM
         s19w==
X-Gm-Message-State: AOAM53315ONZ+zJRGT/v0K4ueQsBjqbtXIRKXyk/QO2yhNvpCYPbOt8U
        5zivXnL7+ewA8l/yE7fpQqANApaniHE=
X-Google-Smtp-Source: ABdhPJx1xGPQ5P5S7KssFqMwmeq11Sud+tSQnhJU18nHVHtuTtoMfx+IvS/4BuDYXck7AYePD8JG6w==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr4342034pjq.69.1601665299402;
        Fri, 02 Oct 2020 12:01:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 134sm2836954pfa.93.2020.10.02.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:01:38 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] phy: usb: Fix incorrect clearing of tca_drv_sel bit in SETUP reg for 7211
Date:   Fri,  2 Oct 2020 15:01:15 -0400
Message-Id: <20201002190115.48017-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 7211a0 has a tca_drv_sel bit in the USB SETUP register that
should never be enabled. This feature is only used if there is a
USB Type-C PHY, and the 7211 does not have one. If the bit is
enabled, the VBUS signal will never be asserted. In the 7211a0,
the bit was incorrectly defaulted to on so the driver had to clear
the bit. In the 7211c0 the state was inverted so the driver should
no longer clear the bit. This hasn't been a problem because all
current 7211 boards don't use the VBUS signal, but there are some
future customer boards that may use it.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 456dc4a100c2..e63457e145c7 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -270,11 +270,6 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 	reg |= params->mode << USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT;
 	brcm_usb_writel(reg, usb_phy + USB_PHY_UTMI_CTL_1);
 
-	/* Fix the incorrect default */
-	reg = brcm_usb_readl(ctrl + USB_CTRL_SETUP);
-	reg &= ~USB_CTRL_SETUP_tca_drv_sel_MASK;
-	brcm_usb_writel(reg, ctrl + USB_CTRL_SETUP);
-
 	usb_init_common(params);
 
 	/*
-- 
2.17.1

