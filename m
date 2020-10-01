Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84572807D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbgJATiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:38:17 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:48978 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgJATiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:38:08 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091JOHSB011587;
        Thu, 1 Oct 2020 15:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=qGqZCvxYUEXb8iXKXovXKYmZNtycaT4BESLt6pDj6O4=;
 b=m9BwSJRuBPQvHTVkwlCeQLi8u2kf+msgJwGMkEM0BSy3tufTqoAQzeZOJrC9Hsz3szCF
 0EPwtTNSc4Dd1pxLmZpwxzB0ISytE4H2jXJCw0a0S8UmdIr63SQ9o0w4xQ30qYuofa6n
 0EY8IV7i/6My9D4jPaAh7l04W3KjQe8574TCP2MCzmoKaaxxgMKMyaW277pCSUvJAxky
 DTTdAo0ejlScWiRzy5TNMpnXm+cvdge6btuEJSOI9O7l09LWa6HBygZoQsRmOjsF7ux5
 ABjeA75eMzasK4Kf8dDPLDJPmGY0Ge/b8erf8Ppg103+5OE98Y7Fj3XH+mQzp1leM8vh Qg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 33t0tekd2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 15:38:00 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091JQMkf193744;
        Thu, 1 Oct 2020 15:37:59 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-00154901.pphosted.com with ESMTP id 33wm3thkdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 15:37:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu0hVFl/1QPeEkfuXrf/GkZvqBDyF82o+cATcgBMbxmNvNBEYx4IKi7Azy3NNiorbhQCLiwLeu+8lsB5b54y2x7ik8AJtrkt65ATlqU6qBKELf/CpjfvieggbceEInUZaiiiF/xmr0QO86Ju20lkKSwDAis38wcOQczE1xyaZ3W2fBYYlwG7ofL2yZayVEACbBZquLlKsVaaielGY5JmEYJpMYNo6YUMEKL06vWd2/Lt34lqK3PIOvEI7JFQslgMv274C8zcmOjlV+jbBK5N05SGxbyfW4ehxxSCzlCSJDn+G+9uDkC6NW+iCuEqgCkztCzeWG4faNVZcsULwMsIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGqZCvxYUEXb8iXKXovXKYmZNtycaT4BESLt6pDj6O4=;
 b=fZUoXcOC1afsp8BpbHMPf6eu/uUdyK0i3QvCOeI6PkoEWfSVV0d1PvxDmhvMdNQnnrlGp9GI4ikYgl1jBw84Mo7GWbz7/Xifq0z+2wtjq8RNxkpNnMdLPsVY1eOYW/tsCM/f/Nwp+8Qagf5xh/4jR3KOmIkWd3F8G5KHfbduFqhackGBOPHCgaodve2m0vt4uDI26qgvD/O62Hynf1y9FcbsBHEYXhRuHsElgcXN+qdAPezXA5HWxrSl8WkBUrSOGupkiV6u0YInUcZ68Cv2f4UgbMAeOlCxriuFyTKTIAkAJr45fTe7PLmnMOVpFiC8JQisYvrydmxV72FV0m8B3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGqZCvxYUEXb8iXKXovXKYmZNtycaT4BESLt6pDj6O4=;
 b=ZLZLYvbBMJTt5uB8gsE92VtEwsUcgEeAoZw1I4P40QjscyrVO9EuqzA2YlyRpZcVIHjCExgQ7Z3od6Pc6ZrGPqMi3ztT/xi0utw5iQsxLGDGAvjwGZsKWna6KrPGw2MYtoFDn4X1C+QEHgxGUNhghDdxC+XDJGmd30A8+aAdKq0=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1161.namprd19.prod.outlook.com (2603:10b6:3:bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Thu, 1 Oct 2020 19:37:57 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 19:37:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWlgw7aMsAV+e0GEu/dASzG9J9LamDEwiAgAAK46A=
Date:   Thu, 1 Oct 2020 19:37:57 +0000
Message-ID: <DM6PR19MB26368CC7E63EB64C380C9F63FA300@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
In-Reply-To: <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-01T19:36:59.7571559Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=89c78a4c-2f4a-49a8-9262-e6fba8030ec9;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92f38772-7e01-4dc7-5530-08d866417fb4
x-ms-traffictypediagnostic: DM5PR19MB1161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB11619EA739718DDC269625AAFA300@DM5PR19MB1161.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJA4QWvrqIHti093K1NdeOXNk6jz5sRKRQlzEYhjzqyP2een/X3W81q8QOe4MVRpL8pN4hr1ZHaOupPH/InESgDWk8Kxq/YPoCCJsV8LcFe0PBSX/eljJODOPUU1gc4b5cR1RKvAn/MWeH7zcodpMdweFBuTXmCCTyLkUdepQ2Ch1jfvKywejzoUBPtBaQnJw6iJik9cnK3qMOl5yZwICW/PHn3cFUkLEq4cs3J3X3kr+XJxu7af+UlAFG/1srdKQfhAl2VJCIOKSGPFBBRUHqTNEiSWW+L+zFDZE5x83OerYkl57EjIb+EL83gARzpoEN85z3cLxU0iPQZAQ9GAvhsdlKtJPjYW5wE9WGZ4HBBqcx8vmzviqVCL4EK2T3iF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(83380400001)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(86362001)(52536014)(71200400001)(55016002)(26005)(9686003)(7696005)(6506007)(186003)(8676002)(110136005)(33656002)(54906003)(478600001)(107886003)(4326008)(8936002)(2906002)(316002)(786003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1iNQP5wftKeDgZmXQRSmymsvo4E8PPOEeHo4A9gUgwjGev3nPatdgAJODFgD1z4ilMwsOMiAKBcX3lP4SyvljKNgkGSlU+5yWdmIyrj2MSR8T0BqDhGsoo5LYzuJgnBx4Ml52Gna7K4FjI+lZwHR7b+rUdxZrIrtL0EDvqQ5wF6pAf1TG/gYNPLt69J5sBSUjwB+ejYAfkNQCZL93qIBVDb24XAvGDb4MoHdAmH4kIlLjANKnHgQvpyzs7+tzwWSlwM8qiPkHmBi9FkUpcr5croQQifvwwwcWde8i+Sydgr20gcjXZkbSkFm1uYol78UcofxThHaRmNZrzd469TRFvPTW3lVvCc1pGmGSAFpCfq42Le6aK61nCvx12nRu2oC3zAcQSvWe0vqwVGSNbG1rrmnjzOHNZwf0QnmS6w6m86VTAueEch5f2I7dIlY9DQ9wwdMMeL4nqSpKGc33ccvzwsNxpjXN2+vpETzXeSRjHk08w40gCEI0VzSLf579htp+k+UCr+MS/041yPmv9yqA98DCa64JsL3ylTJSfSwR2RREb/MO2IW6DMMgtSZnobqhoaJmuTdTKaJMUUH+Pm13GTj9AJ/IjXmSL3elhfqRC/a6Oy6LvcOd9tESmuxrO/2D3jqUmKaZSPbktBjQCa+Bg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f38772-7e01-4dc7-5530-08d866417fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 19:37:57.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UUFx54AV5vyLI4PQk7CCPLAB0CHNh0zWqxll+mtI4hOedhBbtp23gRIoixkmFVWM9/tbVB91gwzQydqZ2qyJ7R3PtZ5ObGCJcERIs4+KQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_07:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010157
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsNCj4gPiArCWlmICghY2FwYWJsZShDQVBfU1lTX0FETUlOKSkNCj4gPiArCQlyZXR1cm4g
LUVQRVJNOw0KPiANCj4gU29ycnkgZm9yIG5vdCBhZGRyZXNzaW5nIHRoaXMgZHVyaW5nIGVhcmxp
ZXIgcmV2aWV3cywgYnV0IHdoeSBpcyB0aGlzDQo+IGNoZWNrIGhlcmUuIElzIHJlYWQtb25seSBh
Y2Nlc3MgdG8gdGhlIHNldHRpbmdzIGJ5IG5vcm1hbCB1c2Vycw0KPiBjb25zaWRlcmVkIGhhcm1m
dWwgPw0KPiANCg0KVGhlIGJlc3QgYW5zd2VyIEkgY2FuIGdpdmUgaXMgdGhhdCB0aGlzIGlzIGV4
cG9zaW5nIGRhdGEgdG8gYSB1c2VyIHRoYXQNCnByZXZpb3VzbHkgdGhleSB3b3VsZCBoYXZlIG5l
ZWRlZCBlaXRoZXIgcGh5c2ljYWwgYWNjZXNzIG9yIHJvb3QgYWNjZXNzDQp0byBzZWUuICBBbmQg
ZXZlbiBpZiB0aGV5IGhhZCBwaHlzaWNhbCBhY2Nlc3MgdGhleSBtYXkgaGF2ZSBuZWVkZWQgYQ0K
QklPUyBhZG1pbiBwYXNzd29yZCB0byBnZXQgImludG8iIHNldHVwLiAgRXhwb3NpbmcgaXQgZGly
ZWN0bHkgdG8gZXZlcnlvbmUNCnN1YnZlcnRzIHRoZSBwcmV2aW91cyBhY2Nlc3MgbGltaXRhdGlv
bnMgdG8gdGhlIGRhdGEuDQoNClNvbWUgb2YgdGhlIHNldHRpbmdzIGFyZSBjZXJ0YWlubHkgbW9y
ZSBzZW5zaXRpdmUgdGhhbiBvdGhlcnMsIHNvIEkgZG9uJ3QNCmZlZWwgaXQncyBhcHByb3ByaWF0
ZSBmb3IgdGhlIGtlcm5lbCB0byBwZXJmb3JtIHRoaXMgYXJiaXRyYXRpb24uDQoNCj4gPiArCWlu
c3RhbmNlX2lkID0gZ2V0X2VudW1lcmF0aW9uX2luc3RhbmNlX2lkKGtvYmopOw0KPiANCj4gQ2Fu
IHdlIHBsZWFzZSBtb3ZlIHRoZSBlcnJvciByZXR1cm4gdG8gZGlyZWN0bHkgYmVsb3cNCj4gdGhl
IGZ1bmN0aW9uIGNhbGwgYW5kIHByb3BhZ2F0ZSB0aGUgZXJyb3IgcGxlYXNlPw0KPiBTbyBtYWtl
IGl0Og0KPiANCj4gCWluc3RhbmNlX2lkID0gZ2V0X2VudW1lcmF0aW9uX2luc3RhbmNlX2lkKGtv
YmopOw0KPiAJaWYgKGluc3RhbmNlX2lkIDwgMCkNCj4gCQlyZXR1cm4gaW5zdGFuY2VfaWQ7DQo+
IA0KPiAJLyogTm9uIGVycm9yIHBhdGggY29kZSBoZXJlICovDQo+IAlyZXR1cm4gc3ByaW50Zihi
dWYsICIlc1xuIiwNCj4gd21pX3ByaXYuZW51bWVyYXRpb25fZGF0YVtpbnN0YW5jZV9pZF0uY3Vy
cmVudF92YWx1ZSk7DQo+IA0KPiBUaGlzIGlzIHRoZSBub3JtYWwgd2F5IG9mIGVycm9yIGhhbmRs
aW5nIGluIHRoZSBrZXJuZWwsIHRoZQ0KPiBpZiAoc3VjY2VzcykgbWV0aG9kIGdldHMgdW53aWVs
ZGx5IHdpdGggbmVzdGVkIHN1Y2Nlc3MgY2hlY2tzOg0KPiANCj4gCWlmIChzdWNjZXNzKSB7DQo+
IAkJLi4uDQo+IAkJaWYgKHN1Y2Nlc3MpIHsNCj4gCQkJLi4uDQo+IAkJCWlmIChzdWNjZXNzKSB7
DQo+IAkJCQkuLi4NCj4gDQo+ID4gKwlpZiAoaW5zdGFuY2VfaWQgPj0gMCkgew0KPiA+ICsJCXVu
aW9uIGFjcGlfb2JqZWN0ICpvYmo7DQo+ID4gKw0KPiA+ICsJCS8qIG5lZWQgdG8gdXNlIHNwZWNp
ZmljIGluc3RhbmNlX2lkIGFuZCBndWlkIGNvbWJpbmF0aW9uIHRvIGdldA0KPiByaWdodCBkYXRh
ICovDQo+ID4gKwkJb2JqID0gZ2V0X3dtaW9ial9wb2ludGVyKGluc3RhbmNlX2lkLA0KPiBERUxM
X1dNSV9CSU9TX0VOVU1FUkFUSU9OX0FUVFJJQlVURV9HVUlEKTsNCj4gPiArCQlpZiAoIW9iaikN
Cj4gPiArCQkJcmV0dXJuIC1BRV9FUlJPUjsNCj4gDQo+IC1BRV9FUlJPUiBpcyBub3QgYSBzdGFu
ZGFyZCBlcnJuby5oIGVycm9yIGNvZGUsIHNvIGl0IHNob3VsZCBub3QgYmUgdXNlZCBoZXJlLg0K
DQooVGhlcmUgc2hvdWxkIHByb2JhYmx5IGJlIHNvbWUgY2xlYW51cCB0byBvdGhlciBkcml2ZXJz
IHRvbyB0aGF0IHVzZSB0aGlzKQ0KDQo+IA0KPiA+ICsJCXN0cmxjcHlfYXR0cih3bWlfcHJpdi5l
bnVtZXJhdGlvbl9kYXRhW2luc3RhbmNlX2lkXS5jdXJyZW50X3ZhbHVlLA0KPiA+ICsJCSAgICAg
ICBvYmotPnBhY2thZ2UuZWxlbWVudHNbQ1VSUkVOVF9WQUxdLnN0cmluZy5wb2ludGVyKTsNCj4g
PiArCQlrZnJlZShvYmopOw0KPiA+ICsJCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLA0KPiB3
bWlfcHJpdi5lbnVtZXJhdGlvbl9kYXRhW2luc3RhbmNlX2lkXS5jdXJyZW50X3ZhbHVlKTsNCj4g
DQo+IFdoeSBkbyB0aGUgc3RyY3B5IGF0IGFsbCwgd2h5IG5vdCBkaXJlY3RseSBzcHJpbnRmIHRo
ZSBvYmotDQo+ID5wYWNrYWdlLmVsZW1lbnRzW0NVUlJFTlRfVkFMXS5zdHJpbmcucG9pbnRlciA/
DQo+IHRoZSBvbmx5IGFkdmFudGFnZSBJIHNlZSB0byB0aGUgc3RyY3B5IGlzIG5vdCBvdmVyZmxv
d2luZyBidWYuDQo+IA0KPiBIb3cgYWJvdXQgdGhpcyBpbnN0ZWFkOg0KPiANCj4gCXVuaW9uIGFj
cGlfb2JqZWN0ICpvYmo7DQo+IAlzc2l6ZV90IHJldDsNCj4gDQo+IAlpbnN0YW5jZV9pZCA9IGdl
dF9lbnVtZXJhdGlvbl9pbnN0YW5jZV9pZChrb2JqKTsNCj4gCWlmIChpbnN0YW5jZV9pZCA8IDAp
DQo+IAkJcmV0dXJuIGluc3RhbmNlX2lkOw0KPiANCj4gCW9iaiA9IGdldF93bWlvYmpfcG9pbnRl
cihpbnN0YW5jZV9pZCwNCj4gREVMTF9XTUlfQklPU19FTlVNRVJBVElPTl9BVFRSSUJVVEVfR1VJ
RCk7DQo+IAlpZiAoIW9iaikNCj4gCQlyZXR1cm4gLUVJTzsNCj4gDQo+IAlzcHJpbnRmKGJ1Ziwg
IiVzXG4iLA0KPiAJcmV0ID0gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlc1xuIiwgb2JqLQ0K
PiA+cGFja2FnZS5lbGVtZW50c1tDVVJSRU5UX1ZBTF0uc3RyaW5nLnBvaW50ZXIpOw0KPiAJa2Zy
ZWUob2JqKTsNCj4gCXJldHVybiByZXQ7DQo+IH0NCj4gDQo+IFRoZW4gd2UgY2FuIGNvbXBsZXRl
bHkgZHJvcCB0aGUgY3VycmVudF92YWx1ZSBtZW1iZXIgZnJvbSBzdHJ1Y3QNCj4gZW51bWVyYXRp
b25fZGF0YS4NCj4gDQo+ID4gKwl9DQo+ID4gKwlyZXR1cm4gLUVJTzsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArLyoqDQo+ID4gKyAqIHZhbGlkYXRlX2VudW1lcmF0aW9uX2lucHV0KCkgLSBWYWxpZGF0
ZSBpbnB1dCBvZiBjdXJyZW50X3ZhbHVlIGFnYWluc3QNCj4gcG9zc2libGUgdmFsdWVzDQo+ID4g
KyAqIEBpbnN0YW5jZV9pZDogVGhlIGluc3RhbmNlIG9uIHdoaWNoIGlucHV0IGlzIHZhbGlkYXRl
ZA0KPiA+ICsgKiBAYnVmOiBJbnB1dCB2YWx1ZQ0KPiA+ICsgKiovDQo+IA0KPiBUaGUga2VybmVs
IHR5cGljYWxseSB0ZXJtaW5hdGVzIGtlcm5lbGRvYyBjb21tZW50cyB3aXRoIGEgc3RhbmRhcmQg
JyovJw0KPiB0ZXJtaW5hdG9yIChub3QgJyoqLycpLiBOb3RlIHRoaXMgY29tbWVudCBhcHBsaWVz
IHRvIGFsbCBrZXJuZWxkb2MgY29tbWVudHMNCj4gaW4gdGhlIHBhdGNoLg0KPiANCj4gPiArc3Rh
dGljIGludCB2YWxpZGF0ZV9lbnVtZXJhdGlvbl9pbnB1dChpbnQgaW5zdGFuY2VfaWQsIGNvbnN0
IGNoYXIgKmJ1ZikNCj4gPiArew0KPiA+ICsJY2hhciAqb3B0aW9ucywgKnRtcCwgKnA7DQo+ID4g
KwlpbnQgcmV0ID0gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlvcHRpb25zID0gdG1wID0NCj4ga3N0
cmR1cCh3bWlfcHJpdi5lbnVtZXJhdGlvbl9kYXRhW2luc3RhbmNlX2lkXS5wb3NzaWJsZV92YWx1
ZXMsDQo+ID4gKwkJCQkgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIW9wdGlvbnMpDQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJd2hpbGUgKChwID0gc3Ryc2VwKCZvcHRpb25z
LCAiOyIpKSAhPSBOVUxMKSB7DQo+ID4gKwkJaWYgKCEqcCkNCj4gPiArCQkJY29udGludWU7DQo+
ID4gKwkJaWYgKCFzdHJuY2FzZWNtcChwLCBidWYsIHN0cmxlbihwKSkpIHsNCj4gDQo+IFNvIHVz
aW5nIHN0cm5jYXNlY21wIGhlcmUgaXMgdXN1YWxseSBkb25lIHRvIGdldCByaWQgb2YgdGhlICdc
bicgYnV0IGl0DQo+IGlzIGEgYml0IGZpbmlja3kgYW5kIGFzIHN1Y2ggeW91IGdvdCBpdCB3cm9u
ZyBoZXJlLCBvZiBzYXkgIkVuYWJsZWQiDQo+IGlzIGEgdmFsaWQgdmFsdWUgYW5kIHRoZSB1c2Vy
IHBhc3NlcyAiRW5hYmxlZEZvb0JhciIgdGhlbiB0aGlzDQo+IHdpbGwgZ2V0IGFjY2VwdGVkIGJl
Y2F1c2UgdGhlIGZpcnN0IDcgY2hhcnMgbWF0Y2guIFNpbmNlIHlvdQ0KPiBhcmUgYWxyZWFkeSBk
ZWFsaW5nIHdpdGggdGhlIFxuIGluIHRoZSBjYWxsZXIgeW91IGNhbiBqdXN0IGRyb3AgdGhlDQo+
ICJuIiBwYXJ0IG9mIHRoZSBzdHJuY2FzZWNtcCB0byBmaXggdGhpcy4NCj4gDQo+IEFsc28gYXJl
IHlvdSBzdXJlIHlvdSB3YW50IGEgc3RyY2FzZWNtcCBoZXJlID8gVGhhdCBtYWtlcyB0aGUgY29t
cGFyZQ0KPiBjYXNlLWluc2Vuc2l0aXZlLiBTbyBJT1cgdGhhdCBtZWFucyB0aGF0IGVuYWJsZWQg
YW5kIEVOQUJMRUQgYXJlIGFsc28NCj4gYWNjZXB0YWJsZS4NCg0KVGhhdCdzIGNvcnJlY3QsIHRo
ZSBmaXJtd2FyZSB3aWxsIGludGVycHJldCBFTkFCTEVEIGFuZCBlbmFibGVkIGFzIHRoZSBzYW1l
DQp0aGluZy4gIEl0IHdpbGwgYWxzbyBkbyBmdXJ0aGVyIHZhbGlkYXRpb24gb2YgdGhlIGlucHV0
Lg0KDQokIGVjaG8gImVuYWJsZWQiIHwgc3VkbyB0ZWUgL3N5cy9jbGFzcy9maXJtd2FyZS1hdHRy
aWJ1dGVzL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1dGVzL1RvdWNoc2NyZWVuL2N1cnJlbnRfdmFs
dWUgDQplbmFibGVkDQokIGVjaG8gImVuYWJsZWRmb29iYXIiIHwgc3VkbyB0ZWUgL3N5cy9jbGFz
cy9maXJtd2FyZS1hdHRyaWJ1dGVzL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1dGVzL1RvdWNoc2Ny
ZWVuL2N1cnJlbnRfdmFsdWUgDQplbmFibGVkZm9vYmFyDQp0ZWU6IC9zeXMvY2xhc3MvZmlybXdh
cmUtYXR0cmlidXRlcy9kZWxsLXdtaS1zeXNtYW4vYXR0cmlidXRlcy9Ub3VjaHNjcmVlbi9jdXJy
ZW50X3ZhbHVlOiBJbnB1dC9vdXRwdXQgZXJyb3INCiQgZWNobyAiRW5BQkxFRCIgfCBzdWRvIHRl
ZSAvc3lzL2NsYXNzL2Zpcm13YXJlLWF0dHJpYnV0ZXMvZGVsbC13bWktc3lzbWFuL2F0dHJpYnV0
ZXMvVG91Y2hzY3JlZW4vY3VycmVudF92YWx1ZSANCkVuQUJMRUQNCiQgc3VkbyBjYXQgL3N5cy9j
bGFzcy9maXJtd2FyZS1hdHRyaWJ1dGVzL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1dGVzL1RvdWNo
c2NyZWVuL2N1cnJlbnRfdmFsdWUNCkVuYWJsZWQNCg0KPiANCj4gTWF5YmUgYWxzbyBjaGVjayBh
Z2FpbnN0IG1pbi9tYXggcGFzc3dvcmQgbGVuZ2h0IGhlcmU/DQo+IA0KPiBJIGd1ZXNzIHRoYXQg
aXMgbW9zdGx5IGltcG9ydGFudCB3aGVuIGNoYW5naW5nIHRoZSBwYXNzd29yZCwgc2luY2UNCj4g
aWYgdGhlIGxlbmd0aCBpcyBub3QgdmFsaWQgdGhlbiBpdCBpcyBqdXN0IGEgd3JvbmcgcGFzc3dv
cmQuDQo+IA0KPiBTbyBJIGd1ZXNzIGl0IGlzIGZpbmUgdG8gb25seSBjaGVjayBmb3Igbm90IGV4
Y2VlZGluZyBNQVhfQlVGIGhlcmUuDQoNClllcywgdGhlIGZpcm13YXJlIHdpbGwgZG8gdGhpcyBj
aGVjay4NCg0KDQo=
