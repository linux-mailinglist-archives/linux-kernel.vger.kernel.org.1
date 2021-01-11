Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8F2F1CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbhAKRje convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jan 2021 12:39:34 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:56990 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732874AbhAKRje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:39:34 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 12:39:33 EST
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:8d8e::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 8EB7F15360;
        Mon, 11 Jan 2021 17:29:01 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 7DAFD21A6C7; Mon, 11 Jan 2021 17:29:01 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Old platforms: bring out your dead
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
        <034ff035-9c58-336d-c8f5-80bf40ad2fc1@free.fr>
Date:   Mon, 11 Jan 2021 17:29:01 +0000
In-Reply-To: <034ff035-9c58-336d-c8f5-80bf40ad2fc1@free.fr> (Marc Gonzalez's
        message of "Mon, 11 Jan 2021 14:13:27 +0100")
Message-ID: <yw1xpn2bcrhe.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Gonzalez <marc.w.gonzalez@free.fr> writes:

> [ Dropping maintainers of other platforms ]
>
> On 08/01/2021 23:55, Arnd Bergmann wrote:
>
>> After v5.10 was officially declared an LTS kernel, I had a look around
>> the Arm platforms that look like they have not seen any patches from
>> their maintainers or users that are actually running the hardware for
>> at least five years (2015 or earlier). I made some statistics and lists
>> for my lwn.net article last year [1], so I'd thought I'd share a summary
>> here for discussion about what we should remove. As I found three
>> years ago when I removed several CPU architectures, it makes sense
>> to do this in bulk, to simplify a scripted search for device drivers, header
>> files and Kconfig options that become unused in the process.
>> 
>> This is probably a mix of platforms that are completely unused and
>> those that just work, but I have no good way of knowing which one
>> it is. Without hearing back about these, I'd propose removing all of
>> these:
>> 
>> * asm9260 -- added in 2014, no notable changes after 2015
>> * axxia -- added in 2014, no notable changes after 2015
>> * bcm/kona -- added in 2013, no notable changes after 2014
>> * digicolor -- added in 2014, no notable changes after 2015
>> * dove -- added in 2009, obsoleted by mach-mvebu in 2015
>> * efm32 -- added in 2011, first Cortex-M, no notable changes after 2013
>> * nspire -- added in 2013, no notable changes after 2015
>> * picoxcell -- added in 2011, already queued for removal
>> * prima2 -- added in 20111, no notable changes since 2015
>> * spear -- added in 2010, no notable changes since 2015
>> * tango -- added in 2015, sporadic changes until 2017, but abandoned
>> * u300 -- added in 2009, no notable changes since 2013
>> * vt8500 -- added in 2010, no notable changes since 2014
>> * zx --added in 2015 for both 32, 2017 for 64 bit, no notable changes
>> 
>> If any of the above are not dead yet[2], please let me know,
>> and we'll keep them.
>> 
>
> I didn't see Mans in the CC list. Not sure he's seen this message.
>
> As far as tango is concerned, I didn't keep any boards.
>
> Mans might have some tango3 and tango4 boards.
>
> Waiting for his take on the matter.
>
> I can point out some device-specific drivers that would become
> useless if tango support were dropped.

I have tango3 and tango4 boards.  Can't say I'm using them for anything,
though.  With the entire platform dead at the vendor level, removal
seems like a reasonable choice.

-- 
Måns Rullgård
