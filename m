Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9652A2A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKBL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C306C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so3470185wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wt3lPJzwtefGpxth/KkqzzH7BRhJIilxCKkHD5PPJbE=;
        b=yJtKNC/+vjIEXWpBJJlefzTpMHwjxCx/gSMz+8mGIeLt1bkIi5vgePcwko4TNWuBGf
         FUUoK4je+xsnbBGTwQQPzz9Dfl2KtEP14aGLRjfC4y5EsyLgM4mo4UgKJKP+IqadJiV5
         rbHK9oZBP9mw1jkLc69lJoO/qOyXPZJrG3tbE4eRRZo3/if0LmMwgq/i0yy/o9Fn84hy
         bP+JSi5zV6rijSiNMZy5OtTrjFepZm5JAr+G7xt6I2aVot7dR4NmCwFb/RzucUJUMPJs
         FFWPRPsZ2WO+iBakwYW/rYNKbgHq0GyJ9Tjv+Xfr1TFfWPvpMc5a4UoU9mK7N5QcZTOT
         mo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt3lPJzwtefGpxth/KkqzzH7BRhJIilxCKkHD5PPJbE=;
        b=LT42T1kzSuoUt+7nLcJjfQCP1s3pbcfFdB2qWK3JWRAvAVhDgrtcM+FtaSXYF+6sJI
         4EzjiyyO7polTDnNILdLqNaNdE1HIAL9iLkjZ09y+wUKLghHL51UkGf8lK6wOy3MDhaT
         v5t/WcjOv3RYqxG2pAd+GVS6/b6UAuJbwFpkp2wFLoPs5hwl854Hr7irHyt4360Bpbvt
         5zGJW73Q7KVeN/GubkfYaSYdQa+78wkEypGMTcqTB1aSQOxHVISM8RCY20fpEflu0EB1
         29N/95Ai38Mrrra+5yHdVwTe+K4eH4jTXD6cm8fHZgAY9A2zWy8PfiAtaWAPYMjtUWBj
         SDgw==
X-Gm-Message-State: AOAM532czVnTXoNRxEUpDafbSUTAsMNplFgN6JVkq6n3493oDnuUvOPJ
        sAc627VW5WeHetiwTZI27CZ/cg==
X-Google-Smtp-Source: ABdhPJy/551pMLUTUdikrwamRX/HOMT1/2BIhn3rH3OST339y0arzTQV71FZrHxnVzPua44qp/ejaw==
X-Received: by 2002:a05:6000:345:: with SMTP id e5mr19017191wre.333.1604318252947;
        Mon, 02 Nov 2020 03:57:32 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 01/19] scsi: aic7xxx: aic79xx_osm: Remove unused variable 'saved_scsiid'
Date:   Mon,  2 Nov 2020 11:57:10 +0000
Message-Id: <20201102115728.1077697-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
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

