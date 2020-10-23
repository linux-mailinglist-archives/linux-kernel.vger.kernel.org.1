Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E23297456
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463359AbgJWQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929A2246CB;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=tFmwNM29Z4/PfnBG2iHx1y5DHZMj6Vv1utRUWGfTh9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jMPhZPV3Dyl8Cacs6hSQpNHuacf27C8Ndlq+KGfckWwDB5sWSvRGCsHfFxBrh7bn
         X+hlmAjXZKxYd2Z35qaiVJ5PHhYkNA3Av7zQGm4c02Wr3bPehlB8/+8joBsIllY2nn
         Lddk8RiB4lzjf+Nz+l316w1MygYQ/DKDBF8jHSwY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxW-Hi; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 47/56] memblock: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:34 +0200
Message-Id: <90f921afef8f60498a997a4a243bcf839b9142ca.1603469755.git.mchehab+huawei@kernel.org>
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
 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ef131255cedc..95fe3cb71c54 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -272,7 +272,7 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 				  unsigned long *out_spfn,
 				  unsigned long *out_epfn);
 /**
- * for_each_free_mem_range_in_zone - iterate through zone specific free
+ * for_each_free_mem_pfn_range_in_zone - iterate through zone specific free
  * memblock areas
  * @i: u64 used as loop variable
  * @zone: zone in which all of the memory blocks reside
@@ -292,7 +292,7 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
 
 /**
- * for_each_free_mem_range_in_zone_from - iterate through zone specific
+ * for_each_free_mem_pfn_range_in_zone_from - iterate through zone specific
  * free memblock areas from a given point
  * @i: u64 used as loop variable
  * @zone: zone in which all of the memory blocks reside
-- 
2.26.2

