Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2E27F99A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgJAGmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:42:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54906 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:42:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0916fvGe112995;
        Thu, 1 Oct 2020 01:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601534517;
        bh=WAQBSDfsouAtHKLExKivcljiQxBv5HXEbRiRoGIS/Cw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AfHKGOGv7buJ3sRUXOdvyiBGF3Q8wq6WeGkgzSrk+x0OqBdXc0/QSKRvlYL+LCnig
         cC42BDKKacVtiPHhARtZlHXVeqdyLZNavPhU3/GuO+y/wtOHFo96K5+GJs49s0O4wc
         RgUTfhdFaQjBnB88n0rwf1/fVyZtL8Xe4bpzXlYw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916fvNL040434;
        Thu, 1 Oct 2020 01:41:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 01:41:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 01:41:57 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916fspd008476;
        Thu, 1 Oct 2020 01:41:55 -0500
Subject: Re: [PATCH 11/11] soc: ti: k3-socinfo: Add entry for AM64 SoC family
To:     Grygorii Strashko <grygorii.strashko@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Anna, Suman" <s-anna@ti.com>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-12-peter.ujfalusi@ti.com>
 <aa10c7a1-ddbd-a3ae-3035-f26a5ce073ae@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <c2dcf5a3-abff-923c-7610-a670f02479e6@ti.com>
Date:   Thu, 1 Oct 2020 09:42:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <aa10c7a1-ddbd-a3ae-3035-f26a5ce073ae@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 30/09/2020 16.56, Grygorii Strashko wrote:
>=20
>=20
> On 28/09/2020 11:34, Peter Ujfalusi wrote:
>> It's JTAG PARTNO is 0xBB38.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> =C2=A0 drivers/soc/ti/k3-socinfo.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c=

>> index bbbc2d2b7091..a14ec68846dd 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -40,6 +40,7 @@ static const struct k3_soc_id {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xBB5A, "AM65X" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xBB64, "J721E" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xBB6D, "J7200" },
>> +=C2=A0=C2=A0=C2=A0 { 0xBB38, "AM64" }
>=20
> Shouldn't it be AM64X

Good point, I'll fix this up and then the DMA series.

While here, what do you think: should we keep the DMA compatibles as I
have them in v1 (am64-dmss-bcdma and am64-dmss-pktdma):
https://lore.kernel.org/lkml/20200930091412.8020-10-peter.ujfalusi@ti.com=
/
https://lore.kernel.org/lkml/20200930091412.8020-11-peter.ujfalusi@ti.com=
/

or change them to am64x-dmss-* ?

I'll ask Rob on the binding doc patches as well.

>=20
>> =C2=A0 };
>> =C2=A0 =C2=A0 static int
>>
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

