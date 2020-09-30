Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890927E2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgI3Hbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:31:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40466 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Hbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:31:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U7VFMH125005;
        Wed, 30 Sep 2020 02:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601451075;
        bh=itvI/CIHIsWpw2HWqaBatszoRYACu5nS402WozX/250=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=C6Jfh4eOAUFVJ5Pm/4rPpLqX87niwWsMTC7yvV7rvVChlNKx7/HepPZNdmZyRAzHJ
         5Qpr3PtL7OnF2vaZ7qC0WrIzo/ORqmFaFBo3ms/gLdbzM4LnhHBaThdI3HkdpnZC5D
         Nt+rvIKgpAWDEwtvkNbC/eLn3PaErLaAXf5a1Dy0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U7VF01072435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 02:31:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 02:31:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 02:31:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U7VDKw107865;
        Wed, 30 Sep 2020 02:31:14 -0500
Date:   Wed, 30 Sep 2020 13:01:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 10/15] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Message-ID: <20200930073111.sk67oqn6hkihmrfd@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-11-p.yadav@ti.com>
 <8346524d-487b-a147-6183-e8055a7ff54a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8346524d-487b-a147-6183-e8055a7ff54a@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 07:23AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > A Soft Reset sequence will return the flash to Power-on-Reset (POR)
> > state. It consists of two commands: Soft Reset Enable and Soft Reset.
> > Find out if the sequence is supported from BFPT DWORD 16.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.h | 1 +
> >  drivers/mtd/spi-nor/sfdp.c | 4 ++++
> >  drivers/mtd/spi-nor/sfdp.h | 2 ++
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> > index 6d7243067252..8ae55e98084e 100644
> > --- a/drivers/mtd/spi-nor/sfdp.h
> > +++ b/drivers/mtd/spi-nor/sfdp.h
> > @@ -90,6 +90,8 @@ struct sfdp_bfpt {
> >  #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD                (0x4UL << 20)
> >  #define BFPT_DWORD15_QER_SR2_BIT1              (0x5UL << 20) /* Spansion */
> > 
> > +#define BFPT_DWORD16_SOFT_RST                  BIT(12)
> 
> the name is too generic. How about
> 
> #define BFPT_DWORD16_SWRST_EN_RST		BIT(12)

Ok.

> 
> > +
> >  #define BFPT_DWORD18_CMD_EXT_MASK              GENMASK(30, 29)
> >  #define BFPT_DWORD18_CMD_EXT_REP               (0x0UL << 29) /* Repeat */
> >  #define BFPT_DWORD18_CMD_EXT_INV               (0x1UL << 29) /* Invert */

-- 
Regards,
Pratyush Yadav
Texas Instruments India
