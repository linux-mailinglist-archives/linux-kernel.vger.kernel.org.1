Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0429BB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1805439AbgJ0QAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:00:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1801351AbgJ0Pkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E22CDAD8C;
        Tue, 27 Oct 2020 15:40:37 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:40:35 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
Message-ID: <20201027154031.GA11489@linux>
References: <20201022125835.26396-1-osalvador@suse.de>
 <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 03:01:44PM +0200, David Hildenbrand wrote:
> > This does not go without saying that the patchset is not 100% complete.
> > It is missing:
> > 
> >  - a way to disable memmap_on_memory (either sysfs or boot_time cmd)
> >  - atm, arch_add_memory for s390 screams if an altmap is passed.
> >    I am still thinking of a way to nicely drop handle that.
> >    Maybe a function in s390 that sets memmap_on_memory false and
> >    stuff that check in support_memmap_on_memory function.
> 
> Or simply implement altmap support ... shouldn't be too hard :)

Yeah, I guess so, but first I would like to have everything else settled.
So, gentle ping :-)


-- 
Oscar Salvador
SUSE L3
