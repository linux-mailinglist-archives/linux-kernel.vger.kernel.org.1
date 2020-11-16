Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC12B3F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKPIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:46:56 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:43388 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726643AbgKPIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:46:56 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 16 Nov 2020 17:46:53 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 16 Nov 2020 17:46:53 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 16 Nov 2020 17:45:27 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Tejun Heo <tj@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201116084527.GA26078@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <20201112103225.GE14554@X58A-UD3R>
 <CAKMK7uEAcLizuCEBAN99oFGaN02Wn_ief5asTbzD=Dcv-b=9VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEAcLizuCEBAN99oFGaN02Wn_ief5asTbzD=Dcv-b=9VQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:56:49PM +0100, Daniel Vetter wrote:
> > > I think I understand it. For things like completions and other "wait for
> > > events" we have lockdep annotation, but it is rather awkward to implement.
> > > Having something that says "lockdep_wait_event()" and
> > > "lockdep_exec_event()" wrappers would be useful.
> >
> > Yes. It's a problem of lack of APIs. It can be done by reverting revert
> > of cross-release without big change. ;-)
> 
> +1 on lockdep-native support for this. For another use case I've added
> annotations for dma_fence_wait, and they're not entirely correct
> unfortunately. But the false positives is along the lines of "you

I'd like to help you solve the problem you are facing. Let me be back
and help you later. I have to all-stop what I'm doing at the moment
becasue of a very big personal issue, which is a sad thing.

Thank you,
Byungchul

> really shouldn't do this, even if it's in theory deadlock free". See
> 
> commit 5fbff813a4a328b730cb117027c43a4ae9d8b6c0
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Tue Jul 7 22:12:05 2020 +0200
> 
>    dma-fence: basic lockdep annotations
> 
> for fairly lengthy discussion of the problem and what I ended up with.
> 
> Thanks, Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
