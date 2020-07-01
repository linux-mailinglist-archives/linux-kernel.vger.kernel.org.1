Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65855210610
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgGAIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgGAIWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED795AF21;
        Wed,  1 Jul 2020 08:22:11 +0000 (UTC)
Message-ID: <1593591727.3586.2.camel@suse.de>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>, nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 10:22:07 +0200
In-Reply-To: <1593498910.3046.2.camel@suse.de>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
         <20200630050803.GA2747@lca.pw> <1593498910.3046.2.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-30 at 08:35 +0200, Oscar Salvador wrote:
> > Even after applied the compling fix,
> > 
> > https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/
> > 
> > madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
> > would succeed without this series. Steps:
> > 
> > # git clone https://github.com/cailca/linux-mm
> > # cd linux-mm; make
> > # ./random 1 (Need at least two NUMA memory nodes)
> >  start: migrate_huge_offline
> > - use NUMA nodes 0,4.
> > - mmap and free 8388608 bytes hugepages on node 0
> > - mmap and free 8388608 bytes hugepages on node 4
> > madvise: Input/output error
> 
> I think I know why.
> It's been a while since I took a look, but I compared the posted
> patchset with my newest patchset I had ready and I saw I made some
> changes with regard of hugetlb pages.
> 
> I will be taking a look, although it might be better to re-post the
> patchset instead of adding a fix on top since the changes are a bit
> substantial.

Yap, I just confirmed this.

Posted version had some flaws wrt. hugetlb pages, that is why I was
working on a v3.
I am rebasing my v3 on top of the mm with the posted patchset reverted.

I expect to post it on Friday.


-- 
Oscar Salvador
SUSE L3
