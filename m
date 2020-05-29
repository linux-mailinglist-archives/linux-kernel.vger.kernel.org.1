Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD51E827B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgE2Pu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 11:50:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:44036 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgE2Pu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:50:27 -0400
IronPort-SDR: vofVvj4+PhGA9oABYx8Dytnc1knzVEWQDC4E+PsQnXvTz0bBbK3xfdsvX08pH2+DDSeXll/cZ/
 ehiR7dQeus7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:50:26 -0700
IronPort-SDR: 5/a/QAl6JXGqsLqRpG0JiY1Z94BoorNRoH2NduCIidNgwjXGV9vba6VClr0T/vmLBhZDRyhZeF
 swgu9OFutvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="292419141"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2020 08:50:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 71C16301B21; Fri, 29 May 2020 08:50:25 -0700 (PDT)
Date:   Fri, 29 May 2020 08:50:25 -0700
From:   Andi Kleen <andi.kleen@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200529155025.GC621576@tassilo.jf.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200528141802.GB1810@lca.pw>
 <20200528151020.GF93879@shbuild999.sh.intel.com>
 <E8ECBC65D0B2554DAD44EBE43059B3741A2BFEEC@ORSMSX110.amr.corp.intel.com>
 <20200529154315.GI93879@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529154315.GI93879@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -	if (ret == 0 && write)
> +	if (ret == 0 && write) {
> +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +			schedule_on_each_cpu(sync_overcommit_as);

The schedule is not atomic.
There's still a race window here over all the CPUs where the WARN_ON could
happen because you change the global first.

Probably you would need another global that says "i'm currently changing
the mode" and then skip the WARN_ON in that window. Maybe a sequence lock.

Seems all overkill to me. Better to kill the warning.

-Andi
