Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82A27D107
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgI2O1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:27:02 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:21924 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbgI2O1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:27:02 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEMd0T003244;
        Tue, 29 Sep 2020 10:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=AnIczJTqvLWHdl5/G638d/tFU82WquY+zijZQxmw3Qg=;
 b=CwxEUSAeHrQj48sVnsC4zBeOu2nynQEYwk9BpiXdlpaxGo2vQmKEmDqQbaka2nUw0Fw8
 JHw3jsMjc08+htaJDNk4ugZIV19Oy0iP8bcqZ9TIwDIMuBbBVTMNT/48AlwwsKhxCqCX
 c99cmqC3+k0mJIJYzQrlhEE9JVTtZ6fLOJKpxo1OShzwGTnN8Z4edi/HSiN+Evv2NJHN
 BTIfkInsi469OF7Sfz1QWKP6xstTSv3IrO7Bi9+0DhLZRDUMV75joDI+GGreCQ2Fdn2i
 VhDDzzExibSPgnOIpYTFQHRJxyhSoE6fdwcBt3suskFQ0zjdQ2PE7A+N8i5FS6VZRdB3 7w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33t1fyh8eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:25:51 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEPGsw195891;
        Tue, 29 Sep 2020 10:25:50 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00154901.pphosted.com with ESMTP id 33v6ba09t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 10:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSsnsg6CjuteveeV2rqmuQzwTIbP/sLiyQaQWmdQQQfFz5Nl/USERMxXYoBGvEq0JETapmmbYebPzC+6S95C6zXQYbGdzMv21oVZlpGASJe5/wp59VgmEvW6tM7tQ/BHkmkxThcSZUnjYhVYX+vRzlgVPYL3mZ/L90gVAi1twScCwc8OB/KYJd6FyQ9j7006eQXLS9NmpQTmv7S2uYQP8jtDlNjJRNFoy7LZVdHZDFGv2FNUpKo5+THTX7OBxqCyU1srJIih+OdeF2u9qILCBFFZQgu5IKUCgO45ykyTFxf7AX4qO5OTQiYSNyThgMIYmx9tGtZx6iVES1vxpqtK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnIczJTqvLWHdl5/G638d/tFU82WquY+zijZQxmw3Qg=;
 b=MSkWZl0WOlh8+n9Rzmo08qrQ5DZtHsUfh4UthANd7zBziy7Q8v8MCFNKIS/P5ewnxkIhaMr+dk0+FzQVXDQI6FkNqFC0zBAsTFnjf6uQKj2gmYtmO56eNTy6uD8L/uQ0qPMim8sZptmVBg3fHeUl+0ipZN1CWLNlpKusDd+2NHS5n2sTd4jh+wGR6RibTDIMn9+J3XGW4IiA5iASr4INT9LinDnOGNVigw6un4dSX2/j2oNL6yy6TqIE828U7o90j93IudwLVzQAithGTwFEp6rVPI8ApZeQfn3Dlky1WyGjykaoPC742zw1BGjESKwsMXW47Fw0+cv6PzGmSUH/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnIczJTqvLWHdl5/G638d/tFU82WquY+zijZQxmw3Qg=;
 b=ejUi9TVr0nz4pQIzdHhNsc85EU7RL0h0eGvI09T2zajP5Jc9FbIlXWwe+ClInetbKNCJZUvz2VAH/iNvuz3l4HkpX+e5mPB0MkfBsdY3ZM512TXfWF19P1iR25Ve2xnWkY5WAmznGOQWm/TMxGkps3YMafuk1gydeFOAmSlXvN4=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB0924.namprd19.prod.outlook.com (2603:10b6:3:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 14:25:12 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 14:25:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: RE: Keyboard regression by intel-vbtn
Thread-Topic: Keyboard regression by intel-vbtn
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpSAAAiigIAAGG+w
Date:   Tue, 29 Sep 2020 14:25:12 +0000
Message-ID: <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
In-Reply-To: <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-29T14:21:56.7117850Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ca234379-621d-4f4e-98a9-ed8fde90e046;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62030ef3-f8eb-4d8d-54bc-08d8648379fa
x-ms-traffictypediagnostic: DM5PR19MB0924:
x-microsoft-antispam-prvs: <DM5PR19MB09243B361A9F885B8E6AA7B9FA320@DM5PR19MB0924.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KW3RyVdw3NXxCahwf6nZz5x0of3iIjwbaFpsP//N3nEdA0K90PmtbeobpPtJ7wXjhnJXAsKvfBXvvaF7+CrOWfwdH1G+AowUUsLx85cHE+jpvcETYNbRrEvUqB8qfScjU24peoyivE4Nr74Pveb8rP5Q6w1BvrTK1DfXnfFH56zl3MFo4asBoC0Je8Kvh+FV+Ejf7B66s0pE5HZT12zaY/0mAtfXPRilPGbPPSkM1u8gy3TDuHPgsGDAeMYL92jKsSKP9CyFhJ4orxdI6L5A0PP/nqBsLpy1I0qCqfh7BGhmnsr7Pv7GPXf0r1pobcvoCKKmZndntPwOHsdGJr6m9mbOJoWGkhMq8SKUxM8qo/gwkvF4Q8o+iM5hvMnsKLKX+SYtpEJ/YusO/lh+54XduMNFybDLYj3uAEB1UDaX5SZN23oXHkTW7GhLvqLSSxM8yEfwQ8XD4Mkhhu3KdiD9UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(26005)(7696005)(53546011)(9686003)(55016002)(186003)(86362001)(8676002)(8936002)(966005)(4326008)(2906002)(786003)(316002)(110136005)(478600001)(54906003)(6506007)(33656002)(83380400001)(52536014)(66446008)(64756008)(66556008)(66476007)(71200400001)(66574015)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EZzxqaXvmPttpN+zPLU+lJtm2OXcpusLMu8Pm6A+wfslaMTtblEQ4PlB6SLnKCkyqdkP1TamLQ2Z3bMvBAhoyJ6t38q0Ai/wlIsvqy4cm3oKmblhptmVAvh87lKCCcK1nzVENFeUI2luNWnOipA6E6AOTJ8Kmy4xo62+SFGLNNvU6SJdsaBUs5QpevO1XtbmtYT0tElz4Rkl6PQ7X2ZCQrm5SYrkAYTkBj2TV4xZUdt45bHFAghQk8GvfyOiRykNzjpGSGn51zb7UAEMFuJTa4itgn46idfcjwBObRjP6AoM63OTGJiQxXVw45rPVZ+MGeLqYvN2sY1kn24vDJWkqFhU9KHGfcwpGUOu7jcK9f0fimkre8o+hBYS497XMlyMbq67ChlH4Z6zfvNw4yoVZNoexw5cJf9jOqHAAbR+N7yAZEqkDD+KgKMgaMmiKys9HOTJZRNXN6pERhhjOuGqXZi7awfHC7KMe04JQr5xihQQdDfk9qtHkCNOq8jyRwWwwrGOv0AAQQ97g21+oQ9BoWFh2/Z6DzfgQ4CqOCJNtkDWiREiGznY7XlpNqiAWu5cTCDl4Cvjc/3gQQSSSIeoVWPKNT1yPcBnbequ5zYUIAXYFLDcSecYl3UKOXnO4KWr542a2dCZ074qSsg5Psydyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62030ef3-f8eb-4d8d-54bc-08d8648379fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 14:25:12.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8sVGBVvLsjk2/DK3NEMw+J11Vdiqp0Zz7NF23EX6GAmtdft98pFh6ceZesBIfNBsyohAoAwQsW+yyiK8f9kUA/erk1dcF1hq3l3AynbyDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0924
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290127
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Tuesday, September 29, 2020 7:54
> To: Limonciello, Mario; Barnab=E1s P=F5cze; Takashi Iwai
> Cc: Andy Shevchenko; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: Keyboard regression by intel-vbtn
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi,
>=20
> On 9/29/20 2:27 PM, Limonciello, Mario wrote:
> >> I'm afraid that the only answer which I have to these questions
> >> is not helpful, but in my experience it is true: "firmware sucks".
> >
> > So FWIW there is a Dell 2-in-1 that has been conflated into this same i=
ssue.
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394
>=20
> That is what a somewhat old kernel (5.0.0) which I guess may
> lack your fix to check the chassis-type.
>=20
> Interesting that this actually is a 2-in-1 though.
>=20
> Also interesting that according to the reporter this was
> triggered by a BIOS update.
>=20
> If you by any chance can provide an acpidump with both the
> 1.2.0 and 1.4.0 BIOS versions that would be very interesting.

I requested on the Ubuntu bug for someone to provide these.

>=20
> > Something that is confusing to me is that on the Windows side all these
> > machines use the same Intel driver for this infrastructure no matter th=
e
> > OEM.
> > So they can't possibly be putting in quirk specific stuff in the driver=
 side
> > can they?
> >
> > It has to make you wonder if some baseline assumptions made in the
> > driver early on around tablet mode support are completely false.
>=20
> I'm not saying your wrong. If you can get Intel to provide
> us with some documentation, or Windows driver source code
> for this, then that would be great.
>=20
> AFAICT the Linux driver currently is entirely based on
> reverse engineering.

That's correct it was originally reverse engineered.

Andy,

As there is no publicly available documentation, could you see if it would =
it be
possible to get someone internal to Intel to compare private documentation =
to the
driver to see if something basic is missing or done wrong?

