Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278329747A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbgJWQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA49246B0;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=jeh4YC+MxwGcd5mb9mDgW+smzNJeeNqLiKDD0oaDL0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dp5HB/65JaGeWDQP2R/ITfNqB1n/bHLrckWbFxT5Bp9FOnlfGcjRGyEKH0DGZtaQP
         0QJIH6hjUZqRVe4jOzmY6HVrR+JwJ7wapnt/ZbDverJRmvQrYY23iK8+xDjbgIK0TD
         Mgfqtra+eUaq0iZWCMK5wW6w2jiKd0IFMRzUEUtU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Awp-5N; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 33/56] vme: fix two kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:20 +0200
Message-Id: <51bfb6724975302f66d64e4ad71de451a7cbbf99.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/vme/vme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vme/vme.c b/drivers/vme/vme.c
index b398293980b6..bb4fed52f74d 100644
--- a/drivers/vme/vme.c
+++ b/drivers/vme/vme.c
@@ -73,7 +73,7 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
 }
 
 /**
- * vme_free_consistent - Allocate contiguous memory.
+ * vme_alloc_consistent - Allocate contiguous memory.
  * @resource: Pointer to VME resource.
  * @size: Size of allocation required.
  * @dma: Pointer to variable to store physical address of allocation.
@@ -647,7 +647,7 @@ int vme_master_get(struct vme_resource *resource, int *enabled,
 EXPORT_SYMBOL(vme_master_get);
 
 /**
- * vme_master_write - Read data from VME space into a buffer.
+ * vme_master_read - Read data from VME space into a buffer.
  * @resource: Pointer to VME master resource.
  * @buf: Pointer to buffer where data should be transferred.
  * @count: Number of bytes to transfer.
-- 
2.26.2

