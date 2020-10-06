Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193152843C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFBXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:23:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:43227 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgJFBXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:23:07 -0400
IronPort-SDR: Z3nnzBRUFSwnZYhGWRazIIpFDCh+WSXkoTNHG9oscBl+SbjL8VsEri9x9u4cGekG+snHnyIJ1P
 pb84sKYM+gXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163521985"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="163521985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 18:23:02 -0700
IronPort-SDR: 6gnIs2V31khnhEModfmRi2exvkZTpQRciwf3afug2YJAM/Hosn45yFCQSC+akp0EOuMVvBl7v1
 dTVYEP/9UIxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="343475592"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2020 18:13:52 -0700
Date:   Mon, 5 Oct 2020 18:15:50 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <20201006011550.GG6041@ranerica-svr.sc.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <de7b5aa2-9866-c93e-0f1b-4ffff82d2f1e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7b5aa2-9866-c93e-0f1b-4ffff82d2f1e@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:27:41PM -0700, Randy Dunlap wrote:
> On 10/2/20 6:17 PM, Ricardo Neri wrote:
> > +/**
> > + * arch_get_cpu_type() - Get the CPU type number
> > + * @cpu:	Index of the CPU of which the index is needed
> > + *
> > + * Get the CPU type number of @cpu, a non-zero unsigned 32-bit number that

Thank you for your feedback Randy!

> Are you sure that @cpu is non-zero?

This is the intent. Maybe it can be reworked to return -EINVAL instead?
I gues it is plausible but less likely that an arch defines a type as
0xffffffea;

> 
> > + * uniquely identifies a type of CPU micro-architecture. All CPUs of the same
> > + * type have the same type number. Type numbers are defined by each CPU
> > + * architecture.
> > + */
> > +u32 __weak arch_get_cpu_type(int cpu)
> > +{
> > +	return 0;
> > +}
> 
> arch_get_cpu_type() in patch 4/4 allows @cpu to be 0.

It should not return 0 if the system does not have
X86_FEATURE_HYBRID_CPU. The currently existing CPU types are all
non-zero as per the Intel SDM. Am I missing anything?

Thanks and BR,
Ricardo
