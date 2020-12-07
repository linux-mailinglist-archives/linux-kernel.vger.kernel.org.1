Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0A2D14EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLGPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:39:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:39:51 -0500
Date:   Mon, 7 Dec 2020 16:39:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607355549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKwN9+29kWGZaYiMYoA21N7+6UWBWHBuDsf/R9WFbGE=;
        b=axgZm7m2FoJ3QBxVBh9BzBvSXQcai48EnwaXhifRGEOPC/WXEU3ZPDU0o67zJw8sdlGlOa
        g8ANFMZCI1TPpAI37pkWD6JVORP+D4nz1OVZrns9UjlcivE4fOqJcj9CWWzLafPxpuOhR1
        DbPYQD/VEaILJM8vom7Cm3CeGDRaiCqt1nSXssLo4gQCg6oaaw7DOEJOXPkr0Ayj5v4fP/
        xeL25pZB7Xiw/zAt5YpygtKTwsj6HHi7t/rBss9dpGmBMC/Q8zpi0+n4MjxOH+wCkfTRj9
        W38zrRn7ycdMmQj4kbevsOMJqukwoGk9rCWlOm5KfaBWaCKcf76vAn4optSvtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607355549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKwN9+29kWGZaYiMYoA21N7+6UWBWHBuDsf/R9WFbGE=;
        b=VSBDhjEOA8gLFqfdew+9aCk9yoJdTZpDhHIZlB9TWEzD/Bo6UkL6gG1Nk8sSskUT8NFxX+
        fBlVwdxph8qmytCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
Message-ID: <20201207153908.5orqlhp3v5xoat63@linutronix.de>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.627618080@linutronix.de>
 <20201207114743.GK3040@hirez.programming.kicks-ass.net>
 <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
 <87tusx63q8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tusx63q8.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 16:22:07 [+0100], Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 15:00, Sebastian Andrzej Siewior wrote:
> > So we keep the RT part as-is and replace the non-RT bits with this?
> 
> No. It would work for both.

So instead of boosting our way through we simply wait until the tasklet
completes. Given that canceling is usually done on start/stop events, it
shouldn't matter if the RT priority is lost.

Sebastian
