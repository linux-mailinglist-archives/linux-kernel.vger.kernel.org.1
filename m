Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3E21D119
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGMIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgGMIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5081C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so14702758wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXWcsoi+xGgOcFmbeWP75diSxyhw0hWfzUHSepxSy6k=;
        b=g5RssAEyVWSu9L06I2k7D7WofbgEQJ8+Fjgyt22YJ6NMm0i+3Pac++WSxZ543qhSQJ
         f1b4YPSM40MFF6z2/hcBwuZ2YZ5SkVFzJZzXrAMYkxdzxogel0GfMUq7rx9Jvn7o1ZJp
         NtDW9QxqFGW7sAmX8FZx6NfNtvJJkuGQbZpFxupI9x/VqMQaBFlmnrnDs4CEIzaBE5eM
         e0J5uMapfLs1KlPpwS6JA123vI6gkoqlYP76ByAefa/FOJkUtevNR6buaCTVZGfKufZL
         xfz6sTNyu2HZjmKnrhKM3cjc1Tf5hFB+SYpG7KhwpYOTz3bvOCSYBpVcDH69EsdNtaHj
         NjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXWcsoi+xGgOcFmbeWP75diSxyhw0hWfzUHSepxSy6k=;
        b=jmD5MHye2KZtRHxeY1YQ4cDtoheXGwLWbnMZ22OuNLdOfDKJLgPxOM6hIlRGrniGqL
         HXFmZnCZoBbcQur8DRXBKoQD5fBdaS3MxCXursrJaE6EdHiifuPXD6ootiWAD0jaPnts
         3eRhuIqUvg8pbFXQIcOvK3eQViTaW782q8MvjDwue1l6xY6by4ssTWrzagg26qBWbtoz
         Ye5Qzx4JvfFRw3ZNQUjfpPQVHOCR+3qx/RwuS7wDNBzE+KEvx9RL8nb53e/qW+hS//Rd
         K/ptAU89mp7Z8uD1+rS4OJCh9yf6siiwa1LsHb2zNvHaOrV0q0NWDpzEkaUNE4tzSUIt
         /Jag==
X-Gm-Message-State: AOAM532C7lC9PJXGgUH6B9lJIShqpvCA+Nzs8WUKdmQ585XgD18sCKYg
        Za6r3yMcHSnucF/Dxy5k1WCUug==
X-Google-Smtp-Source: ABdhPJxqykD8o0/phKKoeJIkLjItJFiDczyKzoE0Ute9/ydr3zPlOOtyOXeU04TUfen5sVewovO+7Q==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr78388722wro.151.1594627233468;
        Mon, 13 Jul 2020 01:00:33 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 23/24] scsi: aic7xxx: aic79xx_osm: Fix 'amount_xferred' set but not used issue
Date:   Mon, 13 Jul 2020 09:00:00 +0100
Message-Id: <20200713080001.128044-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'amount_xferred' is used, but only in certain circumstances.  Place
the same stipulations on the defining/allocating of 'amount_xferred'
as is placed when using it.

We've been careful not to change any of the ordering semantics here.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_done’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:1796:12: warning: variable ‘amount_xferred’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 8e43ff86e0a60..3782a20d58885 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1787,10 +1787,12 @@ ahd_done(struct ahd_softc *ahd, struct scb *scb)
 	 */
 	cmd->sense_buffer[0] = 0;
 	if (ahd_get_transaction_status(scb) == CAM_REQ_INPROG) {
+#ifdef AHD_REPORT_UNDERFLOWS
 		uint32_t amount_xferred;
 
 		amount_xferred =
 		    ahd_get_transfer_length(scb) - ahd_get_residual(scb);
+#endif
 		if ((scb->flags & SCB_TRANSMISSION_ERROR) != 0) {
 #ifdef AHD_DEBUG
 			if ((ahd_debug & AHD_SHOW_MISC) != 0) {
-- 
2.25.1

