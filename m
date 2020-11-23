Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A012C14E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgKWT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgKWT4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:56:07 -0500
Received: from localhost (unknown [176.167.152.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2A820719;
        Mon, 23 Nov 2020 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606161366;
        bh=Qwaj9EAymCre5AbE0cGCpg6mZxagxOd5HkfAdkFeVQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yGMvf60SkCukxVh/qyFIa0RYi5BJnw924x8Ubx2WyW8UGZJJ+OYFmcESBDlzaKidk
         RcRPvUJbQRswpwMC7U7GFJor5K7CuKznFoqHCBHY6xg7Rwf2+a0SgyIbTS6x0Nj4sO
         6YNI9+CpdAy2uYz66KC8EeOTR7UA91ehnUKQnFwM=
Date:   Mon, 23 Nov 2020 20:56:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201123195603.GA1751@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
 <20201123134437.GA95787@lothringen>
 <87r1ojnaai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ojnaai.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:27:33PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> > On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> >> +	/*
> >> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> >> +	 * in_serving_softirq() become true.
> >> +	 */
> >> +	cnt = SOFTIRQ_OFFSET;
> >> +	__local_bh_enable(cnt, false);
> >
> > But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> > __do_softirq() calls softirq_handle_begin() which then sets it back to
> > SOFTIRQ_DISABLE_OFFSET...
> 
> The RT variant of it added in this very same patch
> > +static inline void softirq_handle_begin(void) { }
> > +static inline void softirq_handle_end(void) { }

Oh missed that indeed, sorry!

> 
> Thanks,
> 
>         tglx
