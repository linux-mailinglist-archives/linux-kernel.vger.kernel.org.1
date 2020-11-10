Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CD2ADAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgKJPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:49:11 -0500
Received: from foss.arm.com ([217.140.110.172]:57818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgKJPtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:49:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DBE31396;
        Tue, 10 Nov 2020 07:49:10 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA2A3F718;
        Tue, 10 Nov 2020 07:49:09 -0800 (PST)
References: <20201101131430.257038-1-maz@kernel.org> <jhjsg9syrs5.mognet@arm.com> <20201110130348.GK2594@hirez.programming.kicks-ass.net> <19286daf276f46aa@fake-msgid>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass irq_enter/exit
Message-ID: <jhjpn4lxlel.mognet@arm.com>
In-reply-to: <19286daf276f46aa@fake-msgid>
Date:   Tue, 10 Nov 2020 15:48:58 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/01/70 01:00, Valentin Schneider wrote:
> On 10/11/20 13:03, Peter Zijlstra wrote:
>> On Mon, Nov 02, 2020 at 10:30:50AM +0000, Valentin Schneider wrote:
>>
>>> Now, I'd like to pen exactly why we think it's okay to forgo irq_{enter,
>>> exit}() for that one IRQ and not any other.
>>
>> Thomas already said a few words on this, but basically scheduler_ipi()
>> is a NOP (*almost*), the IPI has no body. All it does is tickle the
>> return-from-interrupt path. So any setup and tear-down done for the
>> non-existing body is a waste of time.

Gotcha.

The pedant in me thinks this makes it more of a handler property than an
IRQ one, but I don't see a nice way to e.g. have this as a flag passed to
__request_percpu_irq() and not have it usable by random modules.
