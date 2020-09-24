Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79A276C63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIXIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:51:25 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:12928
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbgIXIvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOiwwI4vA+ASDmVl0GmPkQsD4WZ3TBhfBCir+bznYfZAYrs1aeqgogLDILW/pXOO5jf1CILyehda6aIxkU10fRNbCtOD4s4/ZPEaxBYIw0QQjwL6BKbpWbrbIZKvcd9Zx68WGqwn9va7N/vpO+gQnusvfFqAAgsfE9+Jctgmg56AdYraj+B7/7At5dKvnmCAWmSO3hXA90HHFeQpJABA9bU5F0ZA/41/OF8lLv7V4YJfqSDZ/ASyNZBwe/iouCQE6Pva4HC2PKjvcjBOLaxaplFS+tSJ4TJhfNrVaGgHUKfZowVi4FMZ+zhSQ2aiN7jlJVVaZJXxsvPSwMfLEAP0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tJC5XlLAxDsxgPJWuXB+L77pBecvt3F2PL5cjZyIgE=;
 b=AeKeqaXoUd3gVmw6Uy/NMMfjCG9xlR9XcqC17HLdX4rA3gK6ZS9ylJN5pYVZCnMzw8UQasmOSK592qM9wMneIyx3LajV7sEC1K1zcdyfjMdapu2uJ8CYrVT1l6bfoZk9xCoYR0/vvR5AmEUv48MSH8KDihk7TGxWkhLEu7qI/qwceR8uKzY/IorA/x3JugJmhR+hUCOv8aVihagk1KQeoMll5/F3FxLqNH0TGc7N5C8ovQ8QTeIjDaOib05blTlYzRYJLAiau7XwJymOeI5mtcdy06KWT2crV2in4PwTgYQmJI84T+eHeizjUq4k78R8Q6bEQrrkQtSRSf9DSKUQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tJC5XlLAxDsxgPJWuXB+L77pBecvt3F2PL5cjZyIgE=;
 b=JvEJoAbt59BV9et2x2IjedlpTqcUx0Ts04LDGt0Wwsvw7B0YSk0FuzyVHp8W3t7+G0+yfB6FwcQcszfqlWZ2fpf5eHFeKlRiOewpPZmOmjuo5mvTqrNkOHFl51iqoNe0Rjhj4dOksi+/ffylEg9AIXMHR8D7X7HidCN5b1YbMJ0=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 24 Sep
 2020 08:51:21 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c39:b37c:c088:e032]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c39:b37c:c088:e032%6]) with mapi id 15.20.3412.021; Thu, 24 Sep 2020
 08:51:21 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 1/8] mfd: da: Constify static struct resource
Thread-Topic: [PATCH 1/8] mfd: da: Constify static struct resource
Thread-Index: AQHWkRZd8s0ar5XaxE20ii/i3e1Syal3fPzg
Date:   Thu, 24 Sep 2020 08:51:20 +0000
Message-ID: <PR3PR10MB4142A37E8055531EABF0A4DA80390@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-2-rikard.falkeborn@gmail.com>
In-Reply-To: <20200922192659.14535-2-rikard.falkeborn@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca1daef0-14ec-40cb-d9c9-08d86067026d
x-ms-traffictypediagnostic: PR3PR10MB4157:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PR3PR10MB4157C83701BC1D06D88E4A7BA7390@PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Veklk4MNGJ39Nj/zhIOCONyC3Q6nJU55vbT7GrdHMxj2tBWQLh7uuGT+KeJzH3Yec9HPVmC/2dtX2gm2/QFsbIcJpHYUUfZ+/GEVOGzZd1OWOeKZbjvezZiP2hNV9BvBBMHg8PNSOSaNu2funHiSsCFCme0ccpLnwRfNCG9E6btuLjH1Hz41ZGzeAbuAWZBBwPwid503se1OiT6LZ3to2LiT/F2h1xX6QlUj/ihhhFXCmd544GY0+TfmzetR23xqB+cHS4MMYwjHt2FNox10HVQSwYImoQuGXFsiRBdzALBEUdZSOnDAlwyG6FOaz6ob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66476007)(7696005)(64756008)(66556008)(66446008)(53546011)(186003)(4326008)(76116006)(2906002)(71200400001)(55236004)(6506007)(66946007)(52536014)(316002)(8676002)(5660300002)(26005)(107886003)(4744005)(33656002)(54906003)(86362001)(110136005)(9686003)(478600001)(55016002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4Hr6OAxvYoszN2zt4/KEct6f4bvk+SewE6ColA1KSOcAih8/rWPzzv9Ajf3VzRQDttXDgAXybYgoWqY3FZ/V64WH81VEtdHygCCVOJFmctTgreLCky2yjxMVeq2dwdkGzGjJuLQgFGqKbF7EMPbGYxU5Vz6eDihWXgSP2RqzUjmGt5rht+UMygqe1yMKnJnLgVwPFYR/TXK+zxBbqVowg5JPeXg1Sn4CnpFn9VR8n05M2IvVJItw2TMQHU2lfli+rs0IsxBlI56MIj9g9R+gwPtfeUlT3xG+Wn3QsZJmZ4/NXNHf2m9GOYGXQwWrp4sTwvwSMAo3tktDs3bmtnwz0u09/WZy0KlRRl2QNAQjnbQfHpyZZVs5teMBpvkRjwOdZHLy2vymsqWZv2IEOHHgHW5KX8n7/9d2iZxVP8jk5uiZF7wzlBI6qj3ML37eE9EIvLwKfZbZ8Mfl7q6SxJtxVNaBHYwfn5YwItb+7SIMIE+iMF5aoGYDM8vMpmHUmGi1JdR4WMNx1x87jPrphMtZUYeyzC+Qi8L6p6PsXYKytYovWzsWWyC/xz+/HAslxJyMPk+lgPS6vxjgnEeMAe1gVuyEO2QEcAxzm0KZ8gBOEXcnPYJ7hrkbpGxjkWqtLkDLVB8cXmkwj+ouFniThtNjvQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1daef0-14ec-40cb-d9c9-08d86067026d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 08:51:21.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOrqQWLYhu9g0yFUIcYa1U2iyUFG63p1g4O9zw3S4r05LYaXwlLzD0/OZAjipEaqegqJO3ERhZTEsNpHEAOM9xP3IziT0w0uAfFOmMJH3g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 September 2020 20:27, Rikard Falkeborn wrote:

> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
