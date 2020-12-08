Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A602D31D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgLHSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:11:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37080 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgLHSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:11:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8IAsIO060952;
        Tue, 8 Dec 2020 12:10:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607451054;
        bh=KukNEevA95t01KvHxeKqUpiG0yj/87OEttzDlhLnfr0=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=PKZxcP+91fPhvIxMRdbBkUtI4nXDQzONgYsz8byNZB3dB+0NAb1KEHlTOUGkXYakv
         8qpzWjAbYUGrHTxtNkSDml9JYmGMD7a0VGII0YEx2MkTP0gyTZDjPeF1LN05xA3AVC
         vCc/B8EK65qDnf+WNRW0TLr9rtieCum6MKk4TIBc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8IAs7A103397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 12:10:54 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 12:10:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 12:10:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8IArMI058897;
        Tue, 8 Dec 2020 12:10:53 -0600
Date:   Tue, 8 Dec 2020 23:40:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR
 flashes
Message-ID: <20201208181050.z747aiiccoxj6xqz@ti.com>
References: <20201201102711.8727-1-p.yadav@ti.com>
 <20201201102711.8727-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201201102711.8727-2-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

On 01/12/20 03:57PM, Pratyush Yadav wrote:
> For NOR flashes EC and VID are zeroed out before an erase is issued to
> make sure UBI does not mistakenly treat the PEB as used and associate it
> with an LEB.
> 
> But on some flashes, like the Cypress Semper S28 SPI NOR flash family,
> multi-pass page programming is not allowed on the default ECC scheme.
> This means zeroing out these magic numbers will result in the flash
> throwing a page programming error.
> 
> Do not zero out EC and VID for such flashes. A writesize > 1 is an
> indication of an ECC-ed flash.

Patches 2/3 and 3/3 have been picked up in the spi-nor tree. Can you 
please pick this patch up?

-- 
Regards,
Pratyush Yadav
Texas Instruments India
