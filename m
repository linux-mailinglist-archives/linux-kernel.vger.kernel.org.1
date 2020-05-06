Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676C61C79DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEFTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 15:06:17 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:44500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727774AbgEFTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:06:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BE06B182C8795;
        Wed,  6 May 2020 19:06:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3871:3874:4321:4470:5007:6119:6742:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12266:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21365:21451:21627:21740:21796:30036:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: offer44_8d78196bd6428
X-Filterd-Recvd-Size: 3210
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 19:06:12 +0000 (UTC)
Message-ID: <aa9e029703e184a56bcab9f0992cfff316136d16.camel@perches.com>
Subject: Re: [PATCH] clone: only use lower 32 flag bits
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Kellner <christian@kellner.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org
Date:   Wed, 06 May 2020 12:06:10 -0700
In-Reply-To: <20200505174446.204918-1-christian.brauner@ubuntu.com>
References: <20200505174446.204918-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 19:44 +0200, Christian Brauner wrote:
> Jan reported an issue where an interaction between sign-extending clone's
> flag argument on ppc64le and the new CLONE_INTO_CGROUP feature causes
> clone() to consistently fail with EBADF.
[]
> Let's fix this by always capping the upper 32 bits for the legacy clone()
> syscall. This ensures that we can't reach clone3() only features by
> accident via legacy clone as with the sign extension case and also that
> legacy clone() works exactly like before, i.e. ignoring any unknown flags.
> This solution risks no regressions and is also pretty clean.
> 
> I've chosen u32 and not unsigned int to visually indicate that we're
> capping this to 32 bits.

Perhaps use the lower_32_bits macro?

> diff --git a/kernel/fork.c b/kernel/fork.c
[]
> @@ -2569,12 +2569,21 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  		 unsigned long, tls)
>  #endif
>  {
> +	/*
> +	 * On 64 bit unsigned long can be used by userspace to
> +	 * pass flag values only useable with clone3(). So cap
> +	 * the flag argument to the lower 32 bits. This is fine,
> +	 * since legacy clone() has traditionally ignored unknown
> +	 * flag values. So don't break userspace workloads that
> +	 * (on accident or on purpose) rely on this.
> +	 */
> +	u32 flags = (u32)clone_flags;
>  	struct kernel_clone_args args = {
> -		.flags		= (clone_flags & ~CSIGNAL),
> +		.flags		= (flags & ~CSIGNAL),

so:

		.flags		= lower_32_bits(clone_flags) & ~CSIGNAL;

>  		.pidfd		= parent_tidptr,
>  		.child_tid	= child_tidptr,
>  		.parent_tid	= parent_tidptr,
> -		.exit_signal	= (clone_flags & CSIGNAL),
> +		.exit_signal	= (flags & CSIGNAL),

		.exit_signal	= lower_32_bits(clone_flags) & CSIGNAL;

>  		.stack		= newsp,
>  		.tls		= tls,
>  	};
> 
> base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd

