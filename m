Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517C295EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505301AbgJVMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505137AbgJVMmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17F58AD07;
        Thu, 22 Oct 2020 12:42:34 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:42:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in
 struct zone
Message-ID: <20201022124231.GC26121@linux>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-6-vbabka@suse.cz>
 <20201008123129.GC4967@dhcp22.suse.cz>
 <fb44322e-c1b1-83e1-de94-e3837c363b95@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb44322e-c1b1-83e1-de94-e3837c363b95@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:55:02PM +0200, Vlastimil Babka wrote:
> Right, here's updated patch:
> 
> ----8<----
> From 6ab0f03762d122a896349d5e568f75c20875eb42 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 7 Sep 2020 14:20:08 +0200
> Subject: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in struct
>  zone
> 
> All per-cpu pagesets for a zone use the same high and batch values, that are
> duplicated there just for performance (locality) reasons. This patch adds the
> same variables also to struct zone as a shared copy.
> 
> This will be useful later for making possible to disable pcplists temporarily
> by setting high value to 0, while remembering the values for restoring them
> later. But we can also immediately benefit from not updating pagesets of all
> possible cpus in case the newly recalculated values (after sysctl change or
> memory online/offline) are actually unchanged from the previous ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Michal Hocko <mhocko@suse.com>

LGTM,

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
