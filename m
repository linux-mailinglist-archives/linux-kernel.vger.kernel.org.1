Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8092527CE29
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgI2MzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:55:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36302 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgI2MzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:55:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TCse9R110421;
        Tue, 29 Sep 2020 07:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601384080;
        bh=RSyzf4BzQ5d5cDLo5NJTHQRueZGxJivPH++jRF/7jUg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WKuwA7wsXF2jpnDr3rV9y9iCJMCjoIIkvKD4vjx9HkBUuLf/DlSTUuNQiXDK/1tJx
         L6PLsODR3S4KP5OM8+ASr/9SoIDO9SKvYY/gfKg9r99HYB4PCzDMiqvMxuk1XEoXSX
         qUTCAfBx3S/Pq5ln+qWGO7zGTF83oFVBcv7ayWHo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TCseQ6081898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 07:54:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 07:54:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 07:54:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TCsdbw103191;
        Tue, 29 Sep 2020 07:54:39 -0500
Date:   Tue, 29 Sep 2020 18:24:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 02/15] mtd: spi-nor: core: add
 spi_nor_{read,write}_reg() helpers
Message-ID: <20200929125436.pxu4omgxajbn6tfj@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-3-p.yadav@ti.com>
 <8632e742-9526-fd80-8980-2792075f194c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8632e742-9526-fd80-8980-2792075f194c@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/20 11:38AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > They are thin wrappers around nor->controller_ops->{read,write}_reg().
> > In a future commit DTR support will be added. These ops can not be
> > supported by the {read,write}_reg() hooks and these helpers will make it
> > easier to reject those calls.
> 
> 2/15 and 3/15 are introducing wrappers for the controller ops. How about
> squashing the commits and using the same naming scheme?
> 
> spi_nor_controller_ops_{read_reg,write_reg,erase}

Ok. Will do. For my information, the patches will still go in this merge 
window, right?

-- 
Regards,
Pratyush Yadav
Texas Instruments India
