Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095F9287B11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbgJHRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:34:40 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:47097 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731283AbgJHRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:34:40 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id E4DF3F858E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 18:34:37 +0100 (IST)
Received: (qmail 21396 invoked from network); 8 Oct 2020 17:34:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Oct 2020 17:34:37 -0000
Date:   Thu, 8 Oct 2020 18:34:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201008173436.GQ3227@techsingularity.net>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net>
 <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:15:46PM +0200, Rafael J. Wysocki wrote:
> > Force enabling C6
> > 
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:0
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status:enabled
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:disabled
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/default_status:enabled
> > 
> > Note that as expected, C3 remains disabled when only C6 is forced (state3
> > == c3, state4 == c6). While this particular workload does not appear to
> > care as it does not remain idle for long, the exit latency difference
> > between c3 and c6 is large so potentially a workload that idles for short
> > durations that are somewhere between c1e and c3 exit latency might take
> > a larger penalty exiting from c6 state if the deeper c-state is selected
> > for idling.
> > 
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/residency:100
> > ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/residency:400
> > 
>
> If you are worried that C6 might be used instead of C3 in some cases, this
> is not going to happen.
>

Ok, so it goes in the C1E direction instead. I lost track of how C-state
is selected based on predictions about the future. It's changed a bit
over time.
 
> I all cases in which C3 would have been used had it not been disabled, C1E
> will be used instead.
> 
> Which BTW indicates that using C1E more often adds a lot of latency to the
> workload (if C3 and C6 are both disabled, C1E is used in all cases in which
> one of them would have been used).

Which is weird. From the exit latency alone, I'd think it would be faster
to use C1E instead of C3. It implies that using C1E instead of C3/C6 has
some other side-effect on Haswell. At one point, there was plenty of advice
on disabling C1E but very little concrete information on what impact it
has exactly and why it might cause problems that other c-states avoid.

> With C6 enabled, that state is used at
> least sometimes (so C1E is used less often), but PC6 doesn't seem to be
> really used - it looks like core C6 only is entered and which may be why C6
> adds less latency than C1E (and analogously for C3).
> 

At the moment, I'm happy with either solution but mostly because I can't
tell what other trade-offs should be considered :/

-- 
Mel Gorman
SUSE Labs
