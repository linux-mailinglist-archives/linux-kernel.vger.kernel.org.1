Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1367B2F5C26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhANIHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C4E5239EF;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=TOaEzhVsXDVk1gO2cAsdiDzBnKmJqIHSPZHY9Jw5cok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQZmHxX7eKw68Hc8gmGSxF9o4kjNJxK8amZxff24u8wi4l4Gzk0NRTjrcxvn+heOX
         HzOuvTfirbcj9bZzh9QA6kPGVwZBnVJ8w41RRADSYOIMKHLNRojPhTKyBf9K8trMmX
         3E1WWKKmFDetgA0DQh3tZYkjRokJOgAJob45bP5jtHdXteFe5zFGGAJXQXTLKQ2J9W
         G87amplyCzrypDBRR9feDDEW4zBeMntQjaM8RlVJtnx1aA6ud9CfRSbPjjCLxLUDmj
         xCPExztl/dCgGk8hunKgq0HCE6Sm30Uj2JQQxWev2oa9VBlPYL6aC+Z6oZdDhvvqya
         L8RhpTQpj4jIQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ6g-1s; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v6 08/16] memblock: fix kernel-doc markups
Date:   Thu, 14 Jan 2021 09:04:44 +0100
Message-Id: <f3c65f61367993a607f9daf9dc1a3bdab1f0a040.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b93c44b9121e..9cc6da7b513e 100644
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
2.29.2

