Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABA2A6E99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgKDUNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbgKDUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:13:29 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B170EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:13:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 45895C1D;
        Wed,  4 Nov 2020 21:13:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EhNBdKwrLQ_R; Wed,  4 Nov 2020 21:13:24 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 7B56E9ED;
        Wed,  4 Nov 2020 21:13:24 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kaP9n-003dhX-Cl; Wed, 04 Nov 2020 21:13:23 +0100
Date:   Wed, 4 Nov 2020 21:13:23 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when specifying non-existent serial port in speakup /
 tty_kopen
Message-ID: <20201104201323.dzyt73tbd2jykcrt@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201104145737.GA11024@camel2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104145737.GA11024@camel2.lan>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Matthias Reichl, le mer. 04 nov. 2020 15:57:37 +0100, a ecrit:
> I initially noticed this oops on x86_64 running kernel 5.4.59 when
> I accidentally mistyped "ttyS0" as "ttyS9":
> 
> modprobe speakup_dummy dev=ttyS9

> [   49.978481] tty_init_dev: ttyS driver does not set tty->port. This would crash the kernel. Fix the driver!

This looks like only a warning, did it actually crash?

> the missing tty->port is quite fatal.

It is fatal for module insertion yes (EINVAL) but IIRC that should be
getting handled properly, making modprobe return the error?

> It looks like spk_ttyio or tty_dev_name_to_number() / tty_kopen()
> should perform some additional validation,

spk_ttyio_initialise_ldisc only has a dev_t so can't do much beyond
calling tty_kopen.

tty_kopen is getting the index from the tty_lookup_driver call (actually
get_tty_driver which uses p->minor_start and p->num) and passes it to
tty_driver_lookup_tty. Perhaps in addition of p->num the driver should
have another field to set, that tty_init_dev could use to reject with
ENODEV indexes beyond what the driver actually provides?

> I couldn't make the kernel warn/crash yet by specifying non-existent
> ttyUSB ports yet though.

That's probably because in the ttyUSB case the device allocation is
dynamic and made exactly according to the number of actual devices,
while for ttyS* there is a large overcommit of minor values.

Samuel
