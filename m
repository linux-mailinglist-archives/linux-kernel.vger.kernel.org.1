Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F22823C4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJCLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 07:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgJCLFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 07:05:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4320D2067D;
        Sat,  3 Oct 2020 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601723102;
        bh=/tulFan4fjxwlreVG+dB6Qz4ubfnQogZCZYwLMiJkjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQ9GKmChfZGbKomxkEoeXtNwzSoufcSyR0X6XX3l1i7E1mehyNbfRiksctPlCPg+M
         hmNyTk1YeXaBEfNwkBLuNKxE5EXhuc//wXuV8Ih4aEpa93OfRhDjFcVosJ30Cg6VEg
         sNECZCN71doKHHMmvwcDdk+IDp1mc7KmuxDXqz1U=
Date:   Sat, 3 Oct 2020 13:05:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <20201003110548.GA145099@kroah.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003085345.GA114893@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 10:53:45AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
> > +/**
> > + * arch_get_cpu_type_name() - Get the CPU type name
> > + * @cpu_type:	Type of CPU micro-architecture.
> > + *
> > + * Returns a string name associated with the CPU micro-architecture type as
> > + * indicated in @cpu_type. The format shall be <vendor>_<cpu_type>. Returns
> > + * NULL if the CPU type is not known.
> > + */
> > +const char __weak *arch_get_cpu_type_name(u32 cpu_type)
> > +{
> > +	return NULL;
> > +}
> 
> Why is vendor part of this?  Shouldn't it just be arch?
> 
> I say this as "vendor" is kind of "interesting" when it comes to other
> arches...
> 
> Speaking of other arches, we all know that other arches have this
> feature as well, have you worked with any other groups to verify that
> this interface will also work with them?

Here's one set of patches for ARM64 for much the same type of cpu
design:
	https://android-review.googlesource.com/c/kernel/common/+/1437098/3
Yes, it's not been posted to any kernel lists, but this is public so you
need to work with the ARM developers to come up with an interface that
works for everyone please.

thanks,

greg k-h
