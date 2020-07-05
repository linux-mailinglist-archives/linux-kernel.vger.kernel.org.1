Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B98214C7D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGEM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 08:59:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:50378 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgGEM7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:59:00 -0400
IronPort-SDR: xcYtSbfWxKcK7yhbnb/dGmuEAe30AHDtEsh2/9n8mKa7cfi/lzKimJwqv0kzFGO60OBA3BGlaI
 LfC3AnJKc+xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="145424684"
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; 
   d="scan'208";a="145424684"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 05:58:59 -0700
IronPort-SDR: OeUWEir2wMUVDpL1KgIbZoJz3NKkIave0HxqjfxLXRQ0+GCxHjhVAdNJEqhDR/DfvM3UFqk4Ik
 mhzsftua3R1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; 
   d="scan'208";a="456398582"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2020 05:58:55 -0700
Date:   Sun, 5 Jul 2020 20:58:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200705125854.GA66252@shbuild999.sh.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 08:15:03AM -0400, Qian Cai wrote:
> 
> 
> > On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
> > 
> > I did reproduce the problem, and from the debugging, this should
> > be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
> > that loosing the batch cause some accuracy problem, and the solution of
> > adding some sync is still needed, which is dicussed in
> 
> Well, before taking any of those patches now to fix the regression, we will need some performance data first. If it turned out the original performance gain is no longer relevant anymore due to this regression fix on top, it is best to drop this patchset and restore that VM_WARN_ONCE, so you can retry later once you found a better way to optimize.

The fix of adding sync only happens when the memory policy is being
changed to OVERCOMMIT_NEVER, which is not a frequent operation in
normal cases.

For the performance improvment data both in commit log and 0day report
https://lore.kernel.org/lkml/20200622132548.GS5535@shao2-debian/
it is for the will-it-scale's mmap testcase, which will not runtime
change memory overcommit policy, so the data should be still valid
with this fix.

Thanks,
Feng


