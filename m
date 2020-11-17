Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2953F2B67F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKQOy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:54:59 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:22964 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727422AbgKQOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:54:58 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHEcnSl031825;
        Tue, 17 Nov 2020 06:54:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=5Eek/3ZxWLQ1xY63oxqnkM+D/qrGJbGldWDbrykEc7g=;
 b=eZB/CA6HuVrCL9J0k356abuxTsnzhKyHHqycOXJMIehxyjwy95m9t1wUUlOu/V5DDX3/
 o2HdgbdiKMq2CnNGD2N4EcUrOw1YCSPgWPOFt5oFP8ElCqnYb2ErDK9n/6eqqy4e+lTQ
 bSrEs51LHDs7yXsYEauVsLy2Nh0XD+S4And1pqtyPRikKREUQ+GdChoW6o/Bi3NAB4Ws
 QxVKnXxNFietQjQmRQJBj4LYYbvtxNkBM5sX/rninCaSlVKwbu7jxhwpWxmj9YB0ISCR
 aTsmnfUzWpNr9FzHQ7TDkycWv63MrrwXIKWHMw07d18vmAVmXaei83BiHGKpOldaWJii hg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34tbq2twy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 06:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPnPpelRYbCH52GEJY3bo8TP/pRrMyzFGBoiesXOuiMBBriXd9j6UKR8Ox+YKgTPML2sdcWTfqjzvsUM3FQJ75T2khje8OOtLXpcpzGcWqCyoSzkbGMco7A4r6POQtYi3ID+VUee8PZt04HPtI/F7RBR3YctVthOv9z0bt9Qe4PM88PDzRRv1vkbamUy3bwS1WdDI9z4AZ5AaX2N+t7nu8z39IBP9AwN438no4vrSzR7uOImr4hTguRX/lhDmv6TJQI8iBjlGugpEhYJurj4cEeuxk9RICD8NJg2XvTsnqtigOU6cofzc3Z4pmYrqNAMB/P5IvMcFOQLrcnRx/iKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eek/3ZxWLQ1xY63oxqnkM+D/qrGJbGldWDbrykEc7g=;
 b=OE8dXG48sUxfcjbAGpN7WDnxJm3QTsnmhQN2+8z/TQXKvXr7E17ibEnxtaNNQfYGMDiiXigbiEsswjCdL+B7vHkxKnTE3Iv9ElQrrWl6wvOyrGzX0pyND7Bg7F0OTvWHkroUmGC1u/px10tB1PwYvMhFM4U/GPrCLdLfjx+mzIjOy2XKacvEfVKdSz0WKv+RLcKHlZHbHmAfoZIz+wboaQEOoWga4c/vbVCft8wUEbkxncFRsUHepmAqkgyq3UIYpV9uviprB1PFNrhzkr6flz3hSrXDN52Yi8F4ReHroo07Mtd6+h+78pV7O8y3/92uhjCq2cDew6RS54GAlJOiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eek/3ZxWLQ1xY63oxqnkM+D/qrGJbGldWDbrykEc7g=;
 b=maotPkfVRfNxWygt52A/svSpqHKaKVJgEYW2YP5uKzROVwO3vRMyoObrPfArR6wEqubPko92Pua1nZ0AoQHGrkXjp7J/rZk40d6+xNqv0PzsLuAHSGYVgk0CNazVNJb/UZdfPjH048zYOqFLCPl4y2+eD4FWr+n7rNWK/WeovWQ=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5452.namprd07.prod.outlook.com (2603:10b6:5:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Tue, 17 Nov 2020 14:54:01 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6%6]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 14:54:01 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v2 06/10] usb: cdnsp: Device side header file for CDNSP
 driver
Thread-Topic: [PATCH v2 06/10] usb: cdnsp: Device side header file for CDNSP
 driver
Thread-Index: AQHWtDI4mMMy/4k2eEGPC68hANNZrKnCPcQAgAo41BA=
Date:   Tue, 17 Nov 2020 14:54:01 +0000
Message-ID: <DM6PR07MB55294E1321620884829F7D1DDDE20@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-7-pawell@cadence.com>
 <20201111023317.GB14896@b29397-desktop>
In-Reply-To: <20201111023317.GB14896@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjcxZGE2MTAtMjhlNC0xMWViLTg3NmUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGI3MWRhNjExLTI4ZTQtMTFlYi04NzZlLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzY3OCIgdD0iMTMyNTAwOTg0MzY1MzE0OTQyIiBoPSJ6YW9hTXArY2ZpbFNTNkYzWWhFTGFEanVxbTA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc3b5fa7-b04b-4634-2fee-08d88b089ed3
x-ms-traffictypediagnostic: DM6PR07MB5452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB54522EEBAF3C2C138AC90AE0DDE20@DM6PR07MB5452.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /f0aoWPaXqprxPRDNykTEfIXOd6qDTrgC4KdzDygns+5dYaWcRlZmdFPTPfzUlGfw9Et5oeBsinPsCESMlATXBZiB5RaWP520bVdpoSR3yYnQqADfKqAegqf80FjHYoaNDA+0+MJS3yXdDE/bxSl5ZVpZ3cl0mU+WOWkZIUr4uKw4YO4ITqmOjrZWdzhT4oiC8HZ/qBQ8pmX96Os230hiN1xLmOxAhwxIG8xYd9TkqsjX6w9rQeRYxXN3cciI18lvN9w7/jy1uWJ0FVt9QSIlPMB9f2c8f/yJx9F2aRVO2Ii60iBNJbxYTo/pIJgB1IJoZ2RrZsgC0j/46CFVNO13USN9qLB0rOa3uSDzwjFf75YZTraKnARUFI7Q3stRnFJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(36092001)(71200400001)(7696005)(9686003)(186003)(478600001)(5660300002)(316002)(6506007)(26005)(76116006)(52536014)(66476007)(8676002)(55016002)(4326008)(64756008)(66556008)(66446008)(6916009)(54906003)(8936002)(33656002)(86362001)(2906002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HKMIR/6TOPkcU/M97si90CbSHrGk7iblxQKbyCGS2LtLtBXK39A1vD1nPgE9k7tVBRp86YFK7ZsgCqrflHXKRrRHwisLDNp8d8UsetOvLCSczTUhDtc/JRN9IyDz7g8h8RXqJ/4VopkTMq79/frx+3YK+dB7n5v02i1Yueh9bLv6QzRI+perPAaqUkHyShtgtEj5UfkSas/ObSicuw3LCD6VXHny92UrPbtdJgTeZArsQwbPp4J8vfe87PWnb5z3VMrTp4CaSMV1+zD+xFwJ4eShsoSLwe2R16jUDMv4v8VZP3GtUjcvij0Qr2g9bgRQ3n/nmuiLd6U9RFDZK1ZpILF94HR6sLq9Spq0mUtSI6OBPZGlYEaIvqqx8Q+KJNLIah8kwDSNBp6etkqSlEHyk3Ol0ZkNvsliyV3Xu68Ux8ZTvsBFmq8Lxv9zC9z60rlHsuQF3TYTzNO1f30OAQn+2Vpb59T3zjgQ5xVpsDk92RS1LE3fEo908L5I+RWI6ApfYKPn2vlWR12yYrmQAI9qTe7FCAJ3LsehTOMSz843KYbBDtVR6XUbfXQF/xDR37GLJWQtxLQjun6rdrl7TDbi2S3MqSMWaGONuyTqjqy9S/4D95k6sYuSbqF+p5EuJqUDPZqKkc/93MjW9vZvBUkvNS5FyPGX7bLCFE0SibeOXISb0UJseze1X8mmiKBsTjLcT3XOI8mA2wC9F7I0T6NTciD6t1YDO1oLiIwnyZgpHxbHfAJD+dwqA3+FZ6LRUy4qN2v6qyr9RFbtVFm6rvH5NOMpmOYDGYLuU76xSdyNmEnDG7clO3sAk1tBB/FG9kRvq0RTZVgNo6Mt4WVrp3bQLSePXU2EuknBXdYrrr71HcnWdnC3/+Ujv/90s3RLfeLL27xlDLVdeiBUneNSNLPCGw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3b5fa7-b04b-4634-2fee-08d88b089ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 14:54:01.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilfpWsSd+ZnT6lUzNE/pZk0Ged2Kc9AwCmjYlPFvcJi4x6meU6dqVDuyZR5ftFrxa0blybke/4wPVbay4+wyS5CPjhOLs+bF1fxa2Zcifck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5452
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_04:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5PbiAyMC0xMS0wNiAxMjo0Mjo1NiwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+PiBQ
YXRjaCBkZWZpbmVzIG1hY3JvcywgcmVnaXN0ZXJzIGFuZCBzdHJ1Y3R1cmVzIHVzZWQgYnkNCj4+
IERldmljZSBzaWRlIGRyaXZlci4NCj4+DQo+PiBCZWNhdXNlIHRoZSBzaXplIG9mIG1haW4gcGF0
Y2ggaXMgdmVyeSBiaWcsIEnigJl2ZSBkZWNpZGVkIHRvIGNyZWF0ZQ0KPj4gc2VwYXJhdGUgcGF0
Y2ggZm9yIGNkbnNwLWdhZGdldC5oLiBJdCBzaG91bGQgc2ltcGxpZnkgcmV2aWV3aW5nIHRoZSBj
b2RlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5j
ZS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9jZG5zcC1nYWRnZXQuaCB8IDE0
NjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE0
NjMgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5z
My9jZG5zcC1nYWRnZXQuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9j
ZG5zcC1nYWRnZXQuaCBiL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLWdhZGdldC5oDQo+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yOWQ1ZTJkMDA4NzkNCj4+
IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLWdhZGdldC5o
DQo+PiBAQCAtMCwwICsxLDE0NjMgQEANCj4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCAqLw0KPj4gKy8qDQo+PiArICogQ2FkZW5jZSBDRE5TUCBEUkQgRHJpdmVyLg0KPj4g
KyAqDQo+PiArICogQ29weXJpZ2h0IChDKSAyMDIwIENhZGVuY2UuDQo+PiArICoNCj4+ICsgKiBB
dXRob3I6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+PiArICoNCj4+ICsg
KiBDb2RlIGJhc2VkIG9uIExpbnV4IFhIQ0kgZHJpdmVyLg0KPj4gKyAqIE9yaWdpbjogQ29weXJp
Z2h0IChDKSAyMDA4IEludGVsIENvcnAuDQo+PiArICovDQo+PiArI2lmbmRlZiBfX0xJTlVYX0NE
TlNQX0dBREdFVF9IDQo+PiArI2RlZmluZSBfX0xJTlVYX0NETlNQX0dBREdFVF9IDQo+PiArDQo+
PiArI2luY2x1ZGUgPGxpbnV4L2lvLTY0LW5vbmF0b21pYy1sby1oaS5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC91c2IvZ2FkZ2V0Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2lycS5oPg0KPj4gKw0K
Pj4gKy8qIE1heCBudW1iZXIgc2xvdHMgLSBvbmx5IDEgaXMgYWxsb3dlZC4gKi8NCj4+ICsjZGVm
aW5lIENETlNQX0RFVl9NQVhfU0xPVFMJMQ0KPj4gKw0KPj4gKyNkZWZpbmUgQ0ROU1BfRVAwX1NF
VFVQX1NJWkUJNTEyDQo+PiArDQo+PiArLyoxNiBmb3IgaW4gYW5kIDE2IGZvciBvdXQuICovDQo+
PiArI2RlZmluZSBDRE5TUF9FTkRQT0lOVFNfTlVNCTMyDQo+PiArDQo+PiArLyogQmVzdCBFZmZv
cnQgU2VydmljZSBMYXRlbmN5LiAqLw0KPj4gKyNkZWZpbmUgQ0ROU1BfREVGQVVMVF9CRVNMCTAN
Cj4+ICsNCj4+ICsvKiBEZXZpY2UgQ29udHJvbGxlciBjb21tYW5kIGRlZmF1bHQgdGltZW91dCB2
YWx1ZSBpbiB1cyAqLw0KPj4gKyNkZWZpbmUgQ0ROU1BfQ01EX1RJTUVPVVQJKDE1ICogMTAwMCkN
Cj4+ICsNCj4+ICsvKiBVcCB0byAxNiBtcyB0byBoYWx0IGFuIGRldmljZSBjb250cm9sbGVyICov
DQo+PiArI2RlZmluZSBDRE5TUF9NQVhfSEFMVF9VU0VDCSgxNiAqIDEwMDApDQo+PiArDQo+PiAr
I2RlZmluZSBDRE5TUF9DVFhfU0laRQkyMTEyDQo+PiArDQo+PiArLyoNCj4+ICsgKiBDb250cm9s
bGVyIHJlZ2lzdGVyIGludGVyZmFjZS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBz
dHJ1Y3QgY2Ruc3BfY2FwX3JlZ3MgLSBDRE5TUCBSZWdpc3RlcnMuDQo+PiArICogQGhjX2NhcGJh
c2U6CUxlbmd0aCBvZiB0aGUgY2FwYWJpbGl0aWVzIHJlZ2lzdGVyIGFuZCBjb250cm9sbGVyDQo+
PiArICogICAgICAgICAgICAgIHZlcnNpb24gbnVtYmVyDQo+PiArICogQGhjc19wYXJhbXMxOiBI
Q1NQQVJBTVMxIC0gU3RydWN0dXJhbCBQYXJhbWV0ZXJzIDENCj4+ICsgKiBAaGNzX3BhcmFtczI6
IEhDU1BBUkFNUzIgLSBTdHJ1Y3R1cmFsIFBhcmFtZXRlcnMgMg0KPj4gKyAqIEBoY3NfcGFyYW1z
MzogSENTUEFSQU1TMyAtIFN0cnVjdHVyYWwgUGFyYW1ldGVycyAzDQo+PiArICogQGhjY19wYXJh
bXM6IEhDQ1BBUkFNUyAtIENhcGFiaWxpdHkgUGFyYW1ldGVycw0KPj4gKyAqIEBkYl9vZmY6IERC
T0ZGIC0gRG9vcmJlbGwgYXJyYXkgb2Zmc2V0DQo+PiArICogQHJ1bl9yZWdzX29mZjogUlRTT0ZG
IC0gUnVudGltZSByZWdpc3RlciBzcGFjZSBvZmZzZXQNCj4+ICsgKiBAaGNjX3BhcmFtczI6IEhD
Q1BBUkFNUzIgQ2FwYWJpbGl0eSBQYXJhbWV0ZXJzIDIsDQo+PiArICovDQo+PiArc3RydWN0IGNk
bnNwX2NhcF9yZWdzIHsNCj4+ICsJX19sZTMyIGhjX2NhcGJhc2U7DQo+PiArCV9fbGUzMiBoY3Nf
cGFyYW1zMTsNCj4+ICsJX19sZTMyIGhjc19wYXJhbXMyOw0KPj4gKwlfX2xlMzIgaGNzX3BhcmFt
czM7DQo+PiArCV9fbGUzMiBoY2NfcGFyYW1zOw0KPj4gKwlfX2xlMzIgZGJfb2ZmOw0KPj4gKwlf
X2xlMzIgcnVuX3JlZ3Nfb2ZmOw0KPj4gKwlfX2xlMzIgaGNjX3BhcmFtczI7DQo+PiArCS8qIFJl
c2VydmVkIHVwIHRvIChDQVBMRU5HVEggLSAweDFDKSAqLw0KPj4gK307DQo+PiArDQo+PiArLyog
aGNfY2FwYmFzZSBiaXRtYXNrcy4gKi8NCj4+ICsvKiBiaXRzIDc6MCAtIGhvdyBsb25nIGlzIHRo
ZSBDYXBhYmlsaXRpZXMgcmVnaXN0ZXIuICovDQo+PiArI2RlZmluZSBIQ19MRU5HVEgocCkJCSgo
KHApID4+IDAwKSAmIEdFTk1BU0soNywgMCkpDQo+PiArLyogYml0cyAzMToxNgkqLw0KPj4gKyNk
ZWZpbmUgSENfVkVSU0lPTihwKQkJKCgocCkgPj4gMTYpICYgR0VOTUFTSygxNSwgMSkpDQo+PiAr
DQo+PiArLyogSENTUEFSQU1TMSAtIGhjc19wYXJhbXMxIC0gYml0bWFza3MgKi8NCj4+ICsvKiBi
aXRzIDA6NywgTWF4IERldmljZSBFbmRwb2ludHMgKi8NCj4+ICsjZGVmaW5lIEhDU19FTkRQT0lO
VFNfTUFTSwlHRU5NQVNLKDcsIDApDQo+PiArI2RlZmluZSBIQ1NfRU5EUE9JTlRTKHApCSgoKHAp
ICYgSENTX0VORFBPSU5UU19NQVNLKSA+PiAwKQ0KPj4gKw0KPj4gKy8qIEhDQ1BBUkFNUyBvZmZz
ZXQgZnJvbSBQQ0kgYmFzZSBhZGRyZXNzICovDQo+PiArI2RlZmluZSBIQ0NfUEFSQU1TX09GRlNF
VAkweDEwDQo+PiArDQo+PiArLyogSENDUEFSQU1TIC0gaGNjX3BhcmFtcyAtIGJpdG1hc2tzICov
DQo+PiArLyogdHJ1ZTogZGV2aWNlIGNvbnRyb2xsZXIgY2FuIHVzZSA2NC1iaXQgYWRkcmVzcyBw
b2ludGVycy4gKi8NCj4NCj5XaGF0IGRvZXMgInRydWUiIG1lYW4gYXQgYWJvdmUgY29tbWVudD8N
Cg0KSSB1bmRlcnN0YW5kIHRoYXQgaXQncyBhbWJpZ3VvdXMuIA0KDQpUcnVlIGlzIG5vdCBhbHdh
eXMgZXF1YWwgIDEuIA0KSSB3aWxsIHJlcGxhY2UgaXQgd2l0aCAxLiANCg0KVGhhbmtzIGZvciBy
ZXZpZXcuDQoNCjxzbmlwPiAgDQoNCi0tDQpSZWdhcmRzLA0KUGF3ZWwNCg==
