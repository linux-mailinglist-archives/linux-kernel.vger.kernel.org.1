Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0B2A2CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgKBOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgKBOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52089C061A4A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g12so14801202wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8wKhzR7FJBQMiEnfCciYkFk4n5t6vlssgzVpAdB5/k=;
        b=db0MVFJWijauPlBzatrYmnHt5JzRud2OXRirPxM8zuMRIBJN0qdVDK10tG1UFZ+iXl
         gqyiXgQHszyEpISWYYOfDbupBX1fQ16nRaIsAMQutn0zj656UVfQv4RrvPF0gHRzSVC9
         eOBKSHJ4shspWcLWliEhxNDo1HFI21TQWc7IZYG2WcQwxQHKYFMW28xRrhWWs3tClsXJ
         NdCGJYmoliiOkdS6DQljVvsmqEBFOJKDQDKYGDbUPVcEPpETSIAKVcshHdPwQkcNoMtN
         avciAnCy044XrMYRCYzPpSeNCKGPaA7TppODaNN4tm6xX3K8TXB9uhrtkCP+gypuJpp8
         3T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8wKhzR7FJBQMiEnfCciYkFk4n5t6vlssgzVpAdB5/k=;
        b=MFrQv1Lw7VCn0+okJRtivvmwM8ctMluULxRbWOdPBUDStqdR8IIdrHcf8jFfig/7Z9
         vTh4EEB/B5ML070v3Tw9yBWozQ9B1x7DPSqMR2hbz9O7YAnh8HFn8TwYHopKKib2o+7J
         AZSum65CwjB/RNLgc5gx3lBPZYS3ZFXPukzdYL9eE2H9CYLmhJavcEUxx+s8bn/3rwrt
         Kj37ohEviHTytw+dGauxzdrLHiPdngq1V5vtWP5txduu5R0EGP5sP5TEIPWMPGzmzYKH
         JIMghG1pdalQdwrNl2dNx2b/u1EPxao7G92zKQoWqftLPg//HwbuDCrgxHpsJs8t4gIj
         a6uA==
X-Gm-Message-State: AOAM532Y29/OBdTQjveDsaCqxCPgRiXUHd9uezOtJ/L+8ELHAO8xypTL
        xhPGHMnOnmpLP+12tyVDyo+LUojFXUJVAQ==
X-Google-Smtp-Source: ABdhPJyg9OT5suipwrg1XnLxsISG6yruwE/0i8QZCwqrPdqHNiqDIuq5gMNXejSs1+p35tM7niZQNQ==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr19655645wrn.146.1604327060108;
        Mon, 02 Nov 2020 06:24:20 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [RESEND 13/19] scsi: esas2r: esas2r_int: Add brackets around potentially empty if()s
Date:   Mon,  2 Nov 2020 14:23:53 +0000
Message-Id: <20201102142359.561122-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_int.c: In function ‘esas2r_doorbell_interrupt’:
 drivers/scsi/esas2r/esas2r_int.c:692:22: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
 drivers/scsi/esas2r/esas2r_int.c: In function ‘esas2r_send_reset_ae’:
 drivers/scsi/esas2r/esas2r_int.c:868:44: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_int.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_int.c b/drivers/scsi/esas2r/esas2r_int.c
index f16d6bcf9bb6d..5281d93563275 100644
--- a/drivers/scsi/esas2r/esas2r_int.c
+++ b/drivers/scsi/esas2r/esas2r_int.c
@@ -688,8 +688,9 @@ static void esas2r_doorbell_interrupt(struct esas2r_adapter *a, u32 doorbell)
 		esas2r_local_reset_adapter(a);
 	}
 
-	if (!(doorbell & DRBL_FORCE_INT))
+	if (!(doorbell & DRBL_FORCE_INT)) {
 		esas2r_trace_exit();
+	}
 }
 
 void esas2r_force_interrupt(struct esas2r_adapter *a)
@@ -862,10 +863,11 @@ void esas2r_send_reset_ae(struct esas2r_adapter *a, bool pwr_mgt)
 	ae.byflags = 0;
 	ae.bylength = (u8)sizeof(struct atto_vda_ae_hdr);
 
-	if (pwr_mgt)
+	if (pwr_mgt) {
 		esas2r_hdebug("*** sending power management AE ***");
-	else
+	} else {
 		esas2r_hdebug("*** sending reset AE ***");
+	}
 
 	esas2r_queue_fw_event(a, fw_event_vda_ae, &ae,
 			      sizeof(union atto_vda_ae));
-- 
2.25.1

