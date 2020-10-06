Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756FB284B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgJFLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:40:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFLkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:40:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096BeQfR120482;
        Tue, 6 Oct 2020 06:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601984426;
        bh=gk+2qUIMQWuyNdV4sTokPJU6E+XSqonOsjTKKCf0OR4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Asts4OR2kH069b6/rSAUEAVtrjAsBvS/LDn1UeDSWEl6TfIvFtAs6PIzmz5dS4mCo
         txynuqsc6KYn/f/eMrTlCE+c8+txc82dasGHpuR1DyiN9qUbobXGfz2z+BkhBTJEp2
         fxdqsNmg0kEQI8vd2LWdDRoLax6+3kA8fsppGFik=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096BeQuY006999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 06:40:26 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 06:40:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 06:40:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096BePv9121668;
        Tue, 6 Oct 2020 06:40:25 -0500
Date:   Tue, 6 Oct 2020 17:10:24 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <bert@biot.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Message-ID: <20201006114022.cwc6mnpboeuzrezd@ti.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <ed7e13a5-db3e-79ad-0cdc-d2875cef2d22@microchip.com>
 <73a258f3-45dd-1354-d5fd-904d5e372d2c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73a258f3-45dd-1354-d5fd-904d5e372d2c@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/20 11:19AM, Tudor.Ambarus@microchip.com wrote:
> On 10/6/20 2:03 PM, Tudor Ambarus - M18064 wrote:
> > On 10/1/20 9:34 AM, Pratyush Yadav wrote:
> >> So using an address width of 4 here is not necessarily the right thing
> >> to do. This change would break SMPT parsing for all flashes that use
> >> 3-byte addressing by default because SMPT parsing can involve register
> >> reads/writes. One such device is the Cypress S28HS flash. In fact, this
> >> was what prompted me to write the patch [0].
> > 
> > Do you refer to spi_nor_get_map_in_use()?
> 
> oh, I see. If addr width is set via the SMPT_CMD_ADDRESS_LEN_USE_CURRENT,
> case, and if the flash comes in 4 byte address mode from a bootloader,
> then setting addr_width to 3 in case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4,
> will break the reading of the map.

Yes it will but that is not the problem I was trying to solve. The 
problem is simply that nor->addr_width is 0 without the
BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 case that I added, since BFPT parsing 
won't touch it at all. And so SMPT_CMD_ADDRESS_LEN_USE_CURRENT results 
in the command using an op.addr.nbytes == 0 for the register read even 
though op.addr.val is set correctly. This means the controller skips the 
address phase and the register read fails.

Defaulting to 3 for the BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 case means 
op.addr.nbytes is correctly set to 3 and register read works correctly 
and SMPT parsing correctly detects the current configuration.

If the address width is set to 4 by the bootloader then we have the same 
problem in some ways as the 8D boot problem where we have no way of 
easily detecting which mode is being used. I did not try to solve that 
problem with this change.
 
> If the Address Mode bit is volatile, maybe we can reset the flash to
> its power on state immediately after identification. For the NV bits,
> we have the same recurring problem.

Yes, the U-Boot xSPI series I sent does this somewhat. It issues a soft 
reset before handing control over to the kernel, so the kernel sees the 
flash in PoR state. This also helps when U-Boot uses the flash in 8D 
mode.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
