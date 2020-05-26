Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A981B155A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgDTTGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgDTTGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:06:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0DC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:06:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g10so8499611lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuOgcxk1XV3miYbE7wpVHuN9QYRjBAm2R22P+wf2gcE=;
        b=L+lzdQ0+hDFUem0lsVOV5EEYL1IYLI2EyZmSOvm4b3/QX4qVY2eRGYR8Fmx43dHaxD
         epXuGVZNXGEWLO/SYMnG05d7STOV0RHNdkoQftSAtlO9QVIUFhFPyz6oIQoNGvgRQc02
         tzao2Bfws+6xheDrFv7gnxb7gcG2SXhJxYmUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuOgcxk1XV3miYbE7wpVHuN9QYRjBAm2R22P+wf2gcE=;
        b=phsk9eVqvRE1vAiuu9Gm1sdOi22chqF/l+iz/auh5dd4nPTkqLh8gDgaORFW07UQCd
         wZAp7Yfap7Z5OCCSYLhs8HTem5fUceuKCEtm9FHEt8VsCZim3ILTZJaNWCMM/bjhc1dn
         b/mdD2K770PGp2xQEUBOTpA6kQ5bj+mUr3ftNXbxt84gtOTEMjNwetvJ3/cLdT77Bfwt
         ULGhwsr/41UxGXAbWd/BZ20qQYM+1/G21GRTw/CBKQHFJGSAaBStfb3FrNDh38RzBXot
         GUi5LvGyrSvvfruDJCjDVJ4WnpvTZignL2k3cd0+Y1628uvG/O9Kt9YRcZvgyqujLI74
         PyBg==
X-Gm-Message-State: AGi0PubJmOgqtQi859d5FAjJ4QKsDRUa7cxnhODzs0i5DXVBy+gTiFvf
        DAvH8dVs3iwwFFWFtia6E3GsP2ELJGo=
X-Google-Smtp-Source: APiQypL8/2Jz8BCA+dbFMBke4u8JRep5nNoU81N4jJgHs/N0K4M5nqZ0VHcX4VFY7ACoD2nL0BVE6w==
X-Received: by 2002:ac2:46c4:: with SMTP id p4mr11392956lfo.37.1587409564688;
        Mon, 20 Apr 2020 12:06:04 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id r20sm234031ljk.42.2020.04.20.12.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:06:03 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l11so8984343lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:06:02 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr11379259lfc.31.1587409561755;
 Mon, 20 Apr 2020 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com> <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 12:05:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
Message-ID: <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:20 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> * I'm at a loss of why you seem to be suggesting that hardware should
> / could avoid all exceptions. What else could hardware do besides
> throw an exception on consumption of a naturally occuring multi-bit
> ECC error? Data is gone, and only software might know how to recover.

This is classic bogus thinking.

If Intel ever makes ECC DRAM available to everybody, there would be a
_shred_ of logic to that thinking, but right now it's some hw designer
in their mom's basement that has told you that hardware has to throw a
synchronous exception because hardware doesn't know any better.

That hardware designer really doesn't have a _clue_ about the big issues.

The fact is, a synchronous machine check exception is about the
_worst_ thing you can ever do when you encounter something like a
memory error.

It literally means that the software cannot possibly do anything sane
to recover, because the software is in some random place. The hardware
designer didn't think about the fact that the low-level access is
hidden from the software by a compiler and/or a lot of other
infrastructure - maybe microcode, maybe the OS, maybe a scriping
language, yadda yadda.

Absolutely NOBODY can recover at the level of one instruction. The
microcode people already proved that. At the level of "memcpy()", you
do not have a recovery option.

A hardware designer that tells you that you have to magically recover
at an instruction boundary fundamentally DOES NOT UNDERSTAND THE
PROBLEM.

IOW, you have completely uncritically just taken that incorrect
statement of "what else could hardware do" without questioning that
hardware designer AT ALL.

And remember, this is likely the same hardware designer that told you
that it's a good idea to then make machine checks go to every single
CPU in the system.

And this is the same hardware designer that then didn't even give you
enough information to recover.

And this is the same hardware designer that made recovery impossible
anyway, because if the error happened in microcode or in some other
situation, the microcode COULDN'T HANDLE IT EITHER!

In other words, you are talking to people WHO ARE KNOWN TO BE INCOMPETENT.

Seriously. Question them. When they tell ytou that "it's the only
thing we can possibly do", they do so from being incompetent, and we
have the history to PROVE it.

I don't understand why nobody else seems to be pushing back against
the completely insane and known garbage that is the Intel machine
checks. They are wrong.

The fact is, synchronous errors are the absolute worst possible
interface, exactly because they cause problems in various nasty corner
cases.

We _know_ a lot of those corner cases, for chrissake:

 - random standard library routine like "memcpy". How the hell do you
think a memcpy can recover? It can't.

 - Unaligned handling where "one" access isn't actually a single access.

 - microcode. Intel saw this problem themselves, but instead of making
people realize "oh, synchronous exceptions don't work that well" and
think about the problem, they wasted our time for decades, and then
probably spent a lot of effort in trying to make them work.

 - random generic code that isn't able to handle the fault, because IT
SHOULDN'T NEED TO CARE. Low-level filesystems, user mappings, the list
just goes on.

The only thing that can recover tends to be at a *MUCH* higher level
than one instruction access.

So the next time somebody tells you "there's nothing else we can do",
call them out on being incompetent, and call them out on the fact that
history has _shown_ that they are incompetent and wrong. Over and over
again.

I can _trivially_ point to a number of "what else could we do" that
are much better options.

 (a) let the corrupted value through, notify things ASYNCHRONOUSLY
that there were problems, and let people handle the issue later when
they are ready to do so.

Yeah, the data was corrupt - but not allowing the user to read it may
mean that the whole file is now inaccessible, even if it was just a
single ECC block that was wrong. I don't know the block-size people
use for ECC, and the fact is, software shouldn't really even need to
care. I may be able to recover from the situation at a higher level.
The data may be recoverable other ways - including just a "I want even
corrupted data, because I might have enough context that I can make
sense of it anyway".

 (b) if you have other issues so that you don't have data at all
(maybe it was metadata that was corrupted, don't ask me how that would
happen), just return zeroes, and notify about the problem
ASYNCHRONOUSLY.

And when notifying, give as much useful information as possible: the
virtual and physical address of the data, please, in addition to maybe
lower level bank information. Add a bit for "multiple errors", so that
whoever then later tries to maybe recover, can tell if it has complete
data or not.

The OS can send a SIGBUS with that information to user land that can
then maybe recover. Or it can say "hey, I'm in some recovery mode,
I'll try to limp along with incomplete data". Sometimes "recover"
means "try to limp along, notify the user that their hw is going bad,
but try to use the data anyway".

Again, what Intel engineers actually did with the synchronous
non-recoverable thing was not "the only thing I could possibly have
done".

It was literally the ABSOLUTE WORST POSSIBLE THING they could do, with
potentially  a dead machine as a result.

And now - after years of pain - you have the gall to repeat that
idiocy that you got from people who have shown themselves to be
completely wrong in the past?

Why?

Why do you take their known wrong approach as unthinking gospel? Just
because it's been handed down over generations on stone slabs?

I really really detest the whole mcsafe garbage. And I absolutely
*ABHOR* how nobody inside of Intel has apparently ever questioned the
brokenness at a really fundamental level.

That "I throw my hands in the air and just give up" thing is a
disease. It's absolutely not "what else could we do".

                  Linus
