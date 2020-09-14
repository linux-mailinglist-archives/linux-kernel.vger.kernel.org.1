Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7F26911E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgINQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:10:02 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:34710 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgINQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:06:30 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EG3XnU018069;
        Mon, 14 Sep 2020 12:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1REVS8cwHgWxenmvQ66OCPjiOUgo39+wriEs6vP7qOM=;
 b=aJf1EVTQqqIxa7gA3Rtq8Dbp4vXN8iHgZRJW7lXjSe0GDJUWZcyKfRen70AHzr76WYci
 p0qBmFGx9eXLQD2Cu0MwYJWB2HmdgVikJ9G5eJ58BlAAO3odntHA9Hjs0Nr4g7GUodTZ
 w/Of/2suWZFc/4cr+f3sLAPmSlEhI5KPG5D+l/rIr7A8wJmTidou7tRHjr8IdCGHuLmn
 ukL4VkEE39LUnFPLghENV3bPfurq6vcUZrrcWfUmSI4qzPJWwYQ7A2bE8FWxqLdjQbge
 VSVm9vMvM7Hdq3cZ7vWHv/S1h/ynqzsCpyN5xR8ZdxF7an4B+4k52mERes4QYhCBnbaW 3w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33gsj8deq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 12:06:18 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EG5OSV134408;
        Mon, 14 Sep 2020 12:06:18 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00154901.pphosted.com with ESMTP id 33jbm707cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 12:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1vmz4G8ZiQL1u/HCPNhyLzQp3cZeXfCHbz8PiYUHN7wVEWSwxHWu7uxivLQXQm7oJGiv6EYTJ6AkUGdFJoKK9YQ5TZakt81CKVOTv5fuLM5s1p25j1VJ51TXHisvCXvj9H4aCLEY9844WF3duZI98pBQUPnvCcisHCiimC6Bt1wMEurhrCp5jxJwCrpq7ZZTC1Gc2R+hPn52hfA94DDmax0WVlWR43B04L+IOVxr/Ks0M/1V2lojEw9vCHyWhvMgBVyqt7Sg7VbNsYf2Wi+n1Jf+zFg2Ql92oVnNn2UX00dJ6LQ8BeWKLnXVX82s1xANiNPrUgJSuYs+fgMJq8H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1REVS8cwHgWxenmvQ66OCPjiOUgo39+wriEs6vP7qOM=;
 b=OUJ2cf0rPdddRmZ8XX5vFtb5wfiSK8AFvWUH8nSxPeUB37G0F3GGsIdNzJbDVYpKpXATMwZ7O4nRdAjLXxqH6jFh13w/iqL+6zXUw5Ne2IBl8ZSxMYuFxmkxUA4SUhJncMYs6JX3knS/n5Gb+7Da70ts+ZInKeAXYFc3DVTQhwZzsy+sU5TC/o86nSCnnoOeiqowSmocYg8hXAZTe6bfDp8qgZlmX/I2bywhINsna+mGGp+kDkk+zdHf9p8TgCoc3jY6b3t7Ndud1KHvunkgUO8vYpr/p5vrHDat5625pZVL+USBKgAqnkVjRZcP+gJRaLkUKTqFK6MR7xTWpoSd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1REVS8cwHgWxenmvQ66OCPjiOUgo39+wriEs6vP7qOM=;
 b=qhJ/kRQ73g2oQF88e2kBgQvd3fdIQz2JVuNnhs33McWypN2rSUqdwpUf4dJ80IZ9B1GAm3cYtWdMyFCiI/4N7RoqQX85Wd5mMahR66Gf5VO4zuhNOXxicGVA3y71ZdfsJYJ4GuaAF6yEqsf07+mNC67ire/9kIGb2LEdSWDMYak=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR1901MB2119.namprd19.prod.outlook.com (2603:10b6:4:aa::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 16:06:16 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 16:06:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Richard Hughes <rhughes@redhat.com>,
        Jared Dominguez <jaredz@redhat.com>
Subject: RE: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Topic: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalTvXYAgBRkaN2AAGzIkA==
Date:   Mon, 14 Sep 2020 16:06:15 +0000
Message-ID: <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
 <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
In-Reply-To: <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-14T15:56:58.8851608Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c91f0978-7c20-4237-81e2-3eef4bf7599e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690d762b-e8a6-4d61-c8ff-08d858c81c0f
x-ms-traffictypediagnostic: DM5PR1901MB2119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1901MB2119FC747026458DCED2DA32FA230@DM5PR1901MB2119.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOevPI0cv4d6nv+O04F29f0nYInz2ojawk4Mfzr6Z+wH7amPhH5B8a1K/ZUnylOxC3/qEBPbQm+xakMo1ZZGvpvzVtpiHhLafK+MD/5sIReG4Po9mOHpW53N03gpfDvx67N0hJxmalMOnlin+GCkhCMpy1li3Monfq95X0JGW8LT3h6/FY71dw59GKULahjDrTl8gEfp9QwhhFwH9gUnb3QoNMdI9Efi350K5lMM0xrg2JJdXAwOWeqwDJnt5xStJGsTYqSeoAZd8NzpmSvoTo8g14lE/fehZc9FH3FUyQ+O5nY4pdqE9B3MNfkI0VGBWuN8LK0k4vPojBDHuDBwh0JoPtn/IXsiyHabmPDeGsGOdR5R2NSYu+Lmu2Auhj4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(83380400001)(8676002)(33656002)(2906002)(86362001)(9686003)(55016002)(5660300002)(66946007)(76116006)(8936002)(52536014)(64756008)(66556008)(66476007)(478600001)(7696005)(66446008)(71200400001)(26005)(186003)(110136005)(54906003)(6506007)(4326008)(316002)(786003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bkgAOmDFzHbPDNMJWHWgrw6PdreLtJ73Hr41AYeuypB/v2lipnHzOhZCnreYCG6saKnrzlljC+iraS/2ngqutaggTzBFOgjIlsEuScvmt8yi8TV/UwuKH0OvWm/GVLCEWHrS8497nGptvczPSrTAK0qCaS0SJiVAVwJXTTi41UXrv7DAMA3x22vSSbNxXAlogjhZMtxLc57Eu9JPNGI34grrqaldcPNYnHecrlXkcPw5kEKG9TFVdk/3/rmtD6wyTlEELIRN9b7dkqPxTeK5aOFGfINVlh7C1Etids7HaXkhdD/cIB/J45gWQYnOFbblJiywmz/fdpxdP5TfPB3Ed2zIFla3J6aF9XsVfBhYnanfdDTcaBekqtvWUGiHpuLWPHpfWQeZwKaYF1bwpsRR1CtvIgORBwfoC7xhHDulhY3ZjC3FTS2/pDQ/nQvOPaIWDvD219QbePZtptDzONnV4e4lp5458YTns6R+DSeF/NZxC2VMezwu6qIKeQlhLA62mJawlmH0YmtjeAamh4OL72aUlhAgbCmyyCSwcCRSLecs5FGFlVfXVYVCl1ep+2ArpDoJqk1iLxJpATPcqebY0TMecN1xbbmEnZxvX1F2D+c7BPIs3B4NhfUY8TNhuVhk6ehdA/QzaEkYpt5oDk8+Ng==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690d762b-e8a6-4d61-c8ff-08d858c81c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 16:06:15.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0BGGMV/XNslUycqY65VxBPeF/VXr+4Kg5OvW0Aw7EnBWba+ABdlonj6igB5Mn4FOS5QMJGR2RgolpVY5QWiGvN/ljit5/0xSlH+8c8IjDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2119
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_06:2020-09-14,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140129
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTbyBteSB0aGlua2luZyBoZXJlIGlzIGFzIGZvbGxvd3M6DQo+IA0KPiAxLiBBRkFJSyBvdGhl
ciB2ZW5kb3JzIG1heSB3YW50IHRvIGRvIHNvbWV0aGluZyBzaW1pbGFyIGluIHRoZSBuZWFyIGZ1
dHVyZQ0KPiAyLiBUaGUgaW50ZXJmYWNlIHlvdSAoRGVsbCkgaGF2ZSBjb21lIHVwIHdpdGggbG9v
a3MgcHJldHR5IGdlbmVyaWMgLyBjb21wbGV0ZQ0KPiB0byBtZQ0KPiANCj4gPiBXb3VsZCB0aG9z
ZSBwb3NzaWJsZSBvcHRpb25zDQo+ID4gYmUgaGFyZGNvZGVkIGluIHRoZWlyIGtlcm5lbCBkcml2
ZXI/DQo+IA0KPiBNYXliZSwgc28gdGhlIGZpcm13YXJlIGltcGxlbWVudGF0aW9uIG9mIGFuIGVu
dW0gdHlwZSwgY2FuIHRha2UgMiBmb3JtczoNCj4gYSkgQW4gaW50ZWdlciBpbiB0aGUgcmFuZ2Ug
b2YgMC0jIHdoZXJlIDAtIyBpcyBsaWtlIHRoZSBpbnRlZ2VyIHZhbHVlIGJhY2tpbmcNCj4gYW4g
ZW51bSBpbiBDDQo+IGIpIFJlYWRpbmcgdGhlIGN1cnJlbnQgdmFsdWUgYXMgYSBzdHJpbmcgYW5k
IHdoZW4gd3JpdGluZyBvbmx5IGEgdmFsdWUgZnJvbSBhDQo+IGZpeGVkIGxpc3Qgb2Ygc3RyaW5n
cyBpcyB2YWxpZA0KPiANCj4gTm93IGluIGJvdGggY2FzZXMsIGVpdGhlciBub3Qga25vd2luZyB3
aGF0IHRoZSBudW1iZXJzIGFjdHVhbGx5IG1lYW4sIG9yIG5vdA0KPiBrbm93aW5nDQo+IHdoaWNo
IHZhbHVlcyBhcmUgdmFsaWQgZm9yIHdyaXRpbmcgd291bGQgbWFrZSB0aGUgaW50ZXJmYWNlIHBy
ZXR0eSBoYXJkIHRvDQo+IHVzZSwNCj4gY2xvc2UgdG8gdXNlbGVzcy4gU28geWVzIGluIHRoYXQg
Y2FzZSB0aGUgZHJpdmVyIG1heSBuZWVkIHRvIGhhcmRjb2RlIHRvDQo+IHZhbHVlcw0KPiAoYXNz
dW1pbmcgdGhhdCBzY2FsZXMgZm9yIHRoYXQgdmVuZG9yIGFuZCB0aGV5IGRvbid0IGhhdmUgYSBn
YXppbGxpb24NCj4gZGlmZmVyZW50DQo+IGVudW1zKS4NCj4gDQo+IEFsc28gbm90ZSB0aGF0IHN5
c2ZzIGF0dHJpYnV0ZXMgY2FuIGJlIG1hcmtlZCBhcyBvcHRpb25hbCwgc28gd2UgY291bGQgbWFy
aw0KPiB0aGluZ3MgbGlrZSBwb3NzaWJsZSBlbnVtLXZhbHVlcywgbWluL21heC9zY2FsYXJfaW5j
IGFzIG9wdGFsIHJpZ2h0IGZyb20gdGhlDQo+IHN0YXJ0Lg0KPiBXZSBjb3VsZCBmb3Igbm93IG1h
cmsgZXZlcnl0aGluZyBvcHRpb25hbCBleGNlcHQgZm9yIHR5cGUsIGN1cnJlbnRfdmFsdWUgYW5k
DQo+IGRpc3BsYXktbmFtZS4gVGhhdCBzaG91bGQgbWFrZSBpdCBlYXN5IGZvciBvdGhlciB2ZW5k
b3JzIGltcGxlbWVudGF0aW9ucyB0bw0KPiBhZGhlcmUgdG8gLyBpbXBsZW1lbnQgdGhlIEFQSS4N
Cj4gDQo+ID4gRGVsbCBzZXRzIHByZWNlZGVudCBoZXJlIGJ5IGhhdmluZyB0aGUgZmlyc3QgZHJp
dmVyLg0KPiANCj4gUmlnaHQgYW5kIG5vcm1hbGx5IEkgbWF5IGhhdmUgd2FudGVkIHRvIHdhaXQg
dW50aWwgYSBzZWNvbmQgdmVuZG9yIGltcGxlbWVudHMNCj4gYSBzaW1pbGFyIG1lY2hhbmlzbSB1
bmRlciBMaW51eCBzbyB0aGF0IHdlIGNhbiBmaW5kIGNvbW1vbiBncm91bmQgYmV0d2VlbiB0aGUN
Cj4gMiBpbXBsZW1lbnRhdGlvbnMgZm9yIHRoZSBnZW5lcmljIHVzZXJzcGFjZSBBUEkgZm9yIHRo
aXMuDQo+IA0KDQpJIHRoaW5rIGluIHRlcm1zIG9mIHRoZSBiYXNpYyBzeXNmcyBmaWxlcyBhbmQg
dGhlaXIgY29udGVudHMsIGEgZ2VuZXJpYyBBUEkgbWFrZXMNCmZpbmUgc2Vuc2UsIGJ1dCBJJ20g
aHVuZyBzcGVjaWZpY2FsbHkgdXAgb24gdGhlIGZsb3cgd2hlbiB0aGUgZmlybXdhcmUgaW50ZXJm
YWNlIGlzDQpsb2NrZWQgZG93bi4NCg0KPiBUaGUgcHJvYmxlbSB3aXRoIHRoYXQgYXBwcm9hY2gg
aXMgdGhhdCBiZWNhdXNlIHdlIGRvIG5vdCBicmVhayB1c2Vyc3BhY2UsDQo+IHdlIHRoZW4gZ2V0
IHRvIGNhcnJ5IHRoZSAidGVtcG9yYXJ5IiB2ZW5kb3Itc3BlY2lmaWMgaW1wbGVtZW50YXRpb24g
b2YgdGhlDQo+IHVzZXJzcGFjZSBBUEkgYXJvdW5kIGZvciBldmVyLCBzaW5jZSBpdCBtYXkgdmVy
eSB3ZWxsIGhhdmUgZXhpc3RpbmcgdXNlcnMNCj4gYmVmb3JlIHdlIHJlcGxhY2UgaXQgd2l0aCB0
aGUgZ2VuZXJpYyBBUEkuDQo+IA0KPiBUaGlzIHNjZW5hcmlvIHdvdWxkIG1lYW4gdGhhdCBhZnRl
ciBzb21lIHBvaW50IGluIHRpbWUgKHdoZW4gdGhlIGdlbmVyaWMgQVBJDQo+IGdldHMNCj4gYWRk
ZWQgdG8gdGhlIGtlcm5lbCkgRGVsbCBuZWVkcyB0byBzdXBwb3J0IDIgdXNlcnNwYWNlIEFQSXMg
dGhlIG9uZSB3aGljaCBpcw0KPiBiZWluZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2ggKyB0aGUg
Z2VuZXJpYyBvbmUgZ29pbmcgZm9yd2FyZC4NCj4gDQo+IFNpbmNlIHRvIG1lIHRoZSBjdXJyZW50
IEFQSS9BQkkgRGVsbCBpcyBwcm9wb3NpbmcgaXMgcHJldHR5IGdlbmVyaWMgSSdtDQo+IHRyeWlu
ZyB0byBhdm9pZCB0aGlzIGhhdmluZyAyIG1haW50YWluIDIgZGlmZmVyZW50IHVzZXJzcGFjZSBB
UElzIHByb2JsZW0NCj4gYnkgbWFraW5nIHRoaXMgdGhlIGdlbmVyaWMgQVBJIGZyb20gdGhlIGdl
dCBnby4NCg0KSSdtIHdvcnJpZWQgdGhhdCB3ZSBhY3R1YWxseSBlbmQgdXAgaW4gYSBzaXR1YXRp
b24gdGhhdCB0aGUgImdlbmVyaWMiIG9uZSBzdXBwb3J0cw0KdGhlc2UgYmFzaWMgZmVhdHVyZXMu
ICBUaGlzIGlzIHZlcnkgc2ltaWxhciB0byB0aGUgRGVsbCBvbmUsIGJ1dCBtaXNzZXMgY2VydGFp
bg0KZW5oYW5jZW1lbnRzIHRoYXQgYXJlIG5vdCBpbiB0aGUgZ2VuZXJpYyBvbmUgc28geW91IGhh
dmUgdG8gdXNlIHRoZSBEZWxsIG9uZSB0byBnZXQNCnRob3NlIGZlYXR1cmVzLiAgQW5kIHRoZW4g
aG93IGRvIHlvdSBrbm93IHdoaWNoIG9uZSB0byBzZWxlY3QgZnJvbSB0aGUga2VybmVsIGNvbmZp
Zz8NCg0KSXQgZ2V0cyBtZXNzeSBxdWlja2x5Lg0KIA0KPiANCj4gPiAyKSBEZWxsIGhhcyBzb21l
IGV4dGVuc2lvbnMgcGxhbm5lZCBmb3Igb3RoZXIgYXV0aGVudGljYXRpb24gbWVjaGFuaXNtcyB0
aGFuDQo+IHBhc3N3b3JkLg0KPiA+IFRoYXQgaXMgKmRlZmluaXRlbHkqIGdvaW5nIHRvIGJlIERl
bGwgc3BlY2lmaWMsIHNvIHNob3VsZCBpdCBiZSBkb25lIGluIHRoaXMNCj4gdmVuZG9yDQo+ID4g
YWdub3N0aWMgZGlyZWN0b3J5Pw0KPiANCj4gV2VsbCBlYWNoIHByb3BlcnR5Og0KPiANCj4gL3N5
cy9jbGFzcy9maXJtd2FyZS1wcm9wZXJ0aWVzL2RlbGwtYmlvcy88cHJvcGVydHktbmFtZT4NCj4g
DQo+IFdpbGwgaGF2ZSBhIHR5cGUgYXR0cmlidXRlOg0KPiANCj4gL3N5cy9jbGFzcy9maXJtd2Fy
ZS1wcm9wZXJ0aWVzL2RlbGwtYmlvcy88cHJvcGVydHktbmFtZT4vdHlwZQ0KPiANCj4gWW91IGNh
biB1c2UgZGVsbC1zcGVjaWFsLWF1dGgtbWVjaGFuaXNtIGFzIHR5cGUgZm9yIHRoaXMgYW5kDQo+
IHRoZW4gaXQgaXMgY2xlYXIgaXQgaXMgZGVsbCBzcGVjaWZpYy4gQXMgbWVudGlvbmVkIGFib3Zl
IEkNCj4gZnVsbHkgZXhwZWN0IG5ldyB0eXBlcyB0byBnZXQgYWRkZWQgb3ZlciB0aGlzIGFuZCB1
c2Vyc3BhY2UgdG9vbHMNCj4gd2lsbCBiZSBleHBlY3RlZCB0byBqdXN0IHNraXAgcHJvcGVydGll
cyB3aXRoIHVua25vd24gdHlwZXMNCj4gKHBvc3NpYmx5IHdpdGggYSB3YXJuaW5nKS4NCg0KU28g
SSB0aGluayB0aGUgbnVhbmNlIHRoYXQgaXMgbWlzc2VkIGhlcmUgaXMgdGhlIGFjdHVhbCBmbG93
IGZvciBpbnRlcmFjdGluZyB3aXRoDQphbiBhdHRyaWJ1dGUgd2hlbiBwYXNzd29yZCBzZWN1cml0
eSBpcyBlbmFibGVkIGluIHRvZGF5J3MgcGF0Y2ggc2V0IChib3RoIHYxIGFuZCB2MikuDQoNClVz
ZXJzcGFjZSB3b3VsZCBwZXJmb3JtIGxpa2UgdGhpczoNCjEpIENoZWNrICJpc19wYXNzd29yZF9z
ZXQiIGF0dHJpYnV0ZSB0byBkZXRlcm1pbmUgaWYgYWRtaW4gcGFzc3dvcmQgcmVxdWlyZWQNCjIp
IElmIHllcyB3cml0ZSBwYXNzd29yZCBpbnRvIHRoZSBjdXJyZW50X3Bhc3N3b3JkIGF0dHJpYnV0
ZSAobG9jYXRpb24gY2hhbmdlZCBpbiAyIHBhdGNoZXMpDQozKSB3cml0ZSBuZXcgYXR0cmlidXRl
IHZhbHVlKHMpDQo0KSBJZiBuZWNlc3NhcnkgY2xlYXIgY3VycmVudF9wYXNzd29yZCBhdHRyaWJ1
dGUNCg0KVGhpcyB3b3JrcyBsaWtlIGEgInNlc3Npb24iIHRvZGF5IHdpdGggYWRtaW4gcGFzc3dv
cmQuICBTbyBpZiB5b3UgaGF2ZSBhIGdlbmVyaWMgaW50ZXJmYWNlDQpyZXByZXNlbnRpbmcgdGhp
bmdzIGFzIGF0dHJpYnV0ZXMgeW91IG5lZWQgdG8gYWxzbyBoYXZlIGEgZ2VuZXJpYyBhdHRyaWJ1
dGUgaW5kaWNhdGluZw0KYXV0aGVudGljYXRpb24gcmVxdWlyZWQuICBUaGF0IHdvdWxkIG1lYW4g
QUxMIGF0dHJpYnV0ZXMgbmVlZCB0byBoYXZlIGEgImF1dGhlbnRpY2F0aW9uX3JlcXVpcmVkIg0K
dHlwZSBvZiBhdHRyaWJ1dGUuDQoNCkFuZCB0aGVuIHRoYXQgY29tZXMgYmFjayB0byB0aGUgcG9p
bnQgdGhhdCBhdXRoZW50aWNhdGlvbiBmbG93IGlzIGRlZmluaXRlbHkgbm90IGdlbmVyaWMuDQpE
ZWxsIHJlcXVpcmVzIHlvdSB0byB3cml0ZSB0aGUgcGFzc3dvcmQgaW4gZXZlcnkgV01JIGNhbGwg
dG9kYXksIGJ1dCB0aGUgc3lzZnMgaW50ZXJmYWNlIGFjdHVhbGx5DQpiZWhhdmVzIGxpa2UgYSBz
ZXNzaW9uIGFuZCBjYWNoZXMgdGhlIHBhc3N3b3JkIGluIG1lbW9yeSBmb3IgdGhlIG5leHQgY2Fs
bC4NCg0KQXMgYSBjb21wbGV0ZWx5IGh5cG90aGV0aWNhbCBpZGVhIHdoYXQgaWYgYW5vdGhlciB2
ZW5kb3IgYWxzbyBzdXBwb3J0cyBhbiBhZG1pbiBwYXNzd29yZCBidXQgZGVjaWRlcyBmb3INCnRo
ZWlyIHRocmVhdCBtb2RlbCBpdCdzIGFjdHVhbGx5IGEgcGFzc3dvcmQgaGFzaGVkIGFwcGVuZGVk
IHdpdGggYSBub25jZSBhbmQgaGFzaGVkIGFuZCBoZW5jZQ0KbmVlZHMgdG8gYmUgc2V0IGV2ZXJ5
IHRpbWUgZnJvbSBzeXNmcz8NCg0KVGhlaXIgZmxvdyBtaWdodCBsb29rIHNvbWV0aGluZyBsaWtl
IHRoaXM6DQoxKSBDaGVjayBhdXRoX3JlcXVpcmVkIGF0dHJpYnV0ZQ0KMikgV3JpdGUgaGFzaChw
YXNzd29yZHxub25jZSkgdG8gY3VycmVudF9wYXNzd29yZA0KMykgV3JpdGUgYXR0cmlidXRlDQo0
KSBXcml0ZSBoYXNoKHBhc3N3b3JkfG5vbmNlKSB0byBjdXJyZW50X3Bhc3N3b3JkDQo1KSBOb3Qg
bmVjZXNzYXJ5IHRvIGNsZWFyIGN1cnJlbnRfcGFzc3dvcmQNCg0KVGhvc2UgYXJlIHZlcnkgZGlm
ZmVyZW50IGZsb3dzIHRvIGdldCB0byBhbmQgY2hhbmdlIHRoZSBzYW1lICJ0eXBlcyIgb2YgZGF0
YS4gIEJ5IERlbGwncyBpbnRlcmZhY2UNCmJlaW5nIERlbGwgc3BlY2lmaWMgd2UgY2FuIGd1YXJh
bnRlZSB0aGF0IHRoZSBkb2N1bWVudGVkIGZsb3cgd29ya3MgaG93IGl0IHNob3VsZC4NCg0KPiAN
Cj4gV2UgY291bGQgZXZlbiBkbyBzb21ldGhpbmcgbGlrZSB3ZSBoYXZlIGZvciAuZGVza3RvcCBm
aWxlcw0KPiBmaWVsZHMsIHdoZXJlIHdlIGFkZCBzb21ldGhpbmcgdG8gdGhlIHN5c2ZzIEFCSSBk
b2N1bWVudGF0aW9uDQo+IHRoYXQgdmVuZG9ycyBtYXkgYWRkIHZlbmRvciBzcGVjaWZpYyB0eXBl
cyBwcmVmaXhlZCB3aXRoIFgtPHZlbmRvcm5hbWU+Lg0KPiANCj4gU28gYWxsIGluIGFsbCBJIGJl
bGlldmUgdGhhdCB3ZSBjYW4gbWFrZSB1c2luZyB0aGUgcHJvcG9zZWQgc3lzZnMgQUJJDQo+IGEg
Z2VuZXJpYyBvbmUgd29yaywgYW5kIHRoYXQgdGhpcyB3aWxsIGJlIHdvcnRoIGl0IHRvIGF2b2lk
IGhhdmluZyB0aGUNCj4gaXNzdWUgb2YgZXZlbnR1YWxseSBoYXZpbmcgYm90aCBhIGNvdXBsZSBv
ZiB2ZW5kb3Igc3BlY2lmaWMgQVBJcyArDQo+IG9uZSBncmFudCB1bmlmaWVkIGdlbmVyaWMgQVBJ
IHJlcGxhY2luZyB0aG9zZSB2ZW5kb3ItQVBJcw0KPiAod2hlcmUgd2UgY2FuIG5ldmVyIGRyb3Ag
dGhlIHZlbmRvciBzcGVjaWZpYyBBUElzIGJlY2F1c2Ugb2YNCj4gYmFja3dhcmQgY29tcGF0LiBn
dWFyYW50ZWVzKS4NCg0KSSdtIHBlcnNvbmFsbHkgbGVhbmluZyBvbiB0aGUgcmlnaHQgcGxhY2Ug
dG8gaGF2ZSBhIHZlbmRvciBhZ25vc3RpYyB2aWV3IGlzICJvdXRzaWRlIg0Kb2YgdGhlIGtlcm5l
bCBpbiBhbiB1c2VybGFuZCBsaWJyYXJ5LiAgQWxsIHRoZSB2ZW5kb3IgZHJpdmVycyB0aGF0IGNo
YW5nZSBzZXR0aW5ncyBjYW4NCmJlaGF2ZSB2ZXJ5IHNpbWlsYXJseSBmb3IgdGhlIG1vc3QgcGFy
dCwgYnV0IGRpZmZlcmVuY2VzIGJldHdlZW4gdmVuZG9yIGltcGxlbWVudGF0aW9ucw0KY2FuIGJl
IGJldHRlciBleHByZXNzZWQgdGhlcmUuDQoNCg==
