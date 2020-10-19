Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34877292E10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgJSTEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730871AbgJSTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BNebSzKa24Vd+I/nEx9yjLMrhbD2Rzt4FX+UGJijfis=;
        b=E8AhZ1fjGH2p8zUC2gVDEUWHqh+V4DZH4aNaD/GK9w9pswl0wLmHuQHcrlYU69QTteu88C
        MlsgCeK298b1Zz41bUW3RhJc1xfTD5kjsBaMONC5nm8d3Yxv9I3WP5ZzE0vYnb+gyBX7ou
        qWw497nEBnC1YakFhHLEgeiTNOq+FBo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-UL8XeajkNf-lg7kMSCBlUg-1; Mon, 19 Oct 2020 15:04:35 -0400
X-MC-Unique: UL8XeajkNf-lg7kMSCBlUg-1
Received: by mail-qk1-f198.google.com with SMTP id s14so417861qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BNebSzKa24Vd+I/nEx9yjLMrhbD2Rzt4FX+UGJijfis=;
        b=GaQSGOST8IqW24DDwd1K9ND5tx9DLkS5u8m8/MYUkgAEdlzfzFem0OOxVrZIuDtHZT
         Z9OOiv29Uj/c/lbzcguEPy5ZYA1vBHtxYF2/i/SRsmHXJvYeaGfDfcQ4yKZcE87J4q4+
         GBQaINYzBI5eRN4vXrMBqVUTCjzm2hK9drWMiiOkr7WbZsbbksMibghWuLPjadVIeQAJ
         YuHqu6dfxF+Y2O/dSNYQQrOzfrKZ6LygrM7CBmvLPabwK7rca/KGODTfC5BWtQeAWkiy
         +XNufzmhBaZBP2K5yya0m64Pit4VXULInfkGmmt/C+DQ8brb1dD6PPQALzJo1c6mV0Yn
         XlyA==
X-Gm-Message-State: AOAM530D7/LF0hMRqlvJ0MVU9IqqOrEmpM8bKVhoB+r52UyJEm41eEM7
        iwvygqjLp2XK0kFTad5v4d8ekc1M+3bCx+2PoIYPoH6jK79v3/iZJeyF4ucZpwwe6hIWVVqam3t
        E2HOO2PzhROVVpkRmy15u94lB
X-Received: by 2002:a05:620a:110f:: with SMTP id o15mr1089459qkk.86.1603134274596;
        Mon, 19 Oct 2020 12:04:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsvFnGYA6/V12A5HT/qy7T29vsPsa7OWyG0NuExIzbt5nxxVicTk6e6xyaEkXkWMmPQRYaqQ==
X-Received: by 2002:a05:620a:110f:: with SMTP id o15mr1089436qkk.86.1603134274362;
        Mon, 19 Oct 2020 12:04:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 68sm390030qkg.108.2020.10.19.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:04:33 -0700 (PDT)
From:   trix@redhat.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nvdimm: remove unneeded break
Date:   Mon, 19 Oct 2020 12:04:29 -0700
Message-Id: <20201019190429.8165-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvdimm/claim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 5a7c80053c62..2f250874b1a4 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -202,7 +202,6 @@ ssize_t nd_namespace_store(struct device *dev,
 	default:
 		len = -EBUSY;
 		goto out_attach;
-		break;
 	}
 
 	if (__nvdimm_namespace_capacity(ndns) < SZ_16M) {
-- 
2.18.1

