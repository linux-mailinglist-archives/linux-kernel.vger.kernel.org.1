Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5432B0872
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgKLPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:31:33 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:12382 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:31:31 -0500
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFRE64027195;
        Thu, 12 Nov 2020 10:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=pRGHhk0cQelf7wzojXBQaw3vbI+2rbzL8zc4mVyIG84=;
 b=bLybgNaz0Uk55/Y4QHIYU/Pwu8AzIexPJPPs2fvcktt0eZaHiQ9rK+8XwPWmfyf0Q8IC
 F9DEn4rAyDxDF9f5UUwew/13qWGtX6IH0kB5X2rJcDOivgTdGhVdKvNqSAtY9YEMCX8u
 1JeW6IQITD5a5qYt7TXpWzkqlPq062ZoZHfIDUHGA6bbZL1K5PwJNZXPibKqiJTlFPRl
 wY11UcqplqL9mmqLFTRpZJrIgr/H/Hq9g3o5zFfwke+im+X29hdYjqHqRu+78k+iHpCi
 2s/3D9aHs9vhCQdZDzgxDsXZ+LBOA2Nkaap9FH3Sap1+37vXrsC+LBSup9DAURXOwozj Zw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 34s0td9jcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:31:20 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFEjcf150994;
        Thu, 12 Nov 2020 10:31:19 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00154901.pphosted.com with ESMTP id 34s06gqhe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 10:31:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH3iNU0gbFUBt2s7cz666saNfkwpPaQVJMDeYWtICRdD/q5+/PoWnhJoOkfoPdvlCBor7Mw9d1tDIu5VGhmnpbekimoM7N48H4BFjoKQledSm8G+E4UjaAt1mCdsesHWVsWrCSedPG2LPHkTfgwK0XaJMVFmyW1xKXYD8NpcvrCdeVr6zJLkQjbc2YwMmv+6xNyJ3yKghwbewx7eGDxPuZrK2DU53nGvOqMPz7M4Ru+tAyZ4qA1DZL9mQAOLA0rWnLve2ZU61KoDfg53zkCCnK3t+8YIZ7e3wN3kXkBnqlX4kDiVhn95rB93CsMqtF/AY4pARayrftMJjL1R+5M+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRGHhk0cQelf7wzojXBQaw3vbI+2rbzL8zc4mVyIG84=;
 b=RWsYJt/eb1jIZQUXpA1aUEqoE7NWdFfIZPLULc8zOYPBhb4LGF213YWwLfB9lzEawH/Y7wlvrnnR5azyqBoT9gHkdQZtiaWJ7bjrH97fn2YBrRUQ8NCMmncoKdv5weZMlL1/Ljddbfcn/B2z/0QS3Ix795i78JJPckQtbrra3LWl7MoBDOQFzMHQUz4cD7sUTZbkFe37rZYb4wluP5jEeqY+WzpnYwKfEVnXnOYYg+g8vH/lzXJ5Vn1pZRuSX2Gtmstk6y7u/NUycACEl/K6ZxnBpV4mFI7nHjJaGE+6/CZDfCptH+hDb5f/+gwefUXznOQ/s38Mueq6tsIclbgf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRGHhk0cQelf7wzojXBQaw3vbI+2rbzL8zc4mVyIG84=;
 b=ZCpE+5fbI/TaIZvyV3G7Qwkf3Hw5MRnBAZ9MJJfnZH06YsPJ8VTd2J7qyaI82k8/Sp5Z2cYLwkJD7Ybf0It5LZ/lmu53d1RmjeIhNovdANZyAeWdWKyzubaqmmSvAh0/zeGWNmtzrMLTRrYl/9+4mPsff/te9QEO2k/MZ/b6pWM=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2569.namprd19.prod.outlook.com (2603:10b6:5:18c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 15:31:18 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 15:31:18 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Topic: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Index: AQHWuQVotUSjecTwXUm8CCIPHIWS6qnEmNyQ
Date:   Thu, 12 Nov 2020 15:31:18 +0000
Message-ID: <DM6PR19MB2636D792A7CCEE8937579EA6FAE70@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
 <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
 <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
 <e8e06aca-c3f1-d833-c766-01f05dfa0f37@metux.net>
In-Reply-To: <e8e06aca-c3f1-d833-c766-01f05dfa0f37@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-12T15:30:15.5568295Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e33d0795-092d-48eb-9332-3652d8a160ae;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: metux.net; dkim=none (message not signed)
 header.d=none;metux.net; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0789fe1-30dd-4094-4fb9-08d8871ffffa
x-ms-traffictypediagnostic: DM6PR19MB2569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB2569860F38E6E50A35D116FCFAE70@DM6PR19MB2569.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ttXVtnXSaSNIynt7yBjEcRl6FqlLhwpDa+jVt2zYpaQLUuUxpvUqa45E5IJdmHEcoT20B3RGdMj7F0aO7b/qNsv3vWdxGsrf7bB1z0J3tVNx2/kUkpHIW9QXdjgsAiLXxD4txW2X6nx4sq9W7pwVPW/E/REwdnUnubnB8Ks3zUfT3l/ZNAoYX3M9A/DA0kxUy/WepFuyokTQETQsZe3BM8aHPljnlIGATuXYM4SdWRiJqOtYe0ywRC+t+LvWYe1sls0iDsEbWksaY6ULMRZiAjUs61GJxWvbL2uWvr+GGt5e92MKMGSjt4l9m1EHoWePD6birHoxMXS+SQYNDaiEl/6smYu1bQj+4+IrCBgMVJ+vBGDyc3RK/hV2aMMSWdH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(110136005)(786003)(316002)(86362001)(54906003)(7696005)(6636002)(5660300002)(66946007)(66446008)(64756008)(66556008)(4326008)(9686003)(66476007)(33656002)(76116006)(52536014)(478600001)(83380400001)(2906002)(66574015)(6506007)(71200400001)(186003)(55016002)(8676002)(8936002)(26005)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M7BV8eVsJNkkp3MZUNfomtwqBCXWam320KhnMDlS4VrUo/09NIIxq1fuG+X4o/YpKs3kuNU/l8MFCC5RdodlSf73rKVC498yXFVxYizSumW8Nal3J2tADHlYbof96O6d2RaqlffXIwpP66mWklgXJSGQ4UjjZNsCJvpkSyQgNIFdxRhsoubryWK/SDkNomFPwa/cvSrnOwGffPo4L2kTdpeAspi0sCF+kHIgb6VE7GBLqkrwjuM/ytNWZh3DwISGmq15tfiLVQ2nvvHhzOU0l9yJBW99y7WSE8YdgGH9aOoykfKNweUlpiZDK9wf5lKz7XyFHIeOsxsJIKR6rgFSQrn1crzSd4TPrqfC6Ej31HU+oembr9Ts7UCYJJr0/lytBwwmoRn1unkt1vV05LmHZu80IDarlRR/cFSKGZ1+yCZaDcLr8ah3o++jWK2RKHpODJldKx3Hw4zHIn38Q0mhiSUwaEDlM5FEFtQd8/k7pokoQGDoK44EnqqUgVk/3xr3ozhQQeJTQ0CPUFJzeg8AHnPzjkI7sux23+W1seup8IPBXw6xV3Ur5he4/8ngPdtMDHkhnhOiQ/gY/sDAAXkFJYDul+bPJMyNQSgDyvWtVLmM2bI9hEpq5ht/vvvudLN1oW/QO59UqLw6ODp7rJ7W/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0789fe1-30dd-4094-4fb9-08d8871ffffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 15:31:18.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjPqFUyZFv2eBxjGfhFAHQBuX6wl6nc3TaLSrbfHTaUDq5wA45mVMnZBSmlZEYCllDszDM/S+8pEtLmiJF05n3NJEZ4ThRebeb/cqd3YNMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2569
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120092
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFByZXNzaW5nIHRoZSBtdXRlIGtleSBhY3RpdmF0ZXMgYSB0aW1lIGRlbGF5ZWQgY2lyY3Vp
dCB0byBwaHlzaWNhbGx5IGN1dA0KPiA+IG9mZiB0aGUgbXV0ZS4gIFRoZSBMRUQgaXMgaW4gdGhl
IHNhbWUgY2lyY3VpdCwgc28gaXQgcmVmbGVjdHMgdGhlIHRydWUNCj4gPiBzdGF0ZSBvZiB0aGUg
SFcgbXV0ZS4gIFRoZSByZWFzb24gZm9yIHRoZSBFQyAiYWNrIiBpcyBzbyB0aGF0IHNvZnR3YXJl
DQo+ID4gY2FuIGZpcnN0IGludm9rZSBhIFNXIG11dGUgYmVmb3JlIHRoZSBIVyBjaXJjdWl0IGlz
IGN1dCBvZmYuICBXaXRob3V0IFNXDQo+ID4gY3V0dGluZyB0aGlzIG9mZiBmaXJzdCBkb2VzIG5v
dCBhZmZlY3QgdGhlIHRpbWUgZGVsYXllZCBtdXRpbmcgb3Igc3RhdHVzDQo+ID4gb2YgdGhlIExF
RCBidXQgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSBvZiBhICJwb3BwaW5nIiBub2lzZSBsZWFkaW5n
IHRvIGENCj4gPiBwb29yIHVzZXIgZXhwZXJpZW5jZS4NCj4gDQo+IGhvdyBsb25nIGlzIHRoYXQg
dGltZW91dCA/DQoNClRoZSBleGFjdCBkdXJhdGlvbiBpcyBjb250cm9sbGVkIGJ5IGNvbXBvbmVu
dCBzZWxlY3Rpb24gaW4gdGhlIGNpcmN1aXQuDQpMaW51eCBpcyB0eXBpY2FsbHkgYWJsZSB0byBy
ZXNwb25kIGZhc3RlciB0aGFuIFdpbmRvd3MgaW4gdGhpcyBjYXNlLg0KDQo+IA0KPiA+IEV4cG9z
aW5nIGFzIGFuIExFRCBkZXZpY2UgYWxsb3dzIHRoZSBjb2RlYyBkcml2ZXJzIG5vdGlmaWNhdGlv
biBwYXRoIHRvDQo+ID4gRUMgQUNLIHRvIHdvcmsuDQo+IA0KPiBXaGljaCBkcml2ZXIgZXhhY3Rs
eSA/IFdobydzIGdvbm5hIGFjY2VzcyB0aGlzIExFRCA/DQoNClRoZSBmbG93IGlzIGxpa2UgdGhp
czoNCg0KMSkgVXNlciBwcmVzc2VzIGtleS4gIEhXIGRvZXMgc3R1ZmYgd2l0aCB0aGlzIGtleSAo
dGltZW91dCBpcyBzdGFydGVkKQ0KMikgRXZlbnQgaXMgZW1pdHRlZCBmcm9tIEZXDQozKSBFdmVu
dCByZWNlaXZlZCBieSBkZWxsLXByaXZhY3kNCjQpIEtFWV9NSUNNVVRFIGVtaXR0ZWQgZnJvbSBk
ZWxsLXByaXZhY3kNCjUpIFVzZXJsYW5kIHBpY2tzIHVwIGtleSBhbmQgbW9kaWZpZXMga2NvbnRy
b2wgZm9yIFNXIG11dGUNCjYpIENvZGVjIGtlcm5lbCBkcml2ZXIgY2F0Y2hlcyBhbmQgY2FsbHMg
bGVkdHJpZ19hdWRpb19zZXQsIGxpa2UgdGhpczoNCg0KbGVkdHJpZ19hdWRpb19zZXQoTEVEX0FV
RElPX01JQ01VVEUsIHJ0NzE1LT5taWNtdXRlX2xlZCA/IExFRF9PTiA6IExFRF9PRkYpOw0KDQo3
KSBJZiAiTEVEIiBpcyBzZXQgdG8gb24gZGVsbC1wcml2YWN5IG5vdGlmaWVzIGVjLCBhbmQgdGlt
ZW91dCBpcyBjYW5jZWxsZWQsDQpIVyBtaWMgbXV0ZSBhY3RpdmF0ZWQuDQoNCkFnYWluLCBpZiBh
bnl0aGluZyBpbiB0aGlzIGZsb3cgZG9lc24ndCBoYXBwZW4gSFcgbWljIG11dGUgaXMgc3RpbGwg
YWN0aXZhdGVkLA0KanVzdCB3aWxsIHRha2UgbG9uZ2VyIChmb3IgZHVyYXRpb24gb2YgdGltZW91
dCkgYW5kIGhhdmUgcG9wcGluZyBub2lzZS4NCg0KPiANCj4gDQo+IC0tbXR4DQo+IA0KPiAtLQ0K
PiAtLS0NCj4gSGlud2VpczogdW52ZXJzY2hsw7xzc2VsdGUgRS1NYWlscyBrw7ZubmVuIGxlaWNo
dCBhYmdlaMO2cnQgdW5kIG1hbmlwdWxpZXJ0DQo+IHdlcmRlbiAhIEbDvHIgZWluZSB2ZXJ0cmF1
bGljaGUgS29tbXVuaWthdGlvbiBzZW5kZW4gU2llIGJpdHRlIGlocmVuDQo+IEdQRy9QR1AtU2No
bMO8c3NlbCB6dS4NCj4gLS0tDQo+IEVucmljbyBXZWlnZWx0LCBtZXR1eCBJVCBjb25zdWx0DQo+
IEZyZWUgc29mdHdhcmUgYW5kIExpbnV4IGVtYmVkZGVkIGVuZ2luZWVyaW5nDQo+IGluZm9AbWV0
dXgubmV0IC0tICs0OS0xNTEtMjc1NjUyODcNCg==
