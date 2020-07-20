Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF043226C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgGTQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389136AbgGTQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:48:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D71C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:48:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595263684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6vhOjdN6ywMQ1hCQjAk0Q+j5ecrOFBEW6Ip0+YJdCs=;
        b=ZA4pvD8rKQSzPPdkdFAcnZFPytP4oQ6eY5AKeNeRHWsEmtPGBljL1eqqSSr/py+SuOmbHV
        uMhrQ2O+OB/szVg5LhHX+wV48fg2tpPlGQTQ7pTMX1EGuI2yMrhjxvVAvntdX64SZCr7sh
        YoL8iyqMm8JNxfZUJ7JKbidKgMC4gY2xSepIAtfsNjNqSUK4nBdJILfnsIoQtuI1DCbgdO
        13pWLy6OdD8n0ZKgecuU3DdYKq1+ijlpVBtB9VunawoYBhdF6UnWR8Vq2TAqvw56aj8Oww
        Xn1wNan4LZtDfEpZZldYF87XAWZkKwO4Rglglvx2qzaQ8JLWDcBrewJPNAM8cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595263684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6vhOjdN6ywMQ1hCQjAk0Q+j5ecrOFBEW6Ip0+YJdCs=;
        b=+53pArHvqhHYDCu9EiME9XT473fok4zzq+rTpbwcFEYnB92nsOc3WKhpTJOKyEpZwRHijA
        7OJ0ZF0qD5no/6Bw==
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
In-Reply-To: <20200720161112.GB620@8bytes.org>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com> <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net> <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com> <20200719023405.GA564835@rani.riverdale.lan> <87pn8rokjz.fsf@nanos.tec.linutronix.de> <20200720161112.GB620@8bytes.org>
Date:   Mon, 20 Jul 2020 18:48:03 +0200
Message-ID: <87sgdmm8u4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <joro@8bytes.org> writes:
> On Sun, Jul 19, 2020 at 12:39:44PM +0200, Thomas Gleixner wrote:
>>  		*(.bss..page_aligned)					\
>> +		. = ALIGN(PAGE_SIZE);					\
>>  		*(.dynbss)						\
>>  		*(BSS_MAIN)						\
>>  		*(COMMON)						\
>
> I thougt about that too (and doing the same for .data..page_aligned),
> but decided that 'page_aligned' does not imply 'page_sized', so that
> putting other variables on the same page is fine in general and saves
> some memory. The problem why it breaks here is only because x86 maps a
> variabe which is not page-sized RO, so my thinking was that it should be
> fixed right there, at the variable.
>
> But if the above is fine too I prepare a patch which also aligns the end
> of .data..page_aligned.

If you do

  struct foo foo __attribute__ ((aligned(__alignof__(PAGE_SIZE))));

then this ends up page aligned in the data section and the linker can
place another object right next to it.

But with explicit sections which store only page aligned objects there
is an implicit guarantee that the object is alone in the page in which
it is placed. That works for all objects except the last one. That's
inconsistent.

By enforcing page sized objects for this section you might also wreckage
memory sanitizers, because your object is artificially larger than it
should be and out of bound access becomes legit.

Thanks,

        tglx
