Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788D720968D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 00:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbgFXWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 18:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388711AbgFXWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:49:49 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BE92065D;
        Wed, 24 Jun 2020 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593038988;
        bh=+Xiia5lz5jMxPkcFiSIcy2n0z1B9hfXtGE0im/2wmaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tyqEQyYnCLpAXNAjThece3itLPMPam/8cGEiE9U1sggON915fah27trGQB5tulRRK
         T33Ra4e4yfl3IjKj3fYmxzC/HvLZmbLCcMxk1pZ/pnGC0169/YA7zcuM8ptR3Vbiw7
         JerXELY9gmukeBuv6Rfq9DEfEVIhgShZYKoJYXWY=
Date:   Wed, 24 Jun 2020 15:49:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-Id: <20200624154947.2f41c426d4b83fb9241d8584@linux-foundation.org>
In-Reply-To: <20200624223618.GA13133@hori.linux.bs1.fc.nec.co.jp>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
        <20200624121742.711331a2a65633a0e16fd9e6@linux-foundation.org>
        <20200624223618.GA13133@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 22:36:18 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Wed, Jun 24, 2020 at 12:17:42PM -0700, Andrew Morton wrote:
> > On Wed, 24 Jun 2020 15:01:22 +0000 nao.horiguchi@gmail.com wrote:
> > 
> > > I rebased soft-offline rework patchset [1][2] onto the latest mmotm.  The
> > > rebasing required some non-trivial changes to adjust, but mainly that was
> > > straightforward.  I confirmed that the reported problem doesn't reproduce on
> > > compaction after soft offline.  For more precise description of the problem
> > > and the motivation of this patchset, please see [2].
> > > 
> > > I think that the following two patches in v2 are better to be done with
> > > separate work of hard-offline rework, so it's not included in this series.
> > > 
> > >   - mm,hwpoison: Take pages off the buddy when hard-offlining
> > >   - mm/hwpoison-inject: Rip off duplicated checks
> > > 
> > > These two are not directly related to the reported problem, so they seems
> > > not urgent.  And the first one breaks num_poisoned_pages counting in some
> > > testcases, and The second patch needs more consideration about commented point.
> > > 
> > 
> > It would be nice to have some sort of overview of the patch series in
> > this [0/n] email.
> > 
> > > [1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> > > [2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
> > 
> > The above have such, but are they up to date?
> 
> The description of the problem doesn't change, but there're some new patches
> and some patches are postponed, so I should've added an overview of this series:
> 
> - patch 1, 2 are cleanups.
> - patch 3, 4, 5 change the precondition when calling memory_failure(). Previously
>   we sometimes call it with holding refcount of the target page and somtimes call
>   without holding it, and we passed a flag of whether refcount was taken out of
>   memory_failure().  It was confusing and caused code more complex than needed.
> - patch 6-10 are cleanups.
> - patch 11 introduces new logic to remove the error page from buddy allocator,
>   which is also applied to the path of soft-offling in-use pages in patch 12.
> - patch 13 is basically a refactoring but I added some adjustment to make sure
>   that the freed page is surely sent back to buddy instead of being kept in pcplist,
>   which is based on discussion in v2.
> - patch 14 fixes the inconsistency of return values between injection interfaces.
> - patch 15 is a new patch to complement missing code found in code review for
>   previous version.
> 
> Core change is in patch 11 and 12, and the others are kind of cleanup/refactoring.

And all the other words in
https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
are still accurate and complete?

