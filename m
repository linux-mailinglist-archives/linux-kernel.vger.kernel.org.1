Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F029AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750684AbgJ0MIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:08:38 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:22168 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750446AbgJ0MIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:08:37 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RC1oYf024624;
        Tue, 27 Oct 2020 05:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=xkE9He5qjnURkSyb4YlytvSZGOJX8ZDP2Hkx3BDJzHA=;
 b=leGfK++1d9DjMUQSnS66Q/Zd1cn3rCGGTB6IkOd5A2gbZmk+SiotRUW4VSpRV1me4euh
 tFnCc40ttB3qba92MO/Y6KVLhtwvjtAL6gfFPyLqVmBbaINys8eLcVDeyJBGeSxF+6Cu
 9Ruo1aiGWV3BJGlmUrAhiUMnjVD7aJx87mPMahLDPdc0BRsry2XUs0Ki4cLqf5BZnGFB
 085+/RJNrAvnUmhHdquL03X0+MaHhh1whVrq+HnWVuhVVUuN9Gjc1AOzKkrGFx2LCBzq
 CjZ/92Nxj61bEXpjCMLNx/JBEdpc51yYzfJAE0jErHEnLrYbankza1Cu4hkP2hpc13/B HA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34cgtvu11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 05:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnBnyooedGFju3z1miR8xsHlB+oFhVO2Klp6K5dh90OzvJzWHhCTaDPnccjAzA6CgbCzzN38ppdShTbL0FwhZpXa/aV7wE93gUxZ0q4f314EIGc7ixpLosB6m9TbprBL7kYcRVuxbqUjDV0xTrcusvVbFdY8j7iB8s7h7Flcp5NGvjuqJH/vo6KwNfxFc5EuQc8pEfgV2povdyALImbu3yCGrAAnxN45ZcTHzBDtvNZ9qww11KHfBRTXern77vHHp+iAFFHCFp6RioNOIr8w6si/1nXE1ZmPfKhyhbXyD/ekGv/t0VzeMGBLofMIVr+e+TUx+tsXC2sknfeKCV2ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkE9He5qjnURkSyb4YlytvSZGOJX8ZDP2Hkx3BDJzHA=;
 b=c4F5SS2kl8Ui5z7GGls4IUgJ66q6CFdVAqv67UZut7uQLZRD0xfr+FzRNlNFsUqkM64uTo0pdn90lpmpmOFiS3yam19pzul9NrKYIQlDbckV5BuR8OrGuX3R5mXFaVYnmOhSdPdrWMmliU7B2nzX9z53WijwR9/RLriTRzeFqkC35nHmK338qhATseNwGfjrrvYuFPE+IorVr7n9aDIKWWMN9KdYmgWOj69GaofO+9TiBceR73JiI5sXfcbFdwx9gMuIMAjTkuOSb7h+qRcritvMLVpYTNZM1e8UUX0HZHZqQIOA+Q+/0VSVImrg5lY3EM32/bAsjGV1eRFwaPlilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkE9He5qjnURkSyb4YlytvSZGOJX8ZDP2Hkx3BDJzHA=;
 b=THVDT47kuaLIsVmp5Y3r/gYx4id7zoSzracON4IxQXSXeLxmM6W/gxTjepAmADCvySNwZ0E4JH/48zlq49wb7RAOOBvMq6J373MlfgU6pLCM34rYU89B0yXnX9p9rtYPZ5O3n06axe4RrP7OmP4EvUu6lpR4AIBKKcJfdF6mLU8=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7243.namprd07.prod.outlook.com (2603:10b6:5:217::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Tue, 27 Oct 2020 12:08:25 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3477.027; Tue, 27 Oct 2020
 12:08:25 +0000
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
Thread-Index: AQHWoq93MTVmC9gJQEy5qA/nl7dl3ampshBwgAAmRYCAAQ0+AIAAiJ9g
Date:   Tue, 27 Oct 2020 12:08:25 +0000
Message-ID: <DM6PR07MB552997CD8216B5AFD522104CDD160@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
In-Reply-To: <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWJiOTIxZGMtMTg0ZC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDFiYjkyMWRlLTE4NGQtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iOTk1IiB0PSIxMzI0ODI3NDEwMzE3OTI4MTMiIGg9IjMzY2FyT25Yc0FDK2JqdVE2NE5IcGZBL1NTST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3e5af5d-adf9-4ae5-c7da-08d87a7101e9
x-ms-traffictypediagnostic: DM6PR07MB7243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7243644900B8DBC1C2A97B92DD160@DM6PR07MB7243.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fO51xRvJtETbbAxxN9eC3DSE3DA0WmGWmPH42zv3Cz3NDLX6w4xTY1slyMkvtiFlIMdedxx2Y7oNJDyyY9hCu4gqqWguoPbm5vvQJJWM5AKGS7bkt2zw9wjdXzxHedX5jTVysKC/SQIcQgPQnhAzGMh2zg/QcRwzAsdNyDBwQNPoqsq9zkjvF69kFXbBYhnu0UBZMoVft2pPXe5U2H4VQ+t64hiLYG9XSCy6m1S6MLKlPykBZXC6JhnjwsZdCBo4spX9MNADG9uKnA7ZXeM8dWoYIvwZn7O6W2f35OKhZycRLPDk8PUSAVJLJzTo3wzWxclanQUOVmsgCZJe19hVNWji0Tl1DI08OGJv42CmD92eyVrleCm4je94zEeyKnK9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(36092001)(26005)(9686003)(107886003)(86362001)(83380400001)(2906002)(8936002)(66946007)(4326008)(64756008)(76116006)(66476007)(66446008)(33656002)(8676002)(66556008)(54906003)(71200400001)(52536014)(478600001)(55016002)(4744005)(316002)(7696005)(186003)(6506007)(6916009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r0zcsZykaL3KyX0xPtnfNvjEhWfIkCEGQZJxPU/e7GDY/i72k2Qhc4PhSuQkPuBg18jZ7MB7UmOZcAdlS0edxjp8XP22+0HR++ZOkJPwqihlcD6YNloMPpYzf3wuuNbaqFXTGAFq/uAc3yp/540L6G2QyxOWZSMcy8PZweFvLLnaZBWN/0if2NW3CzH8taKZzOwxqNSBqT222B9XRyyY2IavYaINk+5eszO1GSW4hVrEARvgR3ohyi6ImC0jdrVc8DSLgI2baKiy0I/ZL7z2JR1Zy0resPUH9iOtvBWXTALjeK+37jS0Uo4R5c6xozIAlpfcs9szE3R1CUT/CbUK9n7HXd8wznWM5W4wrJrtfEYzO7fZFgnYuNyzfWtPkZYFXOYaIXDbSRFw0uUcszuq+DxvP7NHEWRZCjsCZ/+CVpPhriTyJSFyTfBzAtSfwMFw5HRxBj2t8iU7pN9TY8xynRjeAMqIa5mH9nspc1NS5W0qj+whStC4t+Tgt0e0Arhc0taknPbPClHgG7J2Nrp2go8aZ3wkVQKzRCyL93+HiuSJhInVENde6MdWpZzPUlHOiZWILlDYg9hjQ7T9FwW+Oxmotj6/lZInJx3LjEIVJSh/tgdKqQsdtk/XpA2A9L7wM/sVHWB9V7eJYxbzcaYjwQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e5af5d-adf9-4ae5-c7da-08d87a7101e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:08:25.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPjzTEsmt1ZBM+imygLlqti4AoM1VN687BbKIyameXXnNIDroscEZen6UzPL106NgdJsBvOjAquo0Gpp9UrvFWB3x/la9BODljtPYSmdUsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7243
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_05:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=487
 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

It looks like you missed the " [PATCH v3] usb: cdns3: Variable 'length' set=
 but not used"

It's quite important because compiler complains for this when I use W=3D1.

Thanks,
Pawel

>> >
>> > A gentle ping.
>> >
>> > I assume that you should add this and the rest overdue cdsn3 patches
>> > as first to you ci-for-usb-next branch.
>> > Am I right?
>> >
>>
>> Hi Pawel,
>>
>> I queued them locally, and I waited for v5.10-rc1 which was out yesterda=
y, then
>> I will apply them, and add cdns3 patches to my kernel.org branch. Will u=
pdate
>> you these two days.
>>
>> Peter
>
>Hi Pawel,
>
>The cdns3 -next patches pushed to: for-usb-next; cdns3 -fixes patches push=
ed to: for-usb-fixes.
>The git is: git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.g=
it
>
>Currently, I only pushed three of your patches, would you please review my=
 patches, thanks.
>
>Peter
