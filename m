Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02AF2856E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJGDNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:13:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7072 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgJGDNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:13:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09737Cq9023074;
        Tue, 6 Oct 2020 20:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=M50XEzmU2/8aJ3WZAmg+LANO9ne6rd1sF9kevkOZWy8=;
 b=AEQMDX+oeCGQbqBeru69+2yN6EpRuJ2lb06RppBCs0ApLCPMtNGy8bPaBqzGAiNgRhTd
 99oux0xNE3FNz3gnPRVTrIJtcUzGBPDMSOpiIdOWyX0OxLeXe2HJWbM0a3L+SKmQ0BwL
 pboV+qQZ13S2Pv+DYXw1soOgr9pGr/JmvDhOXw0NWtSqqxb05keyBwHmPR7/mmbJNk28
 EieJP+LdBxKqxNQCEmTWOT1OfbtoTgVSWZJsClNMImksYAdl/cQKa/KTrmzQOYYkG49t
 xTO0JVpO02eJxhqKbDs7Ka6C73Z26tOyLPBSs92qQydCYFWBsmGCJl6pRbJX2HJLk6v2 qA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxkr4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 20:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgudBlevypmIZPYjF99IIMrzQhS6G5cFiOaC0CECY+7E/3ex1OpV79kmRqft3IOu24Ha8CQMoB4QUM2oprFWMlTU/RdPPa1yCDJxLZkB3GQ73Pe4pQN3Sg6lrFbUMf3ZedrCR+B3WntY9fAXXompt1XL/UUwUAABNONsOTvyAA3plwvWUlxrU9IC6TI+fbd/i4RRCJlkHjibAY5ntJ4/ZFDDUO0qLCcUmGTZeQsY7JhpcWDfXxbkImFZ30tRvgWgxfkWkRYKPPn5BykHEzdfV8hGRRz4spah+SvtPVI6hMX4b/YOHS9WZsHSoXtzssBOHyZEiKhabSpoJAPZ5LYQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M50XEzmU2/8aJ3WZAmg+LANO9ne6rd1sF9kevkOZWy8=;
 b=L5ukVRUhr6h0LI5k229L8i3Hzl3N4VJts3ncrbLF85hAMvzgYb1KHcaKOG6iQlstQquRRP2oPdY5a2Cdi9HfOMx1AKhUKAswS6W/BSSCl2gebNaSjEvtgpxbwGEz14YISB5t9pBAXRu0rSp1H34mI/crObGKCi7Nv8jtqz8YYQnrpWp+iLiVfqn8uGxWMtNxoyYmHpVULe4f8xw0T2fuv91WmpKQ9ZuJGbrPYf5lGcYfOy7qUlFGDk8SQh/DrZgvD16U79GbH4o+w/5O+UYkQusQbjUg2nkf9V1LhuvxMSiw6H0G13ZsLm/VlrpIeY5WPQBl/3SV0iDRmVIjLHA8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M50XEzmU2/8aJ3WZAmg+LANO9ne6rd1sF9kevkOZWy8=;
 b=7nWU7mNo5NcKVv89wcrx0og4yL9giI9lAEYYC9bvNZTVC5/CWHL5k6fGv9xTziTxVhvEpwh4BWNCelIMt/GcOB24Uk6e4GqdF+I9/vRfAGBTK73KpTdHVJyF/CVs2jupWczHaaHFbemecDndbcqKsWSVmFTQn86f9ixXT+5vswM=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB4134.namprd07.prod.outlook.com (2603:10b6:4:ba::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.42; Wed, 7 Oct 2020 03:12:52 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 03:12:52 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     Peter Chen <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Topic: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Index: AQHWlvch/Roy1G/8IkO8ykqpdGeiF6mEBTKAgAAA+RCAABNFAIAEbf+wgAAx5YCAAACZIIACx1rg
Date:   Wed, 7 Oct 2020 03:12:52 +0000
Message-ID: <DM6PR07MB55293FED0365CA0B70271F45DD0A0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200930065758.23740-1-pawell@cadence.com>
 <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
 <DM6PR07MB5529095F1B656C5065CBA8B4DD310@DM6PR07MB5529.namprd07.prod.outlook.com>
 <b73f6bb7-8e5e-d5f9-5adf-f6b10bdb5fb6@ti.com>
 <DM6PR07MB55297B8671A649E8AED7231FDD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
 <5ca1fdf6-fd91-a223-92cc-a771ffa3c068@ti.com>
 <DM6PR07MB5529E919C70D3E4D0C572691DD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB5529E919C70D3E4D0C572691DD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZmFlMDUwMWItMDg0YS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGZhZTA1MDFkLTA4NGEtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTYxOSIgdD0iMTMyNDY1MTM5NzA0NzMxMDk3IiBoPSJ5SFZNTjliZXpQOE1HMkFyNXdtY2RBbnpNbmM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa242e76-73d2-42be-216e-08d86a6ee0df
x-ms-traffictypediagnostic: DM5PR07MB4134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB41348252A79C1BCDFD6B619ADD0A0@DM5PR07MB4134.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DaB4FMxstunkgFjUuhkDiJSAiu5ZTF7amWUBtxgaQZQ/5LIL0P2a23N9oDv0+T0EsnwPmegLqL2YBegIwUveEGL9WfuZGj9MoTgqFX4fmczsWr2ua0pDmkBdNNIRqovchjWmryK+F+pIYNSMx6eDCT4+NyKndoZpqQ70gpCxJJFDrSABvY7XDmr6iVcyahLduDhz3qlnuuVBAJDo0N8n7mDUhVWPEX4tslRGihntGu/yIfYNPU8UGmlQ6DbS7kB4YxZL0UJB9MSehsKMweAYp1MZ11G5c7DR3T9KSQurF502Q2d9yuWE5L+2mRiVM0nRnpHBWG+3fGcAoH7JJOiIQaAXj1N1ESF/sUvkU694PLfk4x7vaVa3rZ9Fwz3nCfxF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(36092001)(110136005)(66946007)(316002)(66476007)(5660300002)(52536014)(83380400001)(54906003)(8676002)(186003)(26005)(8936002)(9686003)(4326008)(107886003)(6506007)(33656002)(86362001)(76116006)(66556008)(478600001)(55016002)(7696005)(71200400001)(2906002)(53546011)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +nRWe1HuKh0fySHV1AGR249V1kytXMrSXr8K4vsxvq5o1QMC6x8ywpoeJGqwkUaMQJVKnML3T4a2jm27K4kUIqIohT9318KCsGH+Jit6DS60CUUT0jW445duR5MiwqtaJd0Sq2uiT6XaJXJmxJUGAqByWDjRiYVIZGwuTjJnQY1mmtbEITeSijpFeGO4mawKgi/phVEtjvzpH9JtDl6rlahvcxsSFAns0dZIKwFCBGeLUn9hrpz5VFK5+9Ea5P+Km7v2C/UoV97HC8G7KNAWHInigwxfD6pVzEYfVXOH/S3drFObkcDxvlpzyZceV/ZOpJyo3D2q3AZbQjdM7ENQyagQPJAj82vl1FBbW+4qnOIZr1dkyO/bHKC+BtE7D8Ex+DnDSwrS0CZYAIu4yzf7XQVOdx1IGe9KM/i1ZYr0kMRjKhokMG1tdJ0kxVvQWZN9PWRFgjE44d26B9nX7GeYxvjDxT8GS1rF6wxfadVAG/+y+DvmXtb9q3ZKM3DK06do45h+kTEd+3iylywnZC2OXsZbVq5BHuA7dj/dllUvJz/tXPhXbiXkrfQFYI0PqUntOzTrrPw04zsNNcncauGvNhpepY8NL1affiDmNSzLGb2tBnmR74w+S6WE5VBsBZBj7ZfW0FjjFemkpgo3BrDmIQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa242e76-73d2-42be-216e-08d86a6ee0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 03:12:52.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqClOPqJx3EAFsDa7niMg7Te8sPPO6V5BBNZr7ePi8QT9UyVMme3gOJOTSBv5H1SQKbDSvAEjDYEFtridXdDZAJz0+x99YZnEF3DmBzYEMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4134
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_03:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=819 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlLCANCg0KUGxlYXNlICBpZ25vcmUgdGhpcyBwYXRjaC4gSSB3aWxsIGNyZWF0ZSB0aGUg
bmV3IG9uZS4gDQpJdCdzIG5vIHNlbnNlIHRvIHNlbmQgdGhlIHYyIGJlY2F1c2UgSSBoYXZlIHRv
IGNoYW5nZSB0aGUgcGF0Y2ggbmFtZSwNCkRlc2NyaXB0aW9uIGFuZCBjb250ZW50cy4NCg0KUmVn
YXJkcywNClBhd2VsLA0KDQo+Um9nZXIsDQo+DQo+PlBhd2VsLA0KPj4NCj4+T24gMDUvMTAvMjAy
MCAwODo1NCwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+Pj4gUm9nZXIsDQo+Pj4+DQo+Pj4+IFBh
d2VsLA0KPj4+Pg0KPj4+PiBPbiAwMi8xMC8yMDIwIDEyOjA4LCBQYXdlbCBMYXN6Y3phayB3cm90
ZToNCj4+Pj4+IFJvZ2VyLA0KPj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDMwLzA5LzIwMjAgMDk6
NTcsIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4+Pj4+PiBUbyBhdm9pZCBkdXBsaWNhdGUgZXJy
b3IgaW5mb3JtYXRpb24gcGF0Y2ggcmVwbGFjZXMgcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUNCj4+
Pj4+Pj4gaW50byBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbC4NCj4+Pj4+Pg0KPj4+
Pj4+IFdoYXQgaXMgZHVwbGljYXRlIGVycm9yIGluZm9ybWF0aW9uPw0KPj4+Pj4NCj4+Pj4+IFRo
ZSBmdW5jdGlvbiBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSBwcmludDoNCj4+Pj4+ICIgZGV2X2Vy
cigmZGV2LT5kZXYsICJJUlEgJXMgbm90IGZvdW5kXG4iLCBuYW1lKTsiIGlmIGVycm9yIG9jY3Vy
cmVkLg0KPj4+Pj4NCj4+Pj4+IEluIGNvcmUuYyB3ZSBoYXZlIHRoZSBhbm90aGVyIGVycm9yIG1l
c3NhZ2UgYmVsb3cgaW52b2tpbmcgdGhpcyBmdW5jdGlvbi4NCj4+Pj4+IGUuZw0KPj4+Pj4gCWlm
IChjZG5zLT5kZXZfaXJxIDwgMCkNCj4+Pj4+IAkJZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQg
cGVyaXBoZXJhbCBpcnFcbiIpOw0KPj4+Pj4NCj4+Pj4+IFNvLCBpdCdzIGxvb2tzIGxpa2Ugb25l
IGRldl9lcnIgaXMgIHJlZHVuZGFudC4NCj4+Pj4NCj4+Pj4gSWYgd2Ugd2FudCBhbGwgMyBJUlFz
IHRvIGJlIHZhbGlkIGlycmVzcGVjdGl2ZSBvZiBkcl9tb2RlIHRoZW4gd2Ugc2hvdWxkDQo+Pj4+
IHVzZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgpIGFuZCBlcnJvciBvdXQgaW4gcHJvYmUgaWYg
KHJldCA8IDAgJiYgcmV0ICE9IC1FUFJPQkVfREVGRVIpLg0KPj4+Pg0KPj4+PiBXZSBjYW4gZ2V0
IHJpZCBvZiB0aGUgaXJxIGNoZWNrIGFuZCBkdXBsaWNhdGUgZXJyb3IgbWVzc2FnZSBpbiBvdGhl
ciBwbGFjZXMuDQo+Pj4NCj4+PiBUbyBiZSBzdXJlIHdlIHVuZGVyc3RhbmQgZWFjaCBvdGhlciBj
b3JyZWN0bHkuDQo+Pj4NCj4+PiBBcmUgWW91IHN1Z2dlc3RpbmcgIHRvIGxlYXZlIHRoZSAgcGxh
dGZvcm1fZ2V0X2lycV9ieW5hbWUoKQ0KPj4+IGFuZCByaWQgb2YgZnJvbSBjb3JlLmMgdGhlIGZv
bGxvd2luZyBsaW5lcyA6DQo+Pj4NCj4+PiBpZiAoY2Rucy0+ZGV2X2lycSA8IDApDQo+Pj4gCWRl
dl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHBlcmlwaGVyYWwgaXJxXG4iKTsNCj4+Pg0KPj4+IGFu
ZA0KPj4+DQo+Pj4gZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgb3RnIGlycVxuIik7DQo+Pj4g
Pw0KPj4NCj4+WWVzLg0KPj4NCj4+Pg0KPj4+IEEgd29yZCBvZiBleHBsYW5hdGlvbiB3aHkgdGhp
cyBwYXRjaCBoYXMgYmVlbiBzZW50Lg0KPj4+IER1cmluZyByZXZpZXdpbmcgdGhlIGNkbnNwIGRy
aXZlciBDaHVuZmVuZyBZdW4gYWRkIHN1Y2ggY29tbWVudDoNCj4+Pg0KPj4+ICINCj4+Pj4gKwlj
ZG5zLT5kZXZfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgInBlcmlwaGVyYWwi
KTsNCj4+Pj4gKwlpZiAoY2Rucy0+ZGV2X2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4+PiArCQly
ZXR1cm4gY2Rucy0+ZGV2X2lycTsNCj4+Pj4gKw0KPj4+PiArCWlmIChjZG5zLT5kZXZfaXJxIDwg
MCkNCj4+Pj4gKwkJZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgcGVyaXBoZXJhbCBpcnFcbiIp
Ow0KPj4+IFVzZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbD8gb3RoZXJ3aXNlIG5v
IG5lZWQgcHJpbnQgdGhpcyBsb2csDQo+Pj4gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUoKSB3aWxs
IHByaW50IGl0Lg0KPj4+ICINCj4+Pg0KPj4+IEluIHRoaXMgcGF0Y2ggSSd2ZSBjaG9zZW4gdGhl
IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsIGJlY2F1c2UgYm90aA0KPj4+IGZ1bmN0
aW9uIGRvIHRoZSBzYW1lIGJ1dCB0aGUgZXJyb3IgbWVzc2FnZSBmcm9tIGNvcmUuYyB0ZWxsIHVz
IGxpdHRsZSBtb3JlIHRoZW4NCj4+PiBnZW5lcmljIG1lc3NhZ2UgZnJvbSBwbGF0Zm9ybV9nZXRf
aXJxX2J5bmFtZS4NCj4+DQo+PlVzaW5nIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFs
KCkgc2F5cyBkcml2ZXIgZXhwZWN0cyBpdCBpcyBvcHRpb25hbCBidXQNCj4+b25seSB0byBmYWls
IGxhdGVyLiBJdCB3aWxsIGJlIGNvbmZ1c2luZyB0byBuZXcgcmVhZGVyIHRoYXQncyBhbGwuIEkg
bGVhdmUgaXQgdG8NCj4+eW91IHRvIGRlY2lkZSB3aGF0IGFwcHJvYWNoIHRvIHRha2UuDQo+DQo+
VGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLg0KPkkgd2lsbCBzZW5kICBuZXcgcGF0Y2ggd2l0aCBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZS4NCj4NCj5DaGVlcnMsDQo+UGF3ZWwNCj4NCj4+DQo+Pj4+
DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEEgY2hhbmdlIHdhcyBzdWdnZXN0ZWQg
ZHVyaW5nIHJldmlld2luZyBDRE5TUCBkcml2ZXIgYnkgQ2h1bmZlbmcgWXVuLg0KPj4+Pj4+Pg0K
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlbCBMYXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29t
Pg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gICAgIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyB8IDQg
KystLQ0KPj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+Pj4+PiBpbmRleCBhMGY3M2Q0
NzExYWUuLmEzZjZkYzQ0Y2YzYSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvY2Ru
czMvY29yZS5jDQo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+Pj4+
PiBAQCAtNDY1LDcgKzQ2NSw3IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgIAljZG5zLT54aGNpX3Jlc1sx
XSA9ICpyZXM7DQo+Pj4+Pj4+DQo+Pj4+Pj4+IC0JY2Rucy0+ZGV2X2lycSA9IHBsYXRmb3JtX2dl
dF9pcnFfYnluYW1lKHBkZXYsICJwZXJpcGhlcmFsIik7DQo+Pj4+Pj4+ICsJY2Rucy0+ZGV2X2ly
cSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsICJwZXJpcGhlcmFsIik7
DQo+Pj4+Pj4NCj4+Pj4+PiBBcyBwZXIgRFQgYmluZGluZyBkb2N1bWVudCwgdGhlc2UgYXJlIG1h
bmRhdG9yeSBwcm9wZXJ0aWVzDQo+Pj4+Pg0KPj4+Pj4gSSB0aGluayB0aGF0IG5hbWUgcGxhdGZv
cm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwgaXMgbGl0dGxlIGNvbmZ1c2luZy4NCj4+Pj4+IEZ1
bmN0aW9uIGRlc2NyaXB0aW9ucyBzaG93IHRoYXQgYm90aCBhcmUgYWxtb3N0IGlkZW50aWNhbDoN
Cj4+Pj4+IC8qKg0KPj4+Pj4gICAgKiBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbCAt
IGdldCBhbiBvcHRpb25hbCBJUlEgZm9yIGEgZGV2aWNlIGJ5IG5hbWUNCj4+Pj4+ICAgICogQGRl
djogcGxhdGZvcm0gZGV2aWNlDQo+Pj4+PiAgICAqIEBuYW1lOiBJUlEgbmFtZQ0KPj4+Pj4gICAg
Kg0KPj4+Pj4gICAgKiBHZXQgYW4gb3B0aW9uYWwgSVJRIGJ5IG5hbWUgbGlrZSBwbGF0Zm9ybV9n
ZXRfaXJxX2J5bmFtZSgpLiBFeGNlcHQgdGhhdCBpdA0KPj4+Pj4gICAgKiBkb2VzIG5vdCBwcmlu
dCBhbiBlcnJvciBtZXNzYWdlIGlmIGFuIElSUSBjYW4gbm90IGJlIG9idGFpbmVkLg0KPj4+Pj4g
ICAgKg0KPj4+Pj4gICAgKiBSZXR1cm46IG5vbi16ZXJvIElSUSBudW1iZXIgb24gc3VjY2Vzcywg
bmVnYXRpdmUgZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+Pj4+PiAgICAqLw0KPj4+Pj4NCj4+
Pj4+Pg0KPj4+Pj4+ICAgIC0gaW50ZXJydXB0czogSW50ZXJydXB0cyB1c2VkIGJ5IGNkbnMzIGNv
bnRyb2xsZXI6DQo+Pj4+Pj4gICAgICAgICAgICJob3N0IiAtIGludGVycnVwdCB1c2VkIGJ5IFhI
Q0kgZHJpdmVyLg0KPj4+Pj4+ICAgICAgICAgICAicGVyaXBoZXJhbCIgLSBpbnRlcnJ1cHQgdXNl
ZCBieSBkZXZpY2UgZHJpdmVyDQo+Pj4+Pj4gICAgICAgICAgICJvdGciIC0gaW50ZXJydXB0IHVz
ZWQgYnkgRFJEL09URyAgcGFydCBvZiBkcml2ZXINCj4+Pj4+Pg0KPj4+Pj4+IGZvciBkcl9tb2Rl
ID09ICJvdGciIC0+IGFsbCAzIGFyZSBtYW5kYXRvcnkuDQo+Pj4+Pj4gZm9yIGRyX21vZGUgPT0g
Imhvc3QiIC0+ICJvdGciIGFuZCAicGVyaXBoZXJhbCIgSVJRcyBhcmUgbm90IHJlcXVpcmVkLg0K
Pj4+Pj4+IGZvciBkcl9tb2RlID09ICJwZXJpcGhlYXJhbCIgLT4gIm90ZyIgYW5kICJob3N0IiBJ
UlFzIGFyZSBub3QgcmVxdWlyZWQuDQo+Pj4+Pj4NCj4+Pj4+Pj4gICAgIAlpZiAoY2Rucy0+ZGV2
X2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4+Pj4+PiAgICAgCQlyZXR1cm4gY2Rucy0+ZGV2X2ly
cTsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gQEAgLTQ3Nyw3ICs0NzcsNyBAQCBzdGF0aWMgaW50IGNkbnMz
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4+Pj4+ICAgICAJCXJldHVy
biBQVFJfRVJSKHJlZ3MpOw0KPj4+Pj4+PiAgICAgCWNkbnMtPmRldl9yZWdzCT0gcmVnczsNCj4+
Pj4+Pj4NCj4+Pj4+Pj4gLQljZG5zLT5vdGdfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUo
cGRldiwgIm90ZyIpOw0KPj4+Pj4+PiArCWNkbnMtPm90Z19pcnEgPSBwbGF0Zm9ybV9nZXRfaXJx
X2J5bmFtZV9vcHRpb25hbChwZGV2LCAib3RnIik7DQo+Pj4+Pj4+ICAgICAJaWYgKGNkbnMtPm90
Z19pcnEgPT0gLUVQUk9CRV9ERUZFUikNCj4+Pj4+Pj4gICAgIAkJcmV0dXJuIGNkbnMtPm90Z19p
cnE7DQo+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBSZWdhcmRzLA0KPj4+
Pj4gUGF3ZWwNCj4+Pj4+DQo+Pj4+DQo+Pj4+IC0tDQo+Pj4+IFRleGFzIEluc3RydW1lbnRzIEZp
bmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPj4+PiBZLXR1bm51
cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQ0K
Pj4NCj4+LS0NCj4+VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAy
MiwgMDAxODAgSGVsc2lua2kuDQo+PlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtv
dGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
