Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A129A2822AF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJCIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJCIzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:55:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8E0206CA;
        Sat,  3 Oct 2020 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601715310;
        bh=To4JE6YetiAJOgRPiOfCGUFXbLzEzRxkzpSkY4zsVmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTfCrMkKRwKvUGZn3nKof3BcSSfM0mFfhPe1ILihbZqw4pL7XT8ZvOPWHggYzKKU8
         9k/6SR/txNw2nBuXjrbQDyk7yeUdE5X6be3Os2jz7r1BJQTVyj4o+3+ePLUbkBNQBe
         IvKjqEhP60bb36OWB4wUs8SulFReMMJW4BnGoza0=
Date:   Sat, 3 Oct 2020 10:55:06 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/4] x86/cpu/topology: Implement the CPU type sysfs
 interface
Message-ID: <20201003085506.GB114893@kroah.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 06:17:45PM -0700, Ricardo Neri wrote:
> Recent Intel processors combine CPUs with different types of micro-
> architecture in the same package. There may be applications interested in
> knowing the type topology of the system. For instance, it can be used to
> to determine which subsets of CPUs share a common feature.
> 
> Implement cpu_type sysfs interfaces for Intel processors.
> 
> For example, in a system with four Intel Atom CPUs and one Intel Core CPU,
> these entries look as below. In this example, the native model IDs for
> both types of CPUs are 0:
> 
> user@host:~$: ls /sys/devices/system/cpu/types
> intel_atom_0 intel_core_0
> 
> user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> cpulist cpumap
> 
> user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> cpulist cpumap
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpumap
> 0f
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpulist
> 0-3
> 
> user@nost:~$ cat /sys/devices/system/cpu/types/intel_core/cpumap
> 10
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_core/cpulist
> 4

You used the same changelog text here as you did in patch 1/4, why?

thanks,

greg k-h
