Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322C2CC1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgLBQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgLBQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:17:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7EC061A49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:16:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o1so4627203wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6zxn0ciPWvecDtaO/9pXlIMYf7CJlzucbFrKBsiNoc=;
        b=PFKmsM+rz5pWrC4hyjIRpp8wEsGNnX/2pKUjgW2vAioOJIULwPqBNsJOCGOmPppTpw
         PCUogDdRtoz2bhUWAoS8n6d1pxSLzYy2WWT3Lgc5QNAWItCq9vHBPVWrAlW9G9zlS6bp
         mbMcibpUMzJu3rgchGXRqYuzLOGZr4hHGloqAkCGh5M3QzhK5rhilYPIK0gj4N4Ttmnj
         kOlH80A0HaC4MPv8FZhxVY62hePGvx3m/hwNVAZTsw2Vminw3/mFF3LDNDz8GbFZM+FC
         DatoYsLK0ReGk/6GPxUsFSGJ7NTYneBJcAtAWDpydPcqVlSU9rJN/+Tw2jwY/a12R9Ts
         4TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6zxn0ciPWvecDtaO/9pXlIMYf7CJlzucbFrKBsiNoc=;
        b=CEoyescH7Y8CFxt4oD8o0EiyLmCRCR0SXJztyt8dgg545PxGm6SRkif99ON6pT5b9v
         9KAgJY9/3SekX87H7UapF27MRqzlKpy4O1SeMvPPwOAv2E7jED41dYrxXYCC8LiwP+Hf
         fspzAuauBVO2MdSXGS3ZVDT/4WCi2GVJLdIahDqt2wpJnLCKQsP4wc2/iRBm3XzPIaQb
         kgzOFsazUupSZO9lS52LJeMxlgHLl1JTGtI46esOhf4xoJr+6zOzuMe6t4qjubJm2nPW
         8cgxhQRC+skIcJleCG5raB687ixjqektm16l2X0pjcXu4J8nlnFDPyqdtkWtTMBEEY8U
         Fl0g==
X-Gm-Message-State: AOAM532cjpoAEqdSKcVt3pD6tJQtdaKy5Pnf+1xSiVmXrO7bSF6hcUoP
        zO4ZHQY7ajrpC3fnuHPIQA+Uvw==
X-Google-Smtp-Source: ABdhPJxLVNrN068k/FAiywPaBvuF1gJQ5HzHKm2PZFAwrFFYiA4prYxgNUk7lacSuz099v1rYPAy0A==
X-Received: by 2002:adf:f181:: with SMTP id h1mr4305130wro.267.1606925779573;
        Wed, 02 Dec 2020 08:16:19 -0800 (PST)
Received: from belels006.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id s4sm2644505wru.56.2020.12.02.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:16:19 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 4/4] net: freescale/fman: remove fman_get_mem_region
Date:   Wed,  2 Dec 2020 17:16:00 +0100
Message-Id: <20201202161600.23738-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202161600.23738-1-patrick.havelange@essensium.com>
References: <20201202161600.23738-1-patrick.havelange@essensium.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is no longer used, so we can remove it.
The pointer to the resource that was kept inside
struct fman_state_struct can also be removed for the same reason.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 17 -----------------
 drivers/net/ethernet/freescale/fman/fman.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 2e85209d560d..bf78e12a1683 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -531,8 +531,6 @@ struct fman_state_struct {
 
 	u32 qman_channel_base;
 	u32 num_of_qman_channels;
-
-	struct resource *res;
 };
 
 /* Structure that holds FMan initial configuration */
@@ -1737,7 +1735,6 @@ static int fman_config(struct fman *fman)
 	fman->state->qman_channel_base = fman->dts_params.qman_channel_base;
 	fman->state->num_of_qman_channels =
 		fman->dts_params.num_of_qman_channels;
-	fman->state->res = fman->dts_params.res;
 	fman->exception_cb = fman_exceptions;
 	fman->bus_error_cb = fman_bus_error;
 	fman->fpm_regs = fman->dts_params.base_addr_pol + FPM_OFFSET_FROM_POL;
@@ -2405,20 +2402,6 @@ u32 fman_get_qman_channel_id(struct fman *fman, u32 port_id)
 }
 EXPORT_SYMBOL(fman_get_qman_channel_id);
 
-/**
- * fman_get_mem_region
- * @fman:	A Pointer to FMan device
- *
- * Get FMan memory region
- *
- * Return: A structure with FMan memory region information
- */
-struct resource *fman_get_mem_region(struct fman *fman)
-{
-	return fman->state->res;
-}
-EXPORT_SYMBOL(fman_get_mem_region);
-
 /* Bootargs defines */
 /* Extra headroom for RX buffers - Default, min and max */
 #define FSL_FM_RX_EXTRA_HEADROOM	64
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index e6b339c57230..e326aa37b8b2 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -398,8 +398,6 @@ int fman_set_mac_max_frame(struct fman *fman, u8 mac_id, u16 mfl);
 
 u32 fman_get_qman_channel_id(struct fman *fman, u32 port_id);
 
-struct resource *fman_get_mem_region(struct fman *fman);
-
 u16 fman_get_max_frm(void);
 
 int fman_get_rx_extra_headroom(void);
-- 
2.17.1

