Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB92A3A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKCCVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:21:22 -0500
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:35781
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbgKCCVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:21:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai5aNnmQ7izoq2DLn2S514xNgQ6KfM4ICyiYhDKmLZKRbHMrVBgEGyGkTKvKhnv1umrV/aHIzQpTapk0TchBhn6gknAK2SBsjFwTxuNr2+zs+mxa9NNSRcrXmQsjtKRYyyOcGtxjMeoYnoR8aVEzSxsY5PxLiN+qJqW1IKI1vi1NcLAlH3mVCCrBuND3843kOXtHXhHH0j/gNcA7Enuj4Yrj61wESzCVUaOSdBveDqB7a01iads17a2cQsYV4RlB+nO9jRgtsCF3lOwN3uPyDbIrzA52lxU3GGWjmbZtBuEdhwx/KF84nhXUtfSZP4APN0zF52dma8ZsNo4iQW+EKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+PaqPJJgdJrvL2AAnomwxafT7Bdb7Y/TejNPa0PwMo=;
 b=Dlq8uAQxh5uII2XYHzCv043aCSRsDNu8j1mZdeWNAYPpUx8+06PnPCC+Ve42bKUPVzMmZrkT+Ux0y7Y0WFcKegRr4n6vKOM/7QHOK/Z18cNdie5wYhoIvQ3Cr1fr9GyesPGSKk2fMOLbkpJTwHWizHDpPf1A0sylImGZCZ6aEUDNXII9ejSJBf5pZrLK3E8BY6tLS0YD/SfhjoCMLpkJ8yHNDxbYghq1dRU8yzZ5pP3+XkKIh3elM7YWVs8kN4r2JzRvT00ufm0iywNk9OvQZGIRyqzwxG7y+H4MhrJSJ6uyrg2hmJKDxqI26xrO4Vq34JZ8ieXhF1K2x3BvnVHAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ssstc.com; dmarc=pass action=none header.from=ssstc.com;
 dkim=pass header.d=ssstc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssstc.onmicrosoft.com;
 s=selector1-ssstc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+PaqPJJgdJrvL2AAnomwxafT7Bdb7Y/TejNPa0PwMo=;
 b=McakartZi1zVoicAvEm+O9aHcHeMMkSuxJZUsdrAjbLTIsxHJv1maZIHrnL4d4aeQx0beiME3yvVnoomv5iPSG0BpxNiGwY3pp8PjJOmFI3rOOgbMBXwXCfkoIQkOcyLO+hkjjAE2lrGqWVwaJa2m705aj/Ekd7dlenC8YtcZjo=
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com (2603:1096:202:22::15)
 by HK2PR02MB4210.apcprd02.prod.outlook.com (2603:1096:202:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 02:21:16 +0000
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e069:3888:21af:b474]) by HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e069:3888:21af:b474%7]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 02:21:16 +0000
From:   Gloria Tsai <Gloria.Tsai@ssstc.com>
To:     Christoph Hellwig <hch@lst.de>, Jongpil Jung <jongpuls@gmail.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
        "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
        "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>
Subject: RE: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Topic: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Index: AQHWrQrF3kKZ6Iwnv0+X+dwLEwfIxqmurP+AgAaAo4CAAIfmsA==
Date:   Tue, 3 Nov 2020 02:21:16 +0000
Message-ID: <HK2PR02MB4004EE20977D0B14516B030AEE110@HK2PR02MB4004.apcprd02.prod.outlook.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201029145529.GA19011@lst.de> <20201102181327.GD20182@lst.de>
In-Reply-To: <20201102181327.GD20182@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Enabled=True;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SiteId=5715baf5-0afd-4dc3-a35d-166593a054fb;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Owner=Gloria.Tsai@ssstc.com;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SetDate=2020-11-03T02:20:45.2940497Z;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Name=Public;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_ActionId=4ac74212-d2c2-4404-8b67-f60db732fdea;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=ssstc.com;
x-originating-ip: [124.219.110.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e752645-e716-4de7-722e-08d87f9f248c
x-ms-traffictypediagnostic: HK2PR02MB4210:
x-microsoft-antispam-prvs: <HK2PR02MB42104A08A6629B29451DB80BEE110@HK2PR02MB4210.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fg+RV8yIAJZiVsFHhxBpv4kI09pUQHeaibmkHaPg3VN4vfEOnrHJnKHNl5rQ5Dg0ruYDEDtkQ8ZrNdfWyo4faGbl4Nbso3BN91PiyOGCvlCYHe+lRWyRj+c9Hj/+WVvhVDZudaOmYMpxFqHaQrjoFwginzmEnG1vx2aWGv1ZvYAmh0QTvz1GyhpuWDmSrh7Hj5b4XsPro52ffdpUsyMojw3cER+0fYyhiS/S4bjKbQk3hJFZGemjDtAwgodvQ7tS6Ow2fsWLcJOIt4vQopQsLWa+9Bti2NWY26u8WXSD/Vcf4qLW1XtcvgXHWBDz5giQsFue4m8ENbAC7qFnDP/Abw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR02MB4004.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39840400004)(376002)(478600001)(7416002)(2906002)(33656002)(83380400001)(64756008)(66446008)(66476007)(66556008)(5660300002)(76116006)(66946007)(8676002)(54906003)(52536014)(7696005)(8936002)(316002)(71200400001)(110136005)(9686003)(4326008)(26005)(186003)(55016002)(6506007)(53546011)(55236004)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rGxJVyLmyGg+o1BEK/RuEaOz8bXSINftZkgQ8GF0EOq6pXz/vY0477nrKmqs1sYu/LuZ/bGYrSZsX7d9r6z9CvXGUwhxeQPRbodwp1lVfEFY9glanCbF8AVbYUACJ9mr0BaClb8JhOh4oLBIZV/dpbpVoPNIdzUFJJkVPFeBxGNkQr7S7jK/2buFNUb7bW4Hadzhtas+chQ7ANwNF2oTGx8eYaCq2wvNSYEYsyQdwKXIQ2GdoRFOf52gsZgGTGbjpxxiik/3l44Xln//7/TwhajG4PQo86atWd+Vuv2OCMCuqsCDSC6C2IJP9tbSGp+HP96HEjHj/TN+9pqK17LoE9ursuRpO+57jH9D4zRnw6O1wbBckvJh65f8BhK6pOzXPBscKDRZcH6lP9lbyzUrqrlovyutq5vsGg5sjD2s77zrUVazrmwhWCQklGUM69Qh4jHI6sBYbXP3VZmIjMfxbA8STignjJBcOH2lDOxrhqTWSjyqSWyzNTxHVF43eopuyQjvElTjn2bFOpwN/ax5i5SQ5ZqE3h3K6WDLdcOn4Ids9ePYNKcduu727XvP/JsU2zSQATj+i6G+sWiWu1LUQdUkpTArAnFqigea3xz340Xy8+3a9UdWYW5ap1BGo3gotLtnFGuTr3kSM1HobMeWyA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ssstc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4004.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e752645-e716-4de7-722e-08d87f9f248c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 02:21:16.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5715baf5-0afd-4dc3-a35d-166593a054fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRNb30nG74WcyPeG72+4pHfVDv6XOsnukfIF0Xglut+3EnxTSSMyWXyZrXwN9OkoIxce3wfG/kZbBCQo4Y9gNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB4210
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rephrased the problem description here,
When host issue shutdown + D3hot in suspend, NVMe drive might have chance c=
hoosing wrong pointer which has already been used by GC then cause over pro=
gram.
Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC ->=
 D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on dev=
ice SRAM -> over program
The issue only happens in simple suspend (shutdown+D3hot) with specific FW =
on Kahoku board.


Regards,
Gloria Tsai
_____________________________________

Sales PM Division
Solid State Storage Technology Corporation
TEL: +886-3-612-3888 ext. 2201
E-Mail: gloria.tsai@ssstc.com
_____________________________________

-----Original Message-----
From: Christoph Hellwig <hch@lst.de>=20
Sent: Tuesday, November 3, 2020 2:13 AM
To: Jongpil Jung <jongpuls@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Christoph H=
ellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; linux-nvme@lists.inf=
radead.org; linux-kernel@vger.kernel.org; Gloria Tsai <Gloria.Tsai@ssstc.co=
m>; jongpil19.jung@samsung.com; jongheony.kim@samsung.com; dj54.sohn@samsun=
g.com
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running =
FW 220TQ,22001



This message was sent from outside of the company. Please do not click link=
s or open attachments unless you recognize the source of this email and kno=
w the content is safe.


On Thu, Oct 29, 2020 at 03:55:29PM +0100, Christoph Hellwig wrote:
> I'm still worried about this.
>
> If power state based suspend does always work despite a HMB and is=20
> preferred for the specific Google board we should have purely a DMI=20
> based quirk for the board independent of the NVMe controller used with=20
> it.
>
> But if these LiteON devices can't properly handle nvme_dev_disable=20
> calls we have much deeper problems, because it can be called in all=20
> kinds of places, including suspending when not on this specific board.
>
> That being said, I still really do not understand this sentence and=20
> thus the problem at all:
>
> > When NVMe device receive D3hot from host, NVMe firmware will do=20
> > garbage collection. While NVMe device do Garbage collection,=20
> > firmware has chance to going incorrect address.

Any progress in describing the problem a little better?
