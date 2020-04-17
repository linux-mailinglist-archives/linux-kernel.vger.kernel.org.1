Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3124F1AE3DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgDQReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:34:22 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:49374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbgDQReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:34:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0D2F2184AA7F1;
        Fri, 17 Apr 2020 17:34:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:7974:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14180:14659:14721:19904:19999:21060:21080:21451:21627:21660:21740:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rain55_7d2aa5877710a
X-Filterd-Recvd-Size: 2056
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 17:34:20 +0000 (UTC)
Message-ID: <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
Subject: Re: checkpatch.pl warning for "return" with value
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 10:32:07 -0700
In-Reply-To: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
References: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 13:20 -0400, Luben Tuikov wrote:
> Hi guys,
> 
> I get this warning:
> 
> :32: WARNING: else is not generally useful after a break or return
> #32: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:55:
> +		return 0;
> +	} else {
> 
> for the following code, at the bottom of a function:
> 
> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> 		amdgpu_device_gpu_recover(ring->adev, job);
> 		return 0;
> 	} else {
> 		drm_sched_suspend_timeout(&ring->sched);
> 		return 1;
> 	}
> }
> 
> It seems like a false positive--I mean, if the else branch was
> taken, we'd return a different result.

There is an existing checkpatch exception for single line
if/else returns
like:

	if (foo)
		return bar;
	else
		return baz;

because that's a pretty common code style.

But I personally don't think that your example fits the
same style.

I think when unexpected condition should be separated from
the expected condition which should typically be the last
block of a function like:


	if (<atypical_condition>) {
		...;
		return <atypical_result>;
	}

	...;
	return <typical_result>;
}

If you want to code it, and it works, go ahead, but I
won't attempt it because I think it's not appropriate.

cheers, Joe

