Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF21A29E241
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgJ2CMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:00 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36522 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbgJ1Vgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S7K6lY021745;
        Wed, 28 Oct 2020 00:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=qwfMENm5QCXd1OlDUnFPCysqzZTD8wcZVk61ewJx7HI=;
 b=OLCAKLdPz3vuJZFjYbEOAolZ2YvLfFz9Ci/EY605sQ1BLiUewJwQgM+WFZmQcpEpKICh
 sKxZyQu+L6z6VGeEV9Zw4g0U4ve2yV4X1fUbIyJj5Y1jhF3XceQOjT6lJTwx+AkJdAmK
 TCRiMznj3oKloaTt8pVcp2Q1XdDm/HmWuurFkHfuObeyne5omECRkfkr+0nEKCt41SiU
 zdPRjJ1MAQvrDWC13L+pX+KLiWywhprBt2f9GRqtxWBndrN/E202GuI12IwkKpIlrC49
 SRtJK2hgsIPt0fal/gtjdxauiXOjfvcT3cRQZtQ5AkuhyZyZk4WnSJSWe4B8spNiszQt og== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34cfux72ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 00:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no1s5I1dGM0lj2s0EZV62RiHX05mp4qP13y2Phx4INooiCxd1tP2Wb1eI2ncey+ytyL9EJHEo7+Kf/fZdkMfTvWGj86Q4YcsSgDmn0hp69TZJsHGtBq4iHS+ZZPqrLhSJKuvAYgqebwi5jbijXXuqEIGMqNsIJ94SoUe84Ink/yyMjjUQfXHkMN5hbHUGd7Eks3gIZl+xgRc9GEFcM8PG74aGCIFOJLVnM8tqG+5MmIU75il402BdZD/sAcG26mzVlDsnfrt77ux4rLXi5+ycWqe255xl6NqIfPOZc2MEs4OznHBk2/V0Ouy8tmbR+qNFrwL/YWcnt1jS8xDZz6TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwfMENm5QCXd1OlDUnFPCysqzZTD8wcZVk61ewJx7HI=;
 b=nWQqHF8Kugf/XVXHRL2PbfWi50bG4ErvHo6Gnk7+igdLay8mfojlfXu984wwe3Cywty7mDJoyZfKies5VpwRWTCbsxPLrSP69fzWQ4NBZ84jcYy2fwZelKlxLQhBIbGAvO3Ldz/1eAN3NOhrSx5MqdgjA4dLtTM1c/5IItVuXKDNPdGlkSzKEWo8HQ6Pxv/bwGLzeBoouz5R73TTBFeY+LcBSENZa9vY9/HS6HmzkLFLe8rWFEHh6aA2A+bDYN5KA51Xp0Sq11CAMVtDoXN7zpQMJU7UUGIxDXjR4u3tuBY3J1UWV/qNJJNZJwcPsuc4+l6n42LMt1Q6iA5Q4Sk9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwfMENm5QCXd1OlDUnFPCysqzZTD8wcZVk61ewJx7HI=;
 b=KPylCGAb3eKdWfHBQlocb6kU8zryIHXa42/pmBMwB11Y2q7eB7BuYLcVuEKC/Fg2C6gW+0DS45nFLVKqmZRLHgQo5P/2kg47fiZGh5bQ1IbV8sWk45cE8Cr43ntUwV/osrbNpk/A2gfK8b8mti68ACoIzG7aqZ1+XycPy9mBIPA=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB3499.namprd07.prod.outlook.com (2603:10b6:4:6b::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 07:20:51 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3477.027; Wed, 28 Oct 2020
 07:20:51 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Topic: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Index: AQHWoq93MTVmC9gJQEy5qA/nl7dl3ampshBwgAAmRYCAAQ0+AIAAiJ9ggAE4DoCAAAd6AA==
Date:   Wed, 28 Oct 2020 07:20:51 +0000
Message-ID: <DM6PR07MB55296E10F720D4B7431663A4DD170@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <DM6PR07MB552997CD8216B5AFD522104CDD160@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300DE47422D951CF74E006C8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
In-Reply-To: <AM8PR04MB7300DE47422D951CF74E006C8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTk1ZTM5NjEtMThlZS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDE5NWUzOTYyLTE4ZWUtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQwMSIgdD0iMTMyNDgzNDMyNDgyMzc5NTM0IiBoPSJSSk5hdjRIMWtveDdvd1NSSVlYVUlHL09WRVE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d6eb8d4-32db-4604-53a2-08d87b120013
x-ms-traffictypediagnostic: DM5PR07MB3499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB3499EEA1C093E9FBE3D67E82DD170@DM5PR07MB3499.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zba0qmAjah4LQenjqjM11Z0oDvAbe8bLXBV4y9MhXEL+h7dQTom+7WYY3WOVTo+chqV092xayz/I22MsUzgREgBoZSeX6HnYevYr78Ylo1V152cgeTEj+BbfebRKHaGEBn76lRnmfAm5cqwzGd2KGPYSMbWYlh2KAd2tclwn0HY3tOS4Cq/KMmfbiT1RiOck/nA2Uuo1GZHsr9/LrqJ83xC9rCLLVH34azjPwT2qkjZNYJNuoU9PiB09vnQr0PjRInGrxPDTwaKUxhNNIZ7ejOaZ9iLZrd/ORxog5/liZCnbL8rykRwMGGFqFk1OHBZhH/JeDaPOvV0evSGJZRe7iG5NILqQZvSt+V8GVmawsblgGzoYpWQhQVTAYxFCKxYnZRUjFY6Icap7ZaCVjSR4doQCwj/CgWKAYg5mNsR8KprVQTnGEZO+zQoRje54qFLtU/91pGO42zyxyo8W2XYX6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(36092001)(8936002)(107886003)(4326008)(6916009)(316002)(5660300002)(71200400001)(966005)(54906003)(33656002)(9686003)(86362001)(7696005)(66946007)(64756008)(76116006)(8676002)(66446008)(66476007)(52536014)(66556008)(83380400001)(2906002)(55016002)(6506007)(186003)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PXRio5a64KwueBNLh72vbcX22e/fA0lrmBcBhOg6kk2cyzUtvk5l9lUd0kndh0MSQO66dbOksPNkfQbXFuiD0620717vsP8amDo3zCwmyNkGx6z67ZfKgJUOFOPTGlIoLa+kttqKGEoHSnMQZ7WgLTcgf65+HEogDKzQiuFzXEOo+70LF7tjXnFCo2n7IWTGSxpg+oJ0QrWiv4+oCbMUeiA7cL7qbzKLwxjFMQIuX9R9ykYfsMaNlW6etv/dpfl2HSokeFqAce00uz4MknM38tVHYFDIB7uk0XtKwzM8Gc4toUuV4II5ORSEkbZ2pQmXKJRqEFHCWicSs6S/EPY1vUFsgNJQmTkbmdKvAYrt7tWcvyMREa41c8yKApd7K2LYUkvVaMIjypsJIbyMCO6LnH9ZcArwwBklTO7vKvtUIJUN1+hgxYl5BGuGAJVVQHxfUPcj9tcD18E+RvK0Ar3NFrvi0OftTVSVy2C+KsBfiH+3qyYcIvpWoPLXUL1SDsXuHgG8QakFiPpS/YC5tFQslrvBGzPZqp7Ndpg1STLltfi4WXtkkDQUK28lP5xVFarMOlsDtrbTYhzUfVn4aUtq6q4rb1fghYuEy6vAKXEMjn7HlTB8A//R5r/O3GYfXIrFR1/mCjoyXu0EvZ5rM+E3lw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6eb8d4-32db-4604-53a2-08d87b120013
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:20:51.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YixhuOsZ1xCiKxJ6ei9yFt4KAextMY1WmGXkHjIwA2ef4cXDUgjolBZ7LxgNfJ+9EaL7TyjvnnI/5NWLq/xtv6h9lDOXXHtINy8XXbgRals=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_01:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=834
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>> Peter,
>>
>> It looks like you missed the " [PATCH v3] usb: cdns3: Variable 'length' =
set but
>> not used"
>>
>> It's quite important because compiler complains for this when I use W=3D=
1.
>>
>
>Pawel, it is the bug-fix, and located at branch: for-usb-fixes.

But I can't see it in this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git/log/?h=
=3Dfor-usb-fixes&qt=3Dgrep&q=3Dcdns3

I can see there only: usb: cdns3: Rids of duplicate error message.

>
>> Thanks,
>> Pawel
>>
>> >> >
>> >> > A gentle ping.
>> >> >
>> >> > I assume that you should add this and the rest overdue cdsn3
>> >> > patches as first to you ci-for-usb-next branch.
>> >> > Am I right?
>> >> >
>> >>
>> >> Hi Pawel,
>> >>
>> >> I queued them locally, and I waited for v5.10-rc1 which was out
>> >> yesterday, then I will apply them, and add cdns3 patches to my
>> >> kernel.org branch. Will update you these two days.
>> >>
>> >> Peter
>> >
>> >Hi Pawel,
>> >
>> >The cdns3 -next patches pushed to: for-usb-next; cdns3 -fixes patches p=
ushed
>> to: for-usb-fixes.
>> >The git is:
>> >git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>> >
>> >Currently, I only pushed three of your patches, would you please review=
 my
>> patches, thanks.
>> >
>> >Peter
