Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9127ABC9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1K0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:26:31 -0400
Received: from mail-eopbgr100099.outbound.protection.outlook.com ([40.107.10.99]:28112
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgI1K0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:26:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N76vhXe3IqczaKDk+HuRH0p0p894bwaLwMS4KP0rKPG1akNdwweBqlc8tUa7PTA2O/mxDoL0+zeOyCJ4Ne3+zuHFlJSURnc9zGPus3Wk+jarqHnrefyqC/0duwWy13tRAU7ak8/0m+aT7zRxZGhKSlW64nMTm3Rf+xsZ7ZY/TmRIiP+6VhzJAcFWRcCuqHHO1JnmIByRLiB+JfwqFb92hXVdp6QiRLpfzPfN1w88gGxehst3QBB4hxGX9NTlrnz2jptVkzKQwoao18CdKacWBNMbkXjp1dxEoxOqhFKvPF+E1GkvU1TZpW9pQ8XDAhrdjwrlrdk5/q1LpVyfZ0kf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR3PZaKWBoF06y5NonxEwIswVd0R6daggGDTHpvDcA4=;
 b=m2I9UPwRfRyAqmWBWmtpVuk8efZxJqv4QNblfMbNdgtvJR2GCvSzWdR+c+/A61jIjquiSN8HF2eM/GBmcZkUcGbw9V8EX8nJGBjALtI+GrNV3PWSHw56vn3KxonAUijHnGPOtiFC1wlk+Ay0+txBpnDUHAzo+8gqcO2OHnZqc2jp1KAamSwhLQoTXpFXI4JC3AKs28GAYslsGFtadIa/tiQIhVeyjWhNA3iEoeK2anLLV+tKwxavsOFU8ccPiVMCjEaceUvTBk8np4IytoIWrrNp9cP2LwIxFiWX+J3QuZjRwpVwTdqbBxJBup8mdv3XI962/XcBZg6VTGAogfx9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purelifi.com; dmarc=pass action=none header.from=purelifi.com;
 dkim=pass header.d=purelifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purevlc.onmicrosoft.com; s=selector2-purevlc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR3PZaKWBoF06y5NonxEwIswVd0R6daggGDTHpvDcA4=;
 b=EgSSFMsl9MYBORLIsvQt8ODLxgtzDjrzTPqMADfwrgKSwVOll3Ro3Xv5ki/ct2tb5UVvKsDrNPHFMkBNNFKZ3Ctd+3tJevmbaPrPABwYP7GeuvN+VB7CeNyFe2ISZB+eybfwRQsQKtAs1kP0NNOO/Cvbv0kcJY8c3HXShfGe7/E=
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6f::14)
 by CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 10:26:27 +0000
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f]) by CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:26:27 +0000
From:   Srinivasan Raju <srini.raju@purelifi.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Rob Herring <robh@kernel.org>, information <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mostafa Afgani <mostafa.afgani@purelifi.com>,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Topic: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Index: AQHWkoZE6X9fo+Lqi0q3sBmm77AkSal4JvsAgAW3XMk=
Date:   Mon, 28 Sep 2020 10:26:27 +0000
Message-ID: <CWLP265MB197292A924DDB487B0526065E0350@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
References: <20200924151910.21693-1-srini.raju@purelifi.com>,<20200924190758.GM4282@kadam>
In-Reply-To: <20200924190758.GM4282@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=purelifi.com;
x-originating-ip: [103.104.125.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc70a325-751c-41b6-046b-08d86398f584
x-ms-traffictypediagnostic: CWLP265MB0324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB03246AFD4A73E32E125B5E63E0350@CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TO6K1YW13BGCE52Q3WzNGjSrnfux8xZRFb5TrHyYwsY7JInxdt0Vp1qI39si7adaGwZk3QAYUtfW1KuXnmFSrXBg7KpIbiY6njMB+3srDqnpb0jWetlMSctv4C9RN1t9gwvkDFvizOFARaI/ObbtPPjbDik9l8cjq00xn2n5l3X/TSc0fbpYG5N5ROXBEUf25P/+g01vDjmzq2ChoHV2yAToPvTfiO/fR+cdN/xdMkWze5H9gLe3VwBroFDGkqM7eEJcf3KXFAFliIxD5Z50DaiVi6W3jNVI5KPFXSafzgHbGVboDhKaIlANlApspAc0AZp++yK3RmLIRu9BQG6PR/i56S8ehig468WKIMapZ1XogPbCIKTu+hBVbmXV8DvF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(396003)(366004)(346002)(39830400003)(376002)(26005)(2906002)(8936002)(7696005)(8676002)(55016002)(9686003)(76116006)(316002)(33656002)(91956017)(4326008)(66946007)(186003)(54906003)(71200400001)(6506007)(52536014)(6916009)(5660300002)(558084003)(66446008)(478600001)(66556008)(64756008)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sITiQC82jsGLYvsYXEq1YC+8T3ah9BiBgW2K9hIWbHG1jGqlhRIltUBjo+mRJNf4CIP+lA2+TwHbM9w9gV5CTqVsQMYX06pHB1G3gsK5iFvbPFNpKhCzCuX3bS7FTBozO8NvMSQMbR8RMHcTtrkUvAwvzcOH2ctQ1mpoEka1ahJDXMDleAV16OTwW7/nMZqmMdne7z7GDh3ea5nLrClUgdCyKjtwDm084SgMFIsSuEbHeHal1dKl8+ECUtq9qvXE2dVY/UYOJPiUq0Oq6r+o2dhwKi5Q5JIVWwLIIm1L5KjPSCKk3dZ6GaVnTNSv/YvGY6hIpEMyOWl7Cj3D/DJ8X59PzpGSC+wEXb6BV8KxKAwko2lCgwoqk47zZOJxBCD4vzTRrwU1yIJYcUFUuYL4HLtCTQdFj08Wk+Wv2SOddspHqQysLBGScd1zl8SSy+ShkqpdDUlVlvrFL3N3RuAYoZ+0rY0utfovmf4Gplvkn3yf+W2QgzB6cpkAavu3psq/02uBb1UWDVeESAkL2Z7iw0vgiXG9YLrDRT9E6LdVTyILu57agyRYmXejKZAAgWVBQp4HK8u9IWDx0Dht/kp854Qw7rohNbJE5sHtH1QIrShWJbSKG4Ojvk4wny+r4Y/O8EbvLA4+vuQL6hmkXlF3XA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purelifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70a325-751c-41b6-046b-08d86398f584
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:26:27.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5cf4eba2-7b8f-4236-bed4-a2ac41f1a6dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eArT/B/ci3Q/erPbbw9iObZoBqkpxYm8F6NIAysVRkxoWIL/4RLsxu8GbtPi3k9Np0bCC/iq0gIWGc5adiUDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB0324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
> Anyway, those are some ideas.=0A=
=0A=
Thanks for your comments Dan, Addressed your comments and resubmitted in /n=
et/wireless=0A=
=0A=
Thanks=0A=
Srini=0A=
=0A=
