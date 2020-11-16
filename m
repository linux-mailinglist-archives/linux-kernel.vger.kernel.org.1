Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4A2B3D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgKPGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:46:25 -0500
Received: from mail-db8eur05on2093.outbound.protection.outlook.com ([40.107.20.93]:38624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgKPGqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:46:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoV47+UdW38TTV3/ZHgHFJ8lhIRQbX66cLTTzQiyQ/7LEQ4wYJdO05GYd9K1/CpyxEk35s0vRO/ypt0Tdxee3iTvVeeUSmzi6bkkqJcv6vXeSZIa5bzf+2LuPf/QoBp9hJkSdY0fdSEicuSDt6SftErugDdrxiM6QMgmZUO2mK/XkPW/WYOvkyl8lF5H3R6UxL0wfYYMCpsoNh/R72dH6PCq0ms1XR49yY7C0XfdEvFEdT6z2lEQ451xvsFE12JbAParUnEkF2QgdA7DPeo0IO/agUmlSd/fbiHiFze66uqZU01CZak9qHbqjWS+21EbZQasRW2fCzR4OjijP7Z7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCGeBx+/gO8lUpackfRqtddV1Cwj/V6UJ4QhS8S9EsI=;
 b=g5LBeDgIRpg3Bu/04nMoUBShXtWNFmtFLFG3aPMzNewxKeilyudKJnW85L0RlIzsg/WcfFMSyG/mQopv17pUsvYIas76ZXdX4FCS9vCYEJmW3q89bjAnEAnm1ioUMLU4X3Tr/4LwbBJN0Kxel9ntis/8eI2LkK4j36QGmVTtwzSpyF3COGbd0Ct73vnoXpYqliLSmoZYVwJQ8sMCt4TLPt1EKUDcYLaJme3H6tL5t7HtRb1kLw1dyDh3pp2TZXgoengfxUJkmuTF347PALt2pzhG4MJinU89Ozyqzj75V49I46H9xUrMWk9bkWhVFQLhGEqaOFQxAV+AC//fNc+2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCGeBx+/gO8lUpackfRqtddV1Cwj/V6UJ4QhS8S9EsI=;
 b=Rh1jLX/boKrSHIpixSZZfcuR3Hme5+QnBbJM3LG+gshylCI6YbPI09WT2Xw3MNMi6J94Qc+ZCbgwAi887k/TJTWCa5SAFkquFaa1iWR9h8QOEgmufL93DcLhv+i0u0/Y6f3k2TcdyL0+9dggO2cTyk6keddtditi0REMBRtwM50=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM0PR10MB3281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 16 Nov
 2020 06:46:19 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 06:46:19 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v2] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH v2] mfd: kempld-core: Check for DMI definition before
 ACPI
Thread-Index: AQHWt3VsEBqb6T2PvkCar7YtrCX9HanF3SiAgAR8TAA=
Date:   Mon, 16 Nov 2020 06:46:19 +0000
Message-ID: <0588a23d0fc7dbde4c969722ce7a9c476a93ec0a.camel@kontron.com>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
         <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
         <20201113101623.GG3718728@dell>
In-Reply-To: <20201113101623.GG3718728@dell>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c952c24-5dec-420b-bd26-08d889fb5305
x-ms-traffictypediagnostic: AM0PR10MB3281:
x-microsoft-antispam-prvs: <AM0PR10MB32811478F6B34FEC12C8DD6DE3E30@AM0PR10MB3281.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4i4B1TvNY0JMqjBlgornmJcy5J3MsaG/yduNHqBe5Ha/tG0eb6wmVpAEkyMCIpuLiwe5ulowBs0sscCAqH0M0i9o1U6q4BCnLF6yLwhERy3Wa0kGEZb0Xnjv/4hlEZNfAhnqQYE2CJdnT8nwwiEJ95NremFmL76ercUAgb2ZzYlEl87lDLno1QOMv+SPVCkXgjNNSi7OckcTa3xtoRdh6gLsWAIBpeSoTuAXq/b8uRrn5EJ+kqtP/mLS6ZXtJG30Kc0osEfnWFmqjNumMOXnAZ9r4zdhvLQ8VOWmHjiogV4cWtw43kTQEHxuL01tgSt4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(8676002)(8936002)(4326008)(86362001)(66556008)(6486002)(26005)(2616005)(71200400001)(83380400001)(54906003)(76116006)(316002)(186003)(478600001)(36756003)(64756008)(66446008)(6916009)(2906002)(66946007)(91956017)(4744005)(4001150100001)(5660300002)(6512007)(6506007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SLlNPEn4S1LPjLI/Ci2CiqSH0Kw0UG8CjPrPzndpoKcIMwRWX43evG3pIRJ/Wf/3L3Fp29WPBtBBCzoj+cNURmpZqXEdji3ixi26Mq8aKaklBt6SZB3KRk1RUwnykrO0rWVc6tom9eyVDGD79Td3XbgyToIeD64Evqja3ojmMQP87SJWwfp6DbwRh1wyFE/PNxoQyQSC/Er9X1UoerfsUs068+kVc0Qpdj9bSy2bM5tJVuJpdv/CpFYSOn+2RP/EWYBt+W4yKt8GcRTVcD7X3wOcFO/0H+cz8GMahy/2eF29G58utWbNGaUUozEo5Mt7v+bi/ZRFXVY+TMKQDEcReLOQRBE8npJKF415+S8TAM9aAthFKVDWpGF4VPz+TyTRmSKO5JtcBIEuqMcQDYHU4WgBDmHi8JI7IZlCPx+a2+vUaMGrZtDJr6Gvc6tqo87rl4YIbhmDLq9HsgtkqJosuZxGk2Gfnj03+bHFT/hoYKkm0a9iGRt1V4fM1jWA2bfGus/cZzMsjYDnICx5+dqGgzDl7gVZEBrtBVbn3RCnhRNLMw0BZc7A9RnPeN4fPQYnaIM9W5JG2Z0OkFpo6uy44CDp/dNJoA9wPTAkudS9V3KvzCSbp1vxJ3cM6qbLo/YFTIrfXKVLga6uyxe66VSQNhZB5xa9iHDnHLALsCJt4akFT0KQU+E83xbdJOZzA4J3+YdRyeV5huejvJ7LBpkBOWMvOuTLSk7ky7Yvqp45IkGh1W5F7gjcN7khZv4/9t9iFH76gMHg7gG9lb+tI18QsUkBPZwjKJGy3iSbOTwXbbt22DzZsQ1gDjLc3Hr7iIvhap1QI+jnolWwoUZX87hjmfy7C3UvrtggXPhhKCxqV5W9H+vAmx1ch+1c/wRMjFUwXCDimSwZkkHOaGFyLEOhUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <A8CE7CE617CB9E40B206762E789AE2C4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c952c24-5dec-420b-bd26-08d889fb5305
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 06:46:19.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXsepHJ9z1sRbqf9s1m+E32yZsVkLNaOix2EfTdfkagKUrEX1QWE+/MqRGypCsXfzsBn1HzYno/y+qwPEfe1XBOZkzWxJKnYz2PFV18dceU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 10:16 +0000, Lee Jones wrote:
> On Tue, 10 Nov 2020, Michael Brunner wrote:
>=20
> > Change the detection order to priorize DMI table entries over
> > available
> > ACPI entries.
> >=20
> > This makes it more easy for product developers to patch product
> > specific
> > handling into the driver.
> > Furthermore it allows to simplify the implementation a bit and
> > especially to remove the need to force synchronous probing.
> > Based on the following commit introduced with v5.10-rc1:
> > commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")
>=20
> This section should also be removed from the change log.

No problem, just sent v3.

Thanks,
  Michael
