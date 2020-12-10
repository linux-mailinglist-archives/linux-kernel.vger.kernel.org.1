Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A92D534E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgLJFbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:31:22 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13158 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725885AbgLJFbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:31:22 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BA5TRF0012539;
        Wed, 9 Dec 2020 21:30:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=PL4zgDyQAD4FBHAQfJtbSsf0E1to+1AIHM7Lw93u2xo=;
 b=UQIIG6109uOYOQPWxwCaVuJ1Wa2wpqBKnXoT7v5lZb7wuyMwpuvQTfGd8MRn/PN8jJZu
 I7uBK32jdesVzRnDdzOJ6rTClB5qNiAdhj/YkP8w4K6c/E28kBDDajHeeZj0IxtUEpaR
 40ZwRyqLKHZTiUl+fYW2MSVD6NbGvHUpU7jwF+j+yGmfvhmwCtO51SCwkIUPwDRD7mXA
 TEc2Cj4TG5hRtCc4GFBpkxoXHcNIgd9fi6TeKpR1JAvytnaA+nTcUJ0s3Ue1jkQk/E+X
 inr/qT2prXD2/AybZ6NiYD+uo/eKdbgnD0eXLm5swoFhkhcVku7Lnl0i8z+pFrhmEyiv Tg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3586p489qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 21:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9uHyEXaId3CMU9imdTmQ6BbuW1Zm2k/wgM6kpzb3ucDZBwfvzxenHqETRYg1ET4y5DMVt8MP38nnSM5LL2BVZkXeFDD55rCFnfBaNHnXyPfdBzY2ER97bf1lvTV4RwQCBtDA5Yp/vT0SXOSAd6TNdCdGOVfj8lolSO8ubu+bOesnGVh13uLv28W+3OTv5Grsw07miy0B6KN/PVmZL0QG9tZi65zjItGtbNgD/KNzd9i3bGg0goykJFICR86U7BxpWG5NCFLTB4zmb/a+1X9PXQxKUXQexTgq+EZCEMdQA1HpT14Vvxa+8CkqPj5y9Ya7yHMKqXVIAmKPbgvyu5z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL4zgDyQAD4FBHAQfJtbSsf0E1to+1AIHM7Lw93u2xo=;
 b=DMEHr6P7ewBIuqEH1r+6wV32EckRupCF9PN7/4tNRP+aS/KZI47I21AGeoFIbWRkb4pBBYLEKiq5ecI7ACweQ2eKHLbymHyg6v7l8OWRZuQgnz4K92cLyO3v80bVhnGNbn09qIFhMaQ1Q4/OvU2WsgDjHYZl9KD4aeT+z8D15XFVDCS4GSXh6pfv5An6MevghrqdsFHcWrDtwtrH7y6HjbzDbezpBO+S2akCVNYX6JJkqd0S0hhK7Sh/MGTwoFV5Z3NvdZsZLEVMrddQQS97AbHcWvyf7vjApXSNcuxFwCGYCFnmT3Ccxm+/1Iw7eO4iza7MfLsTt7JI3O04og0E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL4zgDyQAD4FBHAQfJtbSsf0E1to+1AIHM7Lw93u2xo=;
 b=oN8j1uQq1M1ZzwPCni1KpOYdmPBC7Iruy00tXdIG26w+xBzFu/j+aekTd6+DUF6mBvrAAK8Eal+2u6CeU7vw5d1JrxbDiHz0B3y8iG0wmUUFP9Pu2Sanr427wwfIM39HVKo0Bns6dFBSepa7ea2Th+06nuP9mGn+j1FOqdg1a7A=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4214.namprd07.prod.outlook.com (2603:10b6:a02:c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 05:30:00 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 05:30:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: Fixed kernel test robot warning
Thread-Topic: [PATCH] usb: cdns3: Fixed kernel test robot warning
Thread-Index: AQHWzmgUUN+gJbROwkmmtzrqbuGXy6nvQySAgACJQIA=
Date:   Thu, 10 Dec 2020 05:30:00 +0000
Message-ID: <BYAPR07MB538160822403E8A79BAE29B4DDCB0@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <1607544952-4891-1-git-send-email-jrdr.linux@gmail.com>
 <ae8cd88c-ea5d-a045-c6cd-2579a55f88d2@infradead.org>
In-Reply-To: <ae8cd88c-ea5d-a045-c6cd-2579a55f88d2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmNmOTJmMDMtM2FhOC0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGJjZjkyZjA0LTNhYTgtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMjY1MCIgdD0iMTMyNTIwNTE3OTc1NzEyMTg4IiBoPSJHd0FrekVSVW9uRlJsVVBrWlBEaVM3b0xpTUU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8f8d3ee-95bf-4c56-d0ed-08d89ccca376
x-ms-traffictypediagnostic: BYAPR07MB4214:
x-microsoft-antispam-prvs: <BYAPR07MB4214DCC214CAB459EEDA0811DDCB0@BYAPR07MB4214.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbpvrctB69IWtd7MGv75pK3zO3gq4z4PChnl9MY0vH+YFDhivMAO9jRDU9Lrbey99q8nnJcrC9jmjfN+QIYPDF3yEYl83TETDgFVtfLebd8/rMEK9j6A3w1HOU8rRWRIfBvE44+u9boYrOxRxsnZ8nVIQFaXgmBNEfX+JBlMrMJFfKDGvwZKNbrTDdzw8FIrU/OdKt5X7/nlz+jYTuz9Rs1HVW8j1m5iPZI0FLY0dxyLUUc3cUqAYI3SIymfHxdx3ci24HYcqoNiSsWXomkf5X5b9dgDJdMPoSKt4JEqJe2H72hhQrRNKZnymIs0lTftxzgt2WjIA83OpgNeDt0m3tFSscCghnUygtOkuZvVrr1T4uSqkobeIYQc91T1R2C6+JkLsK0cqJx1XlqcNaFRhLBzuy5OCqYH1OHaIsR7LF71N2qHB0vUYsV6sJ3JpcpiXsZXRJpSIH063MPgAdIwZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(36092001)(186003)(6506007)(508600001)(33656002)(26005)(66946007)(64756008)(66476007)(9686003)(45080400002)(66446008)(5660300002)(8936002)(83380400001)(2906002)(86362001)(55016002)(110136005)(66556008)(52536014)(76116006)(7696005)(71200400001)(54906003)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?LzNnSlBnT2RzSGdxUm43d291V0k3UUswcE9Nak8zUUhsNVlMMVhBbkxzMk1K?=
 =?utf-8?B?ODhCUUplOXYrRFoxNDlvUjZFaEg0ZE9ZWTZDVUo3ZnQ5ZmpqUkI2dDdiWnY0?=
 =?utf-8?B?Y0VMdHp4c0oxTXh3b3pJWEFHRTFhQU9nNVpQL01hblloQTJSc2k1SHpNUmtP?=
 =?utf-8?B?bzF6bklXV0djRCtJSGVtR291QWh3SFZDclZ5Tll0VjNkYmRNL1NaK09UYStx?=
 =?utf-8?B?SmdRZFpLYTR5bEJOZytsekR2dkkxRUNzZjBySVdrMER4eFk5WlJ3SEc3TW80?=
 =?utf-8?B?WUdFeXhrUXAzNy9ScmNCQUlQN3dFUG0zSCt1aFFqOWVXQ2JQWE9waTJGWE1O?=
 =?utf-8?B?VG90aXcwR0pBN0xuSTd1NTZkd3NWM216VWt4dzFLSVZpa2hXajNkZ05XRHRt?=
 =?utf-8?B?bFVtL1A5c1hLZ0QxVmZkY1IxTUtBYklxQ2NRVVZxRUtrb1k5K29DZUIzaC9M?=
 =?utf-8?B?cTg4QU01Y0JuOGJmM3VsTnF2VEdNamhaVW9aekxIeHB3bGN1aGcraGVOOTV2?=
 =?utf-8?B?RFBqMkQ0TWNuZDdVL2tCK2diM2RpeWFKOGlwVEZVOCtBcFZTV3JQTis5OXh3?=
 =?utf-8?B?QjR2STZZM3hsNnZBYTUzSGRaa2tWMlpRNjVOUXNnUlY4blRmODRyUEMrYzZy?=
 =?utf-8?B?NURBNG5YUW9QV00vYnZYRVRBcFhZeUVUREJiVWg1RUxiaHQ5SFNCZlJaU0s5?=
 =?utf-8?B?OFBhdktHcHV5aWxlVjF1cGpEdEVTZjcyYmFodGhFN0JEWjZaMjdRdmJyZDFJ?=
 =?utf-8?B?Sng1MW5YNEcwMHdqQlQ2ZU5TL0dMUWVKdnlrWTcxWVRaVThkREhZMWxmMTQx?=
 =?utf-8?B?aDRRUW9zMEIxZWkvcytWR0t0M0hNQ2RPTFcyZnVBWnJIVWZpSkEvclgzMWZ3?=
 =?utf-8?B?dWhXbGlYM3ZLUEhyZG9zdGZLMlFPdEhpMkFMSHFJdVlFY0VUL2xtZHVHczhF?=
 =?utf-8?B?Q01VZEZ2clNMdm94aFNpU3M0NllCaGFYT3cyYXM3bWNjYWx6MGVnNis2WGk2?=
 =?utf-8?B?L2I2UmhzNVNTQVBoeTJSUnJmOWVKNUw1MEJ6YVFzbVF3T3VsYjdKMjVCdmVn?=
 =?utf-8?B?ZXNQanh1SGFPSXpOb2Y2NnpMSy84clZ4OGdYNmxoNDJHUUdzZWQzQ3JjZXd1?=
 =?utf-8?B?Q2FYTTV6djc1RjVaOGdQMnB5SDA0UVh0VjhtenFDR21RcDI5TTlHYWpyemJV?=
 =?utf-8?B?S3l3WjBLbVg1NXUyQmkwWVpGTjloMFhoSjRwQ0RQTUc2RE1zazdUZkxQNVli?=
 =?utf-8?B?R25ZODJhTTFEMU1jR2JhU2RMZzQrWlNyU2lKZHJnQWx5YzZkbGVIVkhQUWh2?=
 =?utf-8?Q?CvXEwPXvZjSVM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f8d3ee-95bf-4c56-d0ed-08d89ccca376
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 05:30:00.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcYgBE7hp2/Le/hBYbzpkJTLMepKxd4R7UUN0444ps7VrhAn1NFBrVfMoRFUm6hoIexzrGOKiSbZGoBTS1Q+a2Vwa6CJ/Z/BaekybND5hd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_01:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012100035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIDEyLzkvMjAgMTI6MTUgUE0sIFNvdXB0aWNrIEpvYXJkZXIgd3JvdGU6DQo+PiBLZXJu
ZWwgdGVzdCByb2JvdCB0aHJvd3MgYmVsb3cgd2FybmluZyAtPg0KPj4NCj4+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmM6MjM6DQo+Pj4+IGRyaXZlcnMvdXNi
L2NkbnMzL2hvc3QtZXhwb3J0Lmg6Mjc6NTE6IHdhcm5pbmc6ICdzdHJ1Y3QgdXNiX2hjZCcNCj4+
Pj4gZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0
c2lkZSBvZiB0aGlzDQo+Pj4+IGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24NCj4+ICAgICAgIDI3
IHwgc3RhdGljIGlubGluZSBpbnQgeGhjaV9jZG5zM19zdXNwZW5kX3F1aXJrKHN0cnVjdCB1c2Jf
aGNkDQo+PiAqaGNkKQ0KPj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4NCj4+DQo+PiBUaGlzIHBhdGNoIHdpbGwgc2ls
ZW5jZSBpdC4NCj4NCj5SZWFsbHk/ICBEaWRuJ3Qgc2lsZW5jZSBpdCBmb3IgbWUgd2hlbiBJIHRl
c3RlZCB0aGlzIHBhdGNoLg0KPg0KPkFsc28sIHBsZWFzZSBzZWUNCj4NCj5odHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+dXNiL0RCQlBS
MDRNQjc5Nzk1MDIxOTQ0MTBCQjFBRTk2REYwMzhCQ0MwQERCQlBSMDRNQjc5NzkuZXVycHJkMDQu
cHJvZC5vdXRsb29rLmNvbS9ULyptN2Y3M2ZkZDU3YzBmMTU3N2ZiNjEwZGMNCj5hZjI4NjQ2YjUz
ZmE3ZGMyNl9fO0l3ISFFSHNjbVMxeWdpVTFsQSFYWnpIbFk2bHVFSDNRZXBrZ2dFc0hTMHg3b05O
aXowWEk5WGV5M29JUXBmU2QxVVZRRUd6WGJnWHBmUzJFZyQNCj4NCj4od2hhdCBhIHN0cmFuZ2Ug
VVJMKQ0KPg0KPkkgbm93IGdldCB0aGVzZSAyIHdhcm5pbmdzOg0KPg0KPkluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuLi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmM6MjM6MDoNCj4uLi9kcml2ZXJzL3Vz
Yi9jZG5zMy9ob3N0LWV4cG9ydC5oOjI3OjQ0OiB3YXJuaW5nOiDigJhzdHJ1Y3QgdXNiX2hjZOKA
mSBkZWNsYXJlZCBpbnNpZGUgcGFyYW1ldGVyIGxpc3Qgd2lsbCBub3QgYmUgdmlzaWJsZSBvdXRz
aWRlIG9mIHRoaXMNCj5kZWZpbml0aW9uIG9yIGRlY2xhcmF0aW9uDQo+IHN0YXRpYyBpbnQgeGhj
aV9jZG5zM19zdXNwZW5kX3F1aXJrKHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+ICBDQyBbTV0gIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfcXVldWUubw0KPi4uL2RyaXZlcnMvdXNiL2NkbnMz
L2hvc3QtZXhwb3J0Lmg6Mjc6MTI6IHdhcm5pbmc6IOKAmHhoY2lfY2RuczNfc3VzcGVuZF9xdWly
a+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+IHN0YXRpYyBp
bnQgeGhjaV9jZG5zM19zdXNwZW5kX3F1aXJrKHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+DQoNClRoZSBiZXN0IHdheSBmb3IgcmVz
b2x2aW5nIHRoaXMgaXNzdWUgaXMgdG8gcmVtb3ZlIHhoY2lfY2RuczNfc3VzcGVuZF9xdWlyaw0K
ZnJvbSBob3N0LWV4cG9ydC5oIGZpbGUuIEl0J3MgdXNlZCBvbmx5IGluIGhvc3QuYyBmaWxlIHNv
IGl0IGNhbiBiZSBkZWNsYXJlZCB0aGVyZQ0KYXMgc3RhdGljLg0KDQpUaGFua3MNClBhd2VsDQoN
Cj4NCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwuY29tPg0K
Pj4gLS0tDQo+PiAgZHJpdmVycy91c2IvY2RuczMvaG9zdC1leHBvcnQuaCB8IDIgKy0NCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvaG9zdC1leHBvcnQuaCBiL2RyaXZlcnMvdXNiL2Nk
bnMzL2hvc3QtZXhwb3J0LmgNCj4+IGluZGV4IGZiODU0MWIuLmMxMjU5YWYgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9ob3N0LWV4cG9ydC5oDQo+PiArKysgYi9kcml2ZXJzL3Vz
Yi9jZG5zMy9ob3N0LWV4cG9ydC5oDQo+PiBAQCAtMjQsNyArMjQsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBjZG5zX2hvc3RfaW5pdChzdHJ1Y3QgY2RucyAqY2RucykNCj4+ICB9DQo+Pg0KPj4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBjZG5zX2hvc3RfZXhpdChzdHJ1Y3QgY2RucyAqY2RucykgeyB9DQo+
PiAtc3RhdGljIGlubGluZSBpbnQgeGhjaV9jZG5zM19zdXNwZW5kX3F1aXJrKHN0cnVjdCB1c2Jf
aGNkICpoY2QpDQo+PiArc3RhdGljIGludCB4aGNpX2NkbnMzX3N1c3BlbmRfcXVpcmsoc3RydWN0
IHVzYl9oY2QgKmhjZCkNCj4+ICB7DQo+PiAgCXJldHVybiAwOw0KPj4gIH0NCj4+DQo+DQo+DQo+
LS0NCj5+UmFuZHkNCj5SZXBvcnRlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVh
ZC5vcmc+DQo=
