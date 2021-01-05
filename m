Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29AC2EB506
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbhAEVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbhAEVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:49:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BBC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:48:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m12so1961880lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemestnik-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=TW0hxTviLDNOX8JhOgA6vCelx8pQyhD6qgSkKGEk/Oo=;
        b=L6p/cL4OVYcPabzlqnf3Se53BMSohwnaRGMZfnVrY5Ets/y+tlWp1VYxugakRxuV+q
         xFDJ+hEMqVYqMtxlCGl6XftAPvxM/u1XyffeE/mYV7sC+Wd3BdB56xU22qFNpT2AqO74
         fkMI53m5fwL0DPvM6dlE61AUzQuz0CK4ivoQa3fuAP6SqFz+KCyiD8p4c3KuT0CREIkz
         9Vqbvr9ovhDvpcUMuBVgsrNFnhyRv7FNd+Xwf8yFQJcjJQhr39IwjEG4kAd6L6JeZThs
         CkZWRWhA75VwcwHJLWwRpOsrDqpGlsd/mFzPfGSUAqguIhDEq8VgDv4HlQ/FOy3eu1Ml
         9pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TW0hxTviLDNOX8JhOgA6vCelx8pQyhD6qgSkKGEk/Oo=;
        b=ZaJ7P/+4qlcXXwcVji0zugxF4ID1bb7c4O2N9bDET0bPMLqJwsDMe/JzA/weeotSuI
         A+btAXo3XS1Bk00icjkvOufqZ64HqfX+JUIpFLAEpkJiCh2nlvLjkcEwo1+WVr/ahL8M
         cPu5wO56LL8+12Kf6uLJwkjqt6qvRUXmmfWIcqJ9Iwa6bKvjiNmb8fXP5Qg4fDWnQtha
         L4BJGGuq/b8NEKAPviRjWEVcflvV0gAgtyS0lAKDjCQsS9cTEs6o6hzzd9J8cADzDeUQ
         t/rEknqBYjBE+6hwQriOVVrAYK7OtoQnVwv4CqTlam9nJYP643SYWvqcBuKTU4ch7Ipx
         lTwA==
X-Gm-Message-State: AOAM530gov/rBmAHLfhhec+K+XrKlkqIzd62I4PW31aOSXU55qTRkfMR
        8+cNoKAGPwArqMX9xHraSVgfb+aX8cbaSqaXvAprN0pTL31KSaiA
X-Google-Smtp-Source: ABdhPJxjhzDT17udDSGPvR3+Og8YzSgzx/Kda4415FKGJce4ZpL42IIUWiMjDT+7UVlI/ZTpEejEaPhL0BE9qYWzvzk=
X-Received: by 2002:ac2:46e7:: with SMTP id q7mr525616lfo.311.1609883304929;
 Tue, 05 Jan 2021 13:48:24 -0800 (PST)
MIME-Version: 1.0
From:   Mike Mestnik <cheako@mikemestnik.net>
Date:   Tue, 5 Jan 2021 15:48:14 -0600
Message-ID: <CAF8px55cnNytE=Hg-jt0mtp9CL1grQ5vS1-QXjSrHfQ_C8XXNQ@mail.gmail.com>
Subject: Config option tags/groups.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find good descriptions for CONFIG_IRQ_MSI_IOMMU,
CONFIG_GENERIC_IRQ_CHIP, and CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS.  I
know that doesn't sound like it has anything to do with the subject,
I'm getting there.  I'm trying to add cgroups and virtualization to an
OpenWRT config.  As odd as it seems the config for OWRT is
*obfuscated(AFAICT), so I'm unable to take that config and just edit
it.  My new idea is to strip out the "hardware" parts of the config(or
just the NF config) from Debian's arm64 kernel and merge that with
what I do have from OpenWRT.  The problem, there is no way of knowing
what flags(options/CONFIG_) are dependent on some piece of hardware or
even what flags are part of NF.  I looked at generating a list of
flags that depend on CONFIG_NETFILTER, but that seems like it would
involve reading not only the Kconfig files but also the Makefiles.

You may be asking, what do I want the hardware or the NF parts.  The
answer is either would be a start.  The term hardware is ambiguous(is
SMT options hardware?), so I think I'd be more interested in having
groups that are for NF, flags that add things to the userspace
API(further separated by syscall/proc/sys/dev) and flags that change
parts of the userspace API.

I don't think the metadata should live in the Kconfig files and there
is also no real reason this should live in the kernel tree at all, but
I think it's most useful there.  I'm thinking more about files in a
folder under documentation or something like that.  I would put these
lists together, but as I started with...  that's just impossible for
someone without good documentation on what each flag does.

* If you merge the base, arch, and board configs together you won't
get a config that includes things like NetFilter.  You might think
that's impossible for OpenWRT to work that way, but as it turns out NF
is added by some Makefile scripting.  I tried to run an OpenWRT build,
but that was a dead end for me...  I couldn't get the build system
configured for some reason.

How I got here, the whole rest of what I'm doing:
This is for an ESPRESSObin V7 Board /w the Marvell Armada 3700LP
(88F3720) dual core ARM Cortex A53.  OpenWRT seems to have a great
config for this board that I'm currently using.  I'd like to add
cgroups and virtualization to this config and while I'm at it upgrade
from the 4.x kernel OpenWRT uses.  Doing so, I noticed that
CONFIG_NETFILER was unset.  So I was like that's ok I'll just grab
that from Debian's arm64 kernel .config.  You can't do that though,
AFAICT.  Debian's config has a lot of stuff for other boards and
notably doesn't include the hardware crypto acceleration OpenWRT does.
So I'd like to grab all the userspace stuff from Debian's config and
merge it with the hardware things from OpenWRT, this should be
simple...  I should be able to tell if
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS is a piece of hardware or not.

Wile CONFIG_IRQ_MSI_IOMMU sounds like part of a north bridge(that I
wouldn't have) and CONFIG_GENERIC_IRQ_CHIP sounds like something every
arm64 should have...  but CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS I
can't tell and have no idea.  These come from running olddefconfig on
both configs and diffing, Debian seems to set all of these and the
base OpenWRT kernel has them unset.

I would accept to skip all of this and start working with an
un-obfuscated OpenWRT config, where I can just turn on the two
frameworks I'm interested in.  Though there is still the issue that
Debian seems to have more userspace option flags set, so if I go to
try and run Debian in a container I expect it to fail on not having
POSIX_MQUEUE or something.  I'll cross that bridge when I get there.

Cheers.
