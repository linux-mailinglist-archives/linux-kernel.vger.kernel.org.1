Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57429D925
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbgJ1Woq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389158AbgJ1WmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F8F247E8;
        Wed, 28 Oct 2020 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603907790;
        bh=BUO9MvWjdJPjCOnM9UH2ATg0qMpRGrXC5Zt4ZDEkRf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACb0CdvIUUblBmVUPGMiWr6mgm8qHPAP3WrJCjQKQGxq3kCfZvFeacyrUqb3vxxNz
         TAA3+LfC6NL3261t3QBt4eUQ+w4w89A9J5sqEMY+xu/vOszyIK9532gf3BQHqhQEyt
         /n0jDRvjjwDDXMS85FeBU2zfhhr3KoiKuAZQEQ5I=
Date:   Wed, 28 Oct 2020 17:56:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Does LOCKDEP work on ARM64?
Message-ID: <20201028175625.GA29206@willie-the-truck>
References: <CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 11:51:49AM +0200, Dmitry Vyukov wrote:
> Hello ARM64/LOCKDEP maintainers,
> 
> I've started experimenting with running syzkaller on ARM64 using
> QEMU/TCG. Total execution speed is very low and it ran just a handful
> of tests, but I am seeing massive amounts of locking bugs. Most of
> these were not observed on x86_64, while x86_64 ran gazillions of
> tests by now and most of these are trivial to trigger (depend only on
> call stack) and they do not look ARM64-specific. So I wonder:
> 1. Are there any known issues with LOCKDEP on ARM64?
> 2. Or are all these real and it's x86_64 LOCKDEP that's misbehaving?
> 3. Or are both x86_64 and ARM64 fine and these are just somehow ARM64-specific?
> 
> Here are details. Kernel is on
> f9893351acaecf0a414baf9942b48d5bb5c688c6 (recent upstream HEAD).
> Kernel config:
> https://gist.githubusercontent.com/dvyukov/c92a1e08f3f7e22b1f0387096d98b18b/raw/9f79f83c3b018ac27a040649f7d0fef36b63b960/gistfile1.txt
> 
> Here is one "Invalid wait context". It looks like just a put_user
> inside of syscall function:
> https://gist.githubusercontent.com/dvyukov/15639a949278a981c8eb125b3088a6b8/raw/286117bc292578c07c8afbf0fa563cd5528821e7/gistfile1.txt
> 
> Here is one "bad unlock balance detected". The looks well balanced and
> the code path is well exercised:
> https://gist.githubusercontent.com/dvyukov/805f867823b9f77a26c2ebedec5b9b9e/raw/2e6605fb5c90f56ebd1ccda78d613b5c219dfb82/gistfile1.txt
> 
> Here is one "workqueue leaked lock". Again, lock/unlock are very local
> and there is no control flow in between:
> https://gist.githubusercontent.com/dvyukov/4d18d35a79d7e74bf66d6e7ec3794ec0/raw/1ff3e2a5d3a825eb0d196af1f81c67a47fa3a2f6/gistfile1.txt
> 
> Here is one confusing "bad unlock balance detected":
> https://gist.githubusercontent.com/dvyukov/e222fa34e04104678c52a5b5b1ad15a3/raw/943c6ebbc022418b89fa63b6282fa1f1f40a276a/gistfile1.txt
> 
> Here is one confusing "suspicious RCU usage":
> https://gist.githubusercontent.com/dvyukov/77b0ec246e1db86e549a80e4a11ec218/raw/0bce97be186c0a6617d8835a694443ed1aa2a98a/gistfile1.txt
> 
> Overall I have more than 50 of these now.

I'm not aware of any lockdep issues specific to arm64. Mark -- do any of
these look familiar to you when you run syzkaller on real hardware?

Will
