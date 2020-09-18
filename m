Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E726F6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIRH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:27:47 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30580 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgIRH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:27:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I7Mlnx016285;
        Fri, 18 Sep 2020 00:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=wsPU3hc66u8IpuwgXH1fsin+m1ofmrgg4kaOzAS9gcM=;
 b=EBvyKc6gy9yKfMBnRS6rFfhIUfs1OgQ+DD1hFlc0A0fnfTrExSJkl7tPOR2aIIaym58W
 KNbJovrROr7FHVX8rU44vOF0jLXar88Kmmw0FOI5eF4mxxa9XzSOjkn/l+ENnkozLMJO
 RkDjo08T5RG1VGKg/fYwy1ZwSI0u0UdA34k6YiSlj7Fh4rf1krluZQRryRVIyJeCqeG9
 0MYvzkzAfaC/KgWdj2vnUrDgoE6WAG1+LYYv50hXNTMyS0ztnb+OXtZl72K1HG4YVGkV
 0ZjiZE7t6gESm0da5AtTVs3WrvtmWchTcpHHIqAKx6HgzhB8JMbruf3LD0wmOqqxR/GN rw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmtym8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 00:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8+xwqdIAv44VULdYSJQo43+XAl/X8CTOnqaIJq5oDq2oQPyUdw/OHmf03qVwhHd7FjfLbHokorhEAExImJdk0EE9UN0xwQADqFm31Zk4ch6bpNwXDQaCPdrtLWDZ669i8EqKKv5H3wPMDZkFakLqmElMxEc0AxWSffe/tq3XNGTmY0zgOWMAL2RjYzQ7nsguNv7/Bn8Xr5ry8zDxz7+ikVA2tHMf45LzEqHEcpXRKAlyaSPM+gPWwkodBjsZwN9Fyv3aJrcNXpFj/1ad7Ps09H4Vqn2oRXLfSUIUoeCkLVz9jC1L9paFIRUwzBD27fxaSSnGoQyT1lLmlw9OsANGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsPU3hc66u8IpuwgXH1fsin+m1ofmrgg4kaOzAS9gcM=;
 b=kmHXYGEUHp6J5ltQBg0+c/Yma8x12qdtpwo4ee0U6Mj+OZD0U2ZVOTk+qT8Fq9d4NaQQa/h1GLIwO6RUsDcsCcFlTM8Gr/McX9HY6H9psZipyKxyUBKOpJoA0VYSrdxPch3Mmgv1KAuwq+hsYNBsNbN9khJH6R+nSc7hQ8awhMltcT2ju6T4/2zZsz34GodC0nO5BDNRgnsUxGPmiF7I95yOaEgcCd6H47bWPBEkzbLqEJfXa8fxt5A+VnUCGvv/+tFcJDIV2h3wghh+f1FqlUAk3TF1ZrZAmvkhqCGTtwC9SDSfMxsQEruJXwndBaJaab1jgTPAVcjh8cpoy7NXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsPU3hc66u8IpuwgXH1fsin+m1ofmrgg4kaOzAS9gcM=;
 b=nDAQMbvbd/4kx2Ujs6b2ZxURV/PUL5bcGsEatGT+/lM6issdSF0vykvjPNISvYXQ6agNw6r1wRi6Mmsg407XHkkNlTc73VDDl+VSdE5orGS3WreccAAohMNBhtvt5MSJps8UmB9f/hSaxtlbhrdAArqZOKqcPTEzGyD2vgaMhF0=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 07:27:23 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 07:27:23 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>
Subject: RE: [PATCH v10 1/3] dt-bindings: drm/bridge: Document Cadence
 MHDP8546 bridge bindings
Thread-Topic: [PATCH v10 1/3] dt-bindings: drm/bridge: Document Cadence
 MHDP8546 bridge bindings
Thread-Index: AQHWipVh6qfwktJm6E+lc6hSVjHO0KlrMaMAgALSlxA=
Date:   Fri, 18 Sep 2020 07:27:23 +0000
Message-ID: <DM6PR07MB61541CC71AC926948802B753C53F0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1600087715-15729-1-git-send-email-sjakhade@cadence.com>
 <1600087715-15729-2-git-send-email-sjakhade@cadence.com>
 <37aacded-72e3-eaa9-f97e-488733da98ba@ti.com>
In-Reply-To: <37aacded-72e3-eaa9-f97e-488733da98ba@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02MTg1NWNhZS1mOTgwLTExZWEtODUyZC1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNjE4NTVjYjAtZjk4MC0xMWVhLTg1MmQtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzMjI2IiB0PSIxMzI0NDg4NzYzODU2ODYxOTciIGg9ImxlbTk3bk4rQ0VNY1RxUkxzcFRTL1RmYWo5ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5684c947-3ea5-46c8-464b-08d85ba44915
x-ms-traffictypediagnostic: DM5PR07MB3612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB361291BA972FBD28A1D59357C53F0@DM5PR07MB3612.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8PIREPTkl+Z98LmRVFeijj1OUHOSPLO5kx1SIQOL0+KbGKy/H58YMEhMGMx34fiCzXoAh1aLAtr6gHhqeXIdyk8CWgaifSkDs0MMgxi0bM8wcauYTSs5oXUFWz1pkqmmZ73PxtG7z8kSRu2p/Ux89IuibQJz4LhMW/dbaBByHOvQ87s35YDC9B3GRKcOQceVabR9ztXNYn4SvYEMyjG9OKPWEz++FEu3gDH/FCgBS8WAATz3Bizsd/vyJ+E8B+dzwCtV/vjQESNevUfbg4K8A5ukpLIOw6BhQMYPJeqOcBCcrHeAe82j6EnKOT31jQUQ5PrV02hSC4XpsODqU0d5DHd7Y7CtQBfDj1qZvWFN3CTohH0fB27o9605EOZrV8yEh57k01OVK70e+pkn247Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(36092001)(83380400001)(6506007)(186003)(71200400001)(66946007)(76116006)(53546011)(66556008)(55016002)(7696005)(66446008)(54906003)(2906002)(66476007)(64756008)(110136005)(316002)(8676002)(9686003)(8936002)(5660300002)(4326008)(26005)(52536014)(33656002)(7416002)(478600001)(86362001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P+/IQW0+aOw4kK731Sb4DiDTmuTNJwPZKMu8X5LZ1kjK2N1BH2KJVa4awNshKmZ5hQ331XrJioagP83iq3uQoQkqrPI+KHY1+2Ys51BZoevaq693aO2t4JMANJ1ds0FIjlDhOnxrVyl0CziDtSTxcc1SYueP4MHfn+zaSNJYsyrLvQG8AWqdZk2IkE0bcvSVTzBVyD11PHi3piEtSl0xC+WLNawICn60X5tHyDt7HWLlbdk73uAPQM2mzK9vruD0F3LwYjbHM8VChwpuCNWrBketyBXDhdSHmuy1iAfvfb0Rjlc4JrlbR9KbpZkNt7TY0EKWAY71Lt5NZRgPTUUxmRTfjWKOdDW7JNfG3/np5ciWJt26wFQmox0723tuwF2/ItyDSAV7PTJbugl5QCubRCGnCiMG0ahiHMLmSN4Yvt3fm+wZIDJK99hLg0yl5O5FM4FikJHCTuFjq/hUnnUAft6mDDH0Y23EYcBan6cMSp2W7hLRpGQc3QPHgYUyoBM/SWElGdOrXT/KELANRVJTHOWpJzGrnt4+GXcGvirs67z/xbB6RVRb59HPNnrbi+X4kkBoXDX86gwIU5cNar6BnCg04aTQ7z24QHl9E87YvZc/S9+7gIkAeib+k2v2Yud2bl+VJIRH6DqBlz+8yShjvQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5684c947-3ea5-46c8-464b-08d85ba44915
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 07:27:23.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSMktkmUzn1pJphTAAcCfDTP17wDkXy1XGqhPl3IpsPbPJbA8tnemE6nJLyv0IRbgoXVojx5WERouznfE9UI/EYhRbiaUiWQcwN7pMX5frE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_06:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009180061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVG9taSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb21pIFZh
bGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAxNiwgMjAyMCA1OjQ4IFBNDQo+IFRvOiBTd2FwbmlsIEthc2hpbmF0aCBKYWtoYWRlIDxz
amFraGFkZUBjYWRlbmNlLmNvbT47IGFpcmxpZWRAbGludXguaWU7DQo+IGRhbmllbEBmZndsbC5j
aDsgTGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7
DQo+IGEuaGFqZGFAc2Ftc3VuZy5jb207IG5hcm1zdHJvbmdAYmF5bGlicmUuY29tOyBqb25hc0Br
d2lib28uc2U7DQo+IGplcm5lai5za3JhYmVjQHNpb2wubmV0OyBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+
OyBZdXRpIFN1cmVzaCBBbW9ua2FyDQo+IDx5YW1vbmthckBjYWRlbmNlLmNvbT47IGpzYXJoYUB0
aS5jb207IG5zZWtoYXJAdGkuY29tOw0KPiBwcmFuZWV0aEB0aS5jb207IG5pa2hpbC5uZEB0aS5j
b20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMS8zXSBkdC1iaW5kaW5nczogZHJtL2JyaWRn
ZTogRG9jdW1lbnQgQ2FkZW5jZQ0KPiBNSERQODU0NiBicmlkZ2UgYmluZGluZ3MNCj4gDQo+IEVY
VEVSTkFMIE1BSUwNCj4gDQo+IA0KPiBIaSBTd2FwbmlsLCBZdXRpLA0KPiANCj4gT24gMTQvMDkv
MjAyMCAxNTo0OCwgU3dhcG5pbCBKYWtoYWRlIHdyb3RlOg0KPiA+IEZyb206IFl1dGkgQW1vbmth
ciA8eWFtb25rYXJAY2FkZW5jZS5jb20+DQo+ID4NCj4gPiBEb2N1bWVudCB0aGUgYmluZGluZ3Mg
dXNlZCBmb3IgdGhlIENhZGVuY2UgTUhEUDg1NDYgRFBJL0RQIGJyaWRnZSBpbg0KPiA+IHlhbWwg
Zm9ybWF0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXV0aSBBbW9ua2FyIDx5YW1vbmthckBj
YWRlbmNlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTd2FwbmlsIEpha2hhZGUgPHNqYWtoYWRl
QGNhZGVuY2UuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KPiA+IFJldmlld2VkLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0
QGlkZWFzb25ib2FyZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kaXNwbGF5L2JyaWRnZS9jZG5z
LG1oZHA4NTQ2LnlhbWwgICAgICAgICB8IDE1NCArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE1NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9jZG5z
LG1oZHA4NTQ2LnlhbWwNCj4gSSB3YXMgdGVzdGluZyB0aGlzIG9uIEo3IEVWTSwgYW5kIGxvb2tp
bmcgYXQgdGhlIGR0cyBmaWxlcyBhbmQgRFQgYmluZGluZ3MuIFRvDQo+IGdldCByaWQgb2YgdGhl
IHdhcm5pbmdzIGZyb20gZHRic19jaGVjaywgSSBtYWRlIHRoZSBmb2xsb3dpbmcgY2hhbmdlcy4N
Cj4gDQo+IEkgdGhpbmsgdGhlIGludGVycnVwdCBvbmUgaXMgY2xlYXIuIFRoZSBkcml2ZXIgbmVl
ZHMgdGhlIGludGVycnVwdCwgYnV0IGl0IHdhcw0KPiBub3QgZGVmaW5lZCBpbiB0aGUgeWFtbCBm
aWxlLg0KPiANCj4gRm9yIHBoeS1uYW1lcywgd2UgaGFkIHRoYXQgaW4gdGhlIG91dC1vZi10cmVl
IGR0cyBmaWxlLCBzbyBJIGFkZGVkIGl0IGhlcmUuIFRoZQ0KPiBkcml2ZXIganVzdCBsb29rcyBm
b3IgdGhlIFBIWSB2aWEgaW5kZXgsIGJ1dCBJIGd1ZXNzIHdlIHNob3VsZCByZXF1aXJlIGl0Lg0K
PiANCj4gVGhlIHBvd2VyLWRvbWFpbiBpcyBub3QgbmVlZGVkIGJ5IHRoZSBkcml2ZXIsIGJ1dCBp
ZiBJJ20gbm90IG1pc3Rha2VuLCBoYXMNCj4gdG8gYmUgZGVmaW5lZCBoZXJlLg0KPiANCj4gDQo+
IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9icmlkZ2UvY2RucyxtaGRwODU0Ni55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2NkbnMsbWhkcDg1NDYueWFtbA0KPiBpbmRleCBhMjFh
NGJmZTE1Y2YuLmM1ZjU3ODFjMWVkNiAxMDA2NDQNCj4gLS0tDQo+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2NkbnMsbWhkcDg1NDYueWFtbA0KPiAr
KysNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2Uv
Y2RucyxtaGRwODU0Ni55YW0NCj4gKysrIGwNCj4gQEAgLTQ2LDYgKzQ2LDE2IEBAIHByb3BlcnRp
ZXM6DQo+ICAgICAgZGVzY3JpcHRpb246DQo+ICAgICAgICBwaGFuZGxlIHRvIHRoZSBEaXNwbGF5
UG9ydCBQSFkuDQo+IA0KPiArICBwaHktbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAt
IGNvbnN0OiBkcHBoeQ0KPiArDQo+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ICsgICAgbWF4SXRlbXM6
IDENCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gICAg
cG9ydHM6DQo+ICAgICAgdHlwZTogb2JqZWN0DQo+ICAgICAgZGVzY3JpcHRpb246DQo+IEBAIC0x
MTQsNiArMTI0LDggQEAgcmVxdWlyZWQ6DQo+ICAgIC0gcmVnDQo+ICAgIC0gcmVnLW5hbWVzDQo+
ICAgIC0gcGh5cw0KPiArICAtIHBoeS1uYW1lcw0KPiArICAtIGludGVycnVwdHMNCj4gICAgLSBw
b3J0cw0KPiANCg0KT2theS4gV2Ugd2lsbCB1cGRhdGUgdGhlIGJpbmRpbmdzIGFzIHBlciBhYm92
ZSBzdWdnZXN0aW9ucy4gVGhhbmtzIGZvciB5b3VyIGlucHV0cy4NCg0KVGhhbmtzICYgcmVnYXJk
cywNClN3YXBuaWwNCg0KPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiAgVG9t
aQ0KPiANCj4gLS0NCj4gVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0
dSAyMiwgMDAxODAgSGVsc2lua2kuDQo+IFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQu
IEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
