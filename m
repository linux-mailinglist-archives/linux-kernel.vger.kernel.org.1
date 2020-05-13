Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE55C1D1B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbgEMQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEMQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:43:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA41C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:43:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYuTl-0000gE-KR; Wed, 13 May 2020 18:43:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 067AE100605; Wed, 13 May 2020 18:43:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wojciech Kudla <wk.kernel@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: x86/smp: adding new trace points
In-Reply-To: <b3e3c317-17e4-081f-0bb6-3e6f291f8b86@gmail.com>
References: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com> <b638ef03-04c2-94bf-f026-a01691888624@gmail.com> <87y2pw2fav.fsf@nanos.tec.linutronix.de> <b3e3c317-17e4-081f-0bb6-3e6f291f8b86@gmail.com>
Date:   Wed, 13 May 2020 18:43:32 +0200
Message-ID: <87sgg323bf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wojciech Kudla <wk.kernel@gmail.com> writes:
> On 13/05/2020 13:24, Thomas Gleixner wrote:
>
>> Why would the SMP call function single interrupt go through the
>> PLATFORM_IPI_VECTOR? It goes as the name says through the
>> CALL_FUNCTION_SINGLE_VECTOR.
>> 
>
> Wrong vector, my bad.
>
> However 2) still stands in my opinion. We don't have "ipi raise" trace
> point for x86.  RESCHEDULE_VECTOR, CALL_FUNCTION_SINGLE_VECTOR, as
> well as TLB invalidation vectors are essentially
> inter-processor-interrupts if I'm not mistaken.  Would a patch adding
> such trace point be considered here?

Maybe.

Though that IPI tracing is inconsistent across architectures. I'm not
really interested to have yet another x86 variant which is slightly
different than anything else.

ARM and ARM64 share generic tracepoints for that, though the actual
tracepoint invocation is in the architecture specific code.

If at all we really want to have the common IPIs which are required for
SMP support covered by generic tracepoints and have them in the generic
code and not sprinkled all over arch/*

Thanks,

        tglx
