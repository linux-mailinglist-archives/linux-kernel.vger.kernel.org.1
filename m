Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64AF295FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899795AbgJVNVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899740AbgJVNUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:53 -0400
Received: from [192.168.1.155] ([95.115.71.8]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhlCa-1jrs2z49Mu-00dofx; Thu, 22 Oct 2020 15:20:10 +0200
Subject: Re: [PATCH 1/2] x86: Conditional init of pcengines leds/keys gpios
To:     Ed W <lists@wildgooses.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
 <20201021214151.32229-1-lists@wildgooses.com>
 <0720575c-88c3-4f88-caa7-4707139702a1@metux.net>
 <5684534f-1280-4c37-af94-1e1bc7484585@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f17c4eb9-a7d5-4235-1216-969337a2e665@metux.net>
Date:   Thu, 22 Oct 2020 15:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5684534f-1280-4c37-af94-1e1bc7484585@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8RLFLE1ilbBKpg8mqMgVX26dt6GNQlqR19W/78e86KB16Z/wrpB
 hP7oIqYh9rLGY52U51MEDZ1zHfTt7HQK2s4HXu73Zfafvsrpda5Xo4hlM3ATN8GT8C5lIu8
 7FA7F6BxHteGsDmlfp58A+kFmLV74YTZha8omcH4Kp6czxpIYkFKrZF9LDhnO8HVDGOAmU5
 UYIdQ08fMOODqYMu9Z6TA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1LOY7RnBsjA=:z1lemRHY0tOj0jq1QwVbF6
 YiKPSgihnoVLhXBru27OGiYTaCGyhP0LcZUjHR8Q1ncVkvWfVHXLJAddONs5blprFs3QECt5f
 PRbx9sx1HO/Gx96tkYKiIngQD/H+63bg4BOpm3zJ/wv9K4lrV4ZzkXZcxlHu1YqHJbyNUOLQH
 0O5V2pCLFGX78z/7OaOgb+A2wFImhl2d4NNrpuYSG21ktNQ/EoVFgl4zeoODSdfvgzY2eyX28
 TYWFGZflMPWFkmw9DXd4/8ANL75Srv333MHbBI63X2h8JgdbPpdGJX4fjXU/pE827kX+pYamk
 9FWaBohNmmId/TnlgfbkUGhmKlKiSu0mEhr3USgQTXEM0JcmviLhpqcvWnjPB3Hk5w9kSV2Tx
 V1LGTEHT/gBRDkym6biYl7qoF9W7sRhMK8xyRU08C3/udLYtgijw5Zhu4sSVG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 11:38, Ed W wrote:

Hi,

> As a compromise can you change your userland to cope with dynamic names? I see two simple ways:
> 
> 1) udev rule to set name as you wish

can you give an example of udev rule depending on bios version ?

> To recap though, the situation for many years was that the naming convention was board specific.

Yes, I perhaps should have changed them to something like
"frontpanel:...", but I left them just like they were for apu1.
Don't see any need to have them separate between board revisions.
(nobody ever complained about it, couldn't even find a user of this
old led-only driver on apu>=2 boards - everybody seemed to either ignore
it completely or use raw gpios via /dev/mem - maybe because the driver
did not support and even prevented using the key or other gpios).

BTW: Pcengines folks officially recommended that "userland driver"
via /dev/mem. And I couldn't find a single distro that shipped the
old leds-only driver.

Now pcengines folks came around with yet another different naming. No
idea why the had to put in the word "led" into led names. Oh, hell, we
ca be lucky their didn't use the schematics signal names ...

> There is then just a small window (less than a year I think?) where users saw the name change to be
> non board specific (ie your new module). I would hazard a guess that given the speed of mainstream
> releases, few end users actually saw this change yet, or would notice? Those who did already
> accommodated the name change, so I would hazard a guess they can cope with the revert? (or not even
> notice?)

It has been communicated and discussed in APU community (and directly
to pcengines, too) Most of the responses were happy to have a proper
driver now, the existance of the old driver wasn't actually well-known.

> I just want to get APU5/6
> support in, which is affecting some real boards I want to use in volume. I don't feel the current
> situation of duplicate devices should stay though.

As already mentioned, for APU5/6 I don't mind if LED name changes
(again, assuming all boards in the field already have recent enough fw).

BTW: I wonder why you're so keen on changing things for apu2..4, if
you're only interested on apu5/6.

> My opinion is that we punt "this breaks userland" to being the board vendors problem now. 
> The board is configured largely through ACPI, so if the upstream
> changes the ACPI, then it's on them, not us.

And what's the board vendor going to do about that ? Practically ?
They didn't even talk to me (known I'm the maintainer of the driver for
their boards) - sorry, I don't think they ever do anything.

In the end, responsibility for the whole operating system is ours, the
kernel maintainer's. It's always been that way - just have a look at the
thousands of board or device specific quirks all around the kernel. This
one of the major points where Linux is different from Windows.

Interface/protocol stability never has been a virtue of hw vendors,
even in heavily standardized fields like USB. (okay, I have to stop
myself from ranting against hw vendors, otherwise I'd have to write an
1k pages book about that :o)

We, the kernel maintainers, are the ones who get blamed if anything
breaks. Linux has a long history of stability and consistency (one of
the major reaons for picking Linux in professional fields, especially
for embedded). We put *a lot* of efforts into that, this takes up a
*huge* portion of kernel maintenance work.

> This seems to be the direction the kernel is heading, with ACPI and device trees being used to
> configure the boards, in preference to heavy platform drivers?

Device tree is very different from ACPI (not just technically).
We've got coordinated, contigious standardization processes here.
Not by corporate committees, but the folks on the basis, who're doing
the actual work and know the actual requirements and environments.
Most of the work is actually coming from the Linux kernel community.
And DT is designed to be easily customized (eg. rewriting in by the
bootloader, dynamic overlays, ...). Ever tried that w/ ACPI ?


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
