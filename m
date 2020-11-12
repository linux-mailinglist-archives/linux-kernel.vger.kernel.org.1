Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8D2B07A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgKLOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:41066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgKLOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:38:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE479AFA7;
        Thu, 12 Nov 2020 14:38:04 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] mm, page_poison: use static key more efficiently
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
References: <20201103152237.9853-1-vbabka@suse.cz>
 <20201103152237.9853-3-vbabka@suse.cz>
 <796d64ea-5b40-b8a3-fb36-f15708e60d94@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c4eb5301-0435-d296-5d32-a76ac58787b2@suse.cz>
Date:   Thu, 12 Nov 2020 15:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <796d64ea-5b40-b8a3-fb36-f15708e60d94@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 4:38 PM, David Hildenbrand wrote:
> On 03.11.20 16:22, Vlastimil Babka wrote:
>> Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
>> changed page_poisoning_enabled() to a static key check. However, the function
>> is not inlined, so each check still involves a function call with overhead not
>> eliminated when page poisoning is disabled.
>> 
>> Analogically to how debug_pagealloc is handled, this patch converts
>> page_poisoning_enabled() back to boolean check, and introduces
>> page_poisoning_enabled_static() for fast paths. Both functions are inlined.
>> 
>> The function kernel_poison_pages() is also called unconditionally and does
>> the static key check inside. Remove it from there and put it to callers. Also
>> split it to two functions kernel_poison_pages() and kernel_unpoison_pages()
>> instead of the confusing bool parameter.
>> 
>> Also optimize the check that enables page poisoning instead of debug_pagealloc
>> for architectures without proper debug_pagealloc support. Move the check to
>> init_mem_debugging_and_hardening() to enable a single static key instead of
>> having two static branches in page_poisoning_enabled_static().
> 
> [...]
> 
>> + * For use in fast paths after init_mem_debugging() has run, or when a
>> + * false negative result is not harmful when called too early.
>> + */
>> +static inline bool page_poisoning_enabled_static(void)
>> +{
>> +	return (static_branch_unlikely(&_page_poisoning_enabled));
> 
> As already mentioned IIRC:

Yes, it was, and I thought I fixed it. Guess not.

> return static_branch_unlikely(&_page_poisoning_enabled);
> 
>> +}

>> @@ -1260,7 +1271,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>>   	if (want_init_on_free())
>>   		kernel_init_free_pages(page, 1 << order);
>>   
>> -	kernel_poison_pages(page, 1 << order, 0);
>> +	if (page_poisoning_enabled_static())
>> +		kernel_poison_pages(page, 1 << order);
> 
> This would look much better by having kernel_poison_pages() simply be
> implemented in a header, where the static check is performed.
> 
> Take a look at how it's handled in mm/shuffle.h
  
Ok. Fixup below.

----8<----

 From 7ce26ba61296f583f0f9089e7887f07424f25d2c Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 12 Nov 2020 15:20:58 +0100
Subject: [PATCH] mm, page_poison: use static key more efficiently-fix

Non-functional cleanups, per David Hildenbrand.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
  include/linux/mm.h | 16 +++++++++++++---
  mm/page_alloc.c    |  7 +++----
  mm/page_poison.c   |  4 ++--
  3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d6dd9f44571..861b9392b5dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2867,8 +2867,8 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
  
  extern void init_mem_debugging_and_hardening(void);
  #ifdef CONFIG_PAGE_POISONING
-extern void kernel_poison_pages(struct page *page, int numpages);
-extern void kernel_unpoison_pages(struct page *page, int numpages);
+extern void __kernel_poison_pages(struct page *page, int numpages);
+extern void __kernel_unpoison_pages(struct page *page, int numpages);
  extern bool _page_poisoning_enabled_early;
  DECLARE_STATIC_KEY_FALSE(_page_poisoning_enabled);
  static inline bool page_poisoning_enabled(void)
@@ -2881,7 +2881,17 @@ static inline bool page_poisoning_enabled(void)
   */
  static inline bool page_poisoning_enabled_static(void)
  {
-	return (static_branch_unlikely(&_page_poisoning_enabled));
+	return static_branch_unlikely(&_page_poisoning_enabled);
+}
+static inline void kernel_poison_pages(struct page *page, int numpages)
+{
+	if (page_poisoning_enabled_static())
+		__kernel_poison_pages(page, numpages);
+}
+static inline void kernel_unpoison_pages(struct page *page, int numpages)
+{
+	if (page_poisoning_enabled_static())
+		__kernel_unpoison_pages(page, numpages);
  }
  #else
  static inline bool page_poisoning_enabled(void) { return false; }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd7f9345adc0..1388b5939551 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1271,8 +1271,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
  	if (want_init_on_free())
  		kernel_init_free_pages(page, 1 << order);
  
-	if (page_poisoning_enabled_static())
-		kernel_poison_pages(page, 1 << order);
+	kernel_poison_pages(page, 1 << order);
+
  	/*
  	 * arch_free_page() can make the page's contents inaccessible.  s390
  	 * does this.  So nothing which can access the page's contents should
@@ -2281,8 +2281,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
  	if (debug_pagealloc_enabled_static())
  		kernel_map_pages(page, 1 << order, 1);
  	kasan_alloc_pages(page, order);
-	if (page_poisoning_enabled_static())
-		kernel_unpoison_pages(page, 1 << order);
+	kernel_unpoison_pages(page, 1 << order);
  	set_page_owner(page, order, gfp_flags);
  }
  
diff --git a/mm/page_poison.c b/mm/page_poison.c
index dd7aeada036f..4d75fc9ccc7a 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -30,7 +30,7 @@ static void poison_page(struct page *page)
  	kunmap_atomic(addr);
  }
  
-void kernel_poison_pages(struct page *page, int n)
+void __kernel_poison_pages(struct page *page, int n)
  {
  	int i;
  
@@ -89,7 +89,7 @@ static void unpoison_page(struct page *page)
  	kunmap_atomic(addr);
  }
  
-void kernel_unpoison_pages(struct page *page, int n)
+void __kernel_unpoison_pages(struct page *page, int n)
  {
  	int i;
  
-- 
2.29.1

