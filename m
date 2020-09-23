Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE242758B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIWN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:29:32 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:53606 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:29:32 -0400
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 4154453126; Wed, 23 Sep 2020 09:29:31 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 3633A52A65;
        Wed, 23 Sep 2020 09:29:12 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 0870A1A06DB; Wed, 23 Sep 2020 09:29:12 -0400 (EDT)
Date:   Wed, 23 Sep 2020 09:29:12 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 00/14] HWPOISON: soft offline rework
Message-ID: <20200923132911.GF17169@cathedrallabs.org>
References: <20200922135650.1634-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

On Tue, Sep 22, 2020 at 03:56:36PM +0200, Oscar Salvador wrote:
> This patchset is the latest version of soft offline rework patchset
> targetted for v5.9.
> 
> This patchset fixes a couple of issues that the patchset Naoya
> sent [1] contained due to rebasing problems and a misunterdansting.
> 
> Main focus of this series is to stabilize soft offline.  Historically soft
> offlined pages have suffered from racy conditions because PageHWPoison is
> used to a little too aggressively, which (directly or indirectly) invades
> other mm code which cares little about hwpoison.  This results in unexpected
> behavior or kernel panic, which is very far from soft offline's "do not
> disturb userspace or other kernel component" policy.
> An example of this can be found here [2].
> 
> Along with several cleanups, this code refactors and changes the way soft
> offline work.
> Main point of this change set is to contain target page "via buddy allocator"
> or in migrating path.
> For ther former we first free the target page as we do for normal pages, and
> once it has reached buddy and it has been taken off the freelists, we flag it
> as HWpoison.
> For the latter we never get to release the page in unmap_and_move, so
> the page is under our control and we can handle it in hwpoison code.
> 
> [1] https://patchwork.kernel.org/cover/11704083/
> [2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u

FWIW, tested again with these patches in the ppc64 box and they work.
I see that you added my Tested-by in the last patch but in any case:

Tested-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu

