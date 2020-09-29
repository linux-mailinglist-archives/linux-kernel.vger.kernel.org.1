Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876427D8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgI2Uij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:38:39 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:29622 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbgI2UiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:38:03 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TKVlq4006634;
        Tue, 29 Sep 2020 16:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=XVS5Wpdp9edpmlIkbMemGHF8TGeH0X7f/nOBi99ift0=;
 b=Awushw2C3nOzTe+rdkSz8KX6/P1udwroNol7vByR0VYhPZy1zxIUH6NqkJHIDt+DNZsV
 dLeb61HNtdpLHEfwxHtPhxGa8rEU9G9rbCpoyRsmLjcDU7jA0kG0BGco4VONBMKHLx/d
 ZtDhh7/1RrhBQ2BpFU0mjrWRTVtwKWfZdRNZqwvtpxkF9iAiWAff07GhR541TAUB8H1t
 bWPsDOYR/f0b8eC6WVmqA9J60OI0buu5x0bq/pJTCZ2hj41NcDGFo8Gkix/sGvtW8vP2
 UIcbGhFgkMh3qicaFGchuSlLl+rwz4G6tdYbh5joc9Ndww9r0N9D+lYgRJe1N9sHCCHt bw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33t2ap2rjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:37:52 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TKYZNH188138;
        Tue, 29 Sep 2020 16:37:51 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00154901.pphosted.com with ESMTP id 33v9hr2m41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 16:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f57ViDdMVCF+tB2pNcFnaBfEqO5TyuyT8xeyTcYCnjIEm+NqUVWRbe2haxPVHh5n+Jng96QVmf9yr9U+WkmuYUeld4kdZ3L8JKwkpm0/rWDV5ZEcDL37ysQN6qlyLHvLLd6Ru+7R25T7z6dTywBU2rOse0l+djn7+WRUgSImw+1DS4IDnpcj9Nu2S/mJdp22D8Mp+9vefrSAukqXH4lu7tsXP65pP2YFD1ubGo5wZOKyyKjG6b8TfFHkV8H8/0zITfYZcy+LhWBhCKDC/AR/8wxX6d2O0gKNC9EM1KJZZ6oYkYTzQh5TGKdMsFvoqwrEfyVpRjtM6xuCccKscR5Z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVS5Wpdp9edpmlIkbMemGHF8TGeH0X7f/nOBi99ift0=;
 b=dlwNOaCWsukmqUIY+jvz7E6fNLxKauCQsmAi70MDS0aP2A1Cb5GN1BPdX11f+irXZmCVul9+Z5MIXyQj2a7p9iRNgMyt9Fut3OecvMFTOIZwQU5BG1/kinkfTlguT6kyE+xu0DwEJA8bq0T9U2Gzg2NJeT1pwGoH+AeKbPmEik7+DOrErkvMyyeyq4v+HPrPvEwmA3+meiDiWtl8BV7TDRX3lqWmTvrozbfR8oUCEqeo/4TpwtmVUKrIckLzgUIyfZI5Y6CfG9vJ9qPBC+iiYFvzLvsFBrhjne4EeTxQp/WbQ5C4xOze1X5qECCg5BHBtIwTiOOiaKSSl9c8ZZmACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVS5Wpdp9edpmlIkbMemGHF8TGeH0X7f/nOBi99ift0=;
 b=n1xOjArfThn9nqqcNyTJ4R50IK+8FgIlWiqth7JFla6FOE8JocZ+XejVXJsgTI7METkoVZRdK63xYpfA6eZ4Hkkme+PCqnHMFqOIJNR47bBVnBmz43A8/eSgLvI8XTTya8LbRVw5A2L8b/1BPApHnR89CcRRm3u+tNWRTZUrYaE=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3147.namprd19.prod.outlook.com (2603:10b6:5:195::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 20:37:49 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 20:37:49 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: RE: Keyboard regression by intel-vbtn
Thread-Topic: Keyboard regression by intel-vbtn
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpSAAAiigIAAGG+wgAAqWICAAD300A==
Date:   Tue, 29 Sep 2020 20:37:49 +0000
Message-ID: <DM6PR19MB263687682E9CCA4B75B3DE78FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200929165325.GW3956970@smile.fi.intel.com>
In-Reply-To: <20200929165325.GW3956970@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-29T20:37:45.4853338Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=bbf35941-af41-47ca-aac0-bf23dbc8b190;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [2600:1700:70:f700:4924:2a57:f653:596a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ef49b0c-b3db-42cc-1057-08d864b787fa
x-ms-traffictypediagnostic: DM6PR19MB3147:
x-microsoft-antispam-prvs: <DM6PR19MB31473D19D453F7592BE70771FA320@DM6PR19MB3147.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASGgSj5Ems6xQatQ7mJcRZOXelkCYm66li0MqJ8EebidjlwCVxTPMcXcZnQF6Yh7EwhAWSGaQuyCLYvGMGdHKJ+A0CgAOa/NWXM1pBY4jRGjX3Pjm4KgMfin+JdmTA5yKkB8E0/Kp9rcE4BsEPP+LD7ltD5VjznGo1BwI3vbNoSVK6UdsfZoS657VPVnNwvdJ568+4cm3lHxV+3+MkVi2faEKybeayCkVeTl+FuISEF6ml3RE3q2HJ2nqE60wXBID+VRMgXFqCYykdL46TVgG5ZUZoGJUBXXFlXaXpZeE2ewoQxNJFLfeGKAlS5NsQ0FHrjc/3/MP9O5Hiu5sHaVepvPsbq4otFjr8IgT5AhTSw9jsn5y6vqo4CrZjv/dsK+EPIFxIBPh3w3SZlk0GXEMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(498600001)(7696005)(83380400001)(6506007)(5660300002)(52536014)(83080400001)(66476007)(66556008)(64756008)(66446008)(8676002)(76116006)(86362001)(2906002)(66946007)(33656002)(6916009)(966005)(55016002)(9686003)(186003)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jz3V/zrBO2p7MvNjl7D7e1ssAMLF1AOyviGOqrwLgZqeEe407Rp5+uNfbGaBaD88Pxpzx6/rzB6yakHtDznVyBSSjZA5hahCSyVjlc1Z0sgyc0KGN5JSYBrL0nfJgVApHLFdT3o+et8ZdKpBawrgvj7voK5Vx4ttgTtmAT6v0Uc2RiVEZYjQ9Qjdxb0mZfSlqVCveceSFedo9k+PBiIsuNOyQZjaI2ojRTZngKjn6Qbp0ytRwzirJtmq+L3LRIlbfeNp0WLEhfmTbM2Xc4IvZbWj2+gB62hSjfB5TfwfUxb/Wiv/l974NrhXNpd5lXA6//H3bdhFk1Oaw8KN5BJmQF7/CYKaM5IE+/IndJ3sYCZMLkbi+ORfAp/i3IMJvCr3E916SmAoz9eRTLQ9RsQym12gjqJzC2partJXeFU06pDhgTUvhbHs6422BuMlilgD5luOB9NXEj8dlabAequ+i20hc7lkcyJkOAC4K/KiVxaLLOPaso+AbkIeu3Td5tHYKT0xlaU6dqeyhCb/OSeHGgGjOL9NDKPG6vGkXFX5EDdbC6RkSJGciVuT/KLRAJ5EfPPSivvk49s/lLuHOAwK1EMENaR8G+gYgNUS41C5L0g8awHszdOg10iws7VoOj22HSItBXA+n0wF0jdhE18SAhhbQwKgrcgRB/lrBwrz7HZM4NmmcSoz3nuZQFSSLQMRTY//6V26JZzRR/SXkbjqzQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef49b0c-b3db-42cc-1057-08d864b787fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 20:37:49.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mr0AGqcEiBFDn24JbhN4Zjs1RIraBVzAxJQxh32yKtaGTftzAdKsjXnNDO71N/Y+o+70zxnlGrz8yYdpyl49Ppm/VlS+veQ7zd4TDKumtQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3147
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290174
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >> I'm afraid that the only answer which I have to these questions
> > > >> is not helpful, but in my experience it is true: "firmware sucks".
> > > >
> > > > So FWIW there is a Dell 2-in-1 that has been conflated into this sa=
me
> issue.
> > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394
> > >
> > > That is what a somewhat old kernel (5.0.0) which I guess may
> > > lack your fix to check the chassis-type.
> > >
> > > Interesting that this actually is a 2-in-1 though.
> > >
> > > Also interesting that according to the reporter this was
> > > triggered by a BIOS update.
> > >
> > > If you by any chance can provide an acpidump with both the
> > > 1.2.0 and 1.4.0 BIOS versions that would be very interesting.
> >
> > I requested on the Ubuntu bug for someone to provide these.
> >
> > > > Something that is confusing to me is that on the Windows side all t=
hese
> > > > machines use the same Intel driver for this infrastructure no matte=
r the
> > > > OEM.
> > > > So they can't possibly be putting in quirk specific stuff in the dr=
iver
> side
> > > > can they?
> > > >
> > > > It has to make you wonder if some baseline assumptions made in the
> > > > driver early on around tablet mode support are completely false.
> > >
> > > I'm not saying your wrong. If you can get Intel to provide
> > > us with some documentation, or Windows driver source code
> > > for this, then that would be great.
> > >
> > > AFAICT the Linux driver currently is entirely based on
> > > reverse engineering.
> >
> > That's correct it was originally reverse engineered.
> >
> > Andy,
> >
> > As there is no publicly available documentation, could you see if it wo=
uld
> it be
> > possible to get someone internal to Intel to compare private documentat=
ion
> to the
> > driver to see if something basic is missing or done wrong?
>=20
> I'm afraid that's all was designed solely for Windows and all information=
 is
> not available to us in any form (basically somebody has to ask for WOS dr=
iver
> sources, and funny that as a customer your has more power to get this tha=
n
> mere
> in-house Linux engineer as me).
>=20

I guess this comes back to why we have reverse engineered driver in the fir=
st
place.

Even in this suggested case, such documentation is shared to partners under=
 NDA,
and would need permission to be used in open source.

As such an allowlist for this driver might be the best path forward given t=
he=20
quirky behavior that we have seen.
