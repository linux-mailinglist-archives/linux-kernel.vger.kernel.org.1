Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A54285200
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgJFTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:03:27 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:48364 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbgJFTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:03:26 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id D3AA1C0C23
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 20:03:24 +0100 (IST)
Received: (qmail 27506 invoked from network); 6 Oct 2020 19:03:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Oct 2020 19:03:24 -0000
Date:   Tue, 6 Oct 2020 20:03:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201006190322.GL3227@techsingularity.net>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 06:00:18PM +0200, Rafael J. Wysocki wrote:
> > server systems") and enable-cst is the commit. It was not fixed by 5.6 or
> > 5.9-rc8. A lot of bisections ended up here including kernel compilation,
> > tbench, syscall entry/exit microbenchmark, hackbench, Java workloads etc.
> > 
> > What I don't understand is why. The latencies for c-state exit states
> > before and after the patch are both as follows
> > 
> > /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
> > /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:10
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:33
> > /sys/devices/system/cpu/cpu0/cpuidle/state4/latency:133
> > 
> > Perf profiles did not show up anything interesting. A diff of
> > /sys/devices/system/cpu/cpu0/cpuidle/state0/ before and after the patch
> > showed up nothing interesting. Any idea why exactly this patch shows up
> > as being hazardous on Haswell in particular?
> > 
> Presumably, some of the idle states are disabled by default on the affected
> machines.
> 
> Can you check the disable and default_status attributes of each state before
> and after the commit in question?
> 

# grep . pre-cst/cpuidle/state*/disable
pre-cst/cpuidle/state0/disable:0
pre-cst/cpuidle/state1/disable:0
pre-cst/cpuidle/state2/disable:0
pre-cst/cpuidle/state3/disable:0
pre-cst/cpuidle/state4/disable:0
# grep . enable-cst/cpuidle/state*/disable
enable-cst/cpuidle/state0/disable:0
enable-cst/cpuidle/state1/disable:0
enable-cst/cpuidle/state2/disable:0
enable-cst/cpuidle/state3/disable:0
enable-cst/cpuidle/state4/disable:0
# grep . pre-cst/cpuidle/state*/default_status
pre-cst/cpuidle/state0/default_status:enabled
pre-cst/cpuidle/state1/default_status:enabled
pre-cst/cpuidle/state2/default_status:enabled
pre-cst/cpuidle/state3/default_status:enabled
pre-cst/cpuidle/state4/default_status:enabled

After the commit, the default_status file does not appear in /sys

-- 
Mel Gorman
SUSE Labs
