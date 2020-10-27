Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C529C85A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829403AbgJ0THT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:07:19 -0400
Received: from m12-17.163.com ([220.181.12.17]:34092 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2902408AbgJ0THT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mEweC
        mt22E7HtZLqqnDVM3+F4KShMEJihMB8YkEVp50=; b=Aty8GcfNm5mnErMNWfpvk
        AJpcCL/5OAwhb7uzpxUqyCPZCVlTRsu6LuCRIZOJFAVBIQCZWLLHRbsiFMGCLvIs
        mYNAlAT8o0baSNbQUoOootlwSlAndmRyn4iQfYPDEc3xxpfA7eMur6h6shrjw8at
        ybgHgm7vMEfleU549XOLQU=
Received: from localhost (unknown [101.86.209.121])
        by smtp13 (Coremail) with SMTP id EcCowACXJRLJb5hf0bLkQA--.9970S2;
        Wed, 28 Oct 2020 03:06:49 +0800 (CST)
Date:   Wed, 28 Oct 2020 03:06:49 +0800
From:   Hui Su <sh_def@163.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/list_lru: optimize condition of exiting the loop
Message-ID: <20201027190649.GA67829@rlk>
References: <20201027170420.GA61326@rlk>
 <ae359cb8-5bf9-c2e5-ddd0-812df81de0fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae359cb8-5bf9-c2e5-ddd0-812df81de0fb@suse.cz>
X-CM-TRANSID: EcCowACXJRLJb5hf0bLkQA--.9970S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur43Aw1xuw4UKFy5Kw17KFg_yoWDArcE9r
        9YvFn29a15CrWSgFsFgrn3ArZ5Wr48WFykJF9rJr1Dtry7Za4jg3ZxWF1DXrykWFWfXryU
        Xw18Ar18uw1UtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8fWrJUUUUU==
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgnKX1SIqoT7igAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:45:53PM +0100, Vlastimil Babka wrote:
> On 10/27/20 6:04 PM, Hui Su wrote:
> > In list_lru_walk(), nr_to_walk type is 'unsigned long',
> > so nr_to_walk won't be '< 0'.
> > 
> > In list_lru_walk_node(), nr_to_walk type is 'unsigned long',
> > so *nr_to_walk won't be '< 0' too.
> > 
> > We can use '!nr_to_walk' instead of 'nr_to_walk <= 0', which
> > is more precise.
> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> 
> OK. Why not this too?
> 
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -294,7 +294,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> 
>         isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
>                                       nr_to_walk);
> -       if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> +       if (*nr_to_walk && list_lru_memcg_aware(lru)) {
>                 for_each_memcg_cache_index(memcg_idx) {
>                         struct list_lru_node *nlru = &lru->node[nid];
> 
> 

Thanks for your fast reply.

I did not notice that, and i would add this to my change.
I will resend PATCH V2, and cc to you.

Thanks.

