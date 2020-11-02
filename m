Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627F2A2A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKBL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgKBL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64611C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so4400114wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8LR5dZvOr6PkOQa4lRXQ4kxM6PQGBwW0R1DcsSPVnc=;
        b=Lg7rLM1jF18avAQHiwDIyeBK0r4I+R7UU2LQUI/sqkX9X+KgyZfO04AfkcFFE949DW
         POWREFJ+Xkwgc6REmbuex65rGGKedEC8vZHXoDW65U9vxxKmOIXs5/LK+K1IdjfuHegd
         mxqLglDjUfYtK2jfMxQPTZlYvP0vrTMHzMZYzZpXLHSy62FunyKRmdZSHes8Sh8ni7P2
         calPYuhTjcF6mel8r2KPT9mEvXyJwq2v9l5vbXBcdwU/EyHQv9hXLMqb9465CYwr9KTB
         XJBhKLReLH8TcpuLl7361V/DpzTP8gxbBMS4qenx813p98//utfweE1vcLyPwRYvi0is
         VO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8LR5dZvOr6PkOQa4lRXQ4kxM6PQGBwW0R1DcsSPVnc=;
        b=bsBZHoJvFHBEx2/KuFJeoX77NqZcaFTZE1ogexPRuI06ZQLHU0ZumTj5yDajVVwlSq
         HNlCMzwz5TeZj3DGYG93J7XSDBTNJU4/i8ndKyUjU193iuJMLDr0EM03ObcdErlFdbNn
         IRmOW3YVmBifu5FqJsC8C/evrTz0XIx2Uy/b0i8sa1MGgnYG2TGFjPlVzmyEL99ABX5S
         139qSBOQ5NnXk+Y6Lz2tCLtPp9O2K8CPZfCYmsAWX4+LErA7CS1a6N+HRQfUjbhV7frb
         kbmayoCObox84O7BGQOUlGzSV/+cVTxK4TM76ZlDJYmS4JtaxXs3MZAErLwyKh+9LC7Y
         scoA==
X-Gm-Message-State: AOAM531mYLECPe7FH751CsmkgV5I/fOVvLcGVErSJ1w3MXz5tdnJYMuA
        OCikp9/933LbsKkTupWaCVBrB7jWRQQ/CA==
X-Google-Smtp-Source: ABdhPJywfD3UqYJd2jOLF4naA9Eo6IwRsR1h+HSa0WNLtP+hXYBciMX2OLHDm6cMBfrgEG98AD9rRA==
X-Received: by 2002:a05:600c:288:: with SMTP id 8mr6739448wmk.106.1604318257102;
        Mon, 02 Nov 2020 03:57:37 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 04/19] scsi: lpfc: lpfc_attr: Demote kernel-doc format for redefined functions
Date:   Mon,  2 Nov 2020 11:57:13 +0000
Message-Id: <20201102115728.1077697-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc does not understand this use-case.

Fixes the following W=1 kernel build warning(s):

 from drivers/scsi/lpfc/lpfc_attr.c:26:
 inlined from ‘lpfc_stat_data_ctrl_store’ at drivers/scsi/lpfc/lpfc_attr.c:4164:3:
 drivers/scsi/lpfc/lpfc_attr.c:2315: warning: Excess function parameter 'dev' description in 'lpfc_param_show'
 drivers/scsi/lpfc/lpfc_attr.c:2315: warning: Excess function parameter 'buf' description in 'lpfc_param_show'
 drivers/scsi/lpfc/lpfc_attr.c:2343: warning: Excess function parameter 'dev' description in 'lpfc_param_hex_show'
 drivers/scsi/lpfc/lpfc_attr.c:2343: warning: Excess function parameter 'buf' description in 'lpfc_param_hex_show'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Function parameter or member 'attr' not described in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Function parameter or member 'default' not described in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Function parameter or member 'minval' not described in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Function parameter or member 'maxval' not described in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Excess function parameter 'phba' description in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2377: warning: Excess function parameter 'val' description in 'lpfc_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Function parameter or member 'attr' not described in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Function parameter or member 'default' not described in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Function parameter or member 'minval' not described in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Function parameter or member 'maxval' not described in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Excess function parameter 'phba' description in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2414: warning: Excess function parameter 'val' description in 'lpfc_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2454: warning: Excess function parameter 'dev' description in 'lpfc_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2454: warning: Excess function parameter 'buf' description in 'lpfc_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2454: warning: Excess function parameter 'count' description in 'lpfc_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2478: warning: Excess function parameter 'dev' description in 'lpfc_vport_param_show'
 drivers/scsi/lpfc/lpfc_attr.c:2478: warning: Excess function parameter 'buf' description in 'lpfc_vport_param_show'
 drivers/scsi/lpfc/lpfc_attr.c:2503: warning: Excess function parameter 'dev' description in 'lpfc_vport_param_hex_show'
 drivers/scsi/lpfc/lpfc_attr.c:2503: warning: Excess function parameter 'buf' description in 'lpfc_vport_param_hex_show'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Function parameter or member 'attr' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Function parameter or member 'default' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Function parameter or member 'minval' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Function parameter or member 'maxval' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Excess function parameter 'phba' description in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2536: warning: Excess function parameter 'val' description in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Function parameter or member 'attr' not described in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Function parameter or member 'default' not described in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Function parameter or member 'minval' not described in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Function parameter or member 'maxval' not described in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Excess function parameter 'phba' description in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2572: warning: Excess function parameter 'val' description in 'lpfc_vport_param_set'
 drivers/scsi/lpfc/lpfc_attr.c:2607: warning: Function parameter or member 'attr' not described in 'lpfc_vport_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2607: warning: Excess function parameter 'cdev' description in 'lpfc_vport_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2607: warning: Excess function parameter 'buf' description in 'lpfc_vport_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:2607: warning: Excess function parameter 'count' description in 'lpfc_vport_param_store'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Function parameter or member 'field' not described in 'lpfc_rport_show_function'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Function parameter or member 'format_string' not described in 'lpfc_rport_show_function'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Function parameter or member 'sz' not described in 'lpfc_rport_show_function'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Function parameter or member 'cast' not described in 'lpfc_rport_show_function'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Excess function parameter 'cdev' description in 'lpfc_rport_show_function'
 drivers/scsi/lpfc/lpfc_attr.c:7081: warning: Excess function parameter 'buf' description in 'lpfc_rport_show_function'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_attr.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 0673d944c2a81..6a33f0607cc8b 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1501,6 +1501,7 @@ lpfc_sli4_pdev_status_reg_wait(struct lpfc_hba *phba)
 /**
  * lpfc_sli4_pdev_reg_request - Request physical dev to perform a register acc
  * @phba: lpfc_hba pointer.
+ * @opcode: The sli4 config command opcode.
  *
  * Description:
  * Request SLI4 interface type-2 device to perform a physical register set
@@ -2284,7 +2285,7 @@ lpfc_enable_bbcr_set(struct lpfc_hba *phba, uint val)
 	return -EINVAL;
 }
 
-/**
+/*
  * lpfc_param_show - Return a cfg attribute value in decimal
  *
  * Description:
@@ -2310,7 +2311,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
 			phba->cfg_##attr);\
 }
 
-/**
+/*
  * lpfc_param_hex_show - Return a cfg attribute value in hex
  *
  * Description:
@@ -2338,7 +2339,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
 			phba->cfg_##attr);\
 }
 
-/**
+/*
  * lpfc_param_init - Initializes a cfg attribute
  *
  * Description:
@@ -2372,7 +2373,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
 	return -EINVAL;\
 }
 
-/**
+/*
  * lpfc_param_set - Set a cfg attribute value
  *
  * Description:
@@ -2409,7 +2410,7 @@ lpfc_##attr##_set(struct lpfc_hba *phba, uint val) \
 	return -EINVAL;\
 }
 
-/**
+/*
  * lpfc_param_store - Set a vport attribute value
  *
  * Description:
@@ -2449,7 +2450,7 @@ lpfc_##attr##_store(struct device *dev, struct device_attribute *attr, \
 		return -EINVAL;\
 }
 
-/**
+/*
  * lpfc_vport_param_show - Return decimal formatted cfg attribute value
  *
  * Description:
@@ -2473,7 +2474,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
 	return scnprintf(buf, PAGE_SIZE, "%d\n", vport->cfg_##attr);\
 }
 
-/**
+/*
  * lpfc_vport_param_hex_show - Return hex formatted attribute value
  *
  * Description:
@@ -2498,7 +2499,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
 	return scnprintf(buf, PAGE_SIZE, "%#x\n", vport->cfg_##attr);\
 }
 
-/**
+/*
  * lpfc_vport_param_init - Initialize a vport cfg attribute
  *
  * Description:
@@ -2531,7 +2532,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
 	return -EINVAL;\
 }
 
-/**
+/*
  * lpfc_vport_param_set - Set a vport cfg attribute
  *
  * Description:
@@ -2567,7 +2568,7 @@ lpfc_##attr##_set(struct lpfc_vport *vport, uint val) \
 	return -EINVAL;\
 }
 
-/**
+/*
  * lpfc_vport_param_store - Set a vport attribute
  *
  * Description:
@@ -7061,7 +7062,7 @@ lpfc_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout)
 #endif
 }
 
-/**
+/*
  * lpfc_rport_show_function - Return rport target information
  *
  * Description:
-- 
2.25.1

