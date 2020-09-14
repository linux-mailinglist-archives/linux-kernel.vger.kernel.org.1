Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9292268B32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgINMkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:40:15 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:16199
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgINMhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtI4gGEUQodLM8adwp1pHaxZuRrdRvIcqpgoSxogp8=;
 b=ghl9jDTjbUXdDzf21IqkKii+vtc94SwQKveh2orGza5POvKowzVuSd+vcI/Ng6LDnPcoCNdPb+YSr8BQHDYy7VI8HZz3JV0vuwXiX557s33mOm6JL4FnjSY8HbBosyUu3koCJBH3a11ivj7CzqqjszsFwhA935dycadGsphyO7g=
Received: from AM5PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:203:69::29) by DB8PR08MB5482.eurprd08.prod.outlook.com
 (2603:10a6:10:116::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 12:37:05 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:69:cafe::6f) by AM5PR0202CA0019.outlook.office365.com
 (2603:10a6:203:69::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 12:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 12:37:05 +0000
Received: ("Tessian outbound 7a6fb63c1e64:v64"); Mon, 14 Sep 2020 12:37:05 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7600ebf3a290.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 98838119-9189-4D72-BA18-CCF434E02358.1;
        Mon, 14 Sep 2020 12:37:00 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7600ebf3a290.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Sep 2020 12:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9Dwf4Z/O3Tg0s+HS2lgLSo5vp6R1/7DbkywmL4WgIFU0rs4qRWJD6Zb4WEyPHYP8I0gFPewnbPj9TyH2FbDdnuMdHd4Kzoqp6uewm7e4S6MmQoRecKn+ADDoAo7s2Z2nRrsvKn29u5XDpDT5UWSfiakqLAifCJY+xOzqbDnr0Ti19iLIEeGq62sV5ELxzgOJHv2XhHNLFhXi2/5bFxTwIWhJbaIunnRgSicD+p4EnZ206CTnCsa1Mbtby5U7yLvmnM5+z1v3HYp23MfkqzAKKz7IX0PDHa3HuboY3hEPH27p4BRBNS6a6qnkEKkO5x2WP25ABqhxh866eJY44RZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtI4gGEUQodLM8adwp1pHaxZuRrdRvIcqpgoSxogp8=;
 b=iBUfJhpyZMIUYTGaGrTQcinrLpjHL6IT65/BKpsuGcRwUEBUHLj3F2j0SsxgDIOLlCZXgcJsJWviJsXERQ6AL/XX2gF6vYPGbH4kOcVbnbgUpKJkexBHvsTdVmK3e04IjTH6GRDyPDF9DFAZs9wAKDY8Pr3dIr1eTRRIqbCjxOAY4wSoVBQIGmaN/fG/i3HhzG2K948wKD9HkhaFgs+z9ig/f+C13fVghCc5716ehER154ArfqqTTXcwfMmytld7MZ+xnF2faecrXeszgpPfWGg+yWUX2oxn+v+T4S7UTlA9czhz/PIpy+0hUoqZLz7yneOedUAGr1simyT1kEIuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtI4gGEUQodLM8adwp1pHaxZuRrdRvIcqpgoSxogp8=;
 b=ghl9jDTjbUXdDzf21IqkKii+vtc94SwQKveh2orGza5POvKowzVuSd+vcI/Ng6LDnPcoCNdPb+YSr8BQHDYy7VI8HZz3JV0vuwXiX557s33mOm6JL4FnjSY8HbBosyUu3koCJBH3a11ivj7CzqqjszsFwhA935dycadGsphyO7g=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1977.eurprd08.prod.outlook.com (2603:10a6:3:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 12:36:58 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:36:58 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Greg Kurz <groug@kaod.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        Justin He <Justin.He@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: RE: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall
 bug
Thread-Topic: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall
 bug
Thread-Index: AQHWikiCiYkSwNHtU02Gd4gLL8qNd6lnz4MAgABCvLA=
Date:   Mon, 14 Sep 2020 12:36:57 +0000
Message-ID: <HE1PR0802MB2555979DFB8B63C067572EBAF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914103546.0f775bcd@bahia.lan>
In-Reply-To: <20200914103546.0f775bcd@bahia.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 4454E8913CE8D94FAF1B7A890EBC13FD.0
x-checkrecipientchecked: true
Authentication-Results-Original: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c0b33ac-fdb9-4c37-1f34-08d858aae344
x-ms-traffictypediagnostic: HE1PR0801MB1977:|DB8PR08MB5482:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB54822915C71179EFA4CCEB8FF4230@DB8PR08MB5482.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UuX9dBw0Cy0/eK/DLaytgEEKlkd94Rwu6o/aN48WDFQhqBsVvcsCOo53eNcXQkqt6ni0Wz9kBwXrjFxeLioTL4Fz+QDnzHDungty9q5xiJkg8I1Ac9EJ+gv1cOXbshwbM/n+h67lVecp9fJjKIQGUgom8b12xTJnQFOlezlOc4qji9ogoX9Rkyj66ikroA5vW/58qRNWzs5Jje8ymK+x79/wd3mjFYFoIGtBKuFNLUDYCoSFZa+v7iaCltXLKWW7QyH1iYcDGXSGQHG+S32KIBccLKlTW13slKpNqWf9zZO5bkcDLB28NVBcDhkNU84lcI42BHiaf7x3Tqlx+cflbg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(5660300002)(55016002)(186003)(52536014)(66946007)(66556008)(26005)(64756008)(66476007)(66446008)(76116006)(478600001)(7696005)(6916009)(54906003)(6506007)(53546011)(4326008)(8676002)(8936002)(2906002)(33656002)(71200400001)(83380400001)(86362001)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ITBX2SG5NXafAxP/6xrEzDiCwh57b07ExNgIbj1bZ3k+6zuQAp+t15bNr7bcgrqD/rM8/gEKFzWy4er7f9rDNqWkxTx1fK8Em7sBFJX9p4sUjwGNsMy2ZxZagWR4xShSmLqGALU+qCzzd6UHTF/jkvxXYglKoltIlNW2TIm0/mn1mxO71M+oVAFc0WlXaURhi1mZ+omN1OD6WWqgG3UMXmyq3SKnAWV+eY0qNUyrpOCG5Z5XJViaz0QoDfRVq1Cp5/PGly/mck9E+8qhaCfz5B1WLhkWnf067UvUenPZRmyWhH8EyMl2H2jxTEVrUftNEG6LwfhhPXyHmBbsF1TRoX+t/+JGt9MiIqed+cIw6xl/8BS1DM6xH+q7D4aJYBDw8Do4mdvHH4C1ZarYetPbEqhdRFDdSds23j+3i2fT1t0L8UcjLj0d9kxt45H9fH/M6QZx5PRguzfN4aWEuE76eGSKWanmUXjpM/3tngs2k3tANu6IrtpzmUFT+5SLSiLfb4NxqwKC4JGAh2UPxEndrRM46kiHt6N70m0c7j6z0x0s3XDx/v8hCuAaZcayUm/8CqZGgrBPbwxNm6S1c1WaFDAl7m1Rw/mRjljZyJFPKt0XCjstmXsoUL6JZ/lkaa3mDaDFPVlt77W2LrP6lgOigQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Original-Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: be425da1-824b-4635-6a4a-08d858aadef7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6UugXVvASoTWFJLrPgYIPUpMLldjaHx+Qxxn7dqxWHGzhpBWDx9SwdjXFXSl+jB05LHhLyWmc+Pr9tWPo1xwLm8IakXPKff5Z41HC9b+int4tPiQPspAwMptNA8Jg6atIMiQYkIn24nL2/FUpVXN22cW4avi+Yhaq6LUwLvxkzgt+JJbU9A+iDUbFg8SIbqboxhAiood4j+0Zr0x6ESem3EaYUxei7bWFNvUeDoReCmCItmyHAnq8gPSydJD1yqYVkNK0aKyPrvY7lmKGfb5E3lpQ8PdLfS286KdtTEAII5+40CeLPkKy04/bppTZLlt94CnmNGXAYIe7Tif0i+OoXEE9RDB7/Za3IPxSrnBW0Sb4ZrZTUaTavUU3zDGZehsINAtPuSpnVRV6wVD0q/wg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966005)(5660300002)(55016002)(86362001)(2906002)(33656002)(82740400003)(36906005)(81166007)(316002)(107886003)(82310400003)(336012)(47076004)(356005)(9686003)(6862004)(52536014)(70586007)(26005)(478600001)(186003)(83380400001)(70206006)(8936002)(8676002)(4326008)(54906003)(6506007)(53546011)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 12:37:05.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0b33ac-fdb9-4c37-1f34-08d858aae344
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kurz <groug@kaod.org>
> Sent: Monday, September 14, 2020 4:36 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: ericvh@gmail.com; lucho@ionkov.net; asmadeus@codewreck.org; v9fs-
> developer@lists.sourceforge.net; Justin He <Justin.He@arm.com>; linux-
> kernel@vger.kernel.org; Christian Schoenebeck
> <qemu_oss@crudebyte.com>
> Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*sysca=
ll
> bug
>
> On Mon, 14 Sep 2020 11:37:50 +0800
> Jianyong Wu <jianyong.wu@arm.com> wrote:
>
> > open-unlink-f*syscall bug is a well-known bug in 9p, we try to fix the
> > bug in this patch set.
> > I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this
> > patch set as the main frame of the solution. In patch 4/4, I fix the
> > fid race issue exists in Greg's patch.
> >
>
> IIRC some patches were needed on the QEMU side as well... I'm spending
> less time on 9pfs in QEMU, so Cc'ing the new maintainer:
>
> Christian Schoenebeck <qemu_oss@crudebyte.com>
>
Ok, very kind of you.

Thanks
Jianyong
> > Eric Van Hensbergen (1):
> >   fs/9p: fix create-unlink-getattr idiom
> >
> > Greg Kurz (1):
> >   fs/9p: search open fids first
> >
> > Jianyong Wu (2):
> >   fs/9p: track open fids
> >   9p: fix race issue in fid contention.
> >
> >  fs/9p/fid.c             | 72 +++++++++++++++++++++++++++++++++++------
> >  fs/9p/fid.h             | 25 +++++++++++---
> >  fs/9p/vfs_dentry.c      |  2 +-
> >  fs/9p/vfs_dir.c         | 20 ++++++++++--
> >  fs/9p/vfs_file.c        |  3 +-
> >  fs/9p/vfs_inode.c       | 52 +++++++++++++++++++++--------
> >  fs/9p/vfs_inode_dotl.c  | 44 ++++++++++++++++---------
> >  fs/9p/vfs_super.c       |  7 ++--
> >  fs/9p/xattr.c           | 18 ++++++++---
> >  include/net/9p/client.h |  8 +++++
> >  net/9p/client.c         |  7 +++-
> >  11 files changed, 206 insertions(+), 52 deletions(-)
> >

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
