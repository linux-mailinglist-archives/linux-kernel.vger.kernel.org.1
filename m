Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9893F2B90AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKSLIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 06:08:11 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33117 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKSLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:08:10 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 358566000F;
        Thu, 19 Nov 2020 11:08:06 +0000 (UTC)
Date:   Thu, 19 Nov 2020 12:08:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Gleixner <gleixner@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 01/23] mtd: mtdpart: Fix misdocumented function
 parameter 'mtd'
Message-ID: <20201119120804.549e2e79@xps13>
In-Reply-To: <20201119091402.GY1869941@dell>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
        <20201106213655.1838861-2-lee.jones@linaro.org>
        <20201119091402.GY1869941@dell>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Thu, 19 Nov 2020 09:14:02
+0000:

> On Fri, 06 Nov 2020, Lee Jones wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/mtd/mtdpart.c:300: warning: Function parameter or member 'mtd' not described in '__mtd_del_partition'
> >  drivers/mtd/mtdpart.c:300: warning: Excess function parameter 'priv' description in '__mtd_del_partition'
> > 
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Cc: Thomas Gleixner <gleixner@linutronix.de>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: linux-mtd@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> 
> Is there anything else you need from me Miquel, or does the set now
> look suitable for inclusion?
> 

It's totally fine by me, I will apply the series soon.

Thanks!
Miquèl
