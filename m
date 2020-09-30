Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF227E7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgI3Lm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgI3Lm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:42:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:42:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601466176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0+zNSI+mqx5CfiOQNU/5MvTkNgID9wWHb6xZFpnPBg8=;
        b=JVuhSsX3abSwQuTzm8uJA10+YocXED/oycGiqZYIgEkbN3W11pIgFmWW2CcEwu60jcq1R/
        j/ShUWVNYje5PxAEIZcY6xNOPxB+F2v/gPMC0wf1Cp/MQ33oAOtIt+anRixdk6PZCPwixb
        A2fptVc2DXANmXsKnWgqZkQIRI9C9GoiDBpLjo8RcUzEhj6P6sbjk6FRfH2+krHeewFo0R
        A+pK7ze3GuQki2MWUuke4i1OWPk74UORfNEjPkEM/fMf/Z9iFd5UCAeAuOHythk70a1VO8
        yEqk13X7fXMMaJvb5FOkpFcRvNxFh0HM15DtQFQ0cIZKusX7rdQsyk1z4E4JsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601466176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0+zNSI+mqx5CfiOQNU/5MvTkNgID9wWHb6xZFpnPBg8=;
        b=/AFGh+TIceYNDP5OAzZR05lbvlv5oUTl6tdChUtLopRisGV+2F/Bw8d0K8TkNo6+1hxd5w
        qVEQ1FtmGEieapBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
In-Reply-To: <20200930112836.GC29288@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de> <20200930090134.8723-2-john.ogness@linutronix.de> <20200930094316.GB987@jagdpanzerIV.localdomain> <87imbv1s0d.fsf@jogness.linutronix.de> <20200930112836.GC29288@alley>
Date:   Wed, 30 Sep 2020 13:48:56 +0206
Message-ID: <87ft6z1oe7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30, Petr Mladek <pmladek@suse.com> wrote:
> Anyway, I see hardcoded limit more like a hack. It limits something
> somewhere so that some other code somewhere else is safe to use.
>
> And printk.c is really bad from this point. It sometimes does not
> check for overflow because it "knows" that the buffers are big
> enough. But it is error prone code, especially when there are more
> limits defined (pure text, prefix, extended prefix). And it
> will be worse if we allow to add more optional information
> into the prefix.

So should I post a v3 where the checks are added? Or should I add
comments where checks would be, explaining why the checks are not
needed?

John Ogness
