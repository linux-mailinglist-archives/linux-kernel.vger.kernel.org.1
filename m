Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A327B1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1QZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:25:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgI1QZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:25:52 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3F4AA29AD51;
        Mon, 28 Sep 2020 17:25:49 +0100 (BST)
Date:   Mon, 28 Sep 2020 18:25:45 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thirumalesha N <nthirumalesha7@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mtd: spinand: micron: Generalize the function
 and structure names
Message-ID: <20200928182545.1e972f3b@collabora.com>
In-Reply-To: <20200928182159.5a6cf46a@xps13>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
        <20200913161533.10655-2-nthirumalesha7@gmail.com>
        <20200915101321.1afa5033@xps13>
        <CALKVOUomKLZ5GEHmXb+VfEq8UiNUpCN-Vqkx3N+yykEnCrHkDA@mail.gmail.com>
        <20200928165528.54e5db6e@xps13>
        <20200928174505.75fda272@collabora.com>
        <20200928175005.48783b61@xps13>
        <20200928180343.4c5302a5@collabora.com>
        <20200928182159.5a6cf46a@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 18:21:59 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 28 Sep
> 2020 18:03:43 +0200:
> 
> > On Mon, 28 Sep 2020 17:50:05 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > > > The way OOB
> > > > > bytes are organized do not seem relevant to me, I think i prefer the
> > > > > "_4_/_8_" naming,even if it's not very explicit.        
> > > > 
> > > > The ECC strength doesn't say anything about the scheme used for ECC
> > > > bytes placement, and you might end up with 2 different schemes
> > > > providing the same strength, or the same scheme used for 2 different
> > > > strengths.      
> > > 
> > > So perhaps both should be present in the name?    
> > 
> > No, the point was to re-use the same functions for various strengths if
> > they use the same ECC placement scheme.  
> 
> I get the point, but is the current implementation generic enough? I
> see hardcoded numbers, I have no idea if these numbers are common to
> all strength given a specific layout, or if they only match for a given
> strength?
> 
> +static int micron_4_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +
> +	if (section >= spinand->base.memorg.pagesize /
> +			mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	region->offset = (section * 16) + 8;
> +	region->length = 8;
> +
> +	return 0;
> +}
> 
> If possible, I would like to avoid several successive renaming.

Right, I thought those functions were patched to be generic, but that
doesn't seem to be the case, so I guess sticking to _<strength>_ makes
sense for now.
