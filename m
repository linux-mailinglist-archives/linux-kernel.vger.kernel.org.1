Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7927CB77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgI2M1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:27:51 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:15216 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729774AbgI2M1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:27:25 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TCBecA020335;
        Tue, 29 Sep 2020 08:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=spO40GzvBWdXFKCvtn4K4s76Wb8ADPmGg/R2OWcSlL4=;
 b=LwXjTvbZ50s92RyXmBaAI7CRwn0S/WX9yoc3URtDr50VqWptZ3FyxbBNtdStD4DMLLVS
 zljzs7aNCyna+IdSqm8mNKp7AWhbMfivGArp/dKRqvABhNrSFloU0vTcJ7aA4JiOq4id
 d5Ul+pIq78suyhRLsKvSnWrSNaG8evFcvj093UstZ+3L0whqG7sPIejLdsvCDofd0OET
 mKCbpsZ7Yxooj41+HG/c5PYSyhsOr4QKUpuGxly4N079/aRQbUFMkIkB8Uh93eaHqd5p
 EeRAX9nrKzN8NW5oNuIOg9siu3IJWVjS0C084Vz/oe7bNtBKjhdfHXh5rO+TClMD5DN1 6Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 33t1nkrqet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 08:27:16 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TCHpk1187679;
        Tue, 29 Sep 2020 08:27:14 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0b-00154901.pphosted.com with ESMTP id 33v0swbfsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 08:27:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZU7dF5iBYowZJpVDwc2yBiM3rqNYUhyXa+IiBphiUdzSga88zy/ty3EUUpitDGugjh+cPxmbGSRGPzS8zFw3aE0tO/8yhfP55zHjGDsgRZCe2niMjBduiJa3ntgxhJqQRVg0m89v6AIOc2alJNAGtgXDb3+VV+/Ex7LKzhFTNx4OrN+0XV4o5BsUYk3qoqxjJoUEiERhJv5o+EGG+tHvPSBK5Tz2M4byvO77RU4gX5nujIEiOtZUD/usloRiMoev2GzP73vjsVu/m5wv/6jMwQcfLkRM6FBxjtHS10pn1yZC4UCwBC9V+ikZaOztvLPlMvrj2EL6LPcfhKVcnJYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spO40GzvBWdXFKCvtn4K4s76Wb8ADPmGg/R2OWcSlL4=;
 b=lC/hMZJm/71FqOufa2MM3zfnbSPtZT5Qt3StXhYej/SnrsrFpd3QstQt+8S7HzIOMUoaYSsoogMlChuDRFDjSq1xhbufm6PNf6hP8qO4wT0dzreaACT4aW+GvBaZT+ZRyngod43Bc6X0Q01F2xpbFPGgm4h7A3cmemDAraUWoEk4D1Jn0PPvvH3KQzH/Wii0B1FXFzSUrlHP3CsOGRNVSlMxi+cYcBnBO/vUY6Jb0JxMaFlSKSShDIklFh4BdkDy2qqEJfZGzxzyEqHq4fCt5REGloB1H73WeyY6OGllK7sIYjb/RyV5M/qQZM1Jtkfp3Oytn23clfbWNlCht2zsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spO40GzvBWdXFKCvtn4K4s76Wb8ADPmGg/R2OWcSlL4=;
 b=Wzla8o0htfbvFz+uiEb+Zg2Hanx8MSt4xY7fMV45e8omgFZ2uddtHZAJthdaZqJyZXvjNiLMh6EScR+jQH6IC5f51/PQVhc4EERUCIfgltVBeEssjQQeP5qduqj71xliCsVBUdGy/UU2L5C3mbnsPwMOJBfTaTjRuNjbzbdYldk=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2905.namprd19.prod.outlook.com (2603:10b6:5:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 12:27:13 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 12:27:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Takashi Iwai <tiwai@suse.de>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard regression by intel-vbtn
Thread-Topic: Keyboard regression by intel-vbtn
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpQ=
Date:   Tue, 29 Sep 2020 12:27:13 +0000
Message-ID: <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>,<8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
In-Reply-To: <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6dababa-d446-436d-78d9-08d86472feb6
x-ms-traffictypediagnostic: DM6PR19MB2905:
x-microsoft-antispam-prvs: <DM6PR19MB2905F42A6AD2077CF6830F6BFA320@DM6PR19MB2905.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUjB6u4tLgAEu4+qOVFeh4PTSxjgLHUS6wqmuEUlkp2OIcYjm8iDg1mhWsh2sKYHnae8PilQkA8Ab2a2MD4k4ckvG4BdS7Efzke68rP6zo3o71ohG6rPbfaymDcaISiUe/8C4tkL1/rie7L7aemLoozJDnjVGAbzWzxwIpb9xC+WTcOKT65qY6krGtT3gwwx0YycBT+IRBys1MyyUdLvIRImDIshFbULy0qiMnTXNRye3TfIhXB55U6Ndx2wJNpJjNbJ2C3mD8VIoekPP3+NyAOlukaNedos2SJXGRV54nYMzGSR0badgKCR3xjH5khyiAQcH4xUj5kP0PcgwXHHKAzMOwcxWB6dU8jIYdVuVLS1rggORGABTYUsKPmSY3+fDsH1cbkjC5XDAA0devaxmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(786003)(2906002)(316002)(966005)(54906003)(110136005)(83080400001)(55016002)(9686003)(7696005)(86362001)(8676002)(6506007)(4326008)(26005)(186003)(8936002)(52536014)(5660300002)(4744005)(71200400001)(66946007)(64756008)(66446008)(66556008)(66476007)(33656002)(478600001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: k12iOsOKaebiIwuB76mPNaThuOIpDwA6gPry+d4HlLTf4stgdscCW7BZqwRH7AZI6TfUAXtF09P8DAZPN/F2HQwRQsTw8yVrDspaS1cmrxdQ/vQutQJ5L7c3Xct67m3WYTQUyAQuDxlwtf3g/s82qUPv7RO1PqoM6zB+K9JBoorz3Ai2p4uoqQEEiQfI2N1su1XPdeRx0vF9pNxppUQImT3THvSftwrvC1yBk8EtJv3fzXNCejrAqU+bsSZW2K/QUBbDWh2nrZhSFLah6qeMaxYuMSVPWwJpMcyxNBPBj8yUygNVuKIXd91OT6hxTTtP35gA98z/WW40M6nq9Tv04szB13JVL0ZayxeAZmtlURbnIjKfEINAbYkS/vgKOS8lefML9dmFJvb1LY3pkbN8Njoh4q9W6WQNOREm5FrB/GlsrlWl7LgJDYo1ZHjm/OydOwisQ5KzGEST+w8OBxh6fEuFqmAckgJu9yWSA1POXnRTk83o29yKM9BqCJ6FlgAd4hb8bd7zlUNOxCf8ohXgJSsxJUnmhk54QavgDAMuUj95HBVCQkCVlm3jQVDrO6JG+OAUnXCO3q3oONmvXutQ43c+4U/G4bKtO5fO10nZ7KqazJMZtQ1kCcyBtzHYA8G+MCn6LYcSslQ4Lnv9BXk2tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dababa-d446-436d-78d9-08d86472feb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 12:27:13.3486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ovku9Q4bmAf6pqcQFwkEaYJww3hA+bJu2Z5nJLep4ylLQx7tzNlY9mXBx4XAGWeARxdK/diTbLT8B81iPjt9uG7uc/pvjPCAr+QpqvO/Z6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=865
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290110
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=968 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm afraid that the only answer which I have to these questions=0A=
>is not helpful, but in my experience it is true: "firmware sucks".=0A=
=0A=
So FWIW there is a Dell 2-in-1 that has been conflated into this same issue=
.=0A=
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394=0A=
=0A=
Something that is confusing to me is that on the Windows side all these=0A=
machines use the same Intel driver for this infrastructure no matter the=0A=
OEM.=0A=
So they can't possibly be putting in quirk specific stuff in the driver sid=
e=0A=
can they?=0A=
=0A=
It has to make you wonder if some baseline assumptions made in the=0A=
driver early on around tablet mode support are completely false.=
