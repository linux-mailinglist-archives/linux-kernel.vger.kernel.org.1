Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0E29BB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808781AbgJ0QWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:22:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368944AbgJ0P67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C2A0ABE3;
        Tue, 27 Oct 2020 15:58:57 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:58:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
Message-ID: <20201027155851.GA11785@linux>
References: <20201022125835.26396-1-osalvador@suse.de>
 <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
 <20201027154031.GA11489@linux>
 <daedbc08-7275-40ad-0d07-007ef89ca25f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daedbc08-7275-40ad-0d07-007ef89ca25f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:44:33PM +0100, David Hildenbrand wrote:
> I'm planning on looking into patch #2/3 later this or next week (this week
> is open source summit / KVM Forum).

Sure, aprecciated the time ;-)

> 
> One thing to look into right now is how to make this fly this with vmemmap
> optimizations for hugetlb pages.
> 
> https://lkml.kernel.org/r/20201026145114.59424-1-songmuchun@bytedance.com

I was about to have a look at that series eitherway, but good you mentioned.

-- 
Oscar Salvador
SUSE L3
