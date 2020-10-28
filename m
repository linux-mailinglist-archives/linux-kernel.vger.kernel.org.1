Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920C029DC47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgJ2AXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:23:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55198 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbgJ1Whn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:37:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SK2OQ2015527;
        Wed, 28 Oct 2020 15:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603915344;
        bh=o3y/Ko52UWOP2r6NyGzju3m7wUK+9F50IDH+1PbV1+I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nAcmELvF+vjrrNcZ81hM8wmF68PPe10VPfwKmZrWz/XYSRMnDLoDoh+hs9UOG/+zE
         nTszN8+SY4GsULIBwZLVpNvyG2lpwFP3nWiIKYALcy9SIjP+SVepLE3ggIDUdcllia
         IAvXSYIvF3WiAzhyBLCUC7oIC1JhpS6BjjY0mUxM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SK2OT3092998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 15:02:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 15:02:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 15:02:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SK2Mgs047010;
        Wed, 28 Oct 2020 15:02:23 -0500
Date:   Thu, 29 Oct 2020 01:32:22 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20201028200220.eskcgrf2bqzzijz5@ti.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
 <20201028124920.pot77v4phkqiswhr@ti.com>
 <d9d96eda-4cb6-fe68-7469-e73dc7ba2fda@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9d96eda-4cb6-fe68-7469-e73dc7ba2fda@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/20 03:21PM, Tudor.Ambarus@microchip.com wrote:
> On 10/28/20 2:49 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Tudor,
> > 
> > On 28/10/20 07:53AM, Tudor.Ambarus@microchip.com wrote:
> >> Hi, Pratyush,
> >>
> >> On 10/5/20 6:31 PM, Pratyush Yadav wrote:
> >>> Tested on Micron MT35X and S28HS flashes for Octal DTR.
> >>
> >> Do these flashes define the "Command Sequences to Change to
> >> Octal DDR (8D-8D-8D) mode" table? Can't we use that table
> >> instead of defining our own octal dtr enable functions?
> > 
> > The Micron flash does not have this table. The Cypress flash does. The
> > problem is that one of the samples of the Cypress flash I tested on had
> > incorrect data in that table which meant the sequence would fail. The
> > newer samples of the flash have the correct data.
> 
> Can we differentiate the Cypress flashes?

No way I know of.

> Do you remember what was the incorrect data?

The address width for the write register command was 4 bytes when the 
flash uses 3 bytes by default.
 
> > 
> > I don't know how many of those faulty flashes are out there in the wild.
> > IMO, to be on the safe side spi_nor_cypress_octal_dtr_enable() needs to
> > be implemented. So from the point of view of this series there is no
> > need to parse the Octal DDR enable table.
> 
> Meh, we cover manufacturer's mistakes. On the long run, our aim should be
> to follow the SFDP standard and if a flash implements it wrong, to either
> fix it via a fixup hook (if the fix is minimal), or to skip the faulty
> table.
> 
> Regarding "Command Sequences to Change to Octal DDR (8D-8D-8D) mode"
> table. Have you looked over
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-4-git-send-email-masonccyang@mxic.com.tw/
> ?
> Is there a standard way to determine the offsets of opcode, addr and
> data in the cmd seq?

To be honest the spec does not say much about how the data should be 
interpreted so I am not sure either. My understanding is that those are 
effectively data bytes to send out on the bus.

One way to implement such a function, would be to put the first byte as 
the command opcode and the rest as data [0], with no address and dummy 
cycles. So no matter the address length, the controller should send out 
the bytes in sequence and then the flash can interpret them according to 
the address width it expects.

The downside is that someone debugging this on the controller's end 
might get confused seeing an opcode that expects an address phase but 
SPI NOR not sending one.

The other way would be to use the first byte as opcode, the next 
nor->addr_width bytes as address and the remaining as data, with no 
dummy cycles. This would fail if the 8D enable command does not use 
nor->addr_width address bytes [1].

I don't know which of the two is better but I think both are better than 
the switch-case hackery in Mason's patch which has to assume either the 
address width or the data length and leaves no way to play around with 
them in fixup hooks. If you have any better ideas I'm all ears.

[0] AFAIK many controllers can't have 0 command bytes.
[1] I'm not sure how common that would be though.
 
> Cheers,
> ta
> > 
> >> I see that Mason used this table for a macronix flash:
> >> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-4-git-send-email-masonccyang@mxic.com.tw/
> >> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw/
> >>
> >> Cheers,
> >> ta
> > 
> > --
> > Regards,
> > Pratyush Yadav
> > Texas Instruments India
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
