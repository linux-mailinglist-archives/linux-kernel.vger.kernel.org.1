Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459BC2A2CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKBOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKBOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D4C061A4A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so1151892wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wt3lPJzwtefGpxth/KkqzzH7BRhJIilxCKkHD5PPJbE=;
        b=c26/VTOQ58vAsDiS1Vsz3KlTbK0BTgeqF+Q5twhuB7TzHIvKWJfFdc9xEBJ4f01cWf
         KHIO9qPNW1uffiaMTqPO2cm3L+vj4FLm/W7I/CtbG1ahJkEokn7zYbkuOBczRx4x5CrS
         xfk3y04A0O5A/gKN5fGcFlzaj9BBIrCznuKk1yHcyM0Aq7xp6BeYMdasuTLluCbhi7if
         x3l9D8u/OSTdB6G/S9Wwxea7zXUajOc9SIvn/as2cgFQ1NY9NGOLWYGM398O85Ze1OnC
         vpkLuhvoADtDV3s2gGesqsblops16f51DVS6r/18uommFBCYOHzpvH6knaCchjjTInoH
         m4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt3lPJzwtefGpxth/KkqzzH7BRhJIilxCKkHD5PPJbE=;
        b=KsH2W5z1QuPrpIlkr982X8FoUEiPaVkKWrfZKhH1J1CO7MbQm9VQdGL5/MpW8l16+7
         KRtsZ8/7clb5fWZm8XZtu2Sh82/2XAALp8rvfE+FrHmsPuJmqHoTzdBA2d6sPkeh6LS/
         bhj9kY0lwXSHVI8LxFWAe21kk7pS/l4yMwAkI3DoQBGPIB9ysuB89S9fbQuuCeS8xE4/
         H/cD4AQZewb2hy1tA31iQCrgV6jIRg8cbjJAEtMFAE0baDkn4U5Ll0/8sQvyOVERsM3n
         fUFQo95jMK9HNmUklfDseBLVbj9De9PSUG03MOfcMmY1rA9c6C2RW/ud3JYU5Qs4kOiI
         kDbA==
X-Gm-Message-State: AOAM533JYt8pIiVUHcpq28+d9/RAK+NXUGIOHA2uHBVijIM0XwMZpaTy
        7+tFXozNqtcStOtJQxJcy0TYmg==
X-Google-Smtp-Source: ABdhPJxdQFgpDB63CTFLtIuoJH4zQOZBwaIrU/WkK1h0ikmbxG2XFdjLlAUtx4tF+4YcpgjnxaL4dw==
X-Received: by 2002:a7b:ce05:: with SMTP id m5mr19074687wmc.16.1604327042997;
        Mon, 02 Nov 2020 06:24:02 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [RESEND 01/19] scsi: aic7xxx: aic79xx_osm: Remove unused variable 'saved_scsiid'
Date:   Mon,  2 Nov 2020 14:23:41 +0000
Message-Id: <20201102142359.561122-2-lee.jones@linaro.org>
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

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_linux_queue_abort_cmd’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:2143:9: warning: variable ‘saved_scsiid’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index f32398939f74b..d413b1c5fdc54 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -2140,7 +2140,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	u_int  saved_scbptr;
 	u_int  active_scbptr;
 	u_int  last_phase;
-	u_int  saved_scsiid;
 	u_int  cdb_byte;
 	int    retval = SUCCESS;
 	int    was_paused;
@@ -2254,7 +2253,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	 * passed in command.  That command is currently active on the
 	 * bus or is in the disconnected state.
 	 */
-	saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
+	ahd_inb(ahd, SAVED_SCSIID);
 	if (last_phase != P_BUSFREE
 	    && SCB_GET_TAG(pending_scb) == active_scbptr) {
 
-- 
2.25.1

