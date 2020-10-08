Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E05286D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 06:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgJHES1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 00:18:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21490 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgJHES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:18:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09849RpM028060;
        Wed, 7 Oct 2020 21:18:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ELkjynPTbR27UYa9Lx57DcRTeZkEQYoELdh0t6vaLtQ=;
 b=PWoa5ETK4/byEzuZOG187zeFc50xt8htTHvk7XAvO7HaLlwKXgGHENQdBU4FAMTWV/96
 u+f5kQbuPKoRzXXl5prDHvMRMBbaC67oTIcx7WBpsS7B4oDyttNLyNpNuXlkqo0ESdB/
 IbCQu1cI1bKmByoE0WGSm5eRJrv9uP4gsyCRbKxSRzxdkKGl6i/E3sl8hqG2K9adbELh
 pNq83MiKR6k761TXpxVUQw8ySPS31GQVaEPjoQxGVpFi7YVSoKxfKARFJu0noZhLc7I1
 QUZtrDV+dVijgJmgIV4IMVz4DdQbM7qkZDVbBMAQeVBP6DXJyT57LcUqpvsRM3B3izs3 ow== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33xmvygusg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 21:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIDwQginDwaY06ChJ0MoDLXObuBUlSlXJEiiTZx7fXEVoVz5QR44sTu1BktHb5bv1dyWtqrQjc/foMkC+TV7MQMFkT+LRvU+vsoIDZU9syuwTx13eO2f4DxsJJSt6mjRlfhBtJg/9mCWO6V7JIO+SrPaeVnvJPSXVg++uvA3cJ/ekwASIEqeFcRlaKim2eRm8QP1ShkSPX0V0WL+A5DVBrkPQlHJnrpL4kFA7UFILG7LgTLhbeCtc5vD7Th5YsTg9mxX7lLfFbvkmLOCe9bSEkudmbVyd2tN8XIG1qIbhBYNe+zVIV/q0i70qQNw3RP6YeHubSnEUlDgvXI8y2Pz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELkjynPTbR27UYa9Lx57DcRTeZkEQYoELdh0t6vaLtQ=;
 b=maB8oNdjVvcLGaYlOrEDF9kiXMgeV1ml+iD0tK01j4/4Z4TpziQb78DaX6+eEhU9neR1YpG8UF81HZTlmet5RysrvLp79/IYFrND3LcXQvxAyBlAiYn6Fe31CwImfR1uhyE+C8oiywiq245VPGI6va098thkzM0g25HNle0j2ByRxhoUW2ksrcpf0kSdu5m4p0J0bdLhnB/cqQWLB1GBJxc6MvcqCiV1okNXh4TKFVQm4qrcKZbYZOe0ATcyDr/5ub1ZaJM63tEgG51p0MLRrPV4Bkt6apVtR/c7DzBm/Rjm1LkSgKbVMf2n4/1figcbYUmetCOuEMvMoAujT5F6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELkjynPTbR27UYa9Lx57DcRTeZkEQYoELdh0t6vaLtQ=;
 b=lzYFqtkdEYjCl/jaX0ZfT/22nFU4cbFxVOAfFm2/LCuu7MfT8/KA6tVXUlTWkeUS7XWDYNIHA41pYQ2FQtP5wqFBOkLnPj9HkyeUos7VeoXSSVmWLyZ7MSU9IQngofmCufM5/5V4XRzdmNBZjZ2aEYoaYik7kgRZ1bustS0UFiM=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB4827.namprd07.prod.outlook.com (2603:10b6:5:9d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Thu, 8 Oct 2020 04:18:18 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 04:18:18 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH 1/2] usb: cdns3: Rids of duplicate error message
Thread-Topic: [PATCH 1/2] usb: cdns3: Rids of duplicate error message
Thread-Index: AQHWnFsj/OWpXLBPm02Us9/qEhBWbamLyiUAgAFOryA=
Date:   Thu, 8 Oct 2020 04:18:17 +0000
Message-ID: <DM6PR07MB55292BB3A7BC0A46EE2F5124DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201007033531.22526-1-pawell@cadence.com>
 <94ff37e9-8a32-b61b-5ede-1b71b6a3d4ab@ti.com>
In-Reply-To: <94ff37e9-8a32-b61b-5ede-1b71b6a3d4ab@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDkwOGRkZmMtMDkxZC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ5MDhkZGZkLTA5MWQtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTg2OCIgdD0iMTMyNDY2MDQyOTU5NTAwNTg2IiBoPSJJK1dnUGx2ZkVvd2dEWnVLZk8xbWFrSllaYTg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3b636f2-abd2-431b-5fe4-08d86b412f1f
x-ms-traffictypediagnostic: DM6PR07MB4827:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB4827B04811741AD135C4C4F0DD0B0@DM6PR07MB4827.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFUdjrgA9xhQ8FwQ8g1jPsbygdZT5NZuYUW7ezcmQesktmgqDuuZGSeUk6LgxLxdrDEKg8I2z9QUARTi+oE8jUJL88pXnUKlwTy+wLU+fGiKUHTNl4TBE52PCVLnLv06dwdAPW5f+LDbXXjo6fwKbQOkxCsW5K+aOx5pITlvfiKu6vSLyo0OmaNSDdFWlMb7sTGBhUIPPiOC4NqcYCSlsAlue4iEaOElH7YBppy7H0LdHcnDLch/9E4vxnZN4bW1Aip0rmtDNgfa516oy4SY3i12VLZ+xwNUC3nTQUbiXvWcf3G5Z8p3vZzV6eezAj+zlW2c1ehCVOy1RrN0/PYrsPCHH9Enf2iEH4d0AhKU80Nsemjkd0cVLpGsfjEfGu/b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(36092001)(8676002)(66476007)(64756008)(66946007)(478600001)(76116006)(52536014)(5660300002)(66556008)(4326008)(8936002)(316002)(15650500001)(54906003)(7696005)(26005)(9686003)(33656002)(71200400001)(55016002)(66446008)(110136005)(6506007)(83380400001)(2906002)(107886003)(186003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QX88UIVvfRAhDI4NDi32GjcUkCXeQBqLWrGov2aHGk95z/+j05cDZGgjgw/3IkDeGmjxhmiY/t6/4AV6pjsPueIH5kEXNLKA/HrE1qBxf/dHbMalFwx1FajVzjKb1T90mS7HlqU6UT/f0kIYxNh6QcTujhBhTbBxnj/aNDvKVF8KJa5lzFHBYMlJlU8YFjaK5MBH1BnoUQxgv+slt5jvKUiZ8Ohj/hUAXX0y0nvi+0v6ad128VcXV7tGGTEAkM8kydAPrZeUcXonRGle1QrGNtUsXjItTeS8IbEH2ndTQ5H7VV18USCs6fcTrDG71J1KIUyspivuPhiG0llqOeTFr8YqK7Syre+5WH7pb7P3Y0hyyq9gVUTK//uflPL/5icpI1PaXJmal0vkC8aY44ZrRwP6rQr+DD205KaGlgi7U38JvVplEKazd0OUosOOtBJ5m9IUEfpvSf8bR2Z3es02PbX6Xf2m1reEHW9HIhXXCrg2/ym4LGuxlTcx62ajxA8A6sXhBmcSMT02bL/h9Bo/OoY86u+8vIH44QXWoRzzZm/Z9P0vJ8A+U+Ttysrl9h1B+oCig/mMZ9CKABKjJDwTo/wfiIit/Thh0pFTgdSpf1bkYZT65ZtmGJh4Tsi1tXZyD/oA5HH6b9c7tQDbseTfHQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b636f2-abd2-431b-5fe4-08d86b412f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 04:18:17.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /taaPKjPdR+H1DwDRS6rACbS3+Fbuamd9xQS7HWMSh3eBenGrv46uqPeFhC6PcCpO6rsLCG+24kxJL2yOf2Olqdbo09kWDsJ4Plo6Gl5NX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4827
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_01:2020-10-07,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=971 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCj4NCj5PbiAwNy8xMC8yMDIwIDA2OjM1LCBQYXdlbCBMYXN6Y3phayB3cm90
ZToNCj4+IE9uIGZhaWx1cmUsIHRoZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSBwcmludHMgYW4g
ZXJyb3IgbWVzc2FnZQ0KPj4gc28sIHBhdGNoIHJlbW92ZXMgZXJyb3IgbWVzc2FnZSByZWxhdGVk
IHRvIHRoaXMgZnVuY3Rpb24gZnJvbQ0KPj4gY29yZS5jIGZpbGUuDQo+Pg0KPj4gQSBjaGFuZ2Ug
d2FzIHN1Z2dlc3RlZCBkdXJpbmcgcmV2aWV3aW5nIENETlNQIGRyaXZlciBieSBDaHVuZmVuZyBZ
dW4uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNl
LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMgfCA3ICstLS0tLS0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9j
ZG5zMy9jb3JlLmMNCj4+IGluZGV4IGEwZjczZDQ3MTFhZS4uNGZkM2M3NDJkOWQ1IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy91c2IvY2RuczMvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9j
ZG5zMy9jb3JlLmMNCj4+IEBAIC00NjksOSArNDY5LDYgQEAgc3RhdGljIGludCBjZG5zM19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAJaWYgKGNkbnMtPmRldl9pcnEg
PT0gLUVQUk9CRV9ERUZFUikNCj4NCj5pZiAoY2Rucy0+ZGV2X2lycSA8IDAgJiYgY2Rucy0+ZGV2
X2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KDQpJdCdzIHRoZSBzYW1lIC0gY2Rucy0+ZGV2X2lycSA9
PSAtRVBST0JFX0RFRkVSIDwgMCANCg0KDQo+PiAgIAkJcmV0dXJuIGNkbnMtPmRldl9pcnE7DQo+
Pg0KPj4gLQlpZiAoY2Rucy0+ZGV2X2lycSA8IDApDQo+PiAtCQlkZXZfZXJyKGRldiwgImNvdWxk
bid0IGdldCBwZXJpcGhlcmFsIGlycVxuIik7DQo+PiAtDQo+PiAgIAlyZWdzID0gZGV2bV9wbGF0
Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAiZGV2Iik7DQo+PiAgIAlpZiAoSVNf
RVJSKHJlZ3MpKQ0KPj4gICAJCXJldHVybiBQVFJfRVJSKHJlZ3MpOw0KPj4gQEAgLTQ4MSwxMCAr
NDc4LDggQEAgc3RhdGljIGludCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPj4gICAJaWYgKGNkbnMtPm90Z19pcnEgPT0gLUVQUk9CRV9ERUZFUikNCj4NCj5pZiAo
Y2Rucy0+b3RnX2lycSA8IDAgJiYgY2Rucy0+b3RnX2lycSA9PSAtRVBST0JFX0RFRkVSKQ0KDQpJ
dCBzaG91bGQgYmU6DQppZiAoY2Rucy0+ZGV2X2lycSA8IDAgfHwgY2Rucy0+ZGV2X2lycSA9PSAt
RVBST0JFX0RFRkVSKQ0Kb3IgZXZlbnQNCmlmIChjZG5zLT5kZXZfaXJxIDwgMCkNCg0KQW0gSSBy
aWdodCA/DQoNCj4NCj4+ICAgCQlyZXR1cm4gY2Rucy0+b3RnX2lycTsNCj4+DQo+PiAtCWlmIChj
ZG5zLT5vdGdfaXJxIDwgMCkgew0KPj4gLQkJZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgb3Rn
IGlycVxuIik7DQo+PiArCWlmIChjZG5zLT5vdGdfaXJxIDwgMCkNCj4NCj55b3UgY2FuIHRoZW4g
Z2V0IHJpZCBvZiB0aGlzIGlmIHt9Lg0KPg0KPj4gICAJCXJldHVybiBjZG5zLT5vdGdfaXJxOw0K
Pj4gLQl9DQo+Pg0KPj4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgIm90ZyIpOw0KPj4gICAJaWYgKCFyZXMpIHsNCj4+DQoNCkNoZWVy
cywNClBhd2VsbA0K
