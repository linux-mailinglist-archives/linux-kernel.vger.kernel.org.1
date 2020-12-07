Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110662D0E55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgLGKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLGKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:44:04 -0500
X-Greylist: delayed 1455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Dec 2020 02:43:24 PST
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07946C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 02:43:24 -0800 (PST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kmDbk-0003Gv-1N; Mon, 07 Dec 2020 11:19:04 +0100
Date:   Mon, 7 Dec 2020 11:19:04 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <20201207101904.GC2265@angband.pl>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
 <X8n1JiDS8ZVA6e6o@kroah.com>
 <8e993706-46e2-cbed-265f-1ba63cc9274d@kernel.org>
 <X8n8+Dhi9RT4bfHk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X8n8+Dhi9RT4bfHk@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:10:16AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 04, 2020 at 09:51:07AM +0100, Jiri Slaby wrote:
> > > > > On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
> > > > > > On 03. 12. 20, 3:03, Jann Horn wrote:
> > > > > > > Delete this dead code; but leave the definition of struct termiox in the
> > > > > > > UAPI headers intact.
[was snipped]
> > > > > > I am thinking -- can/should we mark the structure as deprecated so that                                 
> > > > > > userspace stops using it eventually?   

> > Note this ^^^^^. He is talking about _not_ touching the definition in the
> > UAPI header. Does the rest below makes more sense now?
> 
> No, I'm still confused :)
> 
> We can't touch the UAPI definitions, but the fact that this api never
> did anything still is ok as after this patch it continues to not do
> anything.
> 
> I'm confused as to what you are proposing...

The UAPI definition can't be removed, but it would be nice to issue a
compiler _warning_ if it's ever used.

Like eg. __attribute__ ((deprecated))


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀    .--[ Makefile ]
⣾⠁⢠⠒⠀⣿⡁    # beware of races
⢿⡄⠘⠷⠚⠋⠀    all: pillage burn
⠈⠳⣄⠀⠀⠀⠀    `----
