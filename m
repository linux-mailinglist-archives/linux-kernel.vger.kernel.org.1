Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E792A445B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgKCLfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:35:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51800 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:35:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3BZ4a9061252;
        Tue, 3 Nov 2020 05:35:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604403304;
        bh=i5qmm6XtD0qOEO+O0ff0XQHneo6s1jIS3e5zUTXHF24=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CSvnqGSKoA1NACbmhJse9FBkl3F1Y7uDVJLiuesvGE24K33uGlRicBzE3ns8OEI1Y
         /gL3QG8ggOMd6LINvr4Ck7F+UKKpF7k1pIzGsF0y4xthVaOXeUXoc0KmYtwKI26RlJ
         WJirwK0fmduoEvuzfs4soLngvRB7eWbnkhjZTlDo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3BZ4IF049563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 05:35:04 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 05:35:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 05:35:04 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3BZ1m3084217;
        Tue, 3 Nov 2020 05:35:02 -0600
Subject: Re: [PATCH 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201012180404.6476-1-p.yadav@ti.com>
 <20201027111804.e27pyvf62eksngmp@ti.com>
 <CAFLxGvxc=EqBStzLz3ApwYDomKMe=WeK22ohfPQs1WrMCsaVQg@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <fa578bda-132a-320a-264c-d973bae194dd@ti.com>
Date:   Tue, 3 Nov 2020 17:05:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxc=EqBStzLz3ApwYDomKMe=WeK22ohfPQs1WrMCsaVQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/20 3:14 AM, Richard Weinberger wrote:
> On Tue, Oct 27, 2020 at 12:24 PM Pratyush Yadav <p.yadav@ti.com> wrote:
>>> [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/
>>
>> Ping. Any comments on the series?
> 
> From the UBIFS point of view I'd like to avoid as many device specific
> settings as possible.
> We check already for NOR flash, checking for NOR *and* SPI_NOR_NO_MULTI_PASS_PP
> feels a bit clumsy.
> 
> Tudor, what do you think about SPI_NOR_NO_MULTI_PASS_PP?
> This kind of NOR seems to be a little NAND'ish. Maybe we can hide this detail
> in the mtd framework?
> 

Agree with Richard. I don't see need for SPI_NOR_NO_MULTI_PASS_PP. From
MTD point of view setting mtd->writesize to be equal to pagesize should
be enough. Its upto clients of MTD devices to ensure there is no multi
pass programming within a "writesize" block.

If this is not clear in the current documentation of struct mtd, then
that can be updated.

Regards
Vignesh
