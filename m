Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56234217404
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGGQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 12:34:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgGGQeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:34:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1906AC12;
        Tue,  7 Jul 2020 16:34:08 +0000 (UTC)
Subject: Re: [PATCH v4 06/11] mm/migrate: make a standard migration target
 allocation function
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <409b6e24-d143-a61c-95a3-1a55e1a6008e@suse.cz>
Date:   Tue, 7 Jul 2020 16:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There are some similar functions for migration target allocation.  Since
> there is no fundamental difference, it's better to keep just one rather
> than keeping all variants.  This patch implements base migration target
> allocation function.  In the following patches, variants will be converted
> to use this function.
> 
> Changes should be mechanical but there are some differences. First, Some
> callers' nodemask is assgined to NULL since NULL nodemask will be
> considered as all available nodes, that is, &node_states[N_MEMORY].
> Second, for hugetlb page allocation, gfp_mask is ORed since a user could
> provide a gfp_mask from now on.

I think that's wrong. See how htlb_alloc_mask() determines between
GFP_HIGHUSER_MOVABLE and GFP_HIGHUSER, but then you OR it with __GFP_MOVABLE so
it's always GFP_HIGHUSER_MOVABLE.
Yeah, gfp_mask for hugeltb become exposed in new_page_nodemask() after v4 3/11
patch, but that doesn't mean we can start modifying it :/
