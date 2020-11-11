Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F02AF9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKKUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:42:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MFKDeDYeJhRoMqrFdF7ncpuN5b8jI32w2mydshp9Nm4=; b=vSIoE4W5tcQ4cl1P+AsCUWFFv3
        dDhLEK2CMP3BA896lwVaykX/7XtH6x53S3H5cJy1Up8KslQ8yHk0au4mpdh4RSl1uDYRL3vcgD/d1
        cbuod1MeVReqB/h+0TWrteoXRGQanU2cBgFPc8HlB4AtwBCPZDqss8GaTLIxOavIMAm2MTCw3YSM2
        kwCMD/VaTpFpIxVMgQJdjcc33KU+bAZUudyhfZKuWJZ9Qd4owFUXXn1jdDSudt2qfRzVkDgItSWLt
        iz4sDdPvSI0z4FimWf5zwx/c6FDI1SwzDzudaZ88iTcrPk0qJ92pyRxYSo5nRgf58Y+4sc8zdF8bS
        rCC/C1Rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwwo-00071X-3v; Wed, 11 Nov 2020 20:42:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B574D301EE3;
        Wed, 11 Nov 2020 21:42:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A91632BCE964C; Wed, 11 Nov 2020 21:42:28 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:42:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        andrew.cooper3@citrix.com, jgross@suse.com
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111204228.GQ2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111181328.mbxcz2uap2vnqpxq@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:13:28PM -0600, Josh Poimboeuf wrote:
> On Wed, Nov 11, 2020 at 06:47:36PM +0100, Peter Zijlstra wrote:

> > Yeah, so it's all a giant can of worms that; also see:
> > 
> >   https://lkml.kernel.org/r/20200821084738.508092956@infradead.org
> > 
> > The basic idea is to only trace edges, ie. when the hardware state
> > actually changes. Sadly this means doing a pushf/pop before the cli.
> > Ideally CLI would store the old IF in CF or something like that, but
> > alas.
> 
> Right, that makes sense for save/restore, but is the disabled check
> really needed for local_irq_disable()?  Wouldn't that always be an edge?

IIRC there is code that does local_irq_disable() even though IRQs are
already disabled. This is 'harmless'.

> And anyway I don't see a similar check for local_irq_enable().

I know there is code that does local_irq_enable() with IRQs already
enabled, I'm not exactly sure why this is different. I'll have to put it
on the todo list :/
