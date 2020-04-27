Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6095D1BADAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD0TPj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Apr 2020 15:15:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43365 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD0TPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:15:39 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 81C58C0006;
        Mon, 27 Apr 2020 19:15:36 +0000 (UTC)
Date:   Mon, 27 Apr 2020 21:15:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/3] mtd: lpddr: Replace printk with pr_notice
Message-ID: <20200427211534.01b57587@xps13>
In-Reply-To: <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
        <c9684a22b661fdeff9efcd5b18be01653911fc89.1588013366.git.gustavo@embeddedor.com>
        <d036dbad02241fdeb0a6400896f73ff11e98e53b.camel@perches.com>
        <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 27 Apr
2020 14:10:36 -0500:

> On 4/27/20 14:01, Joe Perches wrote:
> > On Mon, 2020-04-27 at 14:03 -0500, Gustavo A. R. Silva wrote:  
> >> pr_notice is preferred over printk.  
> > 
> > So is coalescing formats
> > 
> > ? diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> > []  
> >> @@ -127,31 +127,31 @@ static inline void print_drs_error(unsigned dsr)
> >>  	int prog_status = (dsr & DSR_RPS) >> 8;
> >>  
> >>  	if (!(dsr & DSR_AVAILABLE))
> >> -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> >> +		pr_notice("DSR.15: (0) Device not Available\n");
> >>  	if ((prog_status & 0x03) == 0x03)
> >> -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> >> +		pr_notice("DSR.9,8: (11) Attempt to program invalid "
> >>  						"half with 41h command\n");  
> > 
> > 		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
> >   
> 
> I didn't want to mess with the rest of format, because some maintainers
> don't like that. If Miquel is OK with that, I can fix that up, too.
> 
> Thanks
> --
> Gustavo

I'm fine with it in this case, just mention it in the commit log,
please.

Thanks,
Miquèl
