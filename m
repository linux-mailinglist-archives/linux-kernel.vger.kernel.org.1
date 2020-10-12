Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7D28AEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgJLHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:04:26 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57231 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgJLHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:04:25 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B13F6E000A;
        Mon, 12 Oct 2020 07:04:21 +0000 (UTC)
Date:   Mon, 12 Oct 2020 09:04:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: parsers: bcm63xx: Do not make it modular
Message-ID: <20201012090420.6a07599c@xps13>
In-Reply-To: <20201011141447.GA9215@roeck-us.net>
References: <20200928161617.2a1b2244@xps13>
        <20200929172726.30469-1-f.fainelli@gmail.com>
        <20201011141447.GA9215@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> wrote on Sun, 11 Oct 2020 07:14:47
-0700:

> On Tue, Sep 29, 2020 at 10:27:21AM -0700, Florian Fainelli wrote:
> > With commit 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE
> > detection"), we generate a reference to fw_arg3 which is the fourth
> > firmware/command line argument on MIPS platforms. That symbol is not
> > exported and would cause a linking failure.
> > 
> > The parser is typically necessary to boot a BCM63xx-based system anyway
> > so having it be part of the kernel image makes sense, therefore make it
> > 'bool' instead of 'tristate'.
> > 
> > Fixes: 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE detection")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>  
> 
> What happened with this patch ? The build failure is still seen in mainline
> and in next-20201009.

It has been applied on mtd/next:
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=mtd/next
(I don't remember when though)
