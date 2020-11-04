Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167D72A677B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgKDPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:22:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbgKDPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:22:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604503324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVd2BFkWc5of5VjVKoE7YuBvmfMgyY8s0e7wNvJzc9Y=;
        b=aUe4S6Xr/tG5JNcVOCup5DkipBY4q7JofDrO/mndYO+T6YC9O+auQQkrhFMehNInuj8/DW
        Q/CNSDGmi75+X7GGeEGS4m0IAHindGcYt7DG3XIKZEQfucFmHR2nXx9WjZpb/AMIEccZIs
        A6t+CdR6tY3OchTgP2/JXXz6c/7HOfhtgqXN/sqBmyIyHAZt+nxkUH8jRmREaKpxH1Gfux
        CJD6rJ29eHGmflGduQ5KGRoCr8O1n5nJy4HoY2/PlGi2jhN/J6e7GMIxgwmKUdCjiKld/w
        5h3nlZPb6+RBodvOomMm0ktrQUYa+x76jCUUEQDuLS3n1jtD+8SKgsPmlfYfaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604503324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVd2BFkWc5of5VjVKoE7YuBvmfMgyY8s0e7wNvJzc9Y=;
        b=qmWGkWn/9p1JskciaKaDF2eqiSRvs3Ba4ns8B5M/WqSbvsVhb0JPoMAGV6qXKC9EYgmFTy
        BZ14/chYLMqCc2Cw==
To:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] futex: Handle transient "ownerless" rtmutex state correctly
In-Reply-To: <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com> <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de> <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de> <874km5mnbf.fsf@nanos.tec.linutronix.de> <871rh9mkvr.fsf@nanos.tec.linutronix.de> <87v9ell0cn.fsf@nanos.tec.linutronix.de> <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de> <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
Date:   Wed, 04 Nov 2020 16:22:04 +0100
Message-ID: <87pn4tkuzn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04 2020 at 16:12, Thomas Gleixner wrote:

> From: Mike Galbraith <efault@gmx.de>
>
> Gratian managed to trigger the BUG_ON(!newowner) in fixup_pi_state_owner().
> This is one possible chain of events leading to this:
>
> Task Prio       Operation
> T1   120	lock(F)
> T2   120	lock(F)   -> blocks (top waiter)
> T3   50 (RT)	lock(F)   -> boosts T3 and blocks (new top waiter)

boosts T1 obviously as Sebastian just pointed out to me. /me pulls the
futex induced brain damage excuse ...

