Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4222C3D87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgKYKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:14:56 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbgKYKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:14:55 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0APA7Ut4022286;
        Wed, 25 Nov 2020 02:14:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=UPgsQ04OoYGmWu1ZXJQm/Pcb2r6xM4BJbvLztUmLN5k=;
 b=kMeNMTRZ0KjxkQfm+TZ6+DJDOo1TUzUbPWizVrn6ZQZADvw58sp8OPdLNOzr+/s9eZ4S
 UOszyCMwT6W7U+w+asqxkN5wYU0EM5aLkFVad82nXMjRuAUgfeDdcG48ymJq5R/07gEc
 8MIAmJx+KENzUZe6rq8mYQbR+XfRJBon/n/ZdsMmjatzueMfbjeKzIrLrDV4PngSMH5L
 89TZm1Vmq8c6iCZPV7gOezihQClq4/lZU7g3IIyVQ9IPndg4PvuZTUDxr2bORtgyPyBm
 Od8HXJzPqQnljp+P5wNtifbTczLFPbxA5uQ9f4zw+gItjMuWrwibE3ts7jHhh7odQ66h +w== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34y0b0732t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 02:14:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5hdb5fs28sXPjOtMPkXhvOZBRBDiCdMOWN/xDKTAEWdxSCllh4lS7PLdd9k00hjqvtyPDcMNyMUdlL/Kutv3RLucpLZPyOgk4Zw7M/rRrspxDIOPEVBediegtCJUud0KOsfyA7Zy/21jpXYkLawZ2M9HBkw4paMNL72e5CXcVwHW7KmwS9eXqFDe+siFqUSeRmfI6G5QY+Z2pMcg+wlXaUUJ0CoMiTk+dK8go+uywdvrviMa0Tj+e/Moh3r4pGS1jdkREHhA10viW7yQyxM2XvROlpOyG7e0mmKtbx7kfoknqTRVJODgtbLiB+ep/zKNvC//+KUozCCuC8IKTeTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPgsQ04OoYGmWu1ZXJQm/Pcb2r6xM4BJbvLztUmLN5k=;
 b=LjPZ7QSWTLaMauLscyNEfSXjs20IT/uUoN13bBxx9c1EHro3VIAsoLr+mSlyxnJfy3s4Mi+OrFjEn9STspAwYJ/8rpQZoUKTjZBhet0mKPu3PHssmG/xC+hycPKxi0g7f0sp3CVTd/ZQh/nOqm8q63hLyLE+nrttLhNrWLPaMGLJ4PzeclmAwsPdPq0qupNbh5dHjRg79mEKyyQCPsbRI0mqMUSPdRy90qe+jSLaENeSUPOUg+aUMnxdxr1EiiH1XQzgD4Yi2waj/bABMxHmVh50yk6qCVP5VjSG4qWuqcirHC7Rr+dHgu1NDf3jubkJsZz3kGwXI0/FsdUdlGoNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPgsQ04OoYGmWu1ZXJQm/Pcb2r6xM4BJbvLztUmLN5k=;
 b=SNN8rIn5JesJRzr9niVE8RYuM+bRJMetqdXG+dTwKyn7eJdMZfR0FQLXndoR8krZoczjuhgYWEi14TFlVrMvmt0QtG8AA1auu9DJdZpq50nhWu1v7itrDiI6FD4wMdpD4KZ3DKrhtdnlLpnHyZUK4wrd9T6ih/iSy7YzyMbQ3Dc=
Received: from BL0PR07MB5522.namprd07.prod.outlook.com (2603:10b6:208:37::25)
 by MN2PR07MB6957.namprd07.prod.outlook.com (2603:10b6:208:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Wed, 25 Nov
 2020 10:14:19 +0000
Received: from BL0PR07MB5522.namprd07.prod.outlook.com
 ([fe80::ec07:8b80:7e3d:ac7a]) by BL0PR07MB5522.namprd07.prod.outlook.com
 ([fe80::ec07:8b80:7e3d:ac7a%7]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 10:14:18 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>, Peter Chen <peter.chen@nxp.com>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Topic: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Index: AQHWwY7o3xLxWz8XAEqAevblF5S1PqnW1woAgAAxNYCAAAUmgIAACgIAgAAUkACAAAnZgIAAzQ2AgACbZ4CAAALfYA==
Date:   Wed, 25 Nov 2020 10:14:18 +0000
Message-ID: <BL0PR07MB5522137CC3544C2706187B55DDFA0@BL0PR07MB5522.namprd07.prod.outlook.com>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
 <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
 <20201124114641.GA9929@b29397-desktop>
 <1c4fb95a-97b7-9022-7062-8fafcfe42c3d@ti.com>
 <20201125003550.GB9929@b29397-desktop>
 <f74b3c57-a9f1-2f5f-119c-a52ce9ba2f70@ti.com>
In-Reply-To: <f74b3c57-a9f1-2f5f-119c-a52ce9ba2f70@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjg5YzQ2NzctMmYwNi0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGY4OWM0Njc5LTJmMDYtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iNTg4NSIgdD0iMTMyNTA3NzI4NTYyNDU2OTAzIiBoPSJRTit1ZUoydXNmSldxTG85d0hPK2x4SFdSUkk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0baa9d7-fa77-4bf4-5040-08d8912adf03
x-ms-traffictypediagnostic: MN2PR07MB6957:
x-microsoft-antispam-prvs: <MN2PR07MB6957BE16C9163FCC6D3FE78EDDFA0@MN2PR07MB6957.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fz0unmQCXXmr0a++Q/QhYJBtnKYB5MKVTZ1LKRb8BNoL9m82SwsXq6dIbgnIT2wu4oMkEyxvqqLMQXI8u4jXF1EsUDJAlaNiveYeKNOqwK0pnbRBYFmjhxIoUb3c5fgw78Zk1xh+TVmTwh0d61cuwfxhBsPzhf5ArcZgumkkdqWm/SIXlAd8ZKh+2d/zDkud+8jKeafv3ccA3EQUec55w7qZSPgEnZGr8QSvhDlzm+1qtinojG09nPWetrV+p6VrEVXjNCm70hBEdboRmsGK7UGSUROgxqM583lPJ2g2mKilyGaiEVazBV5setiNnI00HuAbXz3zRVzfkMHsa7mchkqME8iCdCvI4LIg/PziHUAdACZ+yHcEwc6FaaRWG4Gb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR07MB5522.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(36092001)(316002)(4326008)(66946007)(64756008)(186003)(54906003)(86362001)(71200400001)(66446008)(66556008)(6506007)(33656002)(110136005)(83380400001)(66476007)(9686003)(55016002)(8936002)(8676002)(53546011)(2906002)(26005)(478600001)(52536014)(5660300002)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b3A3UmxWSzFibjlyU00yWFNmSUErMXNaOWlzUlRpbzNxcmlKMlNBK1krRXE4?=
 =?utf-8?B?Q3NiNVhXdkY4d2RlN2lHOEN2L1dvVGdoVEg0TEtoQXQrUFl4UGJsQkRUSC9t?=
 =?utf-8?B?eEhnTmVFbEJHVlBURER4c3F4UTVqRzkyWVIzS0E0c3VJcE5LQnNxQkd6YUxE?=
 =?utf-8?B?RWJZMURwdW9rbFFYNGhka2tOMVlnVnZYNkhZaVZBNVJHZi85VkNrdHQrYkx2?=
 =?utf-8?B?VlNwY2V4TzQ2dUp4MjErSm5vS29KTTcwM3lrWjhSZkF4OFp6dllBeDFEemow?=
 =?utf-8?B?NDRFeGZzZEozZzF6cVNlQXJKMDFDQy9VMXN5QXI2RkUwQmpzN3Nwc3dDQ0RQ?=
 =?utf-8?B?UEdQdEE1dGV1SWhmRndkUEo3dTEvdEdIbE1WOVVNakdreVhObmJPNk12WW5Y?=
 =?utf-8?B?MXZtKy9QUGQxTmdpd2FEbno0U3FVY2d3QWRSQkxTSjBzOHdXZzFOYWpHL0ZW?=
 =?utf-8?B?eU1YanNxMDhUWVhrQk1XWjl2NGhINXdSVC9OY1ZFWDc2OHhPdzdMOUFYMVgy?=
 =?utf-8?B?ZEJwa1A0bVYyWHdWMWU2U0QxQk5takdMM1JaOVBJNXV4VE9BWHVwbjZub0NF?=
 =?utf-8?B?RTYrTERBNmlHeHZpNFcrbStIblhWZVRzS1JjNGwrcFdvZ0lmNitJUE1nV0Ro?=
 =?utf-8?B?dFdsZGw4cU05WC8vMlBoa0xQS2l0S2hqNUtQZkNOVkxWS0U3U1JkR0pBN3c1?=
 =?utf-8?B?cVR0T1BwcytrbHVHZStVb05GZlU0amVRK245ZDdTT1N6M004azJlTjM2cG1W?=
 =?utf-8?B?V0tmK0Y3cXNIdnRHNGRlTjl1ZTRBSHdYTHNRTmZBcUdINkJ2R3IwMnE0enBU?=
 =?utf-8?B?ajNMRjkzZVdyWjBUMDB3bmV5dCtlbGYwWFVzdExYN1FnZEVLbGdLZzFyeCtK?=
 =?utf-8?B?NFlYTTluNmRCMW01MTZyM28xMENOdlpuN3U0VDVUd2tTQnRQMzRJK2F0M2Jz?=
 =?utf-8?B?L1dzenYvMDk4eU9Kd1J1NE1IcEMybTlSNmF2MWFqUXl3OHNOTVRVYkprTURK?=
 =?utf-8?B?Q1FYR3lHM2Fza2JVQVBSWC9GQkxpS2hRdVVMckdqZU5XTGZBSVFmTlY1L3BM?=
 =?utf-8?B?K1hwWWpLY00rcEdHQWNvQnIyUzJwZGtQbUNNT2IwalBBTW55NmF4MEhoejZx?=
 =?utf-8?B?R21QT0FoSWxkdUZidU5TdUFuRm42ZlRPeVBIYVB1dktPdmNLMVJTUVBRWm5D?=
 =?utf-8?B?QnZOR2V3dzg3MDBLYitXSDZiMUt2b2lFVXllTFBJZTNVbVlORDEwV0xjM3c1?=
 =?utf-8?B?Q2sxREpyZHFxdktGcXN1V1lldmtNRk1OM2VCdUw4YStUbWZkMkFhYmYwZTY4?=
 =?utf-8?Q?a+K42y9FdYmt8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR07MB5522.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0baa9d7-fa77-4bf4-5040-08d8912adf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 10:14:18.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZOdG2XnUhvz9sYcNuDx4cqk/H3NjJ9uctG2y798v8UQrDTajxOoSsFm/dU/X1LArD21ohZ1lMyDqk6c7p+es+TGwh/WMXMyMZAv44StFbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6957
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_06:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011250061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIDI1LzExLzIwMjAgMDI6MzYsIFBldGVyIENoZW4gd3JvdGU6DQo+PiBPbiAyMC0xMS0y
NCAxNDoyMjoyNSwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4+PiBQZXRlciwNCj4+Pg0KPj4+IE9u
IDI0LzExLzIwMjAgMTM6NDcsIFBldGVyIENoZW4gd3JvdGU6DQo+Pj4+IE9uIDIwLTExLTI0IDEy
OjMzOjM0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgYW0gc29y
cnkgYWJvdXQgdGhhdC4gRG8geW91IHVzZSByb2xlIHN3aXRjaCAvc3lzIGVudHJ5LCBpZiB5b3Ug
aGF2ZQ0KPj4+Pj4+Pj4gdXNlZCwgSSBwcmVmZXIgdXNpbmcgInVzYi1yb2xlLXN3aXRjaCIgcHJv
cGVydHkgYXQgZHRzIHRvIGp1ZGdlIGlmIFNvQw0KPj4+Pj4+Pj4gT1RHIHNpZ25hbHMgb3IgZXh0
ZXJuYWwgc2lnbmFscyBmb3Igcm9sZSBzd2l0Y2guIElmIHlvdSBoYXZlIG5vdCB1c2VkDQo+Pj4+
Pj4+PiBpdCwgSSBwcmVmZXIgb25seSBzZXR0aW5nIGNkbnMtPnJvbGVfc3cgZm9yIHJvbGUgc3dp
dGNoIHVzZSBjYXNlcy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFdlIHVzZSBib3RoIGhh
cmR3YXJlIHJvbGUgc3dpdGNoIGFuZCAvc3lzIGVudHJpZXMgZm9yIG1hbnVhbGx5IGZvcmNpbmcg
YQ0KPj4+Pj4+PiBjZXJ0YWluIHJvbGUuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFdlIGRvIG5vdCBzZXQg
YW55ICJ1c2Itcm9sZS1zd2l0Y2giIHByb3BlcnR5IGF0IERUUy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
Q3VycmVudGx5IGNkbnMtPnJvbGVfc3cgaXMgYmVpbmcgYWx3YXlzIHNldCBieSBkcml2ZXIgaXJy
ZXNwZWN0aXZlIG9mIGFueSBEVA0KPj4+Pj4+PiBwcm9wZXJ0eSwgc28gdGhpcyBwYXRjaCBpcyBj
bGVhcmx5IHdyb25nIGFuZCBuZWVkcyB0byBiZSByZXZlcnRlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
V2hhdCBkbyB5b3UgdGhpbms/DQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBDb3VsZCB5b3UgYWNj
ZXB0IGJlbG93IGZpeD8NCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9j
ZG5zMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+Pj4+PiBpbmRleCAyZTQ2
OTEzOTc2OWYuLmZkZDUyZTg3YTdiMiAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9j
ZG5zMy9jb3JlLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+Pj4+
PiBAQCAtMjgwLDggKzI4MCw4IEBAIGludCBjZG5zM19od19yb2xlX3N3aXRjaChzdHJ1Y3QgY2Ru
czMgKmNkbnMpDQo+Pj4+Pj4gICAgICAgICAgICBlbnVtIHVzYl9yb2xlIHJlYWxfcm9sZSwgY3Vy
cmVudF9yb2xlOw0KPj4+Pj4+ICAgICAgICAgICAgaW50IHJldCA9IDA7DQo+Pj4+Pj4NCj4+Pj4+
PiAtICAgICAgIC8qIERlcGVuZHMgb24gcm9sZSBzd2l0Y2ggY2xhc3MgKi8NCj4+Pj4+PiAtICAg
ICAgIGlmIChjZG5zLT5yb2xlX3N3KQ0KPj4+Pj4+ICsgICAgICAgLyogcXVpdCBpZiBzd2l0Y2gg
cm9sZSB0aHJvdWdoIGV4dGVybmFsIHNpZ25hbHMgKi8NCj4+Pj4+PiArICAgICAgIGlmIChkZXZp
Y2VfcHJvcGVydHlfcmVhZF9ib29sKGNkbnMtPmRldiwgInVzYi1yb2xlLXN3aXRjaCIpKQ0KPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAg
ICAgcG1fcnVudGltZV9nZXRfc3luYyhjZG5zLT5kZXYpOw0KPj4+Pj4NCj4+Pj4+IEFsdGhvdWdo
IHRoaXMgd2lsbCBmaXggdGhlIGlzc3VlIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBtYWtpbmcgdGhl
IGRyaXZlciB0byBiZWhhdmUNCj4+Pj4+IGFzIGV4cGVjdGVkIHdpdGggdXNiLXJvbGUtc3dpdGNo
IHByb3BlcnR5Lg0KPj4+Pj4NCj4+Pj4+IE5vdywgZXZlbiBpZiB1c2Itcm9sZS1zd2l0Y2ggcHJv
cGVydHkgaXMgbm90IHByZXNlbnQgdGhlIGRyaXZlciB3aWxsIHN0aWxsIHJlZ2lzdGVyDQo+Pj4+
PiB0aGUgcm9sZSBzd2l0Y2ggZHJpdmVyLg0KPj4+Pj4NCj4+Pj4+IEkgdGhpbmsgd2UgbmVlZCB0
byByZWdpc3RlciB0aGUgcm9sZSBzd2l0Y2ggZHJpdmVyIG9ubHkgaWYgdXNiLXJvbGUtc3dpdGNo
IHByb3BlcnR5DQo+Pj4+PiBpcyBwcmVzZW50LiBXZSB3b3VsZCBhbHNvIG5lZWQgdG8gc2V0IHRo
ZSBkZWZhdWx0IHJvbGUgaWYgcm9sZS1zd2l0Y2gtZGVmYXVsdC1tb2RlIGlzIHByZXNlbnQuDQo+
Pj4+Pg0KPj4+Pj4gSG93IGFib3V0IHRoZSBmb2xsb3dpbmc/IEl0IHN0aWxsIGRvZXNuJ3QgaGFu
ZGxlIHJvbGUtc3dpdGNoLWRlZmF1bHQtbW9kZSBwcm9wZXJ0eSB0aG91Z2guDQo+Pj4+Pg0KPj4+
Pg0KPj4+PiBSb2dlciwgeW91IHNhaWQgeW91IGFsc28gdXNlIC9zeXMgZW50cmllcyAoSSBzdXBw
b3NlIGl0IG1lYW5zIHRocm91Z2ggcm9sZQ0KPj4+PiBzd2l0Y2ggY2xhc3MpIHRvIGRvIHJvbGUg
c3dpdGNoLCB3aXRoIHlvdXIgY2hhbmdlLCB0aGVyZSB3aWxsIGJlIG5vIC9zeXMNCj4+Pj4gZW50
cnkgZm9yIHJvbGUgc3dpdGNoLg0KPj4+DQo+Pj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uIEFs
dGhvdWdoIHdlIGRvIG5lZWQgYm90aCBmZWF0dXJlcyAoU1cgcm9sZSBzd2l0Y2ggKyBIVyByb2xl
IHN3aXRjaCkNCj4+PiBJIGRvbid0IHRoaW5rIGl0IGlzIHJlcXVpcmVkIHRvIG9wZXJhdGUgc2lt
dWx0YW5lb3VzbHkuIElmIHVzZXJzIG5lZWQgU1cgY29udHJvbCB0aGV5IGNhbiBzZXQgdGhlIERU
IGZsYWcuDQo+Pj4NCj4+DQo+PiBJIHNlZS4gSSBwcmVmZXIgZW1icmFjaW5nIGFsbCB0aGluZ3Mg
cmVsYXRlZCB0byByb2xlIHN3aXRjaCB1bmRlciB0aGUNCj4+IGZpcm13YXJlIGVudHJ5IGNvbmRp
dGlvbi4gQmVzaWRlcywgSSBmaW5kIGFub3RoZXIgaXNzdWUgdGhhdCBkZXZtX3JlcXVlc3RfaXJx
DQo+PiBmb3Igd2FrZXVwX2lycSBkb2VzIG5vdCBjYWxsIHVzYl9yb2xlX3N3aXRjaF91bnJlZ2lz
dGVyIGlmIGl0IGhhcw0KPj4gZmFpbGVkLiBTbywgcHJvYmFibHksIHR3byBwYXRjaGVzIGFyZSBu
ZWVkZWQuIEkgYW0gT0sgeW91IHNlbmQgdGhlDQo+PiBwYXRjaGVzIHRvIGZpeCBib3RoLg0KPg0K
PlBhd2VsLCBjYW4geW91IHBsZWFzZSBjb25maXJtIHRoYXQgaWYgeW91IGFyZSBvayB3aXRoIGVp
dGhlciBoL3cgcm9sZSBzd2l0Y2hpbmcNCj5vciBzL3cgcm9sZSBzd2l0Y2hpbmcgYnV0IG5vdCBi
b3RoIHdvcmtpbmcgYXQgdGhlIHNhbWUgdGltZT8NCj4NCj5JdCB3b3VsZCBoYXZlIGJlZW4gbmlj
ZSBieSB1c2VyIHRvIHRvIGtub3cgdGhlIGN1cnJlbnQgcm9sZSBldmVuIGZvciBoL3cgYmFzZWQN
Cj5zd2l0aGNpbmcgYnV0IGl0IGxvb2tzIGxpa2Ugbm93IHRoYXQgd29uJ3QgYmUgcG9zc2libGUu
DQoNCkZvciB0aGUgbW9tZW50IGl0J3Mgb2sgZm9yIG1lLCBidXQgZm9ybSB0ZXN0aW5nIHBvaW50
IG9mIHZpZXcgaXQgY291bGQgYmUgbmljZQ0KdG8gaGF2ZSBwb3NzaWJpbGl0eSB0byBlYXN5IGNo
b29zZSBiZXR3ZWVuIHRoZXNlIHR3byBtb2RlcyBpbiBkeW5hbWljYWxseSB3YXkuDQoNCkZvciBQ
Q0kgYmFzZWQgb24gcGxhdGZvcm0gcHJvYmFibHkgSSB3aWxsIGhhdmUgdG8gYWRkIHNvbWUgcGFy
YW1ldGVyIHRvIGNkbnMzLXBjaS5rbw0KbW9kdWxlIHRvIGFsbG93IHNlbGVjdGluZyBtb2Rlcy4g
SSBkb24ndCAgdXNlIERUUy4gDQoNCkRvbid0IHdvcnJ5IGFib3V0IGl0IG5vdy4gWW91IGNhbiBw
b3N0IHRoaXMgZml4LiANCg0KQ2hlZXJzLA0KUGF3ZWwgDQoNCj4NCj5jaGVlcnMsDQo+LXJvZ2Vy
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2NkbnMzL2NvcmUuYw0KPj4gaW5kZXggMmU0NjkxMzk3NjlmLi5mYzZhODE1MjQwNmMgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMv
dXNiL2NkbnMzL2NvcmUuYw0KPj4gQEAgLTQyNyw3ICs0MjcsNiBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgY2RuczNfd2FrZXVwX2lycShpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4gICAgKi8NCj4+ICAg
c3RhdGljIGludCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4g
ICB7DQo+PiAtCXN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2hfZGVzYyBzd19kZXNjID0geyB9Ow0KPj4g
ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4+ICAgCXN0cnVjdCByZXNvdXJj
ZQkqcmVzOw0KPj4gICAJc3RydWN0IGNkbnMzICpjZG5zOw0KPj4gQEAgLTUyOSwxOCArNTI4LDIx
IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4+ICAgCWlmIChyZXQpDQo+PiAgIAkJZ290byBlcnIyOw0KPj4NCj4+IC0Jc3dfZGVzYy5zZXQg
PSBjZG5zM19yb2xlX3NldDsNCj4+IC0Jc3dfZGVzYy5nZXQgPSBjZG5zM19yb2xlX2dldDsNCj4+
IC0Jc3dfZGVzYy5hbGxvd191c2Vyc3BhY2VfY29udHJvbCA9IHRydWU7DQo+PiAtCXN3X2Rlc2Mu
ZHJpdmVyX2RhdGEgPSBjZG5zOw0KPj4gLQlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChk
ZXYsICJ1c2Itcm9sZS1zd2l0Y2giKSkNCj4+ICsJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jv
b2woZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpIHsNCj4+ICsJCXN0cnVjdCB1c2Jfcm9sZV9zd2l0
Y2hfZGVzYyBzd19kZXNjID0geyB9Ow0KPj4gKw0KPj4gKwkJc3dfZGVzYy5zZXQgPSBjZG5zM19y
b2xlX3NldDsNCj4+ICsJCXN3X2Rlc2MuZ2V0ID0gY2RuczNfcm9sZV9nZXQ7DQo+PiArCQlzd19k
ZXNjLmFsbG93X3VzZXJzcGFjZV9jb250cm9sID0gdHJ1ZTsNCj4+ICsJCXN3X2Rlc2MuZHJpdmVy
X2RhdGEgPSBjZG5zOw0KPj4gICAJCXN3X2Rlc2MuZndub2RlID0gZGV2LT5md25vZGU7DQo+Pg0K
Pj4gLQljZG5zLT5yb2xlX3N3ID0gdXNiX3JvbGVfc3dpdGNoX3JlZ2lzdGVyKGRldiwgJnN3X2Rl
c2MpOw0KPj4gLQlpZiAoSVNfRVJSKGNkbnMtPnJvbGVfc3cpKSB7DQo+PiAtCQlyZXQgPSBQVFJf
RVJSKGNkbnMtPnJvbGVfc3cpOw0KPj4gLQkJZGV2X3dhcm4oZGV2LCAiVW5hYmxlIHRvIHJlZ2lz
dGVyIFJvbGUgU3dpdGNoXG4iKTsNCj4+IC0JCWdvdG8gZXJyMzsNCj4+ICsJCWNkbnMtPnJvbGVf
c3cgPSB1c2Jfcm9sZV9zd2l0Y2hfcmVnaXN0ZXIoZGV2LCAmc3dfZGVzYyk7DQo+PiArCQlpZiAo
SVNfRVJSKGNkbnMtPnJvbGVfc3cpKSB7DQo+PiArCQkJcmV0ID0gUFRSX0VSUihjZG5zLT5yb2xl
X3N3KTsNCj4+ICsJCQlkZXZfd2FybihkZXYsICJVbmFibGUgdG8gcmVnaXN0ZXIgUm9sZSBTd2l0
Y2hcbiIpOw0KPj4gKwkJCWdvdG8gZXJyMzsNCj4+ICsJCX0NCj4+ICAgCX0NCj4+DQo+PiAgIAlp
ZiAoY2Rucy0+d2FrZXVwX2lycSkgew0KPj4gQEAgLTU4Myw3ICs1ODUsOCBAQCBzdGF0aWMgaW50
IGNkbnMzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgIAlyZXR1cm4g
MDsNCj4+ICAgZXJyNDoNCj4+ICAgCWNkbnMzX2RyZF9leGl0KGNkbnMpOw0KPj4gLQl1c2Jfcm9s
ZV9zd2l0Y2hfdW5yZWdpc3RlcihjZG5zLT5yb2xlX3N3KTsNCj4+ICsJaWYgKGNkbnMtPnJvbGVf
c3cpDQo+PiArCQl1c2Jfcm9sZV9zd2l0Y2hfdW5yZWdpc3RlcihjZG5zLT5yb2xlX3N3KTsNCj4+
ICAgZXJyMzoNCj4+ICAgCXNldF9waHlfcG93ZXJfb2ZmKGNkbnMpOw0KPj4gICBlcnIyOg0KPj4N
Cj4NCj4tLQ0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIs
IDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
