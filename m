Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DCC2914B1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439451AbgJQVRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439427AbgJQVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043BDC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:17:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602969423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZSaf6mICsG61g+Ahs/kdu56X2nbEqMkG66Lbe+nYek=;
        b=ndxeosOQZadtBcUt+JNj+2y2nVugdPwgHSPz0Q3C8rTAhaHlaoQa3JD2Fl3rhLS7dMVwR9
        6B93B+kbDSR6NWrtM4smffy9V7NqZMPJQgxVr4Xea7pNwtAI8/a5wHNO6otTdSRrnKO8wG
        j29OgwoMyQEgVnKQUMluftM0rEQMs6usYsoWQEPr4tdLMUwG/J/YyMPdM9FQxJJ6rGxU+V
        hWoXhV7sP4AFLo5rMdfnYPf2U3pLE1ZgAUC6+PQnVeYilIT1fUQL8+sZUAk9Bz09SJ9AFE
        t38/H0IyuSimeUUbMIja0hV374P35n+Ky3goLvtr2DYw2cg+iXvcRQm66geDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602969423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZSaf6mICsG61g+Ahs/kdu56X2nbEqMkG66Lbe+nYek=;
        b=j4eNE9FnBaEwypZPrH5Qxv6YxiHJ34OlUwjMffbRaIpxdjJNb2adwMD0widNPArjtKDxY2
        4LLAIfxa8HbuAyBw==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <99a29dd4-b968-c4fb-5071-2fd9b14e020e@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk> <87zh4lix8l.fsf@nanos.tec.linutronix.de> <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk> <87wnzpivvx.fsf@nanos.tec.linutronix.de> <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk> <87tuusj2ch.fsf@nanos.tec.linutronix.de> <4a2f1a71-3548-1f13-23a4-2f7e73408cf3@kernel.dk> <87k0voip1w.fsf@nanos.tec.linutronix.de> <ffd90972-d664-b024-f537-8d02f91d12d7@kernel.dk> <87h7qsin38.fsf@nanos.tec.linutronix.de> <99a29dd4-b968-c4fb-5071-2fd9b14e020e@kernel.dk>
Date:   Sat, 17 Oct 2020 23:17:03 +0200
Message-ID: <87eelwimcw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17 2020 at 15:03, Jens Axboe wrote:
> On 10/17/20 3:01 PM, Thomas Gleixner wrote:
>> Sure. I assume you ship it to Linus, otherwise let me know and I'll pick
>> it up.
>
> I can, I have it bundled up with the TIF_NOTIFY_RESUME cleanup. Either
> way is fine with me, so if you're good with it, I'll ship it before -rc1.

Works for me.
