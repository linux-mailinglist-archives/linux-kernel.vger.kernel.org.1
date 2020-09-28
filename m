Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454D827B12C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1PuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:50:10 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36975 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1PuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:50:09 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 19268FF809;
        Mon, 28 Sep 2020 15:50:06 +0000 (UTC)
Date:   Mon, 28 Sep 2020 17:50:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Thirumalesha N <nthirumalesha7@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mtd: spinand: micron: Generalize the function
 and structure names
Message-ID: <20200928175005.48783b61@xps13>
In-Reply-To: <20200928174505.75fda272@collabora.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
        <20200913161533.10655-2-nthirumalesha7@gmail.com>
        <20200915101321.1afa5033@xps13>
        <CALKVOUomKLZ5GEHmXb+VfEq8UiNUpCN-Vqkx3N+yykEnCrHkDA@mail.gmail.com>
        <20200928165528.54e5db6e@xps13>
        <20200928174505.75fda272@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 28 Sep
2020 17:45:05 +0200:

> On Mon, 28 Sep 2020 16:55:28 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > > IMHO, grouped means, ecc bytes are at continuous address, where as
> > > interleaved means ecc bytes splitted into multiple addresses    
> > 
> > I don't like the name. Interleaved means that there are OOB bytes
> > stored in the data section, which is not the case here.  
> 
> Well, I would argue that the term interleaved alone doesn't say
> anything about the things that are interleaved. But I guess

I should have said that interleaved, in this subsystem, generally refers
to in-band vs. out-of-band data.

> split/grouped would be fine too if you want to avoid re-using
> interleaved here.

split/grouped is fine by me.

> 
> > The way OOB
> > bytes are organized do not seem relevant to me, I think i prefer the
> > "_4_/_8_" naming,even if it's not very explicit.  
> 
> The ECC strength doesn't say anything about the scheme used for ECC
> bytes placement, and you might end up with 2 different schemes
> providing the same strength, or the same scheme used for 2 different
> strengths.

So perhaps both should be present in the name?
