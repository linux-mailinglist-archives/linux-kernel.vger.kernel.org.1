Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26C82FAD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbhARWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389241AbhARWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:41:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C4C0617BA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so10667913wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41jrK8tqpJECnYanwp1YJTyb0GhdE88NeiFiFexYn+U=;
        b=CmlNVxQTCIQV4c/g3Ja3Hok8QLIdmpZDAnVm0XuGvNaIgSUSZjGd84XCU0VsGqKlXy
         G4lP1Z1qM/sJylS6BcxYWG/fK7cW+Aw4sUaLhvTBFikXESyzkgAldft3TgS3JZQlTTA9
         ov0YudSg4IQeZ2+68uvxL0ZE5h2QibWmf9u/8Fr4Is6K1LPaTTmQNBwglE50qhKXhWSe
         YyYc/OVf48k395xsPG161hOABYLcKMNgJ1mFR5tD9NUJ8W6DhEO1hJvflEB5lSP8zMB1
         04TsoyUgIejk1PLb05irwtWyYqstkDesep0lSKs+my+bxL7H53EaH5mTls9iYGgrCak5
         eMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41jrK8tqpJECnYanwp1YJTyb0GhdE88NeiFiFexYn+U=;
        b=K70VZW3cfeU7bIGkm5RsfuahDHOaofHVo4d8I7a2a247SaiNfPIsL38PDZuplj9F3F
         ivZzM2/NvBFCR8IVYA3/A4+ndZuxOsnA2q9rZlyRp+16/HONWa1PvCe+hw0SO45Mrirz
         Z3MDQzK/b8nTXslYPcStBlhuLfcP71U0aatGDTOEqf3FByJeQHFtxlP/4sZry/7cXrLX
         lCX8WsyKrUKdfDLiNO/c7WDvRla7jXwuUdrd4lywRVEGhaq0r7wWbc8u1wYx85gjoH4q
         4KZm5+qapacX5Ux6QoNcGGx8jkrr6nns47apLzPC4nI5TaJGm/c5GacLLsfLc4yoCYD0
         DiyA==
X-Gm-Message-State: AOAM531CcORPWWUDhMGCe0CiD5dI6pNVi7PAXh0FLsIGtlG8XD/wFukB
        QzIbyIS3OObJq11MEiCdaNv7TA==
X-Google-Smtp-Source: ABdhPJw24QWYWrJDsRVFCliI3DWdja/CEmJlCTNupjTyNdIeFxS7crWd6U6n5VSX2PBTrVXeBUpf+A==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr1398112wrt.324.1611009591755;
        Mon, 18 Jan 2021 14:39:51 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 17/20] RDMA/hw/i40iw/i40iw_verbs: Fix worthy function headers and demote some others
Date:   Mon, 18 Jan 2021 22:39:26 +0000
Message-Id: <20210118223929.512175-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_verbs.c:273: warning: Excess function parameter 'iwdev' description in 'i40iw_free_qp_resources'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:273: warning: Excess function parameter 'qp_num' description in 'i40iw_free_qp_resources'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:307: warning: Function parameter or member 'udata' not described in 'i40iw_destroy_qp'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:348: warning: Function parameter or member 'iwdev' not described in 'i40iw_setup_virt_qp'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:348: warning: Function parameter or member 'iwqp' not described in 'i40iw_setup_virt_qp'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:348: warning: Excess function parameter 'dev' description in 'i40iw_setup_virt_qp'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:348: warning: Excess function parameter 'qp' description in 'i40iw_setup_virt_qp'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1248: warning: Function parameter or member 'pg_size' not described in 'i40iw_check_mem_contiguous'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1264: warning: Function parameter or member 'pg_size' not described in 'i40iw_check_mr_contiguous'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1539: warning: Function parameter or member 'sg_offset' not described in 'i40iw_map_mr_sg'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1886: warning: Function parameter or member 'udata' not described in 'i40iw_dereg_mr'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1953: warning: Function parameter or member 'dev' not described in 'hw_rev_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1953: warning: Function parameter or member 'attr' not described in 'hw_rev_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1953: warning: Function parameter or member 'buf' not described in 'hw_rev_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1967: warning: Function parameter or member 'dev' not described in 'hca_type_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1967: warning: Function parameter or member 'attr' not described in 'hca_type_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1967: warning: Function parameter or member 'buf' not described in 'hca_type_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1977: warning: Function parameter or member 'dev' not described in 'board_id_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1977: warning: Function parameter or member 'attr' not described in 'board_id_show'
 drivers/infiniband/hw/i40iw/i40iw_verbs.c:1977: warning: Function parameter or member 'buf' not described in 'board_id_show'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 65aedfe57e776..f18d146a6079f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -265,9 +265,7 @@ static struct i40iw_pbl *i40iw_get_pbl(unsigned long va,
 
 /**
  * i40iw_free_qp_resources - free up memory resources for qp
- * @iwdev: iwarp device
  * @iwqp: qp ptr (user or kernel)
- * @qp_num: qp number assigned
  */
 void i40iw_free_qp_resources(struct i40iw_qp *iwqp)
 {
@@ -302,6 +300,7 @@ static void i40iw_clean_cqes(struct i40iw_qp *iwqp, struct i40iw_cq *iwcq)
 /**
  * i40iw_destroy_qp - destroy qp
  * @ibqp: qp's ib pointer also to get to device's qp address
+ * @udata: user data
  */
 static int i40iw_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
@@ -338,8 +337,8 @@ static int i40iw_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 /**
  * i40iw_setup_virt_qp - setup for allocation of virtual qp
- * @dev: iwarp device
- * @qp: qp ptr
+ * @iwdev: iwarp device
+ * @iwqp: qp ptr
  * @init_info: initialize info to return
  */
 static int i40iw_setup_virt_qp(struct i40iw_device *iwdev,
@@ -1241,7 +1240,7 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr *iwmr,
  * i40iw_check_mem_contiguous - check if pbls stored in arr are contiguous
  * @arr: lvl1 pbl array
  * @npages: page count
- * pg_size: page size
+ * @pg_size: page size
  *
  */
 static bool i40iw_check_mem_contiguous(u64 *arr, u32 npages, u32 pg_size)
@@ -1258,7 +1257,7 @@ static bool i40iw_check_mem_contiguous(u64 *arr, u32 npages, u32 pg_size)
 /**
  * i40iw_check_mr_contiguous - check if MR is physically contiguous
  * @palloc: pbl allocation struct
- * pg_size: page size
+ * @pg_size: page size
  */
 static bool i40iw_check_mr_contiguous(struct i40iw_pble_alloc *palloc, u32 pg_size)
 {
@@ -1533,6 +1532,7 @@ static int i40iw_set_page(struct ib_mr *ibmr, u64 addr)
  * @ibmr: ib mem to access iwarp mr pointer
  * @sg: scatter gather list for fmr
  * @sg_nents: number of sg pages
+ * @sg_offset: scatter gather offset
  */
 static int i40iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 			   int sg_nents, unsigned int *sg_offset)
@@ -1881,6 +1881,7 @@ static void i40iw_del_memlist(struct i40iw_mr *iwmr,
 /**
  * i40iw_dereg_mr - deregister mr
  * @ib_mr: mr ptr for dereg
+ * @udata: user data
  */
 static int i40iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 {
@@ -1945,7 +1946,7 @@ static int i40iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	return 0;
 }
 
-/**
+/*
  * hw_rev_show
  */
 static ssize_t hw_rev_show(struct device *dev,
@@ -1959,7 +1960,7 @@ static ssize_t hw_rev_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(hw_rev);
 
-/**
+/*
  * hca_type_show
  */
 static ssize_t hca_type_show(struct device *dev,
@@ -1969,7 +1970,7 @@ static ssize_t hca_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(hca_type);
 
-/**
+/*
  * board_id_show
  */
 static ssize_t board_id_show(struct device *dev,
-- 
2.25.1

