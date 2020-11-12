Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E302B0921
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKLP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:58:12 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:12386 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728327AbgKLP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:58:08 -0500
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFWFPK018931;
        Thu, 12 Nov 2020 10:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=UaaE6y9XajS74w/O95Ys6NB/3STF93D2Muvvx1/F9aQ=;
 b=xO6ubptqMOQkOhrHPmqDmw3iVm7OZHufN3R3ypllOxI8vnznzN4gCFFVisiHrmZziALR
 xQBf6XxGeoiuXEo0FKtrcrKLEQZT5uCcLsKf+jn8xAm840aDkdSvC0EUno0c/k15iby0
 1SJCsqv5XFKW6cBQyORiydDqP6JFlZ0VBB4IjSDmrjYwMNZYQJxEyBm3Q3GVgbASFPKH
 ULshvufdVVi/r5+srLMaz2aLToXeWgQKZ/eBc2aKCH6FuBw3kTXMzlttDkgrN9Dq5u1y
 HRSOt1xZTRXgULtzr0xafqadpFVXIdS/BZsiI/A1Ly3s8KLF1MCzGCNOFmlmdDFUjzxB Fw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 34rtwhjx6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:57:58 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFmB9X193753;
        Thu, 12 Nov 2020 10:57:57 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-00154901.pphosted.com with ESMTP id 34rarmk49c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 10:57:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j03wQrxDb1hGvM/g0bx+LInuSe59jVgr9svuhaa0n2TfHuD+/IgqVpuk3Wbxq608tLTmvV+OaeoTH73ev/Hj5/BljJM7n6R01Zo302yDQBgkWRIciHsLSHQ0APkcGhxLP8OCL07VhK2LzdgD5UCP+7S6CcWXr2zLu8YdUSZJPqjam8WBwylGWSyrxB38GQay/JRS2V+Tpir8XmWBdKX6Zfd7Vb0eCm5582YgNRDw9dKhkQ2KEPCrU8kw55/CsnzfoxaECyUM5Stmz246d+2pTymyR2LoT+Bq1fLGPz7DqyEE3h+Y63jkCl84uike7xctQEYN0uLFoVyREAn2S5zdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaaE6y9XajS74w/O95Ys6NB/3STF93D2Muvvx1/F9aQ=;
 b=ln029rFjg5afcO7oNxZKoCZL6XW13Vam1f14OtqzFOdABS4WwsghMWAb2hcNYHhPNI4CytiDorXYaUnYwjxlm69/1APjGEDDLmYIk44y6YmojdlKRpLyY2fFfZJAnfRXl1JBAq8S0ckeLgl2fTsQtIerzWLcm10gNx2+5uv2G2+pX8VTd0tsZSeySbdpS0BrLPEoWwy+FYBFKzKy90x7KQ3cZZPLGXW2ccsthDre3RH9fzcTUKRcxq3/tlDoUaz5LG+QZuR1fybp34+6MzhTnFGl/KvrL0RO7Bj8VlAho0aqP4XmjX+Dx/YIODoHaB1Nj9/Atg48s93+U01ag6OY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaaE6y9XajS74w/O95Ys6NB/3STF93D2Muvvx1/F9aQ=;
 b=hQxqBvJcOTTqWTzX/ML8JHyeipARvXDsUp5U3+vekr94jp44OiDOuICKQp0a+FmirO+FTJMQyFIYP42quBTRKMBlIH2XuXiVukM1iK7Z9q/6kjOfeV5l29yGM6OyxNupkVGKbVZJoBS73cC/GCutc5FDPCJhSUUmO13UuHmEmYA=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2443.namprd19.prod.outlook.com (2603:10b6:5:15e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Thu, 12 Nov
 2020 15:57:55 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 15:57:55 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Topic: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Index: AQHWuQVotUSjecTwXUm8CCIPHIWS6qnEmNyQgAANe4CAAAAxIA==
Date:   Thu, 12 Nov 2020 15:57:55 +0000
Message-ID: <DM6PR19MB2636C714D1EE520F98617018FAE70@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
 <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
 <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
 <e8e06aca-c3f1-d833-c766-01f05dfa0f37@metux.net>
 <DM6PR19MB2636D792A7CCEE8937579EA6FAE70@DM6PR19MB2636.namprd19.prod.outlook.com>
 <544bc53f-c260-9e46-15a9-2ec2ea41343c@redhat.com>
In-Reply-To: <544bc53f-c260-9e46-15a9-2ec2ea41343c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-12T15:57:52.9613471Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e5de38ac-daef-4948-b45e-1fdb5b9b18af;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e0afd3-a8e1-421d-3213-08d88723b855
x-ms-traffictypediagnostic: DM6PR19MB2443:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB2443EC041BE1F27040BAFDF2FAE70@DM6PR19MB2443.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2f2aYYkNCfaeBgNfHTR7358cUwUNieZEfvyjyIF2xyb5s+WTBRRRiq5UOGLQVd3h6JVK2Muf8X7TNrcjMCt4dIOg5HyjMCqq/kP4GLAJEeCmSXeUXZH6uCceYfS3sZNQkaGLecBfBzEo0HJ/wjetEZFqLnvwZCCXV2Rfh2KoJeA9VPi5lItGuxT17vx3PpQ3OT9HKxmUrKYfxPI1kBPuYyCMubGrqRyj3Jw+KNvCgZftiHiITLBTJnIV2VdHnPnwpALF9Z++d8AF6XNK0S7fIAmj2OeM67QrPdj45/w6SGFSUJjwROSQ7uYYJM2OUvRUnFzADHznev/S0myR5EFzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(5660300002)(66476007)(4744005)(55016002)(478600001)(26005)(64756008)(2906002)(66946007)(8936002)(9686003)(54906003)(316002)(83380400001)(4326008)(110136005)(86362001)(7696005)(186003)(76116006)(786003)(66556008)(8676002)(6636002)(71200400001)(52536014)(6506007)(66446008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c7UdBoVJXsh6boVBz0doQ2uI/TuybqQjEVVnltPkLKr57GsFctKV5+RyTMspSYhvt6BCGM2js6EbaMQVElgrFaSEK353vieQK1d6MABlJy8udR2eKSgBidW32nFsiGL+yBNeW6Df+exnX27I5utW3s69Yiy336/b0pz3tJp6x0E6sWX7yyJrENgDAQQeSCg9u0k6Sm4x8MgQ6eBmX9H/ViV3U2u3DWfRGfOBTO3vRZfLbKxSTqWOrY4VNembpMZ7z5rwI6ExvRM+74U4CZI7OlPVDWVWQDly/sbiVvg7fqa44DK1/P2fdXd4AnKNTkojGLYzQYqEE2a62sWXbqA68JbbMz04se5TkbroMQDflYaf6z/L2gLmx3z/waHcG69IYoBTbH2vUKnXHh5cA0ycBeQwmMBASTS4XG8hhMcETOiQN1cWNEWN7vFCubnQwBhZwV5kdCX2YQqCafMVCN1zc62jAt4ek8NMNvr0Jk1AqNKmauP0LQKwe02LktHuIoyMtP4L5bLRYAIgVHX3lILWeUfHa3RwyhNgvNKgpOB1NDPLNCzG7JDf4IVrkln4tD8HnuvFrrXTyDL/CLHQr5nMXuv7hmzL8Fxm4E+QUn+PtU7MPCJFgHI4E1lyKggWpsV/4i6CCrDBbZvjDxwtPbGvSg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e0afd3-a8e1-421d-3213-08d88723b855
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 15:57:55.8291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp53PaSiD66cHmAWxnrh9FNGufVFf1MgtIvRGPet0IjN7SlEYsYzIoqR4ghL9HxvHcwhJ5xn0xok4R08ncaMh3W80fxd+sVIvRJrVgAiWIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2443
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011120093
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gQWdhaW4sIGlmIGFueXRoaW5nIGluIHRoaXMgZmxvdyBkb2Vzbid0IGhhcHBlbiBI
VyBtaWMgbXV0ZSBpcyBzdGlsbA0KPiBhY3RpdmF0ZWQsDQo+ID4ganVzdCB3aWxsIHRha2UgbG9u
Z2VyIChmb3IgZHVyYXRpb24gb2YgdGltZW91dCkgYW5kIGhhdmUgcG9wcGluZyBub2lzZS4NCj4g
DQo+IFRoYW5rIHlvdSwgY2FuIHdlIHB1dCB0aGlzIGluIGEgY29tbWVudCBpbiB0aGUgZHJpdmVy
IHBsZWFzZSA/DQoNClllcywgSSBhZ3JlZS4gIEkgc3VnZ2VzdGVkIHRvIFBlcnJ5IHRoYXQgaGlz
IG5leHQgc3VibWlzc2lvbiBvZiB0aGlzIGRyaXZlcg0KbmVlZHMgYSBsb3QgbW9yZSBjb250ZXh0
IGluIGNvbW1pdCBtZXNzYWdlIChhbmQgaXQgc291bmRzIGxpa2UgcHJvYmFibHkNCmNvZGUgY29t
bWVudHMgdG9vKS4NCg0KPiANCj4gSSBndWVzcyB0aGlzIGFsc28gbWVhbnMgdGhhdCB0aGUgbGVk
X2NsYXNzIGRldmljZSBpcyBqdXN0IHRoZXJlIHRvDQo+IGNhdGNoIHRoZSBsZWR0cmlnX2F1ZGlv
X3NldCgpIGNhbGwgc28gdGhhdCBkZWxsLWZpcm13YXJlIGNhbiB0ZWxsIHRoZQ0KPiBFQyB0aGF0
IHRoZSBzdy1tdXRlIGlzIGRvbmUgYW5kIHRoYXQgaXQgY2FuIG1vdmUgYWhlYWQgd2l0aCB0aGUg
aHctbXV0ZS4NCj4gDQo+IFdoaWxlIHRoZSByZWFsLCBwaHlzaWNhbCBMRUQgaXMgZnVsbHkgdW5k
ZXIgaGFyZHdhcmUgY29udHJvbCwgcmlnaHQgPw0KPiANCj4gVGhhdCBzaG91bGQgcHJvYmFibHkg
YWxzbyBiZSBpbiB0aGUgc2FtZSBjb21tZW50IGluIHRoZSBkcml2ZXINCj4gKGZlZWwgZnJlZSB0
byByZS11c2UgcGFydCBvZiBteSB3b3JkaW5nIGZvciB0aGF0IGlmIHRoYXQgaGVscHMpLg0KPiAN
Cj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg0KWWVzIC0gZXhhY3RseS4NCg==
