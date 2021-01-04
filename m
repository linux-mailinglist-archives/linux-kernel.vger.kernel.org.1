Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE22E947C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhADMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:02:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:50265 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbhADMCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:02:32 -0500
IronPort-SDR: FiO+5FEO0nCe2kpBlTKPM+OAfUzXlwyXwjuzqNVnFV7zBL+iQampcTIHf+1L2dLYKnU5IAs8dH
 bnqAcw8yT/PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="195464422"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="195464422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 04:00:47 -0800
IronPort-SDR: uPRM0s/6e1puV+EN1qW4UCalQNsHbpu2ghwhnjt3XUtrhC3X74IkfQnK25qpTuH+VZdjGIhqMU
 vUCMH7ldrIpA==
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="397383113"
Received: from hnanjund-mobl.amr.corp.intel.com ([10.254.115.148])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 04:00:44 -0800
Message-ID: <849b34d099f34f8e9422cab1e054e44f8055f29f.camel@linux.intel.com>
Subject: Re: tools/power/x86/intel-speed-select: Fixes for regression
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Jan 2021 04:00:40 -0800
In-Reply-To: <489cb4bb-28b5-e7c8-829e-3d58f047f514@redhat.com>
References: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
         <489cb4bb-28b5-e7c8-829e-3d58f047f514@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-04 at 12:56 +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/21/20 8:18 AM, Srinivas Pandruvada wrote:
> > One side-effect of fixing the scaling frequency limits using the
> > commit eacc9c5a927e ("cpufreq: intel_pstate: Fix
> > intel_pstate_get_hwp_max()
> > for turbo disabled") causes stale HWP_CAP.GUARANTEED to be used as
> > max.
> > Without processing HWP interrupts, user space needs to be able to
> > update
> > a new max while Intel SST is in use. This is not a problem as the
> > change of guaranteed is caused by user space action, so user space
> > knows
> > that guarantee will change.
> > 
> > This series causes user space to trigger scaling_max_freq update
> > with
> > the new base_frequency.
> > 
> > 
> > Srinivas Pandruvada (2):
> >   tools/power/x86/intel-speed-select: Set scaling_max_freq to
> >     base_frequency
> >   tools/power/x86/intel-speed-select: Set higher of
> > cpuinfo_max_freq or
> >     base_frequency
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
>  
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
I thought of applying these to the next 5.11-rc release.
If you want to queue for the next merge window (5.12) then I have other
enhancements, which I will send a PULL request.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
> 


