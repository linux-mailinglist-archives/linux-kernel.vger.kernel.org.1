Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3D27B1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1QWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 12:22:03 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41823 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:22:03 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 656301C000B;
        Mon, 28 Sep 2020 16:22:00 +0000 (UTC)
Date:   Mon, 28 Sep 2020 18:21:59 +0200
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
Message-ID: <20200928182159.5a6cf46a@xps13>
In-Reply-To: <20200928180343.4c5302a5@collabora.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
        <20200913161533.10655-2-nthirumalesha7@gmail.com>
        <20200915101321.1afa5033@xps13>
        <CALKVOUomKLZ5GEHmXb+VfEq8UiNUpCN-Vqkx3N+yykEnCrHkDA@mail.gmail.com>
        <20200928165528.54e5db6e@xps13>
        <20200928174505.75fda272@collabora.com>
        <20200928175005.48783b61@xps13>
        <20200928180343.4c5302a5@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 28 Sep
2020 18:03:43 +0200:

> On Mon, 28 Sep 2020 17:50:05 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > > > The way OOB
> > > > bytes are organized do not seem relevant to me, I think i prefer the
> > > > "_4_/_8_" naming,even if it's not very explicit.      
> > > 
> > > The ECC strength doesn't say anything about the scheme used for ECC
> > > bytes placement, and you might end up with 2 different schemes
> > > providing the same strength, or the same scheme used for 2 different
> > > strengths.    
> > 
> > So perhaps both should be present in the name?  
> 
> No, the point was to re-use the same functions for various strengths if
> they use the same ECC placement scheme.

I get the point, but is the current implementation generic enough? I
see hardcoded numbers, I have no idea if these numbers are common to
all strength given a specific layout, or if they only match for a given
strength?

+static int micron_4_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+
+	if (section >= spinand->base.memorg.pagesize /
+			mtd->ecc_step_size)
+		return -ERANGE;
+
+	region->offset = (section * 16) + 8;
+	region->length = 8;
+
+	return 0;
+}

If possible, I would like to avoid several successive renaming.

Thanks,
Miquèl
