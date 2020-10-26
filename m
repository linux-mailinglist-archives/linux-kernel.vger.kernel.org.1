Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF3299697
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792642AbgJZTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:13:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404516AbgJZTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:04:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603739065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ts7OvCQ8neOrMW3H2L+mcvBibMfSxHH1JqOYqWTehYI=;
        b=Iwae16MnPoQQ3di3i54xsNOXPTmY4XB5Us6Q5Mcp5mPbMb+1S9sSU/O0ATGNYnP6Q4U+nk
        VsFQZbL2zGqCTbQDiNWroT7UwYcM8TQ7R3kAm3+x71jfSUmtjF8bbp6IUfwFc1cxpc17lZ
        RSrtT725UR0Hm9RVqd9Al0egcvMyZzAfkTRjEfsG2skxCbAFy1C0+hyTbMwRmQM4OtfNwt
        qCEsw0lFJjW2hp3xkp08nNOzv9tBreqbBzy9QA0adMF0BRpo/zpZshY/31ulS8AbnRqZID
        +LYxzab5w9eSxfPsdO0telgj8o3Ry3VIAduZ/4N9Y/YjR/cwm22um56qBplY7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603739065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ts7OvCQ8neOrMW3H2L+mcvBibMfSxHH1JqOYqWTehYI=;
        b=0LqayT//imv88st5vOI0NJeAdqjtOjrMMYBenyRge7FnH3VcEBE6Y7XBmBg5bxzKbp4sOb
        yhoLkREniCc8gyBQ==
To:     psodagud@codeaurora.org
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
In-Reply-To: <a6d7f84679240fcf580520230a88c058@codeaurora.org>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org> <87v9f04n8r.fsf@nanos.tec.linutronix.de> <a6d7f84679240fcf580520230a88c058@codeaurora.org>
Date:   Mon, 26 Oct 2020 20:04:25 +0100
Message-ID: <8736204xmu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26 2020 at 10:08, psodagud wrote:
> Based on my understanding with maxcpus option provides, maximum no of 
> CPUs are brough up during the device boot up. There is a different case, 
> in which we want to restrict which CPUs to be brough up.

Again: What for? Why?

> On a system with 8 cpus, if we set maxcpus as 3, cpu0, cpu1, and cpu2 
> are brough up during the bootup.  For example, if we want to bring 
> core0, core3 and core4 current maxcpu(as 3) setting would not help us.
> On some platform we want the flexibility on which CPUs to bring up 
> during the device bootup. bootcpus command line is helping to bring 
> specific CPUs and these patches are working downstream.

A lot of patches work downstream by some definition of work. But that
does not make an argument to bring them upstream.

Thanks,

        tglx
