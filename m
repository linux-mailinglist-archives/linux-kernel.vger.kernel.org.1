Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C926D80D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIQJsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:48:12 -0400
Received: from gentwo.org ([3.19.106.255]:48240 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQJsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:48:08 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id B22FE3F0AD; Thu, 17 Sep 2020 09:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id AFE5B3F0AB;
        Thu, 17 Sep 2020 09:40:09 +0000 (UTC)
Date:   Thu, 17 Sep 2020 09:40:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Marco Elver <elver@google.com>
cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        paulmck@kernel.org, andreyknvl@google.com, aryabinin@virtuozzo.com,
        luto@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        cai@lca.pw, tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/10] mm, kfence: insert KFENCE hooks for SLUB
In-Reply-To: <20200915132046.3332537-6-elver@google.com>
Message-ID: <alpine.DEB.2.22.394.2009170938030.1492@www.lameter.com>
References: <20200915132046.3332537-1-elver@google.com> <20200915132046.3332537-6-elver@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020, Marco Elver wrote:

>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
>  {
> -	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
> +	void *ret = slab_alloc(s, gfpflags, _RET_IP_, s->object_size);

The additional size parameter is a part of a struct kmem_cache that is
already passed to the function. Why does the parameter list need to be
expanded?

