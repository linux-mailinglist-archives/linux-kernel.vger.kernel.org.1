Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33921C9C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgEGUTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 16:19:02 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:35374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:19:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CAE0D182D31F1;
        Thu,  7 May 2020 20:19:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2691:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8985:9025:10004:10400:10848:10967:11026:11232:11658:11914:12043:12114:12297:12438:12555:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21811:21939:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: paste82_6b8b670b6782c
X-Filterd-Recvd-Size: 3000
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 20:18:58 +0000 (UTC)
Message-ID: <3d88023b2da9ead8669d4c180b6c11ebf536abe7.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Date:   Thu, 07 May 2020 13:18:57 -0700
In-Reply-To: <20200507154512.1065cba8@gandalf.local.home>
References: <20200507110625.37254-1-yanaijie@huawei.com>
         <jhjpnbg6lkf.mognet@arm.com> <20200507132828.1af39b80@gandalf.local.home>
         <20200507133024.18dbe349@gandalf.local.home>
         <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
         <20200507144534.09abd685@gandalf.local.home>
         <96fe70f11245433ce4f19bffaf2d167dbf69a2a0.camel@perches.com>
         <20200507154512.1065cba8@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 15:45 -0400, Steven Rostedt wrote:
> On Thu, 07 May 2020 12:06:56 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > People describe changes as a "fix" all the time for stuff
> > that isn't an actual fix for a logic defect but is instead
> > an update to a particular style preference.
> > 
> > Then the "fix" word causes the patch to be rather uselessly
> > applied to stable trees by AUTOSEL.
> > 
> > It's especially bad when the 'Fixes: <sha1> ("description")'
> > tag is also added.
> > 
> > It's a difficult thing to regulate and I don't believe a
> > good mechanism would be possible to add to checkpatch or
> > coccinelle to help isolate these things.
> > 
> > git diff -w sometimes helps, but that's not really a thing
> > that checkpatch could do.
> > 
> > Any suggestions?
> 
> I'm unfamiliar with how the coccinelle script is used, but I thought there
> was some discussion some time back to have checkpatch not produces the same
> kinds of warnings to code as it does to patches.
> 
> A lot of useless updates were being submitted when people were running
> checkpatch on existing kernel code and producing warnings that are not
> worth "fixing", but something that new code should try to avoid.

checkpatch already has several blocks that look like

	if (input_is_a_patch)
		warn(...)
	else if (input_is_a_file)
		check(...)

where by default, check() is not output.

I've also suggested variations discouraging checkpatch
use on files outside of drivers/staging/ multiple times

https://lore.kernel.org/lkml/0753cae7829b98998ac3f5f9fcb52ba1f2475ee1.camel@perches.com/


