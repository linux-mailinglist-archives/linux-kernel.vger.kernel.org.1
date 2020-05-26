Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EEE1E1FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgEZKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgEZKeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:34:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98A59ACAC;
        Tue, 26 May 2020 10:34:22 +0000 (UTC)
Subject: Re: [PATCH v3 14/19] mm: memcg/slab: deprecate memcg_kmem_get_cache()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-15-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <25aaef88-ebad-0f11-14b8-fcfd1bb8ff2a@suse.cz>
Date:   Tue, 26 May 2020 12:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-15-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"deprecate" means it still exist but shouldn't get new callers, no?
maybe just "remove" or "inline ... into its caller"

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> The memcg_kmem_get_cache() function became really trivial, so
> let's just inline it into the single call point:
> memcg_slab_pre_alloc_hook().
> 
> It will make the code less bulky and can also help the compiler
> to generate a better code.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

