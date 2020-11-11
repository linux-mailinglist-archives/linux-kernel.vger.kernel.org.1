Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B313A2AF39B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgKKOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:32:10 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:47436 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgKKOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:32:10 -0500
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABEQWLl018040;
        Wed, 11 Nov 2020 09:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=2eCWKLaJI3s2XyI0dQvtV/I2KCYPMPdi9ltHLQLxf4A=;
 b=BW6uhpRvpPW+YnMFK9aNUu925kLuUJRKdJrxdR9vdY4UtM3bQeruA7p2sGhhUVnZ3OCl
 XR0HP1bzVXyvU7T5OfzohJiV8Et50FdPQFf0HUKmCaspvc57MtoUydbjYBYsubpqMpke
 igiSlMxarCUj8Q/3d2NWkiTXGiBj8H3DZ2WnlpkwMbded7aq5oRbYefCewbtIJVtzrvW
 KbXh86v7acHwj9AEzt/HYwhNOWK3LTByE1y2L+Ap8w0PCzVlOemPupti3926QtUeldWz
 vhQksS949p6YB72MsfcfhwF8Hv0U87a52X7QimRbGpd8Rb1LoutSk8z5b1DcMMMbyX/l OA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 34ns4scg1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 09:32:02 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABEVuqe151877;
        Wed, 11 Nov 2020 09:32:02 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0b-00154901.pphosted.com with ESMTP id 34r17n5n3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 09:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ00RWfmr74QJzeftBZ59n9wAxkaNhbMjnT3vzFFnYz++yzKJm44hU4Tb93KvqFWr+EX+qR++4U6o0a2OK0H4McefZhejUgjaxPSviXvt3EPgRVj2UylDa3EeoceBGNjoCGwmwfeIZ2XKLZZXfZLs51f4P1g3BA+ngOphZcA7RIeGDpDQFkPQqsW0jJUu5BRSIVLX2/Y5/hBguIPYfmtfheiRfpZwxYgEoVc30dKFoXBDer1Jgh9QnapLO1L5UXmXNQn68JZUACygLZog8xkCy9oVXFmaT6qpqf+L5GrvNxjF2A5waEXq5zLO16U8l13jJbf3EYnWSvvasdIJklXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eCWKLaJI3s2XyI0dQvtV/I2KCYPMPdi9ltHLQLxf4A=;
 b=oW4ran2wi1UHbphkkOUTqr0+DfF1MQOK7WBEVnYdtAYJfXNcGKa8SciyckQFMY1kjWnhXuRZO/YrLdst22olaVsUrMIvfrZ88T3pplcNkQqY8FN+/ER/P78C77mSiYM3mf4aH5/vb4bNPTZv/L7/BVpoJ5zHcsFXncbRCbpDtgHur+44pKUbxNdMtKshOa9nrrqqMeFLEXF0fYzW3h+BjWkxu26bB4l2TS+BnC8qmvODYRWo+d9ih4SFrKDstMYowZuQiaN2OU/coiwRkGFj0KP4ScbTmvFal0tzAC3+X/IakMZz+K6L0VABURXO829EhpXhpmknRFj9pF2mNDz4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eCWKLaJI3s2XyI0dQvtV/I2KCYPMPdi9ltHLQLxf4A=;
 b=fGuZzJuF5g546XV4tvb5e5FkmKjUOP+dWlafmPX+8xi37BjIIDR7uXlKCYUPGqXx/wfvjsLXVavbQNK07JP2qTMNUR09DcQqPi9K+avmhkrh3vrBcMEK7mwg8y+j/jrfICRJTFQsYD6r+LLrkdpIMQS85cJabLnXuTOOCG7fpLw=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2283.namprd19.prod.outlook.com (2603:10b6:5:c2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 11 Nov
 2020 14:30:21 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 14:30:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH]  platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Topic: [PATCH]  platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Index: AQHWseC7Gs1HiFSUAUeV6Fy4GsVUCqm3NaWAgAtdCoCAAAERAIAAc6BA
Date:   Wed, 11 Nov 2020 14:30:21 +0000
Message-ID: <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
 <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
In-Reply-To: <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-11T14:30:19.1089256Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=eb287113-8a80-40de-ab03-20577fed41c0;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: srcf.ucam.org; dkim=none (message not signed)
 header.d=none;srcf.ucam.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d04939d7-3616-4cc4-4342-08d8864e5238
x-ms-traffictypediagnostic: DM6PR19MB2283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB228360A0A51222A511ED4FD8FAE80@DM6PR19MB2283.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AG6AjZQF1mZrm2qD+RHhmdawKKM1X2hBycke5kJiV4TbX9uQ6URoCgRhVBssPKFUGy1Gk8GK2OWtU4stDkjCFDYVS7fX+ijZJJmjpe4OztOF/q7SoUE6y4Yw4x88+HG8Rr8gdtYVUWC/Z8Y/uNr3hVO2EI4vhX2zjzxAZIx9X6wJDn/SSECcGAosPaJ9fEu3rM5Z6FQBKXHmuecwm5CzuH13r3GG/nvkt57WIoSI8pyFBoDQeTerHOqnbykJLuu/4IS+M75dX0Gr2N+arGlTeFEExemTeDlZ9VqOCCFzclmgiczvONbuP/E5LMHOklUYeOxLj2HIPdMYDSmBfzzNjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(186003)(55016002)(478600001)(6506007)(8676002)(110136005)(52536014)(66446008)(4326008)(86362001)(7696005)(54906003)(26005)(316002)(786003)(33656002)(2906002)(8936002)(66556008)(6636002)(64756008)(66946007)(83380400001)(5660300002)(71200400001)(9686003)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 60LDHNWxVDxBddie/WpuapviUlfJywgjFUoBmylIvij4EbT9Zm08gGvYtYtaOAMWoeacuGSHknDOSb9koCd18iwkDugRcPc8FQ4Juu413XDFNtn4/w7wArO3R2VcWY21yxpIPmI1rtAa7N90JO4AQgqrfOrqg2DOel+ev3ysUhqxANUTN8r+ypCHQLxlRdGu2948u0MrKKhFSIVPa9/kZB/gsjOd3N/LxRfUPxG5WA9v3tK2HgZ//3DJY1x3dFIx+8VE7v1ihGsnIIqKtDvtOs/eqxao46sBudFZ9nbtOQd3glygWbaUDbuzz25eFaL2zlDmHZs+1WQ1xVcQybenDuge++UBxtHeAxMN9UfsP8Mywld62iX+fOW9YBlc77QzIwkreqP9khQdbN8nMfKM6gdSt0jKYympQSQlluMgIiTvWzg9V0uFKET3WqBu5X1BR8Hca8yuD6UXgfjQmS+f6ncLspEc0ggSgY/hL8hq0tUuwDM5aOfYWcS8kFAueW/meoTQhxod2Ki4mFVizJURwk7gu2Kpm6EA+ooQa3oKxehfZRs3ZpYS5qEMb1yHDzhEuqCAijo5wt1O/Z8tA1N2QFKuJmn6HECum++UlarVzwdcSCakbbvACGeUplJPIx/Hyqo2TRSK7YyRpFfL5smyBg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04939d7-3616-4cc4-4342-08d8864e5238
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 14:30:21.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gTcM//hMu26ip3cmov15TWsug6lZU6xO/+sLsqJyny4oBHtcfzYuE09zA+J6uxkzR/NyHpwhO+Y2dJDv2WPtwSdt25y+OzUtpU/kXn01iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2283
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_07:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=851
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110087
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=964 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Wed, Nov 11, 2020 at 07:21:07AM +0000, Yuan, Perry wrote:
> > > > +    status =3D acpi_evaluate_object(NULL, ACPI_PRIVACY_EC_ACK, NUL=
L,
> > > NULL);
> > > > +    if (ACPI_FAILURE(status)) {
> > > > +        dev_err(led_cdev->dev, "Error setting privacy audio EC ack
> > > value: %d\n",status);
> > > > +        return -EIO;
> > > > +    }
> > > > +    return 0;
> > > > +}
> > >
> > > What's actually being set here? You don't seem to be passing any
> arguments.
> >
> > Yes,  it is a EC ack notification without any arguments needed.
>=20
> I'm confused why it's being exposed as an LED device in that case -
> there's an expectation that this is something that actually controls a
> real LED, which means responding to state. Are you able to share the
> acpidump of a machine with this device?
>=20
> --

Matthew,

Pressing the mute key activates a time delayed circuit to physically cut
off the mute.  The LED is in the same circuit, so it reflects the true
state of the HW mute.  The reason for the EC "ack" is so that software
can first invoke a SW mute before the HW circuit is cut off.  Without SW
cutting this off first does not affect the time delayed muting or status
of the LED but there is a possibility of a "popping" noise leading to a
poor user experience.

If the EC receives the SW ack, the circuit will be activated before the
delay completed.

Exposing as an LED device allows the codec drivers notification path to
EC ACK to work.  Later follow up work is already envisioned that if HW
mute is already enacted but SW mute is modified (IE LED notifier goes
through) that a message can come back out to userspace to tell the user
something along the lines of

"Your laptop mic is muted, press fn+f4 to unmute".=20

I don't believe that will be part of the first commits to land, but that's
why an LED is used, to know the state of SW.

Perry,

Some suggestions for v2:
* You should better explain this hardware design in the commit
message.
* I think the codec changes should be in same patch series as 1/2 and this
be 2/2 rather than them going separately.  It won't make sense for one of t=
hem
to go in without the other.  For example if codec change goes in and dell-l=
aptop
driver tries to change legacy LED it won't do anything.  And if this goes i=
n
but codec driver doesn't, nothing will ever send EC ack.
