Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7056B2EF4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhAHPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:31:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:50618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbhAHPbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:31:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D110FAD89;
        Fri,  8 Jan 2021 15:30:20 +0000 (UTC)
Subject: Re: [PATCH mm,percpu_ref,rcu 3/6] mm: Make mem_dump_obj() handle
 vmalloc() memory
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106011750.13709-3-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <375d4a14-45ad-8917-8484-9806bd07f355@suse.cz>
Date:   Fri, 8 Jan 2021 16:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106011750.13709-3-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 2:17 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds vmalloc() support to mem_dump_obj().  Note that the
> vmalloc_dump_obj() function combines the checking and dumping, in
> contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> The reason for the difference is that the checking in the vmalloc()
> case involves acquiring a global lock, and redundant acquisitions of
> global locks should be avoided, even on not-so-fast paths.
> 
> Note that this change causes on-stack variables to be reported as
> vmalloc() storage from kernel_clone() or similar, depending on the degree
> of inlining that your compiler does.  This is likely more helpful than
> the earlier "non-paged (local) memory".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
