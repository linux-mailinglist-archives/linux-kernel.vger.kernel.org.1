Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B62D4481
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgLIOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:38:41 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:36685 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730869AbgLIOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:38:41 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id DB7EABAD14
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:37:49 +0000 (GMT)
Received: (qmail 14589 invoked from network); 9 Dec 2020 14:37:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2020 14:37:49 -0000
Date:   Wed, 9 Dec 2020 14:37:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] Reduce scanning of runqueues in select_idle_sibling
Message-ID: <20201209143748.GP3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201208153501.1467-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:34:57PM +0000, Mel Gorman wrote:
> Changelog since v1
> o Drop single-pass patch						(vincent)
> o Scope variables used for SIS_AVG_CPU					(dietmar)
> o Remove redundant assignment						(dietmar
> 
> This reduces the amount of runqueue scanning in select_idle_sibling in
> the worst case.
> 
> Patch 1 removes SIS_AVG_CPU because it's unused.
> 
> Patch 2 moves all SIS_PROP-related calculations under SIS_PROP
> 
> Patch 3 improves the hit rate of p->recent_used_cpu to reduce the amount
> 	of scanning. It should be relatively uncontroversial
> 
> Patch 4 returns an idle candidate if one is found while scanning for a
> 	free core.
> 

Any other objections to the series? Vincent marked 1, 3 and 4 as
reviewed. While patch 2 had some mild cosmetic concerns, I think the
version and how it treats SIS_PROP is fine as it is to keep it
functionally equivalent to !SIS_PROP and without adding too many
SIS_PROP checks.

-- 
Mel Gorman
SUSE Labs
