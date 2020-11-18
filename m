Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC82E2B8183
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKRQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:08:59 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:34026 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbgKRQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:08:58 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIG6dXJ011496;
        Wed, 18 Nov 2020 16:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=/TAqhP+RA3+wI7aQKp0bbjtKllvBWN7MuHRkXxzifWY=;
 b=WWxJnyIpyspnKIxSpRO6a4t65I61JsDC/FnSMUFgOzo6gKmTohntswJ95jTTYGBi+PGi
 KvHqZYrjpbXyihG1ZTJft/8J39Mc0AN1C9I1HoVTR9aTgBsuTqPOJM3KhOGrg5/OV2BB
 XMGPLii7mN1QLygs6Pbqd5AfHPt9Dn2U2R1qcjiOESkqiaCsqXK4Ix3SvVkg17efkvQu
 RZL5L344pkhvl4ls7PhzoveBt+EcE/OblzoZMJxAncv/YmUwaU/H2LTkLCN32rMN3Rcb
 uy9HwXIVnoaU4ea1bjxL+bCxrdL7YncgW1HMdWyTxwO+7FNQhvALdzI4nKHWsaA0YhDe QA== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vm4vr0m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:08:08 +0000
Received: from G9W8455.americas.hpqcorp.net (g9w8455.houston.hp.com [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 42FC87F;
        Wed, 18 Nov 2020 16:08:07 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 18 Nov 2020 16:07:57 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2 via Frontend Transport; Wed, 18 Nov 2020 16:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtzGcAOB1Xd9NcR/irD6F6EeKkojinjm5qfDzSvH+/+cmiKbxey1LMlI06SIm3z0++O7m5vm89kIOZKYyCoqSNs8IC/35aboAEhok3DED1NzEkYZ3ZzGhlyX+qdVUUhHjxvvMB59qPDL0NTeakuiKc4s1QVXFxkhB7fleiCxTx0UqMDVOSTD76WIWy5GsJvA9lPno6zqzPhzPsW7himUFl3ciSnSQWKopdIOJtDr9TR24SLP0xZMLEQ2FjqEJAVzqcAq+kDOKj/4j9pKv4wz2VrorvNCOaRRcyiDWB8qrK5b+YoQ+ftjhv3jqpT28DR8rZMeZEcp4MZOAAaWTUbqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TAqhP+RA3+wI7aQKp0bbjtKllvBWN7MuHRkXxzifWY=;
 b=lnOp2Vii3Xs9zBXZlZMztOPtxCBkeIPP5YawKnY6vUGIhn8M/2/KP6MosxLTKcAEGWeibK9a2HooDVe4cXO4QjFx0+E/V4Ulc+2vOdxsiYmSrIlraHLFEn4T0yG1DPEvHvMpO/bv3AJgARp0aRHJhl4kAGFzbY+LFQa0kr9rv7bsq7CO9JAM5BNqscrmOtqwWvVl+dX4qDpAlWADbL6p7agcbZPzS7VFUgPP/GmhoPmbv0NfQJ6dJs0l48e5Uqd5dPl/l1ixCqLX+1359q0/7FUxMarncrG7DcRO4lfOHnEgvoIZi10keFjxuEL/xXenAuJSC9nJjh/aTo8DAbr0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:742b::18) by AT5PR8401MB1219.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:742a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 18 Nov
 2020 16:07:56 +0000
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f89b:ae35:98f5:997c]) by AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f89b:ae35:98f5:997c%7]) with mapi id 15.20.3564.033; Wed, 18 Nov 2020
 16:07:56 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: RE: [PATCH 0/5] Add uv_sysfs platform driver
Thread-Topic: [PATCH 0/5] Add uv_sysfs platform driver
Thread-Index: AQHWvSJAdkb21AnRg0y7XxJ5jdE3O6nNueCAgABThcA=
Date:   Wed, 18 Nov 2020 16:07:56 +0000
Message-ID: <AT5PR8401MB1300DCD22C7191DE4FEA8A8A87E10@AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201117204224.51230-1-justin.ernst@hpe.com>
 <99d26b0e-efd7-a32d-7be0-607c98ac2569@redhat.com>
In-Reply-To: <99d26b0e-efd7-a32d-7be0-607c98ac2569@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.61.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 155294a2-5703-4ada-ef23-08d88bdc1cb4
x-ms-traffictypediagnostic: AT5PR8401MB1219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AT5PR8401MB1219A95C9B489A37490F532787E10@AT5PR8401MB1219.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4TCiEU5ls72ykZPCrP19ktG4he2lfadNpmKOSe5fF32QBUZ4+W4GjI3RvGlinxy/5JeWlk8YbbgNo9p9qzXOEXz9QRm9Ksu+OvINMMUBy0IoGQH9K5P1a9JrG7vpPdbs0sA49q7KRVy4WafFqkG00/2+o9MpBFPPaucvrWij3wEHCjS2/+pE48S4Gw52YdK2N6+zTjCidBxYDClGAdRE+YwUPwhQuLaWaxcX9j9e9CU6ziH7wD+uHWtzJvxIUZnkUyQuVYFvBBxMlgh5m9nAxhxd5IgvubftS+wEY3vnJ15poBSaaOlEVhOylaH/G20Thx2utizd4owt5GS4pglL7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(110136005)(54906003)(2906002)(86362001)(83380400001)(76116006)(55236004)(5660300002)(4326008)(66476007)(71200400001)(186003)(64756008)(478600001)(53546011)(26005)(7416002)(66556008)(66946007)(66446008)(9686003)(316002)(7696005)(55016002)(6506007)(52536014)(8676002)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B6KnPVSrhRrGO4n0yD5imf/p6jAzGV4K+zFB6lAnHhAbdgPDWUAK26nPk04/XL2xP9pUefNmmDem6/0fYmtBIOvBUhq0YWPPmXvsB6oEkJCzqkMZ/7nnNf5URVJQ5RJBLy1JiRNSWyZYdqHG5Qd2O34dx9ox7qpbq4H9MKfzdegQLvBwRZLUEOJw0ATr7O2xicivNwmvjooGnyGrY7AJ3CRjK1IEgz10HZKdBSY0gixB7JV0304Jxy9qiH+V5V7jqqZo+MeEQNWhib+uhheFpJ4peH+Ykwo9W4nZXXAW6Dhswk/2SwH0Yfl0p09QesibFRKHUKtpVQBOEUKLFG7ZqLUe01z5JEfezUhn6gsA9ZgZgs67zRDSyVoGRd+6iBHipe7BsgHE8ygvmoge7I4bRzPA4NCv2Xy8EYfetUDxse9fGkvAMS3fAtxqvPCMrGm5FXCr8qHHiEHPAk5tRRj6CtRCZz9adhMQHyOnR1BMRtWDsF4MycUdRHgo2dVNR412IfhkkFbhTYiklCapz78OAzlWkuG8EjsbOCbE20DhGASexzjmajC37kKCQc8miLGa3lQH0EarILrs9dEiuftMgXp9slBCqQEY0wfvMRsnxVDG8Z+LWkpDeRQgMfRad1dICsXO5fExtpRGiC+SGuZfc+lDS3iw1hjui40vDNzDxp4dQLJg4G1zKpBOksVDmNX0eAzlGrQnbzEwzaNpPGP9sqP9H7xtTX76lJz8fPz/AMafALCDxpQ7cCEyLcwney4m1WaeTzD+lhGnp1OYl3YNHlAdv9O1ppr0KLEip64v9akjC5EVdEtllKgVoJMRspQvpelF/XPsD2Fnnfmge3A64biKRiy/HRvHRK3AgGPb4qGdBpfaSFPw/G27lMJFDaWr4nesac5adEJiDcO1TN7F/w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 155294a2-5703-4ada-ef23-08d88bdc1cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 16:07:56.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHxasy/uspIben/yUCAcF+8cr9KVuHLdDf6qPpbx55TYWHZ9Hp60AXUAQ3MX60LNUggFz99kGSwJkz3n33aeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1219
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=865 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011180113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwNCj4gDQo+IE9uIDExLzE3LzIwIDk6NDIgUE0sIEp1c3RpbiBFcm5zdCB3cm90ZToNCj4g
PiBJbnRyb2R1Y2UgYSBuZXcgcGxhdGZvcm0gZHJpdmVyIHRvIGdhdGhlciB0b3BvbG9neSBpbmZv
cm1hdGlvbiBmcm9tIFVWIHN5c3RlbXMNCj4gPiBhbmQgZXhwb3NlIHRoYXQgaW5mb3JtYXRpb24g
dmlhIGEgc3lzZnMgaW50ZXJmYWNlIGF0IC9zeXMvZmlybXdhcmUvc2dpX3V2Ly4NCj4gPg0KPiA+
IEp1c3RpbiBFcm5zdCAoNSk6DQo+ID4gICB4ODYvcGxhdGZvcm0vdXY6IFJlbW92ZSBleGlzdGlu
ZyAvc3lzL2Zpcm13YXJlL3NnaV91di8gaW50ZXJmYWNlDQo+ID4gICB4ODYvcGxhdGZvcm0vdXY6
IEFkZCBhbmQgZXhwb3J0IHV2X2Jpb3NfKiBmdW5jdGlvbnMNCj4gPiAgIHg4Ni9wbGF0Zm9ybS91
djogQWRkIG5ldyB1dl9zeXNmcyBwbGF0Zm9ybSBkcml2ZXINCj4gPiAgIHg4Ni9wbGF0Zm9ybS91
djogVXBkYXRlIEFCSSBkb2N1bWVudGF0aW9uIG9mIC9zeXMvZmlybXdhcmUvc2dpX3V2Lw0KPiA+
ICAgeDg2L3BsYXRmb3JtL3V2OiBVcGRhdGUgTUFJTlRBSU5FUlMgZm9yIHV2X3N5c2ZzIGRyaXZl
cg0KPiANCj4gU28gcGF0Y2ggMS8xIGRyb3BzIHRoZSBleGlzdGluZw0KPiANCj4gL3N5cy9maXJt
d2FyZS9zZ2lfdXYvY29oZXJlbmNlX2lkDQo+IC9zeXMvZmlybXdhcmUvc2dpX3V2L3BhcnRpdGlv
bl9pZA0KPiANCj4gc3lzZnMgQVBJLCB0aGVuIGFjY29yZGluZyB0byBwYXRjaCA0LzUgcGF0Y2gg
My81IHJlaW50cm9kdWNlcw0KPiB0aGUgL3N5cy9maXJtd2FyZS9zZ2lfdXYvcGFydGl0aW9uX2lk
IEFQSSwgYnV0IHRoZSAvc3lzL2Zpcm13YXJlL3NnaV91di9jb2hlcmVuY2VfaWQNCj4gZmlsZSBp
cyBnb25lIGZvciBldmVyID8NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGF0IHVzZXJzcGFjZSBiaXRz
IChtYXkpIGRlcGVuZCBvbiB0aGlzIGJ1dCB3aXRob3V0IG1vcmUgaW5mbw0KPiB0aGlzIGxvb2tz
IGxpa2UgYSBjbGVhciB2aW9sYXRpb24gb2YgdGhlIGRvIG5vdCBicmVhayB1c2Vyc3BhY2UgQVBJ
cyBydWxlLg0KPiANCj4gU28sIGJhc2VkIG9uIHRoaXMsIEkgaGF2ZSB0byBuYWNrIHRoaXMgc2Vy
aWVzIGluIGl0cyBjdXJyZW50IHN0YXRlLg0KPiANCj4gTm93IGlmIHRoZXJlIGlzIGEgc3Ryb25n
IGJlbGlldmUgdGhlcmUgYXJlIDAgKG5vdCBhIGZldywgYnV0IF96ZXJvXykgdXNlcnMNCj4gb3V0
IHRoZXJlIHdobyByZWx5IG9uIHRoZSAvc3lzL2Zpcm13YXJlL3NnaV91di9jb2hlcmVuY2VfaWQg
ZmlsZSB0aGVuIHRoaXMNCj4gbWlnaHQgYmUgb2suIEJ1dCB0aGVuIHRoZXJlIG5lZWRzIHRvIGJl
IGEgdGVjaG5pY2FsIGFuYWx5c2lzIG9mIHdoeSB0aGlzIGlzDQo+IG9rIGluIHRoZSBjb21taXQg
bWVzc2FnZSBvZiB0aGUgcGF0Y2ggZHJvcHBpbmcgdGhpcyBzeXNmcyBmaWxlLg0KPiANCj4gQWxz
byB0aGUgY29tbWl0IG1lc3NhZ2Ugb2YgcGF0Y2ggMS81IHNob3VsZCBtZW50aW9uIHRoYXQNCj4g
L3N5cy9maXJtd2FyZS9zZ2lfdXYvcGFydGl0aW9uX2lkIHdpbGwgYmUgcmUtaW50cm9kdWNlZCBs
YXRlciB0aHJvdWdoDQo+IGFub3RoZXIgZHJpdmVyLg0KDQpIZWxsbyBIYW5zLA0KDQpJIHdpbGwg
cmVzdWJtaXQgdGhlc2UgcGF0Y2hlcyB3aXRob3V0IHRoZSBBUEkgYnJlYWthZ2UsIHJlaW50cm9k
dWNpbmcgdGhlIGNvaGVyZW5jZV9pZCBmaWxlIGluIHRoZSBuZXcgZHJpdmVyLg0KDQpUaGFuayB5
b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byBsb29rIG92ZXIgbXkgcGF0Y2ggc2V0Lg0KDQo+IA0K
PiBSZWdhcmRzLA0KPiANCj4gSGFucw0KDQo=
