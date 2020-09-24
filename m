Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC669277843
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgIXSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:08:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B941C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:08:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600970910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Bw5S+6KuIUsf1Ic4pM97Qi2nlRcZRP5Ar9fFDTLLUw=;
        b=BFv13BBwZgcf3j3gzcZuOliSN8tZcl0i/3dGzy5msoV6KtAaVM1UaERRetVK3NJaHj/5xk
        UIO65CxI9LstgnSToCBpHWSmRN5EbRbO5g8NKQCPFX+QnEgqiWGGWkPYWilX0+AjyEUbHq
        loo+/XDnwPc4bBteAQPZT6IZCGA6UKBEyt4azsnpKrLgYAwOVhdT+x7DhevzuiE50fPh/S
        Rbd0PHY+fAFQV7Jop2Ji0MLy07aMAqo5Y8jkV4in2rUObveERnjBm+Wf5hpu84JMGojsr0
        Mka2am2irirRyj+a86syQ7G2qQ8nQxXPv7h05GpofGotZ28FiD/9P1tM0H7xag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600970910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Bw5S+6KuIUsf1Ic4pM97Qi2nlRcZRP5Ar9fFDTLLUw=;
        b=FyjIgl0rAl+mfyJCmXnGuCr/m1OxqqIiW9SGRGkrMzi5Arq7DjIq7YyFH81d135W6Tf9YP
        GcyvhfigZHF+9OBA==
To:     Prasad Sodagudi <psodagud@codeaurora.org>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH 1/2] genirq/cpuhotplug: Reduce logging level for couple of prints
In-Reply-To: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
Date:   Thu, 24 Sep 2020 20:08:30 +0200
Message-ID: <87zh5f6o9t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23 2020 at 17:08, Prasad Sodagudi wrote:
> During the cpu hot plug stress testing, couple of messages
> continuous flooding on to the console is causing timers
> migration delay. Delayed time migrations from hot plugging
> core is causing device instability with watchdog. So reduce
> log level for couple of prints in cpu hot plug flow.

This is fixing the wrong end, really.

Timer migration can be delayed by other means as well.

The real problem is that the migration happens _after_ the CPU is
completely dead and the hotplug control thread is not guaranteed to
reach the timer migration state before timers are overdue at all.

There is a bunch of related problems, e.g. the interrupt migration
mechanism kicks in late as well.

I'm not against changing the log level per se, but the justification for
doing so is just bogus.

The more obvious question is whether these printks are useful at all
other than at the pr_debug() level.

Thanks,

        tglx
