Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD34B28439E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJFBGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:06:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:44650 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJFBGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:06:37 -0400
IronPort-SDR: suNcF+wd2X9sCieTtc93tF4KeXHIR2GJyABPJg2UO9fkql3j53KZWxVKjCOOA+IFJ9CNppfAAg
 2Ys/2hZqJPmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="248999147"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="248999147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 18:06:36 -0700
IronPort-SDR: ffBB7t+xNXiv8KMGFiiIMOi5s2eA6Y4WZE1hFXaawbbF8MKbCjYe8YUQhB36VzTPHK/HcwaLBq
 degP0k/ldI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="353188958"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2020 18:06:36 -0700
Date:   Mon, 5 Oct 2020 18:08:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20201006010835.GF6041@ranerica-svr.sc.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com>
 <20201003110548.GA145099@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003110548.GA145099@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 01:05:48PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 03, 2020 at 10:53:45AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
> > > +/**
> > > + * arch_get_cpu_type_name() - Get the CPU type name
> > > + * @cpu_type:	Type of CPU micro-architecture.
> > > + *
> > > + * Returns a string name associated with the CPU micro-architecture type as
> > > + * indicated in @cpu_type. The format shall be <vendor>_<cpu_type>. Returns
> > > + * NULL if the CPU type is not known.
> > > + */
> > > +const char __weak *arch_get_cpu_type_name(u32 cpu_type)
> > > +{
> > > +	return NULL;
> > > +}
> > 
> > Why is vendor part of this?  Shouldn't it just be arch?
> > 
> > I say this as "vendor" is kind of "interesting" when it comes to other
> > arches...
> > 
> > Speaking of other arches, we all know that other arches have this
> > feature as well, have you worked with any other groups to verify that
> > this interface will also work with them?
> 
> Here's one set of patches for ARM64 for much the same type of cpu
> design:
> 	https://android-review.googlesource.com/c/kernel/common/+/1437098/3
> Yes, it's not been posted to any kernel lists, but this is public so you
> need to work with the ARM developers to come up with an interface that
> works for everyone please.

Thanks for the pointer, Greg! I will study this proposal and work with
the ARM engineers.

BR,
Ricardo
