Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDC28C51A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbgJLXIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:08:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:43626 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390967AbgJLXIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:08:51 -0400
IronPort-SDR: H9w7Rn5fLG/THzja+JaPBIqT03aneCNDc3FJk28L5zpACohNKL1WNTl7xiwvigaKrpZk61us/k
 BpNYrgaqJyvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153646639"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="153646639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 16:08:50 -0700
IronPort-SDR: jtQsQXJHH7eTYWq3g2YnZj8ebqv/fNrpVEK9oorh3ySws/SZZbBaQFE+OZV1x3Jwe3x6/6sH16
 wVcRirR8o6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="299359052"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 16:08:48 -0700
Date:   Tue, 13 Oct 2020 07:05:50 +0800
From:   Philip Li <philip.li@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [kbuild-all] Re: [PATCH] mm: memcg/slab: fix slab statistics in
 !SMP configuration
Message-ID: <20201012230550.GB19671@intel.com>
References: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <202010020814.M5nb692Y-lkp@intel.com>
 <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
 <20201002053405.GA30771@intel.com>
 <20201002175506.GB2954069@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002175506.GB2954069@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:55:06AM -0700, Roman Gushchin wrote:
> On Fri, Oct 02, 2020 at 01:34:06PM +0800, Philip Li wrote:
> > On Thu, Oct 01, 2020 at 05:55:59PM -0700, Roman Gushchin wrote:
> > > On Fri, Oct 02, 2020 at 08:08:40AM +0800, kbuild test robot wrote:
> > > > Hi Roman,
> > > > 
> > > > Thank you for the patch! Yet something to improve:
> > > > 
> > > > [auto build test ERROR on mmotm/master]
> > > 
> > > It's a bogus error, the patch was applied onto mmotm/master, which doesn't
> > > contain necessary slab controller patches.
> > sorry for the wrong report, and thanks for the input, we will check
> > this to see whether we can find an appropriate base for this case.
> 
> I wonder if you can look at the "Fixes" tag if the patch contains one?
Thanks for the advice. Yes, we have Fixes tag as part of hint for us
to analzye the possible base. For this case, "Fixes: ea426c2", the commit sha
is a little short than we expected, thus ignored. We have updated matching
rule now to handle such situation.

> 
> > Meanwhile, you can give a try to use --base option when git format patch, which
> > helps us to have more clue when looking for base info.
> 
> Will do.
> 
> Thanks!
