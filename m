Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CE296565
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370315AbgJVTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:30:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370205AbgJVTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:30:57 -0400
Received: from [192.168.1.155] ([95.115.71.8]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6bHC-1kM8C01Uty-0183kL; Thu, 22 Oct 2020 21:30:46 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed W <lists@wildgooses.com>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
 <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
 <d0d91191-cad2-94a1-6373-0f3ff4e38376@redhat.com>
 <795ae78b-26cf-f58d-6981-f68d7599ccdf@wildgooses.com>
 <6a603bd6-63ff-52e8-8fa2-4442b06e493b@metux.net>
 <cb7a0dcd-7b4f-9baa-788d-c42db72afeb2@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e21d6e89-9ae9-6b14-ff30-ae208d86a594@metux.net>
Date:   Thu, 22 Oct 2020 21:30:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cb7a0dcd-7b4f-9baa-788d-c42db72afeb2@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TTFU7oUGRD8cTfLnwpwJyB/LjcWwqmbhHzfHYEMVI9t/sX4eFFX
 nYjRRfqK+9Qms55sjaqNR38850ODaOXxl/bi4+oexOl3TyXwfV76okwXlorfLetGet/fwg1
 qFsK2nV8SaO9DUhs3clixQOvn59r6CMVfb3zK8WIE27mLozAoZ2slaK2L7KEEv8hjuKdKIz
 IXYtZaNWLdj/hDRjSqUEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ruM0cY5oiJc=:Mp4fKbl125Fi8dSBnWTHmL
 x4FuhX0UvVXLRuO4LnhtL99V5ZOinRvM/vM4FkwGe0cR4o9x82XGLobCCmqu1yXuL3npFDrnM
 mwI+LM6dD6cW+DNCaiCgU/3m3JDAtQ5q592HuHkcc1apCB6x18mzmx6shEoqPLd4JbSuG3Sva
 KKL7390k07nNAUjliDaNw7cvjAdXsVvbvAeUGZHPXTsNgWtlhlVorxhCmMVAflT+Ns9YJF9n5
 pYpkYRp73yQRkkTqSwYyh4kKJ5Eu2meTK0fNfqYvxWRD11VV5+urmk7zr3wUbXg0xja9XkYed
 QeChTflpc0QOxG/myLIfCXkFH0pefd0f6hOC2uvN20ZxuXqeJyznbJyCkvM18HXe+HcGeit1A
 cdr7EJV6uK8oVSUkpv3hz0+VoPqcbdkWBjFFLaKVwPf5vtnd2zist0rd8ckZW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 17:10, Ed W wrote:

Hi,

> You are reaching the wrong conclusion I feel?
> 
> a) your proposal doesn't address that ACPI and the upstream board configure all this stuff already.

Only for those with recent enough firmware. As already mentioned, we
can't expect users to do BIOS upgrade in the *field* or have an
dependencies between BIOS and kernel versions.

> We are creating duplicate devices right now. 

Does that cause any actual failures ?

> b) there is no reason for naming to be different between APU2-4 and 5. Lets standardise. I use the
> boards somewhat interchangeably

I'm fine with (actually prefer) having the same naming also on apu5.
Actually, your argument is exactly why I did it this way for apu[234].

> c) If you check my patch, there is already a DMI match for APU5, so this can do whatever you want it
> to, however, since it's green fields, I've set it up to match the way APU2-4 is working (in my patch)

Feel free to repost the patch for adding apu5 only.
(too much traffic @lkml to keep everything)

> d) Your driver already broke my userspace a year back when you changed these names. I've just
> supported all/both versions of the LED naming conventions since then (it isn't hard). I do believe
> we are overthinking this? It's really trivial to incorporate?

Might be trivial for your case, lucky for you. My cases (and those I
just got distant reports from) aren't so trivial, most of this hasn't
much to do with actual coding (unfortunately, embedded world isn't as
agile as some might want it to be)

> Knock yourself out. However, make sure that you read Pascal's email to you where he states that
> these lines aren't actually wired up on many of the board revisions?

I know, but on some they are. The final implementation will take care
of that (at least if we can gather that information somewhere).

> The APU2-4 have
> 
> - 3x mpcie *shaped* slots
> 
> - On some boards there are two of these wired with the pcie signals
> - On some boards there are two or three of these wired with USB signals
> - On some boards there are mSATA signals to one of these slots
> - On some boards there are either 1x or 2x SIM cards wired to some of the slots

ACK, that's pretty much my information - just don't recall the exact
details for each one. (would have to dig into schematics again). I can
confirm that each one (of those I have/had) has at least one msata,
one pcie, one usb+sim - some have multiple functions.

But I still wonder what exactly you mean w/ "LTE-Port". Just an alias
for those having USB+SIM ? (sorry if I'm too nitpicking, but I've
learned that exact terminology often is very important - perhaps I've
been a lawyer in some former life ;-))

> What is common is that the reset lines (and rfkill) go to the same slots as the SIM lines.

Let's rephrase it: those w/ USB+SIM also have a reset line.

> So my suggestion is to name these lines based on "purpose", ie modem1 and modem2, which is 100%
> consistent, rather than slot number, since that varies based on which board you pickup off the pile

NAK. They still can serve several kinds of purpose, eg. those w/ USB or
PCIE *and* SIM are by far not limited for modem's (and I'm really glad
about that).

Does it make any sense having WLAN, SSD, DAC, etc in an "modem port" ?
I don't believe so.

> I'm confused about what you mean by M2 slot? There are no m.2 slots on the board? only mpcie, some
> with USB signals, some with SIM?

Sorry, I've just been confused, believing that NGFF (in its different
types) was an superset of mpcie - both can carry different signal types,
You're right, I've been mistaken on that.

I've just been looking for some adequate name for those kinds of ports
which may have pcie, usb, sata, etc, all on one connector. Suggestions
welcomed.

Now we have at least two types of such things now on the table:
mpcie/msata/usb (like apu*) and M.2. From embedded world, I know of
several (propritary) port types fitting into similar category.
PDMI and similar stuff (apple connectors, ...) probably, too

I'll have to rethink what's the optimal approach with that, probably
by a new subsystem (even though there's a little bit of overlap with
extconn). Yes, that's a whole topic on it's own - we went quite
offtopic.

> We just need the GPIOs exposing in some way. Nothing else. Everything else is done in userspace

Might be fine for you, but not for me. Exposing raw gpios isn't an
entirely good idea (except for rare cases where kernel really cannot
know what's the actual function of those IOs might be)

> Not disagreeing, but it seems about as reliable as doing a software upgrade. If you do those then
> you are likely safe doing this

Already mentioned, BIOS is very different from OS. We've got several
techniques for rescuing a machine from failed kernel (even remotely),
but no such thing for broken BIOS - that requires physical replacement
in the field.

> Hint: use netboot for simplest setup

Assuming there is another server in the LAN. We don't have this luxury.
We're already happy with an dialup land line or some serial link routed
out of some PLC. Remember: this is embedded, not office PC.

>> Let's try summarize the current state of knowledge:
>>
>> * apu2..4:
>>   * BIOS support highly depends on BIOS version, we need to
>>     support older versions.
>>   * Field depends on on driver's naming, keycodes, ...
> 
> 
> Realistically that's only partially true:
> 
> - older kernels and older bios has "old names"
> 
> - kernels from a year back with your driver have a mix of "new" or "new + old" names depending on
> whether the bios is newer than 4.10.

Yes, and you suggested was removing the LEDs entirely. This means more
radical changes, including loosing it all on older bios (which still is
heavily used in the field).

It certainly would be much simpler, if we could just run BIOS upgrades
everywhere,
but then the question would be: who's gonna pay the bill for that ? And
who's responsible if anything goes wrong ?

> - After the patch I proposed: newer bios and newer kernel use ACPI, older bios match your driver,
> people upgrading from kernels more than about a year old don't notice since they move from "old"
> names to "acpi names" which are identical.

Very most of those people will only notice something completely new
appearing - already mentioned: haven't found a single distro that had
that enabled, nobody in the apu community seem to even know about it.

Congratulations, you're the first person I've ever known who was
actually using it :p

>> * simsw:
>>   * similar to mpcie-reset (still experimental, ...) ...
>>   * seems to be really bound to M2 ports
> 
> Not experimental. Works reliably. 

I (maintainer) considered it experimental due to lack of testing
and being a bit unreliable.

> Just don't toggle them during bootup (as your driver was doing in
> the past - current driver doesn't do this anymore - problem resolved)

And thanks for that report.

> The GPIO lines are wired to a SIM swap chip which does all the work. 
> The LTE cards don't know or see what is happening

On which boards did you see that ?

For my boards (don't recall which combinations I've actually tested),
it seemed to work sometimes, but not very reliable. (probably because
of the bug you've mentioned).


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
