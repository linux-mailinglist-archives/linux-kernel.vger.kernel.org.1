Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91623541E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHATHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 15:07:47 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:42654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgHATHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:07:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3DF39180A8121;
        Sat,  1 Aug 2020 19:07:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:4184:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12297:12663:12740:12760:12895:13069:13141:13230:13311:13357:13439:14180:14659:14721:21060:21080:21433:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:8,LUA_SUMMARY:none
X-HE-Tag: thing29_0b107ba26f8e
X-Filterd-Recvd-Size: 1464
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 19:07:45 +0000 (UTC)
Message-ID: <46c11b84dcf83d185ba771f92d2348aa82621dec.camel@perches.com>
Subject: Re: [PATCH 0/4] Checkpatch tool errors clean up
From:   Joe Perches <joe@perches.com>
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Date:   Sat, 01 Aug 2020 12:07:44 -0700
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-01 at 19:45 +0100, Jules Irenge wrote:
> Hi
> I am proposing these 4 patches. 
> I am currently learning the core kernel the hard way. 
> I will appreciate any feedback negative or positive.
> Thanks 

Generally, whitespace only changes outside of drivers/staging
are not encouraged.

> Jules Irenge (4):
>   acct: Add required space between variable and operator
>   audit: uninitialize global variable audit_sig_sid
>   audit: uninitialize static variables
>   context_tracking: uninitialize static variables
> 
>  kernel/acct.c             |  2 +-
>  kernel/audit.c            | 10 +++++-----
>  kernel/context_tracking.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

