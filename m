Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5227601A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:40:06 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:55616 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgIWSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:40:06 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NIVGR9020114;
        Wed, 23 Sep 2020 14:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GjWH+ItUfTtqFnLBaW8b69NrxmZpXF9J7ZDYT8zm40I=;
 b=IfupWaXUVIjvJ2y7LNQ/ZoxgtnKVXmbA4n03ZfNfZYeseexuPyPrRVSmfk/H2+3dbjI+
 ixKfj2yZBW/VbEudGWwSE+pgycw1PdkhP6+lUw0BavavCg/KsvXDErmhcPRSUJjx+8ze
 LKdqjRz4/94z+lzZNZwB6tt5gg98J/EE7E/BIgmv4IJN/K+G4ruQclI0HlI1VAvAu0/J
 A8BL9szJLbt7c0Um/r7bm2YxP0Ll65KrUUDwrh8xsAJQGwTXXLdBtx9fK061/aSZxUsY
 lH0DuZa5Od7ubRQpbhXflcyrb7TY3hb6TkJ0psWds2q6R/bGS1GO0YdPpzUaBwtwCzQy 7A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33ncj5psv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 14:39:56 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NIRYri183371;
        Wed, 23 Sep 2020 14:39:55 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-00154901.pphosted.com with ESMTP id 33ramp1573-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 14:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT4tTLldY4N1owzKbB7Ufj2gBWlJBZbRu1zTYXGwB27+yg5lSYMJDMnNvPGIKXuyemnVJSwc8dm6/01XmNQ8Bp7OUKNE9XsJX9MrQhOvL98S/n/CPrL92F9ZEtB0OGDkI0WbL8dfwSnzalcoSJyPSNJ6xnKOBYQUopAY6vJ8DAskve0/bP21g9QfUZeMOuf/B/N1PJEruVbknx5M3uonk5CTIgAxrkNSIA1daawQ2WmIu+b8G/Wch42asRSCesjTpr6Qzgs0UUQcNTEj2y/iJM9qo5ve8eIKUBDN4UZ1fimPYYhLv64Kuhy0ksn1wr0Rn5iHT9oIeloktxK9U7VeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjWH+ItUfTtqFnLBaW8b69NrxmZpXF9J7ZDYT8zm40I=;
 b=A5q5xbN02LGX79LFu2vjj1us4L16n/VDYMuFTOcDHiohp+9UkCM4JZV0KVPRfUqgplawuVOjN/rKo5PJxD2AFqWvF7Me0Ip/osaXWWCrFlzDmQXyq1MvLR/744VtML96s7FKeyK/BvMlwrOcrJ8TLYCjGxUNObs0pAvrxbW5LalRi0ACRLZyHI6RmdjkGRu2uSPqQttgf7t01cAd2NXInj5E9pnswDxKXthK8ukcE6IQcPWG/xV1c4LmQ5vGnSE5rdJL5uClaT/AdazLF3040+wAB8rqRW1A+mHZI0FxHK+ET3YXiD3a2RVDRrMPGK1MmaSbCOQtSD8iynzUvJ6ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjWH+ItUfTtqFnLBaW8b69NrxmZpXF9J7ZDYT8zm40I=;
 b=KouUrvbs5X4TnwBeNNY7yzuEG04BrKFIm9D10msv1b85LfSdC2Zs9T5kypZCsj8A3ArBFpX5mXgV5ADWVZJxFC5HDDQfknDFW335qh/uvt2vgWHXOAYzwnK7PWdyOGHKeJ6YrU64uCauyaAhiHSTLbd6im9tM78BT2pt/xh0rD4=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3804.namprd19.prod.outlook.com (2603:10b6:5:22a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 18:39:53 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 18:39:53 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v4] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v4] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWkZ0PK+VpsB9MMUuqIU/IRJ73Bal2dfAAgAAYZJA=
Date:   Wed, 23 Sep 2020 18:39:53 +0000
Message-ID: <DM6PR19MB2636C149F84D46718774E7D2FA380@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200923113015.110980-1-divya.bharathi@dell.com>
 <9b015765-de6f-3b2a-8804-e23864eb8806@infradead.org>
In-Reply-To: <9b015765-de6f-3b2a-8804-e23864eb8806@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-23T18:39:50.5989609Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=7e4bd28a-b37d-44bf-831a-6da33bd784ef;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab895e7-b52b-45e0-ee4f-08d85ff00fdd
x-ms-traffictypediagnostic: DM6PR19MB3804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB380465AC742B93B48998C2C0FA380@DM6PR19MB3804.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGI81EVjAs0/ob4I6KGWjE84H44lST9WmXqY1P0k+SQoLxAMBtBmczyIfBQkyFfJOraBnUHAQ7TQexPmjEFJO6emtGvD5Ot0Sylblbee6xAPd6njfbXFwVx8UiIQlJE99gY3BM/MDTLmTAajGRyBK6KNZIDI8PLe9tWrkOY2Kv0RPRe8yfPCILhRUvOQIqSeyTp6K70waUkd82+P+6QDxN7GwK1SZtyF/1404Z+Xg/p216/rD7ws/7JPoSO5oqwcLiz9rEn92wx5F8nMt+NKclcBCVYiTCutHgibKsYH361OcX4J2/VHVcAw+E2UYUbimoCr+mL9ZirlRy1CHm6RM2HfMK7GV7N7XrMwh8MhjSaypKvRk3TipOfLjw1gJHuP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(76116006)(5660300002)(53546011)(9686003)(8936002)(86362001)(7696005)(26005)(110136005)(498600001)(55016002)(83380400001)(54906003)(33656002)(8676002)(6506007)(66476007)(66556008)(107886003)(66446008)(52536014)(186003)(64756008)(4326008)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tDkznV/bPOe5h4eYntfS4YW9xHVw5+pf/+4kF1WLnhHSOSv2ur+oihwemlfr1ZBXQPNx9oQQInKW9LbyfSD9invh9t14s8Yw2PLWX6nmi4Mw6C0p9tRGeFaao5FC1WApM8UwlmlWobqYD12Cb26QKiPn1j/JBQupp5gTgzSZRX87/zEl5kwv4VsfKy+BpRJioerGMV3OalksB67OOXaSNVfNsllFqMtQIsK58+BUhu79LZtwT1+GYF9pSz2TeiwqS6xYRKrISLdNnjRu8ufTm5uLcOLhLjyIixx1gr6Zc0O/54LxH1bxhR/9VrLiN7wy/x+S9HayUqMFyE9Rqbb8BWWCFczTM6k7PPaAP38b1YCDKTwVIbw6Z8VKaVgdJRdcVOH/HzsoGD8a4m4hCr8onjQujCmvkmIB5ohozcPw44YSOKJXtkDISVMVryUng0+fXbrmngeqby9h819wOi9K/TRuxNGv671cFzO/M+Gulods6o+HSVbySQI9pjtzRfpF7SBvErTocJnvXN0pJ2NweBvQ9oxPd2RGtbLDUt6xGAL6EDQ+Rry5nvelP+3e7yiuuR98nb3tcRKN0BFGdtNodks2qFiYQuegwvNKp4Rj4CHHmpTF0UUlb4sGxOMf6HBGjItVQGrMNzagYKycO3+aKg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab895e7-b52b-45e0-ee4f-08d85ff00fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 18:39:53.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YZ05vLx1bumAGz61m5SnjZhTm3Cr+XmKUGbA9yW3G4R6tnxR4RGo1q0v16bOiJP1iaeqLff6ddAAwGEsW71Ew2vxcx7tWb/0PzV7y0kxlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3804
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_13:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjAg
MTI6MTINCj4gVG86IERpdnlhIEJoYXJhdGhpOyBkdmhhcnRAaW5mcmFkZWFkLm9yZw0KPiBDYzog
TEtNTDsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IEJoYXJhdGhpLCBEaXZ5
YTsgSGFucyBkZSBHb2VkZTsNCj4gQW5keSBTaGV2Y2hlbmtvOyBtYXJrIGdyb3NzOyBMaW1vbmNp
ZWxsbywgTWFyaW87IEtzciwgUHJhc2FudGgNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gSW50
cm9kdWNlIHN1cHBvcnQgZm9yIFN5c3RlbXMgTWFuYWdlbWVudCBEcml2ZXIgb3Zlcg0KPiBXTUkg
Zm9yIERlbGwgU3lzdGVtcw0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IEhpLA0K
PiANCj4gT24gOS8yMy8yMCA0OjMwIEFNLCBEaXZ5YSBCaGFyYXRoaSB3cm90ZToNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L0tjb25maWcNCj4gPiBpbmRleCA0MDIxOWJiYTY4MDEuLjRmZDdhM2YwYTkwNCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvS2NvbmZpZw0KPiA+IEBAIC00MzAsNiArNDMwLDE4IEBAIGNvbmZpZyBE
RUxMX1dNSQ0KPiA+ICAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9v
c2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwNCj4gPiAgCSAgYmUgY2FsbGVkIGRlbGwtd21pLg0K
PiA+DQo+ID4gK2NvbmZpZyBERUxMX1dNSV9TWVNNQU4NCj4gPiArCXRyaXN0YXRlICJEZWxsIFdN
SSBTeXN0ZW1zIG1hbmFnZW1lbnQgV01JIGRyaXZlciINCj4gDQo+IENvdWxkIHlvdSBkcm9wIG9u
ZSBvZiB0aG9zZSAiV01JIiBzdHJpbmdzIG9yIGFyZSBib3RoIG9mIHRoZW0gbmVlZGVkPw0KPiAN
Cg0KVGhhbmtzLCB0aGF0J3MgYSBnb29kIHN1Z2dlc3Rpb24uICBIb3cgYWJvdXQgaW5zdGVhZDoN
Cg0KIkRlbGwgV01JIGJhc2VkIFN5c3RlbXMgbWFuYWdlbWVudCBkcml2ZXIiDQo=
