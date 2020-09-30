Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2BB27EC14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgI3PMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:12:53 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:36964 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgI3PMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:12:17 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UFBmX0027982;
        Wed, 30 Sep 2020 11:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=BUsqUN2gjtbNCC0uK16ij3yH58ZO3NFhunK6BffhDVI=;
 b=e8PxONmHHJ+bVJ+2DkL2QL2G4YGJbRAmVIHv+FaSTOv12TZY118MwBEV7+e5HAWzBQy+
 CciipoXTeoSg6hH1uBaFwvk25WXo1IM+EKHuF5uD4r66ZR4UvzqRSAzcJIKh8g0O/O0O
 F16uZSOF8lxhlG5byxqy7ahbg5TtqJ3kB3ZPz3b6Hmv5gkC0H4okekucwX01ZKqRXIKr
 z7RgWo6nUAp3sVYhujwfwU60V2Zsj6BZABgORuYPGuiLil6uEWvCdelrdOe8AU4uwBwH
 PQzsIHhiSfWSkxfzQrXwNJIwzW0n9yL4fKHxqoBLFttAZgVWvoNm2cGhgsRy11RDd/u5 Cw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 33t2ap5xe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 11:12:02 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UFB32k019887;
        Wed, 30 Sep 2020 11:12:02 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00154901.pphosted.com with ESMTP id 33vvcd83p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 11:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPJPYvMTYptHSKpMqXfYa4hfOUe3o66lg3NoE93AhIgs47X6M8Duk12m9ohXU2fVgLHpyfABbwxHdWGUZ4/0NVC/Se9UTEd/nxOFrq9GWKcHhf367kUyi0YrRl7JFkzDSa3Jc10pKqbQV8Tn7r8Hhc3wtywoZYHWni3ClnrZf4yclexKKKJCSMFCZRD5Rma0Yc4tE+ZlIxVCKzNTredt0xEcShDHRnip1LAYef5dN7HhW38s3N4iErzB76QEBnGamRc2ly0DYI1b/E00fBBfUBbOWUN1Dx/v0jx1CHq5PgLgEvsJU3+3zvzQb6dQq5EjUN5OEEU4UmhXkT1/wlMrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUsqUN2gjtbNCC0uK16ij3yH58ZO3NFhunK6BffhDVI=;
 b=gGwMHvnMhXrRVDTnsRd+5sX0E+aksYzC+1ZsrNaKdmbyCKSChNhPL+JO5yAdkX/lvkBuzZdNOFF0c4JjSBPlLsGsHPacKH+tiO9diJdINRJB9jqAQGyN5HRRV3siVNAP/rNnemzt7q4VmpCcXimqydO4KTFDvPsCl2GEQQa2VVIrtej5HMpzSN8DQ6VzK9poHt4eP8tE0jpME6DmfMQB2Hp1gTfnDr7Q2FocVgqAgJOoEFhWu01rp3Yx6cvqsP7Zs1x5jcdfVdgm34H4v/38H+jYvWu16AwdDEbvm+U9qHfwruv8fMs3oKDiouoiJqIr8xeNoPIpMRx+AN+6DWv/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUsqUN2gjtbNCC0uK16ij3yH58ZO3NFhunK6BffhDVI=;
 b=mrjKkBoma91LMvidJi+86qmMXX9U8dF+0EgCp7d4A65MFsSQXTdXk9W/FexzeAsQFpRfgqUnTCY02WFDtrtiIsgeLz6vadYvm99cDH+9D5xEoPYYUywYkxwtLN11nPEz3dtoYPh+kmE5AcbDfAELWoffjaTKHD49diIqZgTbAyo=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2330.namprd19.prod.outlook.com (2603:10b6:5:c4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 30 Sep
 2020 15:12:00 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 15:12:00 +0000
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
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpSAAAiigIAAGG+wgABpVeCAARoOgIAAG6ag
Date:   Wed, 30 Sep 2020 15:12:00 +0000
Message-ID: <DM6PR19MB2636919AD0E9FD06F05AC8A8FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <fce9f346-5c02-0997-216a-14ab6c8b336d@redhat.com>
In-Reply-To: <fce9f346-5c02-0997-216a-14ab6c8b336d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-30T15:11:57.2557440Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=9f9932d6-5414-44ea-befa-84d5a30454ff;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a793880a-f321-4b10-0ad6-08d865532e31
x-ms-traffictypediagnostic: DM6PR19MB2330:
x-microsoft-antispam-prvs: <DM6PR19MB2330A94BC829DE27C107E1C2FA330@DM6PR19MB2330.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hj6Xhq58IKGYp5K6YyiiZEfmHWgDB7XUhdT8AgzhW5eFOwEHdi9OYRmLtYM1wPOvshLUsnHLm5oI2S9d+lpMcB/QWZTnMQaAIxvBMQwT9oTLu/KR7mvF+BoKPnQAryYUtTGcXJ3rp8RFlXQVROb6h9FaO1iqPrV+6AkZycXdjXWMqBWPj1Z9TA5jqnk7fEvgZBg3CcrqgoCS6dfRLXZvVJGjdAoAguTKnOVEjyTAk19sl56hieG/BUkyaYfJl9Xmn2aRpdSc8KHv0qdHipv2YuXzgvZJgPFwZ38JdhbgE5AdA8g1eGMugEk2QYtZeglksj3EBEnpyunXF6cIYqvM72TSSj9mBZONM2UuMVNQjbEnk9sYIbLr6nQNKw9QpRtW/jVjVyMiD4D2Y1xJheTNaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(786003)(83380400001)(2906002)(26005)(52536014)(76116006)(66946007)(64756008)(66556008)(66476007)(186003)(66446008)(8676002)(4326008)(6506007)(7696005)(53546011)(9686003)(55016002)(8936002)(5660300002)(316002)(83080400001)(86362001)(54906003)(71200400001)(478600001)(110136005)(33656002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Aj/jSi4RRh4JK35EWxlfLrb687ZepkiCY3GILvA+FEeNUQCdPHeE01j40yWH0jehAq5snTxVncbSqpdXg4ZLUsYOu7pXGFulG5r+Az0iaKP8MhLsAQnoxABCqYZtL64UiXKnQvin5yKnLV1CTBRl4x1xoxkiyMgFGJUOmFJEni1rImmWj+aiuuDnekb7rLUwmJWozdE0MKLTEJ2hn28pN3dGC5zOsOGtiFkQ68yknbgJGY2beByN2wWIlRDSjcpGkFTwg7R+a48BALSWaUqylqfdc/YSQ9Z05/rFNTPrrq+AXtUBk1FzIpGPy6RLhQkknKQ2lUH0HhKuX4Vr5zbBSoOHklvI3uv5rHBi90wuPtXHE6OXbSEeaG3bqbwGayBL+vzQC9PggPe091Cf5ozIGFgzAIdd2bPTej4T9BBr7Ayl0mXOn62Xcs3E2IhSKoIj0pU9k8juE77SyMLkf4iilVLy/318w9euFaJW0QaZKyD3mrKOrHd9FfA76JeoGD3zRlOEqABIIa1i+0MWemDjvuirnimjgxfQ546xX89UC6lZIbYxpRAphZbyFyDyuMHJHshaNNOhMQviX02dXvXkn85t9AgJGdRC4xhWiU9rRF/ZTC3mErmTeXxHa93/AYAp3oFCfz4jCbOBrIgUOru7vw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a793880a-f321-4b10-0ad6-08d865532e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 15:12:00.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1hxUlwe5GOEMU77YXCkogn+Z1Yg8jf+j0SQpMSPASHsXkUIML2xTUJ4OGRItkc6eijHmTQNkNoPI+1VqbZHeU3Un3Hdop86dbUMm+mM4oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2330
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_08:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300123
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Wednesday, September 30, 2020 8:28
> To: Limonciello, Mario; Barnab=E1s P=F5cze; Andy Shevchenko
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Ta=
kashi
> Iwai
> Subject: Re: Keyboard regression by intel-vbtn
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi,
>=20
> On 9/29/20 10:47 PM, Limonciello, Mario wrote:
> >>
> >> I requested on the Ubuntu bug for someone to provide these.
> >>
> >
> > Joe Barnett was kind enough to share two ACPI dumps to compare.
> > Not affected:
> >
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/=
54153
> 18/+files/1.2.0.acpidump
> >
> > Affected:
> >
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/=
54154
> 05/+files/1.13.0.acpidump
>=20
> Thank you, I took a look at these (before completing my allow-list fix),
> but there is not really much which stands out. The only related thing whi=
ch
> stands out is that the 1.13.0 dsdt.dsl has this new bit:
>=20
>=20
>                              Case (0x08)
>                              {
>                                  Return (^^PCI0.LPCB.H_EC.VGBI.VGBS ())
>                              }
>=20
> Inside the _DSM of the HIDD / INT33D5 device.
>=20
>              Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Metho=
d
>              {
>                  If ((Arg0 =3D=3D ToUUID ("eeec56b3-4442-408f-a792-
> 4edd4d758054")))
>=20
>=20
> What is interesting here is that the PCI0.LPCB.H_EC.VGBI.VGBS object/meth=
od
> does not actually exist the correct path is:
>=20
> ^^PCI0.LPCB.ECDV.VGBI.VGBS
>=20
> So this does suggest that something around the VGBS handling changed
> (and since it points to a non existing ACPI object, possibly broke)
> in the newer BIOS version. But what exactly is going on on this XPS 2-in-=
1
> cannot really be derived from the acpidumps.
>=20
> Regards,
>=20
> Hans

Looking through some publicly found content I think I might have figured ou=
t what
bight be the missing link.

https://software.intel.com/sites/default/files/detecting-slate-clamshell-mo=
de-and-screen-orientation-in-convertible-pc-1.pdf

You can see that the device with CID PNP0C60 is supposed to indicate the pr=
esence
of a convertible hinge.  We don't currently have anything that matches that=
 _CID or _HID
in intel-vbtn.

In the DSDT dump you can see that the status method for the INT33D3 device =
returns
0x0F on 2-in-1.s

        Device (CIND)
        {
            Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardw=
are ID
            Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Co=
mpatible ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If ((OSYS >=3D 0x07DC))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }
        }

On a non 2-in-1 device I don't see this present.  So I think we should have=
 intel-vbtn
look for that INT33D3/PNP0C60 device to decide whether to offer the switch.

Similarly as mentioned in that document I think that we should not be showi=
ng the
docking switch only when INT33D4/PNP0C70 is present and returns 0xF.
