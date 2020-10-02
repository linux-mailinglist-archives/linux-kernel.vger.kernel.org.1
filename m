Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0A2812D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgJBMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:36:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:36:08 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m9so347182qth.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qte7dDEik/LGw+83souKDg7C3zKSP9QwGh1sa25ffbQ=;
        b=J2MYhD18E1gMXfoIFxude3BGmvj2VTNsUpjX5LmfGwJiRpu8SpLZxZ8Sc+vobz+DAE
         7vnN8ngt6SiUtI+qy26qCnshsZXzrFKhOp36bwWAEVaqoNQq8NHjRmYzX8lzpFXZLopl
         eUVeRx+LuxdAz7R1MjNNb7VivDs1xAMsFHEW0khGZbg33Fuamw83EfcdoRDbXXp5BknE
         7rmB2T29oD50BMjyNEJVzM8O0fSR+FtRPBa7LYaAJVN0nwotjhixVDy3BR8qLEdEzllZ
         7juJTACbHwe2uilvlKf1msb7APGtN3Nc9wxYk7PTV1cx53jxJjfw8sFjGfoglhiMSlQI
         OpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qte7dDEik/LGw+83souKDg7C3zKSP9QwGh1sa25ffbQ=;
        b=hskyHqIugGkMDyUrKDQSG8Dly6AQc92G2iY3GUdsH+vwPhz9dqn9HQdtQ52VYnR0Lb
         rDFLJRZoN2OLSdYfbjeepMsoOA6THqAhslKlN89+M3cFc/PKZnY6VukOjUyjpskStuQ1
         qPcBvP++8xGVxIDPjhMtwC/brWgQD1fTmIaQ/uWju1e080NX6cNrrlCeb8NzLbdT8Lp7
         +i5nFfCzwRZFi9K03cv+gUov9ON1dC62mTIUqRsKQvi8aa71J8F42BpircLPoV5esVMM
         ARzcH0D3qwWHwK8MPaGYKW7IIuIgl1esS9OB1q9D2d7n2/KDaDWD0DiBdfaYeV8GZbl8
         cwYg==
X-Gm-Message-State: AOAM533tiYs4AOrjH1vbWcQ03jsJ2wT+FUBcdwlM19A9rCVNbFjGoUBI
        ggCMV3on70MjTg1KLGWFQ58=
X-Google-Smtp-Source: ABdhPJxxNm3Rg688Jf0S4RH8et/jCNOzqOnd85PzttsW95poYC6dttpsKXFGKEZRSSJz+YrA3EkLoQ==
X-Received: by 2002:ac8:7145:: with SMTP id h5mr2121246qtp.110.1601642167129;
        Fri, 02 Oct 2020 05:36:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 5sm917641qkj.135.2020.10.02.05.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2020 05:36:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 31A1C27C0054;
        Fri,  2 Oct 2020 08:36:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Oct 2020 08:36:05 -0400
X-ME-Sender: <xms:tB53X1xkW3uQc0b8kUQIKblcddfQCTDjpC01qI_WBOl0blhkFViOKQ>
    <xme:tB53X1R_2jb9We8VUYz8QxomgvV5YDruwxgurf_6VPhV5cSXDiRojb-fjmZN9QC_p
    AVoylIFEhnBptA_iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:tB53X_UGPtp535Lc-CdtI4F5xwJ6Nvx-WewEmwgXlf_Dz944avc3XA>
    <xmx:tB53X3iAaMvQUez1tHWjbQaDFqjHMpw6r1jJJAAjg8MlLnUOHSLcGQ>
    <xmx:tB53X3BHzjnENB4M4u3_JF_ABxSo7S7qQ7TFeI9_o_hAB2h9Tbc2Bg>
    <xmx:tR53Xy6IOSvzTcBXE2wwxg-zLHr8FRziWwus44N673ReBWXSW-hPBw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id EE06C3280063;
        Fri,  2 Oct 2020 08:36:03 -0400 (EDT)
Date:   Fri, 2 Oct 2020 20:36:02 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     g@hirez.programming.kicks-ass.net, Qian Cai <cai@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20201002123602.GE17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
 <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930190228.GL2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190228.GL2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:02:28PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 08:18:18PM +0800, Boqun Feng wrote:
> 
> > For one thing, I do think that LOCK_READ_USED trace is helpful for
> > better reporting, because if there is a read lock in the dependency path
> > which causes the deadlock, it's better to have the LOCK_READ_USED trace
> > to know at least the initial READ usage. For example, if we have
> > 
> > 	void f1(...)
> > 	{
> > 		write_lock(&A);
> > 		spin_lock(&C);
> > 		// A -> C
> > 		...
> > 	}
> > 
> > 	void g(...)
> > 	{
> > 		read_lock(&A);
> > 		...
> > 	}
> > 	void f2(...)
> > 	{
> > 		spin_lock(&B);
> > 		g(...);
> > 		// B -> A
> > 	}
> > 
> > 	void f3(...) {
> > 		spin_lock(&C);
> > 		spin_lock(&B);
> > 		// C -> B, trigger lockdep splat
> > 	}
> > 
> > when lockdep reports the deadlock (at the time f3() is called), it will
> > be useful if we have a trace like:
> > 
> > 	INITIAL READ usage at:
> > 	g+0x.../0x...
> > 	f2+0x.../0x...
> > 
> > Thoughts?
> 
> Wouldn't that also be in LOCK_ENABLED_*_READ ?
> 

But what if f2() is called with interrupt disabled? Or f2() disables
interrupt inside the function, like:

	void f2(...)
	{
		local_irq_disable();
		spin_lock(&B);
		g(...);
		...
		local_irq_enable();
	}

In this case, there wouldn't be any LOCK_ENABLED_*_READ usage for
rwlock_t A. As a result, we won't see it in the lockdep splat.

Regards,
Boqun

> That is, with PROVE_LOCKING on, the initial usage is bound to set more
> states, except for !check||trylock usage, and those aren't really all
> that interesting.
