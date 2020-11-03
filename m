Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA72A49A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgKCP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgKCP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B454C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:16 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c18so13166009wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfZrsuegqx+OmRO4GpwLy9Cb2wkLW2cpKd0ybvPvY8c=;
        b=FavDb9p/+6vVsi5kkU5BM2yQpZuZMCuDxbCNPZ3i2ikOvdmu9oq9Wh+VBTzxnjRzvP
         1iMendN7Uq0YKDs1reiHHl4zQn3OrDfwrCM4qs8hgBK/oa3nwgnJ6pDqcrm4O8ER7bsN
         mz0l2zEiXnVbgU5XQQViAXUfN3GxwCvg19E4iBGPaj+qZMFaYb3M9ngKgm6cOKI9U6lS
         pPFRLfZfnZhb9MGFuKkpzp377YE0q4oZ3J3LIs4MHROhnVzX7VIINTCasqDAQ/+j8HJX
         xGgHPPYizzw14MsJKLzCqBevf+rG0b6ONujwXxMJRCK0/XdcAJJNXw43SC3Zku3Esoqu
         88Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfZrsuegqx+OmRO4GpwLy9Cb2wkLW2cpKd0ybvPvY8c=;
        b=dCHGPXuSBoJwj6yl/mDsXzKKvFMOzm3Yqs+f1IulkUTDnT08figTXwbkzatFwiwZ5B
         P1Xl1dJBBaZfuYWOCMvFoU1GEa2mKAaxq2n+Eqi+Nhj6jWdX2k4bnnNa0N5SDkF0O5nA
         pZdBgvKME5RyvBVFTIPjgjQrrGc76x6pKs3ASKDg1wHTmLvrSUsY79HQaBbQPSU7pba8
         KsM2Q+SDvAeZz0+OWHYLHUMDG5i8f1MuRt2ij99DDOq6aJqUqDcIS6pMcOycZBf4PabG
         6nQUC8YR5Xg7aZky54AwcPzxLhdkDHF2P/MtiZHrmXC+vRbyx/zC2ApWyFjQERCFfoiY
         haNA==
X-Gm-Message-State: AOAM5305GDR9XY2X+cZKFr+ezzF9Ts4UHe9p9PVl8BEYDgCF18vriWrd
        M/cFR3H30H1oe6HBYnrxAKQe7A==
X-Google-Smtp-Source: ABdhPJzliMylxUcb30fC3RVeqyOpaETp603v3eHDKWTv3/UzCu2Bz6MbuvwQNgVnJm4Khpek01d44A==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr308897wme.65.1604417355037;
        Tue, 03 Nov 2020 07:29:15 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/25] soc: fsl: dpio: qbman-portal: Fix a bunch of kernel-doc misdemeanours
Date:   Tue,  3 Nov 2020 15:28:17 +0000
Message-Id: <20201103152838.1290217-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/fsl/dpio/qbman-portal.c:430: warning: Function parameter or member 'inhibit' not described in 'qbman_swp_interrupt_set_inhibit'
 drivers/soc/fsl/dpio/qbman-portal.c:430: warning: Excess function parameter 'mask' description in 'qbman_swp_interrupt_set_inhibit'
 drivers/soc/fsl/dpio/qbman-portal.c:518: warning: Function parameter or member 'd' not described in 'qbman_eq_desc_clear'
 drivers/soc/fsl/dpio/qbman-portal.c:529: warning: Function parameter or member 'respond_success' not described in 'qbman_eq_desc_set_no_orp'
 drivers/soc/fsl/dpio/qbman-portal.c:529: warning: Excess function parameter 'response_success' description in 'qbman_eq_desc_set_no_orp'
 drivers/soc/fsl/dpio/qbman-portal.c:941: warning: Function parameter or member 's' not described in 'qbman_swp_push_get'
 drivers/soc/fsl/dpio/qbman-portal.c:941: warning: Excess function parameter 'p' description in 'qbman_swp_push_get'
 drivers/soc/fsl/dpio/qbman-portal.c:955: warning: Function parameter or member 's' not described in 'qbman_swp_push_set'
 drivers/soc/fsl/dpio/qbman-portal.c:955: warning: Excess function parameter 'p' description in 'qbman_swp_push_set'
 drivers/soc/fsl/dpio/qbman-portal.c:1052: warning: Function parameter or member 'd' not described in 'qbman_pull_desc_set_fq'
 drivers/soc/fsl/dpio/qbman-portal.c:1065: warning: Function parameter or member 'd' not described in 'qbman_pull_desc_set_wq'
 drivers/soc/fsl/dpio/qbman-portal.c:1079: warning: Function parameter or member 'd' not described in 'qbman_pull_desc_set_channel'
 drivers/soc/fsl/dpio/qbman-portal.c:1403: warning: Function parameter or member 'd' not described in 'qbman_release_desc_clear'
 drivers/soc/fsl/dpio/qbman-portal.c:1412: warning: Function parameter or member 'd' not described in 'qbman_release_desc_set_bpid'
 drivers/soc/fsl/dpio/qbman-portal.c:1412: warning: Function parameter or member 'bpid' not described in 'qbman_release_desc_set_bpid'
 drivers/soc/fsl/dpio/qbman-portal.c:1421: warning: Function parameter or member 'd' not described in 'qbman_release_desc_set_rcdi'
 drivers/soc/fsl/dpio/qbman-portal.c:1421: warning: Function parameter or member 'enable' not described in 'qbman_release_desc_set_rcdi'

Cc: Roy Pledge <Roy.Pledge@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 659b4a570d5b5..f13da4d7d1c52 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -424,7 +424,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
 /**
  * qbman_swp_interrupt_set_inhibit() - write interrupt mask register
  * @p: the given software portal object
- * @mask: The mask to set in SWP_IIR register
+ * @inhibit: whether to inhibit the IRQs
  */
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
 {
@@ -510,7 +510,7 @@ enum qb_enqueue_commands {
 #define QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT     4
 #define QB_ENQUEUE_CMD_DCA_EN_SHIFT          7
 
-/**
+/*
  * qbman_eq_desc_clear() - Clear the contents of a descriptor to
  *                         default/starting state.
  */
@@ -522,7 +522,7 @@ void qbman_eq_desc_clear(struct qbman_eq_desc *d)
 /**
  * qbman_eq_desc_set_no_orp() - Set enqueue descriptor without orp
  * @d:                the enqueue descriptor.
- * @response_success: 1 = enqueue with response always; 0 = enqueue with
+ * @respond_success:  1 = enqueue with response always; 0 = enqueue with
  *                    rejections returned on a FQ.
  */
 void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
@@ -932,7 +932,7 @@ int qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
 
 /**
  * qbman_swp_push_get() - Get the push dequeue setup
- * @p:           the software portal object
+ * @s:           the software portal object
  * @channel_idx: the channel index to query
  * @enabled:     returned boolean to show whether the push dequeue is enabled
  *               for the given channel
@@ -947,7 +947,7 @@ void qbman_swp_push_get(struct qbman_swp *s, u8 channel_idx, int *enabled)
 
 /**
  * qbman_swp_push_set() - Enable or disable push dequeue
- * @p:           the software portal object
+ * @s:           the software portal object
  * @channel_idx: the channel index (0 to 15)
  * @enable:      enable or disable push dequeue
  */
@@ -1046,6 +1046,7 @@ void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
 
 /**
  * qbman_pull_desc_set_fq() - Set fqid from which the dequeue command dequeues
+ * @d:    the pull dequeue descriptor to be set
  * @fqid: the frame queue index of the given FQ
  */
 void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid)
@@ -1057,6 +1058,7 @@ void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid)
 
 /**
  * qbman_pull_desc_set_wq() - Set wqid from which the dequeue command dequeues
+ * @d:    the pull dequeue descriptor to be set
  * @wqid: composed of channel id and wqid within the channel
  * @dct:  the dequeue command type
  */
@@ -1071,6 +1073,7 @@ void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, u32 wqid,
 /**
  * qbman_pull_desc_set_channel() - Set channelid from which the dequeue command
  *                                 dequeues
+ * @d:    the pull dequeue descriptor to be set
  * @chid: the channel id to be dequeued
  * @dct:  the dequeue command type
  */
@@ -1398,6 +1401,7 @@ int qbman_result_has_new_result(struct qbman_swp *s, const struct dpaa2_dq *dq)
 /**
  * qbman_release_desc_clear() - Clear the contents of a descriptor to
  *                              default/starting state.
+ * @d: the pull dequeue descriptor to be cleared
  */
 void qbman_release_desc_clear(struct qbman_release_desc *d)
 {
@@ -1407,6 +1411,8 @@ void qbman_release_desc_clear(struct qbman_release_desc *d)
 
 /**
  * qbman_release_desc_set_bpid() - Set the ID of the buffer pool to release to
+ * @d:    the pull dequeue descriptor to be set
+ * @bpid: the bpid value to be set
  */
 void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid)
 {
@@ -1416,6 +1422,8 @@ void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid)
 /**
  * qbman_release_desc_set_rcdi() - Determines whether or not the portal's RCDI
  * interrupt source should be asserted after the release command is completed.
+ * @d:      the pull dequeue descriptor to be set
+ * @enable: enable (1) or disable (0) value
  */
 void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable)
 {
-- 
2.25.1

