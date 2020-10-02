Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEC280F88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgJBJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:08:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:17252 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgJBJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:08:45 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09296nvL012077;
        Fri, 2 Oct 2020 02:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Dp/hjLiK+wAD1zl98fUPXu4CaIyODvgpLxnH+fWE4Ss=;
 b=XFyyZnjFCIiJSKQc/IT0LIN7NZ9o0cSuYmdm1+MzVDwTArh4PjdNzIRPj/iQyntMVhwu
 esaWBPenEgCVkp+iZwsNNEGDprh2axcrGOOY7mqeTMIjpstbO1HYGUwPnHBFaZPlxySi
 +uZkoO8ikWSjk+K9KW2zrezHjOqsgvPXAtWNySljRQEB0J0wT+/62f5/b2HPMLdC3oot
 yj1vrAFhWgX7nkqmtgz6Dyqa+zvBG1fDerfjo83JrJjnuVXfl+WSKwZbqZZJWNanIUZ7
 VkIv0jHXmMq63kez2FqqXzi/qf63b6nQjtAQBIugJKqUEozGEs8BFpElYnHseEqzxrTN 0g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33t26xy1v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 02:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UozoVunRN8T2YacofgOvLpSD6FPxcYiCuJi0Wtun/v//ubhz19iMf1aMNq2XB5F0IcL8WM3siHaztBFrwnVRdmCpqXQmUlJ1q4xqUnDLnmx7WFJ1V9G6GAQRMcZp/CKWurqjPrWlSVUlckbYcZqF5/n5BOgqe8y55OqA7yzN7DOalK3GpiBIFcTBEIOk6OxoAfs10eviGY6g96O/ZYnwc+u0LwF4F5FSMZm99qtHbJwLxajOvpNiAaPEokKJghCsxyfYjMrF8PQB7EuQjxHbn0g3F6wFUAEGBvPEcKdTmREael6lCGd+WceBP/n8DDOIZ5ZyZNj2YIahqIK9o4G6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp/hjLiK+wAD1zl98fUPXu4CaIyODvgpLxnH+fWE4Ss=;
 b=YCu+H6xL/e7HQsTAfiG+8Td+GctY+XZtxEIzDUTHJ3C+gAufoijT0H7pq67Nw47iqK0B9y9hpgzyVwqVagY1NCWCKyisYwLzzRWyWKHIJ5AFj5CecmT/5UvW1LFfnH+pgew8nfjuXzCl4PHKr3jnZkIHMztCInrMDSC1q3MElBq1Yc/0mN0FidiBQRHCmEX+vJZ7VkNcndMhAe4UAw9XpEoBqlGIe3DDqSNGdcYj+KKr183DysJ8/gYY/z489/a3szVEEKG4xkOizbrAQJEs3SjHgLqjGtpH7qLKDAT2n8QTHAtHoGBlPghLwM3AxQtQFG4wgyAa8FyAzLgvpU6w7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp/hjLiK+wAD1zl98fUPXu4CaIyODvgpLxnH+fWE4Ss=;
 b=2WT99eQo8/AVzisQNuiC4l3hj92ctM2eIztW8t09PLmogA6atvlsohIl7zclonbsIzoM0uHClL3vvFAty9Uh4B9keCKHBgHvfErrPu+MmPsG7yVNrfOlxOHtLsF3sQ74mikZI1vto5Daw9Z0y+ZdsOL1qC7CBkPxC7vGWB0hKMg=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5099.namprd07.prod.outlook.com (2603:10b6:5:4b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Fri, 2 Oct 2020 09:08:36 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.037; Fri, 2 Oct 2020
 09:08:35 +0000
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
Thread-Index: AQHWlvch/Roy1G/8IkO8ykqpdGeiF6mEBTKAgAAA+RA=
Date:   Fri, 2 Oct 2020 09:08:35 +0000
Message-ID: <DM6PR07MB5529095F1B656C5065CBA8B4DD310@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200930065758.23740-1-pawell@cadence.com>
 <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
In-Reply-To: <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDc5NjAwYjQtMDQ4ZS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQ3OTYwMGI1LTA0OGUtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjgwOCIgdD0iMTMyNDYxMDMzMTI0MzE5Njk2IiBoPSJWaFhSVkRXRHhILy8xeHBZTHZXWVlDWXJZZ009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af1ccfde-9e66-4176-14d4-08d866b2be7f
x-ms-traffictypediagnostic: DM6PR07MB5099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB5099018200FD7E5F5719790DDD310@DM6PR07MB5099.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUeOondZnJn6DNPhx3+4lRXSU/m0UhDokeR/T7+e5zfqnHp8LEjMnu3MqCGyVxldKX7fHLnt5U4ep+LyFHSSrqmB92gzWNXtDy0ezCvGL4LxP9gSacCJJzjSBd3ijbdsmPwg/xx/eFYiw71xOhuL978vcM6Sqxqi7uQqaX9YLG64Xo5V0VFy1B6wLvdNs3zf7IsfrFjxDTcVlTO7nStThCpsjoWOj4HzFVhRybUd033+Vwgx0rEY7xh4UOCgpCLBH6Z9QBxgqjtyJ/j9gwayHxk+3/zBGB6T2lCgetMK3vYkdOORUi9hGUoK9i8ETJ5fBqQ3ARMyOaKqwyAeC/MJoee2J4JWZWgGQpSkGZ7THblCizufKKpUOuWxpECDMd5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(36092001)(110136005)(316002)(54906003)(52536014)(5660300002)(8676002)(186003)(26005)(2906002)(86362001)(107886003)(6506007)(66446008)(66556008)(66476007)(64756008)(55016002)(76116006)(66946007)(9686003)(478600001)(8936002)(33656002)(4326008)(83380400001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KFfZMzx4nrXDv6XNE7DKn8yDkZb59OhvbBJRk8uoVmL89YQ6PL/5TfD6TQMCIwDpClcn8z6NvZypFjnMQS3OjeNECGbzTggtO174iAtYB2UzOAMdC8aN5OVGjJY3Y1TYdTsJ19AIxWZSL+c0/HM8rV6d8vobxz8Btl4UIYMvdJqS+tyBgydLPXKgZdDqDekYjMAZFMZgFyifrG7PUxfB8adT6cmaBqrgqexBX9IsAt3mzdkpSQLRwq9GO9Vgn3C01y2rwrD87kaQyyrsUWB6ca4ExCwHb2N77odBbJqwHXQ4taNP8sBVyLCV12mRpIIPb9VjdczgirP7uM3jktV7lST5/9UDXdr+9BgqtAYf2/0ov8kPU1LN0Of/tEOvPcEVLDeqW/qr2UqvaUJ43kNxF54Onrjlr2wdC8/679R0RTTN6V2V3j6NgdF86PuXCBsx8M2DbwkpwAf5RpeE/WTIcwxNo/ifgm5PPHkdB5t4O9YIHN49SjBopKIrJMgoiw/z/+lCcd8nnvpMkVeG0oahmTCzWrlUOazbKSVDlt6DoD5ZUE9UKgdD9sr6iWqM8P0ButMrNFKxPJoZTjWTwcJMJ6vBHhY9NW9ongQZQ2Ngp9pRubj+XXMexTdSkfa7/y0LBJAh46D2g/0Jw1xhNRBkLg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1ccfde-9e66-4176-14d4-08d866b2be7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 09:08:35.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: th4cggtdHedjsEEbu+xiOcJ5KOZfsjP1+uWmUpWtn8SvTQoQqmVYGMxpTsAhRCFmPzKPrariMmVpkxYBmkXNVn1OVlnwglELHUzsWGrwyVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5099
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_05:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=406
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9nZXIsDQoNCj4NCj5PbiAzMC8wOS8yMDIwIDA5OjU3LCBQYXdlbCBMYXN6Y3phayB3cm90ZToN
Cj4+IFRvIGF2b2lkIGR1cGxpY2F0ZSBlcnJvciBpbmZvcm1hdGlvbiBwYXRjaCByZXBsYWNlcyBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZQ0KPj4gaW50byBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9v
cHRpb25hbC4NCj4NCj5XaGF0IGlzIGR1cGxpY2F0ZSBlcnJvciBpbmZvcm1hdGlvbj8NCg0KVGhl
IGZ1bmN0aW9uIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lIHByaW50Og0KIiBkZXZfZXJyKCZkZXYt
PmRldiwgIklSUSAlcyBub3QgZm91bmRcbiIsIG5hbWUpOyIgaWYgZXJyb3Igb2NjdXJyZWQuIA0K
DQpJbiBjb3JlLmMgd2UgaGF2ZSB0aGUgYW5vdGhlciBlcnJvciBtZXNzYWdlIGJlbG93IGludm9r
aW5nIHRoaXMgZnVuY3Rpb24uDQplLmcgDQoJaWYgKGNkbnMtPmRldl9pcnEgPCAwKQ0KCQlkZXZf
ZXJyKGRldiwgImNvdWxkbid0IGdldCBwZXJpcGhlcmFsIGlycVxuIik7DQoNClNvLCBpdCdzIGxv
b2tzIGxpa2Ugb25lIGRldl9lcnIgaXMgIHJlZHVuZGFudC4NCg0KPg0KPj4NCj4+IEEgY2hhbmdl
IHdhcyBzdWdnZXN0ZWQgZHVyaW5nIHJldmlld2luZyBDRE5TUCBkcml2ZXIgYnkgQ2h1bmZlbmcg
WXVuLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5j
ZS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvY2RuczMvY29yZS5jIHwgNCArKy0tDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2Nk
bnMzL2NvcmUuYw0KPj4gaW5kZXggYTBmNzNkNDcxMWFlLi5hM2Y2ZGM0NGNmM2EgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2Nk
bnMzL2NvcmUuYw0KPj4gQEAgLTQ2NSw3ICs0NjUsNyBAQCBzdGF0aWMgaW50IGNkbnMzX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pg0KPj4gICAJY2Rucy0+eGhjaV9yZXNb
MV0gPSAqcmVzOw0KPj4NCj4+IC0JY2Rucy0+ZGV2X2lycSA9IHBsYXRmb3JtX2dldF9pcnFfYnlu
YW1lKHBkZXYsICJwZXJpcGhlcmFsIik7DQo+PiArCWNkbnMtPmRldl9pcnEgPSBwbGF0Zm9ybV9n
ZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAicGVyaXBoZXJhbCIpOw0KPg0KPkFzIHBlciBE
VCBiaW5kaW5nIGRvY3VtZW50LCB0aGVzZSBhcmUgbWFuZGF0b3J5IHByb3BlcnRpZXMNCg0KSSB0
aGluayB0aGF0IG5hbWUgcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwgaXMgbGl0dGxl
IGNvbmZ1c2luZy4gDQpGdW5jdGlvbiBkZXNjcmlwdGlvbnMgc2hvdyB0aGF0IGJvdGggYXJlIGFs
bW9zdCBpZGVudGljYWw6DQovKioNCiAqIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFs
IC0gZ2V0IGFuIG9wdGlvbmFsIElSUSBmb3IgYSBkZXZpY2UgYnkgbmFtZQ0KICogQGRldjogcGxh
dGZvcm0gZGV2aWNlDQogKiBAbmFtZTogSVJRIG5hbWUNCiAqDQogKiBHZXQgYW4gb3B0aW9uYWwg
SVJRIGJ5IG5hbWUgbGlrZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgpLiBFeGNlcHQgdGhhdCBp
dA0KICogZG9lcyBub3QgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZSBpZiBhbiBJUlEgY2FuIG5vdCBi
ZSBvYnRhaW5lZC4NCiAqDQogKiBSZXR1cm46IG5vbi16ZXJvIElSUSBudW1iZXIgb24gc3VjY2Vz
cywgbmVnYXRpdmUgZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQogKi8NCg0KPg0KPiAgLSBpbnRl
cnJ1cHRzOiBJbnRlcnJ1cHRzIHVzZWQgYnkgY2RuczMgY29udHJvbGxlcjoNCj4gICAgICAgICAi
aG9zdCIgLSBpbnRlcnJ1cHQgdXNlZCBieSBYSENJIGRyaXZlci4NCj4gICAgICAgICAicGVyaXBo
ZXJhbCIgLSBpbnRlcnJ1cHQgdXNlZCBieSBkZXZpY2UgZHJpdmVyDQo+ICAgICAgICAgIm90ZyIg
LSBpbnRlcnJ1cHQgdXNlZCBieSBEUkQvT1RHICBwYXJ0IG9mIGRyaXZlcg0KPg0KPmZvciBkcl9t
b2RlID09ICJvdGciIC0+IGFsbCAzIGFyZSBtYW5kYXRvcnkuDQo+Zm9yIGRyX21vZGUgPT0gImhv
c3QiIC0+ICJvdGciIGFuZCAicGVyaXBoZXJhbCIgSVJRcyBhcmUgbm90IHJlcXVpcmVkLg0KPmZv
ciBkcl9tb2RlID09ICJwZXJpcGhlYXJhbCIgLT4gIm90ZyIgYW5kICJob3N0IiBJUlFzIGFyZSBu
b3QgcmVxdWlyZWQuDQo+DQo+PiAgIAlpZiAoY2Rucy0+ZGV2X2lycSA9PSAtRVBST0JFX0RFRkVS
KQ0KPj4gICAJCXJldHVybiBjZG5zLT5kZXZfaXJxOw0KPj4NCj4+IEBAIC00NzcsNyArNDc3LDcg
QEAgc3RhdGljIGludCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
Pj4gICAJCXJldHVybiBQVFJfRVJSKHJlZ3MpOw0KPj4gICAJY2Rucy0+ZGV2X3JlZ3MJPSByZWdz
Ow0KPj4NCj4+IC0JY2Rucy0+b3RnX2lycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBkZXYs
ICJvdGciKTsNCj4+ICsJY2Rucy0+b3RnX2lycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29w
dGlvbmFsKHBkZXYsICJvdGciKTsNCj4+ICAgCWlmIChjZG5zLT5vdGdfaXJxID09IC1FUFJPQkVf
REVGRVIpDQo+PiAgIAkJcmV0dXJuIGNkbnMtPm90Z19pcnE7DQo+Pg0KPj4NCj4NCg0KUmVnYXJk
cywNClBhd2VsDQo=
