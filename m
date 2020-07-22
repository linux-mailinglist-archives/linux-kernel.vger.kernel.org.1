Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228A022A043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgGVTrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:47:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E228C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:47:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595447228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwUsxLhyZP3fH9e0zTOVROIUA9shwK17i2WSFrKTECw=;
        b=Av8u/TuZQnjfTEPyZ6dCHGBuuG8kISj5EUBgXas81Ic7MFQQ5eEg0B6vvgC/EngqF7ssks
        HrqOXtbtN6/ei1UgHloxPH5uEvRyfhN/OX+d4kt4h/+QplPmHbxnHhEnqLsOelRUEI00OC
        YSmdIP3MUoLdNLcCOMETX3C/W6tF2ofZZMNgIie1hzW4EpQkAxWAZ+2O4ISzQrAUE2Kmtk
        83qd8rwcMrLzkfbw8pMcL/4akb3jPgwNuRhn1YTd8rm5T+dxzN8l+FEDmXQGHIYOtFqdVL
        TAYh+fzFzekZ+lX9lwMZYHXynR+8G9WNWEuFAi4lP1lO7ZdBw1MFnJ04qoT3ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595447228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwUsxLhyZP3fH9e0zTOVROIUA9shwK17i2WSFrKTECw=;
        b=7dY15eYPnkgACMLMa5kzRwRrDzJ1g8MrJVrtxVtNZTNlooDBdYRioysfqsULOrMEZhqKDx
        m5tmsD8Y5RSq1UBA==
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack: Dump user space code correctly again
In-Reply-To: <CAMe9rOrER7Mg_YvzuqguS-GCyP-bD2hogWeo+OMXm7F6JXQUDQ@mail.gmail.com>
References: <bug-208655-6666@https.bugzilla.kernel.org/> <87h7tz306w.fsf@nanos.tec.linutronix.de> <CAMe9rOrER7Mg_YvzuqguS-GCyP-bD2hogWeo+OMXm7F6JXQUDQ@mail.gmail.com>
Date:   Wed, 22 Jul 2020 21:47:05 +0200
Message-ID: <87r1t3z612.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H.J. Lu" <hjl.tools@gmail.com> writes:
> On Wed, Jul 22, 2020 at 10:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> +       if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
>>                 printk("%sCode: Bad RIP value.\n", loglvl);
>>         } else {
>>                 printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
>
> Add a kerel self test?

Care to whip one up?

