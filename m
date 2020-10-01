Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0D27FB90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgJAIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:37:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37660 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:37:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0918bgBD053910;
        Thu, 1 Oct 2020 03:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601541462;
        bh=Hi8WgMTw+/dEZZLoXlkBElU7G3gt+3V10JrngjJzxwI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=o0Y2JkObjtO7UyzG5aFY2Q7/r7HweK13KhBazrgv1MR+vMjjUfYe1KJCqlsPWLunD
         jZLGTMmOB7FPNcFpI7AN7cEG955mGy7yTEzxHA+Ftr/Fd6qw/GaejBFAlszK1ANxdU
         hyp3W3smevtMJE/n7pp8vK0K3Ae86WbWyWM3SNR4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0918bgvs059099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 03:37:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 03:37:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 03:37:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0918beBV092139;
        Thu, 1 Oct 2020 03:37:41 -0500
Date:   Thu, 1 Oct 2020 14:07:39 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 03/15] mtd: spi-nor: add support for DTR protocol
Message-ID: <20201001083737.iacunfb7l75elvex@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-4-p.yadav@ti.com>
 <67f14906-ef28-ff4c-b41f-3500c9212ad7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67f14906-ef28-ff4c-b41f-3500c9212ad7@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 07:46AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > @@ -2387,12 +2496,16 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor 
> > *nor, u32 *hwcaps)
> >         struct spi_nor_flash_parameter *params = nor->params;
> >         unsigned int cap;
> > 
> > -       /* DTR modes are not supported yet, mask them all. */
> > -       *hwcaps &= ~SNOR_HWCAPS_DTR;
> > -
> >         /* X-X-X modes are not supported yet, mask them all. */
> >         *hwcaps &= ~SNOR_HWCAPS_X_X_X;
> > 
> > +       /*
> > +        * If the reset line is broken, we do not want to enter a stateful
> > +        * mode.
> > +        */
> > +       if (nor->flags & SNOR_F_BROKEN_RESET)
> > +               *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
> 
> SNOR_HWCAPS_X_X_X is already masked out above. Do we need to do it again?

That might change later and the person removing that line might not 
remember or even know to add it back here.
 
> > +
> >         for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
> >                 int rdidx, ppidx;
> > 
> > @@ -2967,7 +3098,9 @@ static int spi_nor_init(struct spi_nor *nor)
> >                 return err;
> >         }
> > 
> > -       if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
> > +       if (nor->addr_width == 4 &&
> > +           nor->read_proto != SNOR_PROTO_8_8_8_DTR &&
> > +           !(nor->flags & SNOR_F_4B_OPCODES)) {
> >                 /*
> >                  * If the RESET# pin isn't hooked up properly, or the system
> >                  * otherwise doesn't perform a reset command in the boot
> > @@ -3024,7 +3157,21 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
> > 
> >  static int spi_nor_set_addr_width(struct spi_nor *nor)
> >  {
> > -       if (nor->addr_width) {
> > +       if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
> 
> This should come as an "else if". We need to let the posibility to retrieve
> addr_width from SFDP, the standard knows better than us.

Ok. Will fix.
 
> With these addressed, one can add:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> > +               /*
> > +                * In 8D-8D-8D mode, one byte takes half a cycle to transfer. So
> > +                * in this protocol an odd address width cannot be used because
> > +                * then the address phase would only span a cycle and a half.
> > +                * Half a cycle would be left over. We would then have to start
> > +                * the dummy phase in the middle of a cycle and so too the data
> > +                * phase, and we will end the transaction with half a cycle left
> > +                * over.
> > +                *
> > +                * Force all 8D-8D-8D flashes to use an address width of 4 to
> > +                * avoid this situation.
> > +                */
> > +               nor->addr_width = 4;
> > +       } else if (nor->addr_width) {
> >                 /* already configured from SFDP */
> >         } else if (nor->info->addr_width) {
> >                 nor->addr_width = nor->info->addr_width;

-- 
Regards,
Pratyush Yadav
Texas Instruments India
