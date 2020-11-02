Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E382A2A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKBL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:37 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B000FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e2so9230568wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRHYymPZSeiW3b0Obvxms+pRftWjvOHGSla0h5dK+wA=;
        b=awZhfRs9R2hUKroVPJWg0t04ksNDD0/GktyFn/YfAnhpI4ry5Ad08CG5ee8DUYC9Cm
         F0Ac9rCqG0yZyIcdkyH2guEeZGah/oYc0fFi9EmCEu5oVdSNCMlytN0oPkbQBbXqQbyN
         EW1Jjh7a+zORYtafdOuigRyWcfVa0HC/yPuX0/xOmHSixw71/+Ohe2CF9zoK5NPx8IGj
         HB9ocJJOijOhfY0yiC2unHyofkukPYK54jAwPPIcxizDpqw0vn8qW+vYBM2xA8UXlXht
         Hmx0xSOCRwc+vRjOR7SJhmXZ5IJA3WUKV59sGbNOckLrAapUseORg+WXN+rAtGUv2WB5
         reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRHYymPZSeiW3b0Obvxms+pRftWjvOHGSla0h5dK+wA=;
        b=fx/831wQUF75CJG0aXaHG2j1O5wsQHncGDHX8kV+3HsA5dxaylzPTfubHdIDoPT58M
         mv+eu2qdc0MTCI67NsSRybq++xY5E7uX60Pa3g+9v7itvJ7SD5UUyjfWxG1S1neltA6N
         MyKy6Cjke/fGzhJWsLLd6evJAUjAwtth3PbOCvzU9nCotyz37Hqwq4eInr5kkfSRL/5k
         B636b59lqwu+GZfwDVTioDLm24X00ENB0w90xuk3fRYcrNp9JqRPunjiRyf/wmCFtg3+
         AuMCD0TAvZgq2TXsuCQFeBVo4RiqJ9AoP10Bz6Wbpi/Zp9Whliq90lzQVOmcTo35gl+I
         sXuw==
X-Gm-Message-State: AOAM5338mwVT00jnCbkr5hv4SjFrKGFW1P5K1jwAMqnL96KfHHrk3Per
        7x5ure2biQNs87CWLUuZpg8LmQ==
X-Google-Smtp-Source: ABdhPJzDtZBTLLWpnZiw2NpMc7zfV/gtEFlh4EeQGQWDhSyv6a4D2Dz/vnRaw9DHi9iG62eKBDL3eg==
X-Received: by 2002:a1c:a7ce:: with SMTP id q197mr7154570wme.138.1604318254485;
        Mon, 02 Nov 2020 03:57:34 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@avagotech.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH 02/19] scsi: mpt3sas: mpt3sas_scsih: Fix function documentation formatting
Date:   Mon,  2 Nov 2020 11:57:11 +0000
Message-Id: <20201102115728.1077697-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2778: warning: Function parameter or member 'ioc' not described in 'scsih_tm_cmd_map_status'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2778: warning: Function parameter or member 'channel' not described in 'scsih_tm_cmd_map_status'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2829: warning: Function parameter or member 'ioc' not described in 'scsih_tm_post_processing'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2829: warning: Function parameter or member 'channel' not described in 'scsih_tm_post_processing'

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@avagotech.com
Cc: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 5f845d7094fcc..f01983dc73703 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2762,8 +2762,8 @@ mpt3sas_scsih_clear_tm_flag(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 
 /**
  * scsih_tm_cmd_map_status - map the target reset & LUN reset TM status
- * @ioc - per adapter object
- * @channel - the channel assigned by the OS
+ * @ioc: per adapter object
+ * @channel: the channel assigned by the OS
  * @id: the id assigned by the OS
  * @lun: lun number
  * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in mpi2_init.h)
@@ -2808,9 +2808,9 @@ scsih_tm_cmd_map_status(struct MPT3SAS_ADAPTER *ioc, uint channel,
 
 /**
  * scsih_tm_post_processing - post processing of target & LUN reset
- * @ioc - per adapter object
+ * @ioc: per adapter object
  * @handle: device handle
- * @channel - the channel assigned by the OS
+ * @channel: the channel assigned by the OS
  * @id: the id assigned by the OS
  * @lun: lun number
  * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in mpi2_init.h)
-- 
2.25.1

