Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501DD27ABCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1K1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:27:41 -0400
Received: from mail-eopbgr100101.outbound.protection.outlook.com ([40.107.10.101]:58080
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgI1K1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:27:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAcoXDq3UaEE/rjY8OC+hZoQzzSxy4/ecUzUsqZBflY731t5zaTez0OTMrjnMq7YbJgvl9Vu0aMvLtLYNBsUsz+i87fPepywtcy3dsqAxq90rjHQoDise35TKXIMNCorC5+V0cuY1t7eLDanxmEpCjpmaK7JoMkj4PUzy10flgJTeY6DrHVhcrlFZ8Bk/S6blM2ujmgLgfOahqV1aSIRKFoARa37jgnhW/Vt4/GAswBEpXz4viQCci3FpBG/3mVp7NojNEwz7s/t7FJEY3tgsaSahNjP6PxQYtOS7m9A/E2YQyrn6hc0lJpyJca2DRfDjvSDQ4z9puoGQBsz5BjR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXussICYDt1GeqqN6M+erVdRYdk0soTIgN+DdPBngFE=;
 b=QmasOmeS2hYQX3NJnE4rhaV/BkpBBXDRjID8SweDtEyllfZhBNuqLUczLaedcuJnuQQPlHwqGFTkZb7Aq5E9NpLx+QbO609ySkI/D3ArcW7UBo5hFpYSX29otg97UphrzjXLMT8CwP3vQOGruCYKUR4c7VbZd8iarWkU01OSZkjtktiOtUU9YptS3PWRHR8tmoT1YvPvg9d3Ouhz93Bld+0/O69rlj6eV9J03XHbonjp0JUvnLzgCy7t9l0J3NOJDlsIdMuXgbCpbZlmZMx5i78+H5pf3Js4hTejxzFuU3mTURWZzFiDb2dbGiB925uHvVGQQ8v2zhumKxbRdvAD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purelifi.com; dmarc=pass action=none header.from=purelifi.com;
 dkim=pass header.d=purelifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purevlc.onmicrosoft.com; s=selector2-purevlc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXussICYDt1GeqqN6M+erVdRYdk0soTIgN+DdPBngFE=;
 b=mlwobn/aHOp9d29u4HJI41ainXdPh3rDkU10b7zCcDkIn/CO7i7umDMQ2B+rM4FqJHs93x6URHMfmH0bh9IkBdA5BcE/3QxLxjw+LhK8izzpPcTF6qDEXg6bCkHMwBrTKixa8834Ps7sFFezWqoWevvWB4pZOiKscExo8xGRHuk=
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6f::14)
 by CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 10:27:38 +0000
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f]) by CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:27:37 +0000
From:   Srinivasan Raju <srini.raju@purelifi.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Rob Herring <robh@kernel.org>, information <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mostafa Afgani <mostafa.afgani@purelifi.com>,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Topic: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Index: AQHWkoZE6X9fo+Lqi0q3sBmm77AkSal4G9iAgAXC0r0=
Date:   Mon, 28 Sep 2020 10:27:37 +0000
Message-ID: <CWLP265MB197240BE125442129C3BCA9BE0350@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
References: <20200924151910.21693-1-srini.raju@purelifi.com>,<a57f6bf1-2504-577b-4316-ed609dbb17ee@infradead.org>
In-Reply-To: <a57f6bf1-2504-577b-4316-ed609dbb17ee@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=purelifi.com;
x-originating-ip: [103.104.125.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d2ace4-e0df-409f-76ea-08d863991f57
x-ms-traffictypediagnostic: CWLP265MB0324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB03248AF98A21BA6D5A948194E0350@CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ZgukHFyAl+vniBxU1+u5gRHt77TVOIVbAjFQSqQV8Ju/HfSQr48CwKNyr95Hg9Jhn7bcvg3evaRICMTBS5Iv+WZwg0+y/alsc+jDR7Cb0a0eXGshvL885QHplgKlVVgsOJNsq8fEPEnizz8fy8eYR/gPOWaNM43YdEYxCYcIv2+H/hcQ4dkC8Zwda28hUZcpGRIQ5nT1gdbMiREbmI/FLOzBzzAThrurf1CBp3H5cvj4DjUqQqbyBffoF6x84CLPtrncvIj/KfRY0QlaIUluChaE7NW4bjLsJd4H6D+3/2fKs5/SeR1MF/U9RZ3mB3b1k11Gb0PQ/kmTFdZmUMOlNMnMOr1i3Mfnmtkm4GHvR1qsJkmokEZ21th5gMQGGtl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(396003)(366004)(346002)(39830400003)(376002)(26005)(2906002)(8936002)(7696005)(8676002)(55016002)(9686003)(76116006)(316002)(33656002)(91956017)(4326008)(66946007)(186003)(54906003)(71200400001)(6506007)(52536014)(6916009)(5660300002)(558084003)(66446008)(478600001)(66556008)(64756008)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LBrrfWjYFDJv/JTzGOhBcPPEnR6SHBfcWdcJJJITWD+1+tmkRJl0Q5OvtCtFURLRScGDZpXDqcutDlmkVmQp81uBE94GzSKKBuTWtvx7NSNobqIgFwiDCdpTDVW5un7EQnvbbdeB5t3kAih+yNY2WaC2mAyyLAYnY2zZdl3PC9IgPOGzns8KJ461pkhYmy7J7nNGAPouatzPXoMZDKso92h+aR09WpVZAk12AIm5eYm5Au1RQ62JkCrEUgZyp93t+jMZivesH0g6Gr/LLnYn9WmpUz4upgiilzaoWpGJaGOFKOCwCbsLWlt0fWHjHXtyxiJZoSMcqhp0KPEm+/EXMYD0mPaf/rIlIG1soL8K8hnBscytCYTVJNWaeoBOq2vHl0rV14sLhiIyHyVbh4nj3SOdWEbyiv19qXpQDjHWgLT4kUtVovDCKGSC0Z0bms0IDM8zX5rmiDUQLTu19KJVRYgcG3HzxoQpqYaklCSOg2HNMq8gs1PNSkpApXyrlQUsWw3Z+wFrm847gcfpNEPvNzComrKO4JT/7BC5G+U9p269UBaV52hzmR5VbjrwEzSvtM4qBzcB1KN9GxuhqzJLyUxI1HdbY9nvp9HSoXjgmYOYFo7lUtVwRZO4NLm/ux2N79kKptPFWG0+gPuN5cueMA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purelifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d2ace4-e0df-409f-76ea-08d863991f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:27:37.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5cf4eba2-7b8f-4236-bed4-a2ac41f1a6dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIfwaKKowe9Twxnlchpc8smFg3kpY67YmJveCKNqb7CgkLAF6yH+rIBYIXqfz6KMNK1U67po67ghJ17IIQyFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB0324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
> It would be more common just to check for CONFIG_PURELIFI_AP in the sourc=
e=0A=
> file(s) instead of adding a synonym for it.=0A=
=0A=
Thanks for your comments Randy, Addressed your comments and resubmitted in =
/net/wireless=0A=
=0A=
Thanks=0A=
Srini=
