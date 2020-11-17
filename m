Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9C2B68D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKQPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:37:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:58520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKQPhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:37:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CF0FAC23;
        Tue, 17 Nov 2020 15:37:53 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:37:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2 4/8] powerpc/mm: protect linear mapping modifications
 by a mutex
Message-ID: <20201117153750.GD15987@linux>
References: <20201111145322.15793-1-david@redhat.com>
 <20201111145322.15793-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111145322.15793-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:53:18PM +0100, David Hildenbrand wrote:
> @@ -144,7 +147,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
>  	start = (unsigned long)__va(start);
>  	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>  
> +	mutex_lock(&linear_mapping_mutex);
>  	ret = remove_section_mapping(start, start + size);
> +	mutex_unlock(&linear_mapping_mutex);
>  	WARN_ON_ONCE(ret);

My expertise in this area is low, so bear with me.

Why we do not need to protect flush_dcache_range_chunked and
vm_unmap_aliases?

-- 
Oscar Salvador
SUSE L3
