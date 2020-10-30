Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EE2A07C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgJ3OY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:24:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58420 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3OY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604067867; x=1635603867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fi3ezR484UJE9S/iHTVxqIxtZBhvpJptVqXk3S5CYRM=;
  b=jGkpaHHbNAhPZ7iY4KBJ0Wn0Yc7UqX4macWoXMdEiae2xMiJIpC5vl6a
   Eh9eTvXYO53PTF7TlR8O9/Etw6gTHNz8VyT4G08ZNqpGFTuGLjQu+BWXM
   I5NZ+e56BQrDVtq94PTn70GGKZ6wsd44YXehVV6nftrrNyFxWBjXYeVdI
   gARccbaWD+TbWH7yHh3ncpLJ8tXxizJXG7AqKJiaZKme6oAi5/jryhOpZ
   pihPjWxIbHMhuBAkV6Og1xv2VpiKtnaFdMnzulhJneFcf1YzytaTPo9fq
   /BPdgfR/CZznj4xtVVrPNW0xgsEgbYDjMDorPz618sTDkNL1pqF5KL1el
   g==;
IronPort-SDR: gOAyZQ/xS8zJV8XDcYxw0e2QaOrMBsH1CCetkI66kOx/UY8xbmWw6Q+Sj1b6pGKJCUhi7rxMDd
 9BmJntKPFTeBe3/A11ao/75V48WxrZRUT5BCwKN8+7ckotA4ZjGhtutIQKfIoHf+dIntUh88wK
 ETB0mr4cyfh0KyoCsQeNU06YC3H0Ro/Fxg8n9RHOyRD68b5VQMDgq1clFAzZ7rj40ZRuir+k4I
 wZNT2J0f+3DPEi5O5IUj3Rilarbb6U1QPC11pd9jn126zwFsfk6zlY+RUDccmsYOi9XPrSJioY
 sd8=
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="91965309"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2020 07:24:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 30 Oct 2020 07:24:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 30 Oct 2020 07:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTh57yhuM1R5byV2MI/pA26krtIg+NQggmb0gWK7MDAP6aap4WhuPeW3CZJVzavYOjSCwq3phqIiO8xskO/s0z/2/ULX7e/xsHn/XWLtqOlX+3MpMrQ3QoO+z3ceLFEKt0jRXuVGA7Y7Wj93TsVkLki55AGoiHNKT3LYlPf3gnkkEmK/XhQa3CxQJHly3NJSWoejG00B+h75hkpUQNZCYwUnc67+sP7skeDUfG1N7q7j5hp+PRLcICDxyFvk5BaPST6uM+/T3yme0Z5Wi5xRp/Ny+WSKxmSz0PfgUgPJk3LAz0JPC61Tza/9guB5cWX/bL97FvBVdVVS+Aeyo3tvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi3ezR484UJE9S/iHTVxqIxtZBhvpJptVqXk3S5CYRM=;
 b=ii2glWileM0MJc45ZByHEvo4jc0IVee3EtqmUtF3GTm/7k4ZFhWmlNtxaZmEHlSNcpAefrT/DHK9Z8yp3WdOPe+4pv60PBJxeGXU5KHaeQb6wbeSlv0R1uORt+VrtZNmTeT6TXm/Lyl6x6t7up5JvOL5mGELyl78tx9L8LzmZOKzqKuk0Foo3+rRqZWZnADa1HLOWFheg/oI9+CWxsLk+wVpvXf4ZGQhYAZc7hlVIwdxDpAgrqo9IA1g/KU37xcI+xSUaP25KQxFRdgT5SXdE+LJRXNMjCP1rZO0fOonDMOm4hTkdM05toD/AQb2e1FzvqbwtrXZipMArVdQy9MPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi3ezR484UJE9S/iHTVxqIxtZBhvpJptVqXk3S5CYRM=;
 b=WrTExv/Hd9abZGvwZjpYPE1WelqOkmXY/J8jk3NZizleFShq/dI5VtvcDtbXgHO6I8/dq9Qe9IUIpmdbLGWzeBPV/oAq6Y5LwLSW4kLyy5tD9+R/Ve163mwr42m0lkU0lMNSA2NyvxMHfthwmLvv6HOqw8EcmyT3PH9GCbFQ9vw=
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 (2603:10b6:903:b1::22) by CY4PR11MB2006.namprd11.prod.outlook.com
 (2603:10b6:903:2f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 30 Oct
 2020 14:24:24 +0000
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e]) by CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 14:24:24 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.genoud@gmail.com>,
        <lee.jones@linaro.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Topic: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Index: AQHWrq0BNGYIfVuhjkKKUxhuAsgrHKmwJpcAgAAMyIA=
Date:   Fri, 30 Oct 2020 14:24:24 +0000
Message-ID: <f370bbf7-5cfc-1524-8103-061698ba6b67@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
In-Reply-To: <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [86.121.145.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 800cf4cf-7d45-4247-d4cb-08d87cdf806e
x-ms-traffictypediagnostic: CY4PR11MB2006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB20062DE86A62CBB1A15D7576E7150@CY4PR11MB2006.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVIdH68enQjc4v9G23QDmumMwQYszeS4SN5M+TSdt1zAOUI5xtJgXzD1RBQaEIAnUZw752Ynz6vcdztk0JFFq3om8pnPzqT2+AJQ12yZ87bGt15WrNZXs9knHdw/d1V1EFokSbe9QCElVlBFm1rAER1/W4eBnESPZ89lZ+aOjj6Jfrg9KOS1Yl8o1hy7T7rugD1CvaAWoF7K8jO3zkx0fTfRTCzxtzGP+aVgexUFq81I3ED05Pemn6qoaX32wjMIOHEZTHI/E1bDn+cKrQykY4Wv3Nn5wIPtp5pdD5098hT7F3+S/EZWY1xZUQcb3Ss9wXdKo6HfrVG7J/wnLGxQLASNTfFxuw0dugw5C4PEj2yS6000RdjGD0Fid0LkxI8D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(2906002)(71200400001)(107886003)(64756008)(8936002)(66446008)(91956017)(76116006)(66476007)(66556008)(8676002)(36756003)(26005)(316002)(66946007)(5660300002)(4326008)(478600001)(2616005)(6486002)(31696002)(53546011)(6512007)(54906003)(110136005)(31686004)(186003)(83380400001)(86362001)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: q71Hl5AScYHFPt3zv5urPRsyB3ujIKbhp0IXBH3nvQ3DK3dhypFogwOWC8U9zIUnUjImHl+Nqa36BPQ7BIiYd6QGyiE1gWQVtYbMlbdHg66IJBBEhRZY/vM1PZxEO+xpbB3TazpBrNttNY7jbBfSs9vv1wyEcl5BPkNIJ2zS/8wqRJaJCwSwH1a1PsbxLR4ZFA50ipUfFiPq9+6LWf6wbOsiNftyWXHotoKxAUThNx47d8ViwCZOwjf/ZTYEnBLxk8NUU/gyFBp/MujDtxJLNwd1Cjzydllys4FU3Ld94lw0TCIKLT7tyXusyqY02ITzdSlS6HWPuqYxWdd41xJAPLuSOp67E9HTyL2khcjTKbbSSXIcrw4giIlVCaQdvmIamnGPEiCBL1o0wrhrGnl+kycN30EOBDb5GB0g/Q12KC2A/g9z7nx1gOHBAlKNeay0qVA+hHJv1TzeLje/GUVdmFjyh1Xx3snHw40njxithRyjfiwMUVt114sT0L1oAlgTbn8iD8HJuRsR3TY0VrzeM0bOgV2YJYzzafqfU3kPlolehSYu92DyClcdn4WXlMyvZ8DSAfjNoFWZ2BTS7suJLiwtyScGSObRyrLXFmKDk+VjaEi3sACtTca6Icy0o+bmyMkJD3bkk7XnKK+aJQLVSA==
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BF7A8435D1C5F84AB77750FB2CD43A21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800cf4cf-7d45-4247-d4cb-08d87cdf806e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 14:24:24.6393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Y8ahwWL/DKGa+gJMImP2BZsYLlxMzVlAe6Zj0OgV4zXxFh2B9GgWyHvqTyvQp5KRKzUcFJBacmR02veCcm+pme7cevLfsO5gQPmhZ7hS5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2020 15:38, Nicolas Ferre wrote:
> On 30/10/2020 at 12:07, Codrin Ciubotariu wrote:
>> The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs=20
>> sub-nodes
>> to match the registered platform device. For this reason, we add a seria=
l
>> subnode to all the "atmel,at91sam9260-usart" serial compatible nods. Thi=
s
>> will also remove the boot warning:
>> "atmel_usart_serial: Failed to locate of_node [id: -2]"
>=20
> I don't remember this warning was raised previously even if the MFD=20
> driver was added a while ago (Sept. 2018).
>=20
> I would say it's due to 466a62d7642f ("mfd: core: Make a best effort=20
> attempt to match devices with the correct of_nodes") which was added on=20
> mid August and corrected with 22380b65dc70 ("mfd: mfd-core: Ensure=20
> disabled devices are ignored without error") but maybe not covering our=20
> case.

Well, it's not covering our enabled devices.

>=20
> So, well, I don't know what's the best option to this change. Moreover,=20
> I would say that all other USART related properties go into the child=20
> not if there is a need for one.
>=20
> Lee, I suspect that we're not the only ones experiencing this ugly=20
> warning during the boot log: can you point us out how to deal with it=20
> for our existing atmel_serial.c users?

My understading is that platform devices registered by MFD should have a=20
correspondig DT node. The parrent properties are also available for the=20
other usart device (usart-spi), so I think we should keep them in the=20
parrent.

Best regards,
Codrin
