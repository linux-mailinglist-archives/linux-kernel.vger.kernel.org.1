Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827822B4CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgKPRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgKPRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:24:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:24:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605547471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gq4UiBiAx/WS5IzE7JiWxBNeoN2nn9Rg43gm72By5HE=;
        b=cGm8IwMBJrDCrRips4icXoJWto83hDV2TQC0N5cBgVJetwnqdF9dYn7dcBbn0CKMQszemQ
        I/GyQFUmG0ApnXWFgN6MEyhPVSMACQqf3ZFTPJ7KEg/E7UDa52lYSeVwqXeuZNIkmztmxF
        Ay5Naw5hBTup/qFx+J/oYr6/pymWnJHsqXbcFIrWNxt9i8KlmCJosUPLv8sH9rKaFWMC+c
        KCGVDbewQ4NwbmmEBLmkOLNtVgiVrc9ymBMaYMWsbytYmbFRa116KQz81SUyQQQRVp5MDV
        nXUjN6QJ/xxtmcLe4HzPBgMkTaRVqgDPCHSBtRPa40LcG+U1dh+V0LXqycAyew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605547471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gq4UiBiAx/WS5IzE7JiWxBNeoN2nn9Rg43gm72By5HE=;
        b=i6urDyofHeNs7wpEns01sAbLZWQbzzCQ+eHnnLbmbzeeNBAQ9jKgY8seqBBnA1lfWti9et
        u4q3bmmZKBLa1ACg==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     eupm90@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu: Allow rcu_irq_enter_check_tick() from NMI
In-Reply-To: <20201116121012.GC3121378@hirez.programming.kicks-ass.net>
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net> <87ima8luix.fsf@nanos.tec.linutronix.de> <20201114010526.GK3249@paulmck-ThinkPad-P72> <20201116121012.GC3121378@hirez.programming.kicks-ass.net>
Date:   Mon, 16 Nov 2020 18:24:31 +0100
Message-ID: <87a6vhz034.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 13:10, Peter Zijlstra wrote:

> Any which way around; here's a proper patch...
>
> ---
>
> Subject: rcu: Allow rcu_irq_enter_check_tick() from NMI
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Nov 16 12:54:56 CET 2020
>
> Eugenio managed to tickle #PF from NMI context which resulted in
> hitting a WARN in RCU through irqentry_enter() ->
> __rcu_irq_enter_check_tick().
>
> However, this situation is perfectly sane and does not warrant an
> WARN. The #PF will (necessarily) be atomic and not require messing
> with the tick state, so early return is correct.
>
> Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from r=
cu_nmi_enter()")
> Reported-by: "Eugenio P=C3=A9rez" <eupm90@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
