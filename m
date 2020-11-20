Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E62BA961
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKTLmw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Nov 2020 06:42:52 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39519 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgKTLmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:42:52 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AE8DE240009;
        Fri, 20 Nov 2020 11:42:47 +0000 (UTC)
Date:   Fri, 20 Nov 2020 12:42:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 23/23] mtd: devices: powernv_flash: Add function
 names to headers and fix 'dev'
Message-ID: <20201120124246.4aee04d6@xps13>
In-Reply-To: <20201120075000.GA1869941@dell>
References: <20201109182206.3037326-24-lee.jones@linaro.org>
        <20201119210716.25046-1-miquel.raynal@bootlin.com>
        <20201120075000.GA1869941@dell>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lee Jones <lee.jones@linaro.org> wrote on Fri, 20 Nov 2020 07:50:00
+0000:

> On Thu, 19 Nov 2020, Miquel Raynal wrote:
> 
> > On Mon, 2020-11-09 at 18:22:06 UTC, Lee Jones wrote:  
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
> > >  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
> > >  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
> > >  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'
> > > 
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linux-mtd@lists.infradead.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> > 
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.  
> 
> Superstar.  Thanks for your help Miquel.
> 

haha :) well it was late, I applied these patches to the wrong branch,
I just moved them to the mtd/next branch, sorry for the push -f :)

Cheers,
Miquèl
