Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49C2A63F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKDMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:11:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:52006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDMLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:11:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC5DFAAF1;
        Wed,  4 Nov 2020 12:11:12 +0000 (UTC)
Date:   Wed, 4 Nov 2020 13:11:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 3/4] powerpc/mm: remove linear mapping if
 __add_pages() fails in arch_add_memory()
Message-ID: <20201104121109.GA5126@localhost.localdomain>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-4-david@redhat.com>
 <20201104095007.GB4981@localhost.localdomain>
 <20201104120651.GQ4879@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104120651.GQ4879@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:06:51PM +0200, Mike Rapoport wrote:
> On Wed, Nov 04, 2020 at 10:50:07AM +0100, osalvador wrote:
> > On Thu, Oct 29, 2020 at 05:27:17PM +0100, David Hildenbrand wrote:
> > > Let's revert what we did in case seomthing goes wrong and we return an
> > > error.
> > 
> > Dumb question, but should not we do this for other arches as well?
> 
> It seems arm64 and s390 already do that. 
> x86 could have its arch_add_memory() improved though :)

Right, I only stared at x86 and see it did not have it.
I guess we want to have all arches aligned with this.

Thanks

-- 
Oscar Salvador
SUSE L3
