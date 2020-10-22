Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72BA2962F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897849AbgJVQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897775AbgJVQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:44:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E1FC0613CE;
        Thu, 22 Oct 2020 09:44:16 -0700 (PDT)
Date:   Thu, 22 Oct 2020 18:44:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603385054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAgp/FPQnzgtmkmILpnWcclVKTl0LshiSeRck3Sg+gg=;
        b=V8JTAEYAFi6C3CQZ86xwkcAn6RgwrBWPIO7128dxKoxZjawSt4CXvy994PtZc5a8fEFuCr
        Jg8WJA7r6c9N4zhz8PnynoUfmwrkWkIZ/q/AIEOMcaTrnSaPoXPLMB+IXBh00OHO2qJ4/C
        pRRAzIkpchkPTl8bonW3odEEmZ9mMu9zLl7TUFTprX2Mk+GobWDnSXl5oZovVlGHoybBXR
        YCc230QrQPMQGIOSz4YyKiX4fdD8fAGeye8W5PsfcvdJazaVTJ7yLYeGmhSugPZ8seF0CO
        xT7LJShfMnIiamHUwJMjUrRYUkj+BSeLzn2b0Z4iwdlWolQ7M0YLjfTszxsa1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603385054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAgp/FPQnzgtmkmILpnWcclVKTl0LshiSeRck3Sg+gg=;
        b=QLClwpsjmIysJI/PUJReFABUGgGaLaRkiWdEPhKXAMsUGywP6mEI808fYh37LcxzDWBrIN
        r9Ig50GM9zdok5BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ltp or kvm triggerable lockdep alloc_pid()  deadlock gripe
Message-ID: <20201022164413.tnchtyqbotvbnp2e@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <1236de05e704f0a0b28dc0ad75f9ad4d81b7a057.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1236de05e704f0a0b28dc0ad75f9ad4d81b7a057.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22 07:21:13 [+0200], Mike Galbraith wrote:
> Greetings,
Hi,

> The gripe below is repeatable in two ways here, boot with nomodeset so
> nouveau doesn't steal the lockdep show when I then fire up one of my
> (oink) full distro VM's, or from an ltp directory ./runltp -f cpuset
> with the attached subset of controllers file placed in ./runtest dir.
> 
> Method2 may lead to a real deal deadlock, I've got a crashdump of one,
> stack traces of uninterruptible sleepers attached.

Just added commit
	267580db047ef ("seqlock: Unbreak lockdep")

and it is gone.

Sebastian
