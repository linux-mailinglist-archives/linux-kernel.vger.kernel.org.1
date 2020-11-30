Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F62C8598
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgK3Neg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:34:36 -0500
Received: from mail-eopbgr1380052.outbound.protection.outlook.com ([40.107.138.52]:54869
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbgK3Ned (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:34:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkeq6tQzaP8N0GZ9eGResJmJMG1GEPAPuwDZD2TXKjtlrK4lNJQdF47VYzWTb6DntYji7fcrRV2olBX7MGUhJIP85VJ/u6L914g6NJLG0gehtfNtqdJBDTQSSLcUFaX+Z+DgqLN6EX5fhvYf48mD+BzjGRQatPTK3AUBW7Fp1x+J/PObDg9Fmvt9QC5BTaCaxAK8xL0htVHumFp6OTBdRErj58NX1r2AM9U0l7t4SzVcdiJHRDEJclLMp2I/wriYWXjVfwVxU8rCtT6xxpt1uImmp1mQ8jA9gOei3izygyoIk4c3G2gbJq/WlFi+we6AcAVVZGXXtTJyoSfbweH5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPRwZt6GqYm2jyGU2M5K4xYjiWNUjYFUMf+WjtuM35k=;
 b=jVN46pTS6OCtE8fd+Jow9jRZadIw2ghm8I5i8gG2EnlpniUupUZagb+czTx/leJfORQpIi1mBgwncbDkDV/FkGJVOm7EQZSBpjM5gbpeTYc0qoN968uLoPuTlwOcOREGRvL3QnXXQI3UdmUS1sgJSnsOOXzAdaD/GOxeoeHi7wozdLol5kjXuLeTJuu6NzP39aZUt00GK1bVpUbc80u+hxYVOKVDuTmRXdT4TP/lsvgH8yiGSgT3v5S/a9LkTOXv0rfHZ5aNrbdmHIgnf6VkBB/5/f3I0rZdmtB57Oui64EwBXK9UuWgBiqAb6dXREoYgcHtWHvIsiLbVUkkFNmgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolrdvisiondata.com; dmarc=pass action=none
 header.from=wolrdvisiondata.com; dkim=pass header.d=wolrdvisiondata.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT6437635.onmicrosoft.com;
 s=selector1-NETORGFT6437635-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPRwZt6GqYm2jyGU2M5K4xYjiWNUjYFUMf+WjtuM35k=;
 b=OaGT/+VOjvZBMZI837nwVuN09N/FRbljBqg1NTcp4BMGHJbtRiS0ZnmTjXUmtxRYMPn2KUZ93QZfUFr/uM30BxLxuwnEvRw0USfVWWHHv+gClqPFR6uZIvzGeLFuFbOqbHfTZlEH5Waa5OQ5/0e9ThQA0Cph58XOrfzfgFIyaP5yLHKeJ6b/MRbwPER51ELalzXnCH4gG1S52lAB6oNZioELp9ufz3mCN2nN6WXwSU+h46DPX92Txrx0F1Aq3A0hjLIwQeRzA+hUMoMrgZeLGqoG/RhMSIR9J/qSW0OFpF+X8+g1j4jB5Nx2eR6WiZ/rN2dNxt8Cpw1zhaPXE8FMrw==
Received: from MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:6f::22)
 by MAXPR01MB2173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 13:33:44 +0000
Received: from MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2898:2472:50ad:c3c0]) by MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2898:2472:50ad:c3c0%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 13:33:44 +0000
From:   brenda taylor <brenda.taylor@wolrdvisiondata.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Visitors List - Gulfood 2021
Thread-Topic: Visitors List - Gulfood 2021
Thread-Index: AdbHHWuUegSE9XOEQUa4l1ck6dDy3A==
Importance: high
X-Priority: 1
Sensitivity: private
Date:   Mon, 30 Nov 2020 13:33:44 +0000
Message-ID: <MAXPR01MB347109212EDB7CA37887115FEEF50@MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolrdvisiondata.com;
x-originating-ip: [103.91.180.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd3ca24-68ea-4d70-ead9-08d895348efd
x-ms-traffictypediagnostic: MAXPR01MB2173:
x-microsoft-antispam-prvs: <MAXPR01MB21732A1944DDCE869811C104EEF50@MAXPR01MB2173.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoqV3AsQcYQfvIqyXoWjYSBOY9np7ohA1nwH1Pq68/JgBFWJhSfDKhYZ7eFm1tr3DM2SQWT2kWzTE2Om91/XvMUTyGFfqlPetVuYu4oxdwNFeBbKV8A+4k2c3MLtKGG57/ANrKx6FVYnk+JM5E72PYOlRbZRKqnrCNQgK4ZLAt+rW8w/Zbagacqs2x1IFuFw9LsQWZPyQ2pWDihxwkOoBHBUA6XZ/ZIR8Q3rbD8cAa7EdShSLsxLv+767YD0ll+5A9l+iOowfjn6rFIDYlOocdG3OpyTZmy2oDko18z5yNbIoh0+JGZIi7x0MnMXccgz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39850400004)(52536014)(6506007)(7696005)(2906002)(186003)(83380400001)(9686003)(76116006)(8936002)(5660300002)(478600001)(55016002)(316002)(6916009)(71200400001)(66446008)(66556008)(64756008)(66946007)(66476007)(26005)(8676002)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yGyBy6f5JyiUSXuwqedbqKhOe5QrrRFurg9HQE4EJ0QGdeYnpllpj0B9sXF0pLCNJxLUl2sZR1BwHndMh0PWYqg4L08B9l7O7fACiImrGkgfAHfxtKVBa9CD1OYjTh26jvJ9mg7PPr6M0j+mZt3eJh3NhnucE4KWtkN2b5bFBrSwf1iIn/ayK9qfWsOyvVUidEZOLeDj4W9DeozYTCvJ21b/xTrZTXm/wtPOV/4p0H7LtaKHCxmvGAHKpdfKbzkl5fOFaGDtylEcEeu5+N+SJzaAZfxuyv6v+fLeyPaaSfF3/W+oE5yJ5hbjZ8keDjRoZqkFxvgE771gW7lk/3yj+WIi8NADAfz97f8u0hF0UKVScD9NaRYPXACYi4l4sfVspzduVDbUpuvBpctegTY2LNM3URdCGSN9YbQqbjGgKh1aEKRfEoGrNqNiG8rfI3lOTjDtQzWe1WOhg0ZiAPEMQI17U5I3tjJnGgcCTnyrg1doUvePLAO+nzQFYrZdVAi2Z2EO/LRiG/bUzdTcMgoZg2DZgX40p6ozwfkWkMiAM7jtbbgqGmcBYS7QYjKgnvjY8US2iJgFT1FDkvn7SMtxkIe77QZgPtdSNB4oWGWE+4Iot1/CADcwZKjfp7HqZC02VTLKl0BsnwvcBBEUj79tqGaijaMOEWveI4Do5Tp9N62W2rDYhxDSlswMpjLeLSUeDq1wzgjLtIS343jiPa/8zjwtPplZ4zeS6Dgz7srExwo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wolrdvisiondata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd3ca24-68ea-4d70-ead9-08d895348efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 13:33:44.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 446afebd-6727-459a-9f99-49f9f43d6b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2q0qQbgSAU0dCAaesaYgSnTNJYrV4nW++qfIRoaAYCtcPvCW+9xOJtOheWvQBkefDskiS41pX9mNi0dYTC2ZPF6P2TXmsKK2VdOb0We59YbjBVNK5fQljD2a9tNygKeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB2173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

Hope this email finds you well.

I do see you were exhibiting at Gulfood 2021 (International Trade Show For =
Food And Beverage, Grocery, Bakery, Cafe, Supermarket and Restaurant) and w=
as wondering if you would be Interested in acquire Attendee Companies List =
for your business needs.
We have the most updated records of past/current Attendee Companies who are=
 participating in these events.

Information Provided: Company name, URL, Contact name, Job title, number, f=
ax number, physical address, Company size, Email address etc.

Date    :  21 - 25 Feb 2021
Venue :  Dubai, UAE

Our list is the best source for awareness and can be used for Booth Invites=
 -Industry initiatives - Product launch - Brand awareness - increase in rev=
enue etc.

We also provide customized lists as per your target audience.=20

Kindly confirm and let me know if I can share Proposal for your approval.

Many thanks,
Brenda Taylor
B2B investigation & Tradeshow Specialist
=20
If you're not interested kindly reply with the subject line "Opt-Out.


