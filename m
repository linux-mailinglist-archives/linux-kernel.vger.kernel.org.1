Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F462C662D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgK0NBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:01:34 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:2274
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbgK0NBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Af594O04N6qmMgIzu0jD6OFfl9EwOW5QMJhCBN2SBA+i7kc+3QQspy2Wgg44iQ6ynVOtRhDFswVW4RwuXN/AU3NHpNEahNyFyNhrFHRRbLrsmt92tetL3Q8OVoWgCeglCbE6QCWwdQHX1j7ZatNYIRp4m6w0tMTmd+j6hPJEizdsHx4LuxCJY7BTaNhHFAweSSkLNqUMoNL6jfWBF3+LuKflms153mQ8rkcyvIWtcF6+dwy6i0Ytfkd3MStY3h/0/ljX2q1KTDGYUQJX1ozCXgk+ZQC1b7PqvByOYC5qeQdXxgv3lfRRn57PkVs9yuCfiRnaazWZ1MTCdApPJqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkP6rUXPV05vQOHv7ka5J7X8w4KrxPljlorFXGJO7Q=;
 b=J89NxuqAxNI0sAHekgysYdNziiKe43h/ZwVCjBCnTDMLHwiTpsdAmen5V9jWmtPdfA+vJUFjkkzZCNwbSfbYXD1OvVsOebxrr0fYKVQ7gal3LjQkFwUhHGUgxQCQ/r0gZ8AOxrvcAJ+Fj/yPly8NN6uHyjGCuJ7mI1CxKAL0nupHtQBl1NaBqO0sX22StVr9yb9/ACNiVLbgVLR/XL+vVuYo2k8YsiMexs/cah048qJ4FcdckISYLCDyzAxHbxx155cXIc0Z2Z6ve2oVqeihlECB0w64mNG0jZf30SeG9YJoDw+nVaLOw4p8O2TUBagSL8aiHJza/0wxMPbNHTChrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkP6rUXPV05vQOHv7ka5J7X8w4KrxPljlorFXGJO7Q=;
 b=mNVCa4YHD6Wkg9tFjNSFkYTHU55b0EfRZER9d8EYfnuZ3TUDKQpVq4tFzCS/4oBk09uDJmwJ3/MSMxRa7assFknSIwSROf9E8qeHzlKTKSPl4CyNxLJ3mnPCyPgwwGQXgEVQlP1mMsJZ8uR7+61ykb1bsQtB1L1hF47FYXdrRR4=
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::16)
 by AM7PR10MB3924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:01:25 +0000
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c]) by AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c%6]) with mapi id 15.20.3611.022; Fri, 27 Nov 2020
 13:01:25 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/9] regulator: Update DA9121 dt-bindings
Thread-Topic: [PATCH 1/9] regulator: Update DA9121 dt-bindings
Thread-Index: AQHWv0O5F6Rm9z+Ib0GqpmvwxtJw4KnYmjiAgANg2EA=
Date:   Fri, 27 Nov 2020 13:01:24 +0000
Message-ID: <AM6PR10MB2807F4A8D11B71282BCB3A4CECF80@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <20201120134742.y7bocaok3gcahbxt@axis.com>
 <20201125092137.ehwfytsrr3x5vkiy@axis.com>
In-Reply-To: <20201125092137.ehwfytsrr3x5vkiy@axis.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.134.193.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 120c7bda-a4da-4ea1-a867-08d892d48be1
x-ms-traffictypediagnostic: AM7PR10MB3924:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM7PR10MB392477DD00EFB4670A698A47CBF80@AM7PR10MB3924.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oNLGEt0o3VQyAwaXrNaK9Jb8SjArGyVq41iDauRAsYkpynYWravmHCFlV/h11hv0Ef1Sia3YHmu0sOUuOdIUepkovxSjPr+zxOL2Jn8OeRXMX3Qv7VUCqKACbnkoAy+1nvnvmwOZI47MbMMu1vFmr4WmFzKy7RGhHZYcegsEQIvm5GA7qG2EjdJIu9irvY4rLn0bJdPOo3IyrVHBOjb+l6XI9lKZiypw9BDbLZBbmdMb+LHHGlD7WfKxVJQFA7A7trmVQyPfwaIltyyyUZv6Gt/lQ7yhh9p/J1vHt0brUWqqXw6LdQRvxVe5yzpJt2W7l2eJO8i8qwd07vGIrU3EFXMFcb3tZqpeQLjNm/lbb44+4Ihd4gukGmxtApUWKfMKzfd0JIya3/gW6CI4zIBaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(366004)(346002)(376002)(9686003)(54906003)(64756008)(66446008)(4326008)(316002)(86362001)(4744005)(110136005)(2906002)(66476007)(6506007)(76116006)(66556008)(186003)(7696005)(52536014)(71200400001)(66946007)(55016002)(8936002)(83380400001)(5660300002)(8676002)(26005)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bM5wnZd1c33EhHbuhJgwn3fbwW2yFfxrneiHOcobS8oz3FfFSndwiCQguUkM?=
 =?us-ascii?Q?0sNRn/UIXKY7tEU1d53nfSW8B0IRlF1Ypf4yDlQwpf/mbC8Imo78GjZGN9uz?=
 =?us-ascii?Q?NWZbKN2FSCQMSSoG2GjfjoY+FF5DNyZ8U7rIoRy8USPa9DyiSIJfiFJIanOG?=
 =?us-ascii?Q?U3Xb5/E2tl+B50KkUXPRIcSdaXqvgzl+su74ArQNY0J6BHv7KXhBDCwwgKLS?=
 =?us-ascii?Q?bHgm+kR3QjmZni2wDEcC5+PRtrrL+kZXKM+QH0/0j/jyCEo+PbUpJHUZZRaf?=
 =?us-ascii?Q?7nnj0ZEWeIa2vFQSvZGzdlir0WfWcjMAvUDYbV2MCN5ecEwWXCU/N86bD101?=
 =?us-ascii?Q?Rfn/iOJWReQW1UdL3i+n6HbyTEfV6C8MW0R0Gdk4AZ8MqcEJsk4F1fUiQvkd?=
 =?us-ascii?Q?03tE1WUVpf0qeR44UZWGLo7A7ickintSbv691EoEkXDj3vvAB+rslsTy8HL5?=
 =?us-ascii?Q?CJlDbJzZDEj21GjiMzDvnytdje3j0swDRE2A5QcGacGgbsQ0EstCsSLSuxpu?=
 =?us-ascii?Q?WsNIoT//pEx3oIjwZT39FQ2cB4Tb6YuRo8wGw3uFAG4oR3HuAoSO7dvQEbLZ?=
 =?us-ascii?Q?Xpq8bkQ47XJuY/O1g1+zct0M8ZQDlc8LtVcNeTepM2pwY6WI+j8El+ardFRC?=
 =?us-ascii?Q?Ki+VoXITTjdWnXeHR6RGlr/RwPVRcqXyiHemoTi46+SK6dQiWZsgSMZoZS9f?=
 =?us-ascii?Q?/FK813L0f24CIlLhZa5+xaVkPU3tcGj7gstTWGENH1sg7ZuQcFm7Jn7TlpNN?=
 =?us-ascii?Q?OomZbqLW+AjIih61RvntMFmNTwt5CEMtD97+QkD/PXAyV4UBK0F6VFLSftOe?=
 =?us-ascii?Q?y+/WoTGVkjvu8g1sw+0ebZlSxKf/mEt65chKO73V/EOxkGEiltOech7XjFJs?=
 =?us-ascii?Q?DkulxE5iYmuIPs8ti155M6yWY/GEdPqyxt+JuGP9OISpdQwyOevhnnhEV9na?=
 =?us-ascii?Q?DapielYVgqdGdl/oAVaNJI11HSq6w9NUcd3sdUU+l70=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 120c7bda-a4da-4ea1-a867-08d892d48be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 13:01:24.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5AewblCROFd3TuKg1A69kVefqA4pT/EzcOzdASyhp5Jxd5RrS1aapBJzd+U8mQ8ucXxDPiMFOxwgXzJzMAavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 20, 2020 at 02:47:42PM +0100, Vincent Whitchurch wrote:
> > On Fri, Nov 20, 2020 at 01:14:50PM +0100, Adam Ward wrote:
> Actually, perhaps I'm missing something, but I don't quite see why this
> move to a sub-node is needed.  There is some flexibility in the
> regulator framework for this as I noted earlier
> (https://lore.kernel.org/lkml/20201102154848.tm5nsydaukyd7rrw@axis.com/).
> For the case of an MFD it certainly makes sense to have a "regulators"
> sub-node but for these chips it seems rather redundant.

This sub-node looks fairly well instituted for devices with multiple regula=
tors.
There's also the possibility to add GPIO support into another sub-node for =
all the variants.

Mark, do you have a preference?

