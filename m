Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C33283034
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJEFyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 01:54:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9104 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgJEFyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 01:54:15 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0955l8U9030211;
        Sun, 4 Oct 2020 22:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=qIQUCeAhO+9CXOEmqaZxCvHa0XYiU5QWN12OkHGH2Fg=;
 b=FUc/dxn2PeO0Nu35hhX8s6iZM18EAfYPJT6zMS5B9SFqrCumSZfq7TZ3gahlpbXkMgP4
 MiJObmqXQvyMSCtid2pchqzvsf+0DVteA5xBctP8mKgp1Fekrcqf0dVoWm5g505n3Di5
 Di5xjIVLZwvUgIWdgW7OpQ37FWju6pni0dJjkHDs+B39BIYltNstYxLYSjw3vUoqPvGd
 o04InLkKdLq4j1/+uapAjUHKZ1LB0DfiEr5aOobe+O4kJ6aLWf55wBn+zwMglV9W1z9i
 9RY4mRgHQtn2z+vHMuPV/Pi+6JV7Uslw9PhwhuCcndtjYnBXGF08Tu9sjo9y1JBoumMV qA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxc609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 22:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqAwwbr9gaO2pLxj92SKc4aW+vs1c9AkHqDmZC6wxwvigmstTtXII+YoARVYyrjRPxpUI4oLaiHfyd0IXFl+H2eaxvkb8xE7pB5kxrMWxcENW+0RbXOL97nGmYUsxLnGnHYZIKH1D2ETLhtytfjsP3nq1PH4+k+f8my4wJBkqnxQE2KNCkOjab+4gsB81SmqQ+XY5ks/1fWLtK439FV3Ve2OTvOUVtElWIo/oflgwmucpZq2nkXwrcD2KAafancqgYBaLDpObNYe5UecsMNbdILjVZLe73YUoNsziBVSn1bnxSOsxf1x3M9sSlszAEC0bTml1ASSREyJTrbnR55iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIQUCeAhO+9CXOEmqaZxCvHa0XYiU5QWN12OkHGH2Fg=;
 b=JQ21apUj2pvY2suYzg1lQV5hEAYp7ddzfzLfC3YTJUIE2riQVl8JSPnmGDh1tFtMP/fudi/MmYdfv93FK3I/mPphR2F/CpPEfBlv16pcPl9GVrvcJRw+SK6PH97zKt9DGzORbXhDLDBzm3tP6WDN6oMgs9aC7CQvZmLg830wln7HBRzslyVYPtKj/2tdSzAbaomz4ZcwfK66UoMD9w+EdUZYzsGx42zjnqCtzfFvIiqatXi56OlhX8HlFWkcUoTmYkglxUHdKE7JksMrQMWW0YhF23t8Giqidtms478Z4A2stBrKmLp07alZ6D/Nl50z3aU9nU54dujPK9WhTQUmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIQUCeAhO+9CXOEmqaZxCvHa0XYiU5QWN12OkHGH2Fg=;
 b=Jc11pN2gSXq2LcfBId2DE5dR0YQyc5aK0d6DRtqqjxwN81WKl9JsH4vVQoHtSettse0BiHOOFIUQDah1azaNpsBt0P0w9lVzh/Js6F8R4nFpasoBOaY+22c+rkCYDlcEjMQpmnXmku69eEdXHHv2ktMwI62kn/T0QdmDvP6JUss=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB8073.namprd07.prod.outlook.com (2603:10b6:5:1fe::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Mon, 5 Oct 2020 05:54:03 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 05:54:02 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.org" <peter.chen@nxp.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Topic: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Index: AQHWlvch/Roy1G/8IkO8ykqpdGeiF6mEBTKAgAAA+RCAABNFAIAEbf+w
Date:   Mon, 5 Oct 2020 05:54:02 +0000
Message-ID: <DM6PR07MB55297B8671A649E8AED7231FDD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200930065758.23740-1-pawell@cadence.com>
 <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
 <DM6PR07MB5529095F1B656C5065CBA8B4DD310@DM6PR07MB5529.namprd07.prod.outlook.com>
 <b73f6bb7-8e5e-d5f9-5adf-f6b10bdb5fb6@ti.com>
In-Reply-To: <b73f6bb7-8e5e-d5f9-5adf-f6b10bdb5fb6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjkyODVkNDgtMDZjZi0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDI5Mjg1ZDQ5LTA2Y2YtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDQ5NiIgdD0iMTMyNDYzNTA4MzkzOTg5OTk0IiBoPSJOdkVHRDc1NGIyS1lkbUZxNktqS0dCOWdBdXM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb07cd5-b310-42c5-b23b-08d868f31009
x-ms-traffictypediagnostic: DM6PR07MB8073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB8073188374A0987EB8B80713DD0C0@DM6PR07MB8073.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbEx1prEKdGx28+OyqRM5UMMpKgCXVtZVMX0EE0FJisqnFp+eKcdAWB7a97oOJS1CzeVxCUOfZbd6N3UQzPUB+8uGyzhsyr/0iP6oq6VdzLM8B41vyLjsenGrMglj30pPwuKSOMO4x+NpYPGkiqhovFuMgjUYj82zkjj3WXdJiyHAMdjqk0/8/EWT/BeWON4mFbFt9inENpi8QhW0EMOIC5+1+ob0oHQR4eju3DB32FOOF1iUT7PbClbqbtnlVaeGEedJiEyGot2/380irtgmUuX9vs6kSIq88DvnjE30BJ24QfSoBAYay3bv60z6qQuTpmJYwDg+nwXb0f6mfXU4mpBbsbrE9AKYJ4Od0bEwugOp8DEFDvpa39qOkaT8VUS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(36092001)(26005)(186003)(33656002)(76116006)(4326008)(5660300002)(66556008)(64756008)(66446008)(7696005)(66476007)(66946007)(52536014)(8676002)(110136005)(316002)(54906003)(6506007)(53546011)(107886003)(478600001)(55016002)(9686003)(8936002)(71200400001)(83380400001)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: snF33PmlYjQFjarbveuUCPh62X7wkvRizASO0V1IKCFii3twYkjnqEqTk+5MK0oMsMvomxGav7M2pdYTr3JeNgReDh2mv5EBy9P+Mmr0Oma3VEOD+w7iDhnI2tlWhIG9nRZ52hSr4XxeBIp3F3dZuyIG5NXVdl/hwBRuf6qAMBa45256zuKUWlhjpmaGBws3NRw10FfLM9S9oSyIaQYfzxKcHY+l+R3OzUiVG1ZvzFLEWLmqx1mDZN2xRDrfsU/gHFFzY5hFfn78MlGPNTAdfK49xNMpQOW7sJYgBYVbl7Q1cIpPqxNK+uKMJIYL2piYVHUlFcAL6xmrcfQ4GlBOK56OGZWxK0dAAoI+NSOopjfOZSWl3ydeVweSSMXTxApRlq+jS198WLsiqCg1iwBTfbWwSFx8KSpAXWNgpTFUnEdNU3wkcHyCewtbwQBZAimZ2d6nqXHdzcasx5kkpZQgn8nYfB/7sI2dpjeP+My6tXqdaAhnHhCC+nFFghhLeqOlwcR40lpg4uw4fTg9gQ3yjJxMyJTYjjruC11w2JxgNsmM7jLcFvpp8ryPd4c16QngpmCc+dWRfWZv2Mkr4VU9AYhld3+WAXAqdmeYp5AcaG3klVUBgzZ5DjQSVk5HpQ8uXa6KXHXsC+QXRxHnbSnSvQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb07cd5-b310-42c5-b23b-08d868f31009
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 05:54:02.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQDHMn6VrhpMcYex901StryXkBEmvbftwO5mD07vV8PsuxknLBQuPxcAFqxfWxXFeXTT1bCLYVb3D9A7h8UQBTl3eg64OauZtXVNElwMzPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8073
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_04:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=648 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9nZXIsDQo+DQo+UGF3ZWwsDQo+DQo+T24gMDIvMTAvMjAyMCAxMjowOCwgUGF3ZWwgTGFzemN6
YWsgd3JvdGU6DQo+PiBSb2dlciwNCj4+DQo+Pj4NCj4+PiBPbiAzMC8wOS8yMDIwIDA5OjU3LCBQ
YXdlbCBMYXN6Y3phayB3cm90ZToNCj4+Pj4gVG8gYXZvaWQgZHVwbGljYXRlIGVycm9yIGluZm9y
bWF0aW9uIHBhdGNoIHJlcGxhY2VzIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lDQo+Pj4+IGludG8g
cGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwuDQo+Pj4NCj4+PiBXaGF0IGlzIGR1cGxp
Y2F0ZSBlcnJvciBpbmZvcm1hdGlvbj8NCj4+DQo+PiBUaGUgZnVuY3Rpb24gcGxhdGZvcm1fZ2V0
X2lycV9ieW5hbWUgcHJpbnQ6DQo+PiAiIGRldl9lcnIoJmRldi0+ZGV2LCAiSVJRICVzIG5vdCBm
b3VuZFxuIiwgbmFtZSk7IiBpZiBlcnJvciBvY2N1cnJlZC4NCj4+DQo+PiBJbiBjb3JlLmMgd2Ug
aGF2ZSB0aGUgYW5vdGhlciBlcnJvciBtZXNzYWdlIGJlbG93IGludm9raW5nIHRoaXMgZnVuY3Rp
b24uDQo+PiBlLmcNCj4+IAlpZiAoY2Rucy0+ZGV2X2lycSA8IDApDQo+PiAJCWRldl9lcnIoZGV2
LCAiY291bGRuJ3QgZ2V0IHBlcmlwaGVyYWwgaXJxXG4iKTsNCj4+DQo+PiBTbywgaXQncyBsb29r
cyBsaWtlIG9uZSBkZXZfZXJyIGlzICByZWR1bmRhbnQuDQo+DQo+SWYgd2Ugd2FudCBhbGwgMyBJ
UlFzIHRvIGJlIHZhbGlkIGlycmVzcGVjdGl2ZSBvZiBkcl9tb2RlIHRoZW4gd2Ugc2hvdWxkDQo+
dXNlIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgYW5kIGVycm9yIG91dCBpbiBwcm9iZSBpZiAo
cmV0IDwgMCAmJiByZXQgIT0gLUVQUk9CRV9ERUZFUikuDQo+DQo+V2UgY2FuIGdldCByaWQgb2Yg
dGhlIGlycSBjaGVjayBhbmQgZHVwbGljYXRlIGVycm9yIG1lc3NhZ2UgaW4gb3RoZXIgcGxhY2Vz
Lg0KDQpUbyBiZSBzdXJlIHdlIHVuZGVyc3RhbmQgZWFjaCBvdGhlciBjb3JyZWN0bHkuDQoNCkFy
ZSBZb3Ugc3VnZ2VzdGluZyAgdG8gbGVhdmUgdGhlICBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgp
DQphbmQgcmlkIG9mIGZyb20gY29yZS5jIHRoZSBmb2xsb3dpbmcgbGluZXMgOg0KDQppZiAoY2Ru
cy0+ZGV2X2lycSA8IDApDQoJZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgcGVyaXBoZXJhbCBp
cnFcbiIpOw0KCQ0KYW5kDQoNCmRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IG90ZyBpcnFcbiIp
OyANCj8NCg0KQSB3b3JkIG9mIGV4cGxhbmF0aW9uIHdoeSB0aGlzIHBhdGNoIGhhcyBiZWVuIHNl
bnQuDQpEdXJpbmcgcmV2aWV3aW5nIHRoZSBjZG5zcCBkcml2ZXIgQ2h1bmZlbmcgWXVuIGFkZCBz
dWNoIGNvbW1lbnQ6DQoNCiINCj4gKwljZG5zLT5kZXZfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9i
eW5hbWUocGRldiwgInBlcmlwaGVyYWwiKTsNCj4gKwlpZiAoY2Rucy0+ZGV2X2lycSA9PSAtRVBS
T0JFX0RFRkVSKQ0KPiArCQlyZXR1cm4gY2Rucy0+ZGV2X2lycTsNCj4gKw0KPiArCWlmIChjZG5z
LT5kZXZfaXJxIDwgMCkNCj4gKwkJZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgcGVyaXBoZXJh
bCBpcnFcbiIpOw0KVXNlIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsPyBvdGhlcndp
c2Ugbm8gbmVlZCBwcmludCB0aGlzIGxvZywNCnBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgd2ls
bCBwcmludCBpdC4gDQoiDQoNCkluIHRoaXMgcGF0Y2ggSSd2ZSBjaG9zZW4gdGhlIHBsYXRmb3Jt
X2dldF9pcnFfYnluYW1lX29wdGlvbmFsIGJlY2F1c2UgYm90aA0KZnVuY3Rpb24gZG8gdGhlIHNh
bWUgYnV0IHRoZSBlcnJvciBtZXNzYWdlIGZyb20gY29yZS5jIHRlbGwgdXMgbGl0dGxlIG1vcmUg
dGhlbg0KZ2VuZXJpYyBtZXNzYWdlIGZyb20gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUuDQoNCkNo
ZWVycw0KUGF3ZWwgTGFzemN6YWsNCg0KPg0KPmNoZWVycywNCj4tcm9nZXINCj4NCj4+DQo+Pj4N
Cj4+Pj4NCj4+Pj4gQSBjaGFuZ2Ugd2FzIHN1Z2dlc3RlZCBkdXJpbmcgcmV2aWV3aW5nIENETlNQ
IGRyaXZlciBieSBDaHVuZmVuZyBZdW4uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFBhd2Vs
IExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2ZXJz
L3VzYi9jZG5zMy9jb3JlLmMgfCA0ICsrLS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2NkbnMzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+PiBpbmRl
eCBhMGY3M2Q0NzExYWUuLmEzZjZkYzQ0Y2YzYSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy91
c2IvY2RuczMvY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+
PiBAQCAtNDY1LDcgKzQ2NSw3IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4+Pj4NCj4+Pj4gICAgCWNkbnMtPnhoY2lfcmVzWzFdID0gKnJl
czsNCj4+Pj4NCj4+Pj4gLQljZG5zLT5kZXZfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUo
cGRldiwgInBlcmlwaGVyYWwiKTsNCj4+Pj4gKwljZG5zLT5kZXZfaXJxID0gcGxhdGZvcm1fZ2V0
X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgInBlcmlwaGVyYWwiKTsNCj4+Pg0KPj4+IEFzIHBl
ciBEVCBiaW5kaW5nIGRvY3VtZW50LCB0aGVzZSBhcmUgbWFuZGF0b3J5IHByb3BlcnRpZXMNCj4+
DQo+PiBJIHRoaW5rIHRoYXQgbmFtZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbCBp
cyBsaXR0bGUgY29uZnVzaW5nLg0KPj4gRnVuY3Rpb24gZGVzY3JpcHRpb25zIHNob3cgdGhhdCBi
b3RoIGFyZSBhbG1vc3QgaWRlbnRpY2FsOg0KPj4gLyoqDQo+PiAgICogcGxhdGZvcm1fZ2V0X2ly
cV9ieW5hbWVfb3B0aW9uYWwgLSBnZXQgYW4gb3B0aW9uYWwgSVJRIGZvciBhIGRldmljZSBieSBu
YW1lDQo+PiAgICogQGRldjogcGxhdGZvcm0gZGV2aWNlDQo+PiAgICogQG5hbWU6IElSUSBuYW1l
DQo+PiAgICoNCj4+ICAgKiBHZXQgYW4gb3B0aW9uYWwgSVJRIGJ5IG5hbWUgbGlrZSBwbGF0Zm9y
bV9nZXRfaXJxX2J5bmFtZSgpLiBFeGNlcHQgdGhhdCBpdA0KPj4gICAqIGRvZXMgbm90IHByaW50
IGFuIGVycm9yIG1lc3NhZ2UgaWYgYW4gSVJRIGNhbiBub3QgYmUgb2J0YWluZWQuDQo+PiAgICoN
Cj4+ICAgKiBSZXR1cm46IG5vbi16ZXJvIElSUSBudW1iZXIgb24gc3VjY2VzcywgbmVnYXRpdmUg
ZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+PiAgICovDQo+Pg0KPj4+DQo+Pj4gICAtIGludGVy
cnVwdHM6IEludGVycnVwdHMgdXNlZCBieSBjZG5zMyBjb250cm9sbGVyOg0KPj4+ICAgICAgICAg
ICJob3N0IiAtIGludGVycnVwdCB1c2VkIGJ5IFhIQ0kgZHJpdmVyLg0KPj4+ICAgICAgICAgICJw
ZXJpcGhlcmFsIiAtIGludGVycnVwdCB1c2VkIGJ5IGRldmljZSBkcml2ZXINCj4+PiAgICAgICAg
ICAib3RnIiAtIGludGVycnVwdCB1c2VkIGJ5IERSRC9PVEcgIHBhcnQgb2YgZHJpdmVyDQo+Pj4N
Cj4+PiBmb3IgZHJfbW9kZSA9PSAib3RnIiAtPiBhbGwgMyBhcmUgbWFuZGF0b3J5Lg0KPj4+IGZv
ciBkcl9tb2RlID09ICJob3N0IiAtPiAib3RnIiBhbmQgInBlcmlwaGVyYWwiIElSUXMgYXJlIG5v
dCByZXF1aXJlZC4NCj4+PiBmb3IgZHJfbW9kZSA9PSAicGVyaXBoZWFyYWwiIC0+ICJvdGciIGFu
ZCAiaG9zdCIgSVJRcyBhcmUgbm90IHJlcXVpcmVkLg0KPj4+DQo+Pj4+ICAgIAlpZiAoY2Rucy0+
ZGV2X2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4+PiAgICAJCXJldHVybiBjZG5zLT5kZXZfaXJx
Ow0KPj4+Pg0KPj4+PiBAQCAtNDc3LDcgKzQ3Nyw3IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+Pj4gICAgCQlyZXR1cm4gUFRSX0VSUihy
ZWdzKTsNCj4+Pj4gICAgCWNkbnMtPmRldl9yZWdzCT0gcmVnczsNCj4+Pj4NCj4+Pj4gLQljZG5z
LT5vdGdfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgIm90ZyIpOw0KPj4+PiAr
CWNkbnMtPm90Z19pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAi
b3RnIik7DQo+Pj4+ICAgIAlpZiAoY2Rucy0+b3RnX2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4+
PiAgICAJCXJldHVybiBjZG5zLT5vdGdfaXJxOw0KPj4+Pg0KPj4+Pg0KPj4+DQo+Pg0KPj4gUmVn
YXJkcywNCj4+IFBhd2VsDQo+Pg0KPg0KPi0tDQo+VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBP
eSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuDQo+WS10dW5udXMvQnVzaW5lc3Mg
SUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg==
