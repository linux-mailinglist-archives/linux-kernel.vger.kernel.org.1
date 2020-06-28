Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CEA20C946
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgF1Rhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 13:37:33 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:44342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgF1Rhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:37:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B07C6100E7B43;
        Sun, 28 Jun 2020 17:37:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4385:5007:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:12986:13019:13069:13141:13153:13228:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trade85_0d0653126e68
X-Filterd-Recvd-Size: 2324
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Jun 2020 17:37:30 +0000 (UTC)
Message-ID: <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
Subject: Re: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
From:   Joe Perches <joe@perches.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 28 Jun 2020 10:37:29 -0700
In-Reply-To: <20200628152500.17916-1-brgl@bgdev.pl>
References: <20200628152500.17916-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-28 at 17:25 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Memory allocated with kstrdup_const() must not be passed to regular
> krealloc() as it is not aware of the possibility of the chunk residing
> in .rodata. Since there are no potential users of krealloc_const()
> at the moment, let's just update the doc to make it explicit.

Another option would be to return NULL if it's
used from krealloc with a pointer into rodata
---
 mm/slab_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 37d48a56431d..f8b49656171b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1683,6 +1683,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
  * @new_size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  *
+ * If the object pointed to is in rodata (likely from kstrdup_const)
+ * %NULL is returned.
+ *
  * The contents of the object pointed to are preserved up to the
  * lesser of the new and old sizes.  If @p is %NULL, krealloc()
  * behaves exactly like kmalloc().  If @new_size is 0 and @p is not a
@@ -1694,6 +1697,9 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
 
+	if (unlikely(is_kernel_rodata((unsigned long)p)))
+		return NULL;
+
 	if (unlikely(!new_size)) {
 		kfree(p);
 		return ZERO_SIZE_PTR;



