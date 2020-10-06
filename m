Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7582B2853C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgJFVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:18:24 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:34357 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbgJFVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:18:24 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 560E5FB784
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 22:18:22 +0100 (IST)
Received: (qmail 7675 invoked from network); 6 Oct 2020 21:18:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Oct 2020 21:18:22 -0000
Date:   Tue, 6 Oct 2020 22:18:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201006211820.GN3227@techsingularity.net>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:29:24PM +0200, Rafael J. Wysocki wrote:
> > After the commit, the default_status file does not appear in /sys
> > 
> Something is amiss, then, because the commit doesn't affect the presence of
> this file.
> 

This was cleared up in another mail.

> The only thing it does is to set the use_acpi flag for several processor
> models in intel_idle.c.
> 
> It can be effectively reversed by removing all of the ".use_acpi = true,"
> lines from intel_idle.c.
> 
> In particular, please check if changing the value of use_acpi in struct
> idle_cpu_hsx from 'true' to 'false' alone (without reverting the commit)
> makes the issue go away in 5.9-rc8 (the default_status file should be
> present regardless).
> 

Thanks.  I applied the following

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9a810e4a7946..6478347669a9 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1044,7 +1044,7 @@ static const struct idle_cpu idle_cpu_hsw __initconst = {
 static const struct idle_cpu idle_cpu_hsx __initconst = {
 	.state_table = hsw_cstates,
 	.disable_promotion_to_c1e = true,
-	.use_acpi = true,
+	.use_acpi = false,
 };

netperf UDP_STREAM
                                      pre                 enable                 enable                5.9-rc8                5.9-rc8
                                      cst                    cst        cst-no-hsx-acpi                vanilla            no-hsx-acpi
Hmean     send-64       203.96 (   0.00%)      179.23 * -12.13%*      201.04 (  -1.44%)      203.24 (  -0.36%)      233.43 *  14.45%*
Hmean     send-128      403.66 (   0.00%)      355.99 * -11.81%*      402.28 (  -0.34%)      387.65 *  -3.97%*      461.47 *  14.32%*
Hmean     send-256      784.39 (   0.00%)      697.78 * -11.04%*      782.15 (  -0.29%)      758.49 *  -3.30%*      895.31 *  14.14%*
Hmean     recv-64       203.96 (   0.00%)      179.23 * -12.13%*      201.04 (  -1.44%)      203.24 (  -0.36%)      233.43 *  14.45%*
Hmean     recv-128      403.66 (   0.00%)      355.99 * -11.81%*      402.28 (  -0.34%)      387.65 *  -3.97%*      461.47 *  14.32%*
Hmean     recv-256      784.39 (   0.00%)      697.78 * -11.04%*      782.15 (  -0.29%)      758.49 *  -3.30%*      895.28 *  14.14%*

This is a more limited run to save time but is enough to illustrate
the point.

pre-cst is just before your patch
enable-cst is your patch that was bisected
enable-cst-no-hsx-acpi is your patch with use_acpi disabled
5.9-rc8-vanilla is what it sounds like
5.9-rc8-no-hsx-acpi disables use_acpi

The enable-cst-no-hsx-acpi result indicates that use_acpi was the issue for
Haswell (at least these machines). Looking just at 5.9-rc8-vanillaa might
have been misleading because its performance is not far off the baseline
due to unrelated changes that mostly offset the performance penalty.

The key question is -- how appropriate would it be to disable acpi for
Haswell? Would that be generally safe or could it hide other surprises?

-- 
Mel Gorman
SUSE Labs
