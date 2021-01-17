Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF72F91B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbhAQKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:18:08 -0500
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:36163
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbhAQKRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn+QiVKKJ7OpWvhMoOyVttgFDS2FTNRs3i1vs3zR9lZTWzhI9g8Vpl53oPw0PmBqW46eGCvHHBbnIUl/kYXdaKe35ilmAqfJMNSJPsdNj8ugtOJ3Jo/yfqSWj0kWVovmFEKt8SYuYiittLmCrDDxiHzs+etXvKXCS2cLaWrIpkMqzyq6YGHasErbvWu7QPjcLeavraCZbZI+L1mnWUBOx/20Fup+YvganXLkCQfW0GV3pZVSyLQ1UrJMk4ypSyufuhWrmIS6hUBrrFeY16HscCQ6kfAQxGMLRlwxpjs1t+M+Iv/7Dj6kWelRhTs6kgr9UX8qQ+dgClWCitfAh8ED+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiBdqmCXWlhg9fLOX+vAq+YjTQ2f6KZ7CD/iTbzaxek=;
 b=Mq0lqiY81dYIb6WZ1CkIEAKadgPcMLRe/ShrcDphnxCQl4xNwSbn3qyvCLQ8HVbQ2vDQdQKb2YuoSNztvokvFKOI2iOx2ihIUZmkN0Jg5GUizy/A9eSZUmERD7ImtyeoAcz5W5R/GHxUmNIMpAQR07juzF7Vel2VwzptjFTz9/k+b/RFU4Phs06aoUv7wu+dqTKqTVKKmbTvlrVT37xxfI3iTq4JD0av6K+8YEmrw3hc0Rq/Fo+uoID53Z5/6ECzo/B9BH/ByNXzuZIBotovMfB8MoYCZH+ACxw8B4SYn4/JoxWJjtceZP/OUr8IdtJqCYhqha5NHMT5fSI0o8pntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiBdqmCXWlhg9fLOX+vAq+YjTQ2f6KZ7CD/iTbzaxek=;
 b=Fel/misfxPCy+15BS1xAzTYAWUT0OSfFETdcNq6zQ+AoLcjhKrYpddIDgORUFlTFY56qEkG13XkdqF5hasHm9wYnR/7+3U3Y4GsPb9nyT1+GI+NnHNc0qAlEtEPiUwj6HZkFQFL7dQ9p1Tpo51h6e0EKnupSkngfvC83e7j76Rk=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2918.namprd11.prod.outlook.com (2603:10b6:a03:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sun, 17 Jan
 2021 10:16:23 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3763.014; Sun, 17 Jan 2021
 10:16:23 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "laijs@linux.alibaba.com" <laijs@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogUXVlc3Rpb24gb24gICB3b3JrcXVldWU6IE1hbnVhbGx5IGJyZWFr?=
 =?gb2312?Q?_affinity_on_hotplug?=
Thread-Topic: Question on   workqueue: Manually break affinity on hotplug
Thread-Index: AQHW6kaGanHzOLWWlkGf08xC7Dod66om1gUAgAS7tyM=
Date:   Sun, 17 Jan 2021 10:16:23 +0000
Message-ID: <BYAPR11MB263266CF64A8EE2A91B979E5FFA50@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB2632FC41FF64133708F4537FFFA80@BYAPR11MB2632.namprd11.prod.outlook.com>,<YAAK1MOPAPjrbSIt@hirez.programming.kicks-ass.net>
In-Reply-To: <YAAK1MOPAPjrbSIt@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [106.39.151.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e9a5191-875e-4fb9-1b38-08d8bad0f118
x-ms-traffictypediagnostic: BYAPR11MB2918:
x-microsoft-antispam-prvs: <BYAPR11MB29181FE2901D8FA12270A01EFFA50@BYAPR11MB2918.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gB3CyFMISx5ZbH8LoER/mCdnvs3a54iWoiBCz/ueDY3k/00aluRpfI/pU1mq6EJoSrQVRFh3Za+fu42HvWq1j/MIJ3Ub2gocUZs0GWoZ2AXMg27vRPufExpLcjm8BkL32d0f0tBwah+G8saGklvH7ljYI3WE2XD2pR9QhsZzPg2flhGWOPJOkeCWDjT8BfPD3X3yUcIC5VPLnwKocUZ1erwb8Gnp+BywxGSd9zJUi1gol6gvrebIZWh5z4SL1YI7N9WF+SYv++1YR4QUTmCMmLDFNEj+8ijmpfoMlj8yAkub1/aIZ6rXAkHitimBB76FPNTUzFLCoTq35GklaRa44fYzGctOsarPBlFJ41iziSIEq7sAEb31Pw/aObe8tuBertnXdjQGr8IdnNQhWZT2Y9iovLmaatpV4GQqLSFVeRI+oToljlvL36RGnfmEL9+MkgY+xJeUEKCbmEErg/+h+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39840400004)(316002)(33656002)(6506007)(110136005)(8936002)(4326008)(91956017)(76116006)(186003)(966005)(478600001)(26005)(71200400001)(52536014)(86362001)(5660300002)(64756008)(66446008)(66556008)(66476007)(66946007)(224303003)(7696005)(83380400001)(2906002)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RDJuTEo2UTQ5OERyaDdQK2JIbHZ1SENvQjNpVkluMmhLK0UxWGs3OU1wcXpr?=
 =?gb2312?B?RysyeU5Hd1BZaEhpSXRHc0lvWEpoSFRsUVhOVHFUTG8ySWxkRXhCZnRFeDdC?=
 =?gb2312?B?NUhjN3I3ZTBBUktPdll0bDZWOWt0eWw5RE9NWmt1ODd5QU5ickxPZjViU2px?=
 =?gb2312?B?UUFQNzFIWGdwcU9mRmM2TVIxWWdFdVRWSW1jZk9XbWwxcm5MRGZVYXVZK3VU?=
 =?gb2312?B?U0k2YVF4Ync2cWFPdWZFTTVrTFh2QTV6VWpxZy9ZK2Rpa2U2eXUrbDNjQTFa?=
 =?gb2312?B?L0xBcUluOXMwMzB2MzVibXhtMXorZ0xmYVZHWWIwaFR3dGhVVmV2RlBSa0g2?=
 =?gb2312?B?V3ZVOU9MWlRRTDdZL3o1ZktZMmhDOFZWOHVaNFRsMy9Ndi9TRGQvbWRUY3Nz?=
 =?gb2312?B?TjdJZVhsNkRyaTRUU2ViRkRzNjJpRFFGekNTb3l1VE50U3pMVWZsek9IcUxV?=
 =?gb2312?B?VHVoZVVFdjN4QUhvaWZJcXh2dmRHOWxBOTdneGsrTDd1cUFtblJYSUoxazgy?=
 =?gb2312?B?WXBwWWpJTVN1elBVV0t0Y2c3Q1RYb3VEN1ZKRXlJVytxMzVmMG1BZXlEblZl?=
 =?gb2312?B?QVBtNkI0L1V3YzlWUndHU0wrQkxTczBwZ1I3aXhGTU5GbkRUOThEdDJDSFhD?=
 =?gb2312?B?eVdHZ3RYV0NYWE1MeGp2ckRtejFJMXdVbHdmRmlCNnV1bG5EeTNsaG1WWC92?=
 =?gb2312?B?bk1hdWNsTUx0NDRTbGZmeU1Zd04wWmxpdE9sam1ibjhHNys2R2pLcHBrM2Fw?=
 =?gb2312?B?RWxpL0N2bXMzK1VwOUp3d0NlZ0wxVUZ1dHFrUUVmbHdLWERDUjlURUU2SStr?=
 =?gb2312?B?dk5ON2x0ckppb2EwWjY0bTRpTDBGVDExTlBYdUlISjEyR05FcklVUWZkYVo3?=
 =?gb2312?B?UHZzRnVjNWNHZS8xQkxCZitjaVk5TURpMWdOQi9Yb0YyTHdyWCtYYUFnM1ow?=
 =?gb2312?B?SXdUNTZaMEp0VjQwSTNtakNNSXZNTjdNTGNza2NwMXhXd01FcWFyTllacjls?=
 =?gb2312?B?Vno3Y3hEOTRTRkhLRU5XcHhaSVBnYVhhYldRTHlEeFRiZkxCY1dQcjZJNlBx?=
 =?gb2312?B?Z3lwSjdzTktEcXFLOG5ZK1pDV3JibXNXOTF4ZW1XbnJkVlFVZ2NodTVWeVda?=
 =?gb2312?B?NWhsbGtSWHF2M29XaGczc1hKMExjQXFDN1JERjVEeHE2Y1ppSzcySG1Ec2Rx?=
 =?gb2312?B?bXFQTEtSbzlCaGZRbkJWK2gzZktFMUNkZnhVZGoxSXdldWUzcDFMYm1WcmNi?=
 =?gb2312?B?L3I0cUZiRDkyY3dRZGkvMEJ2NXk1dGhhL0VycGNHWTlxbUVjY0drUW1OVGZK?=
 =?gb2312?Q?tyjroofZyur6U=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a5191-875e-4fb9-1b38-08d8bad0f118
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2021 10:16:23.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pp+RvYAR+O0wQWqWweQP6i0h3gRVp+83Lb7b+e0fGPaurvNoZeAUvAWVWeQaUB7E6vroM8ZANj9XXxVhnrre+3IUWIEADP8k2G6aRTHdDMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGV0ZXIsIExhaQ0KDQpTb3JyeSB0byBkaXN0dXJiIGFnYWluLCBJJ20gc3RpbGwgY29u
ZnVzZWQsIHdoZW4gdGhlIENQVSBpcyBvZmZsaW5lLCB3ZSBhY3RpdmUgIGNhbGwgc2V0X2NwdXNf
YWxsb3dlZF9wdHIgZnVuY3Rpb24gIHRvIHJlc2V0IHBlci1jcHUga3RocmVhZCBjcHVtYXNrLA0K
aW4gc2NoZWRfY3B1X2R5aW5nIGZ1bmN0aW9uICwgbWlncmF0ZV90YXNrcyBmdW5jdGlvbiB3aWxs
IHJlc2V0IHBlci1jcHUga3RocmVhZCdzIGNwdW1hc2sgb24gcnVucSwgZXZlbiBpZiBub3Qgb24g
cnVucSwgd2hlbiB3YWtlIHVwLCAgb3RoZXIgb25saW5lIENQVXMgd2lsbCBhbHNvIGJlIHNlbGVj
dGVkIHRvIHJ1bi4NCg0Kd2hhdCBJIHdhbnQgdG8gYXNrIGlzIHdoeSB3ZSB0YWtlIHRoZSBpbml0
aWF0aXZlIHRvIHNldCBpdCB1cD8NCg0KVGhhbmtzDQpRaWFuZw0KDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPg0Kt6LLzcqxvOQ6IDIwMjHE6jHUwjE0yNUgMTc6MTENCsrVvP7Iyzog
WmhhbmcsIFFpYW5nDQqzrcvNOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBS
ZTogUXVlc3Rpb24gb24gICB3b3JrcXVldWU6IE1hbnVhbGx5IGJyZWFrIGFmZmluaXR5IG9uIGhv
dHBsdWcNCg0KW1BsZWFzZSBub3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1t
YWlsIGFkZHJlc3NdDQoNCk9uIFRodSwgSmFuIDE0LCAyMDIxIGF0IDA4OjAzOjIzQU0gKzAwMDAs
IFpoYW5nLCBRaWFuZyB3cm90ZToNCj4gSGVsbG8gUGV0ZXINCj4NCj4gRXhjdXNlIG1lLCBJIGhh
dmUgc29tZSBxdWVzdGlvbnMgZm9yIHlvdSwgYWJvdXQgYSBkZXNjcmlwdGlvbiBvZiB0aGlzIGNo
YW5nZToNCj4NCj4gJydEb24ndCByZWx5IG9uIHRoZSBzY2hlZHVsZXIgdG8gZm9yY2UgYnJlYWsg
YWZmaW5pdHkgZm9yIHVzIC0tIGl0IHdpbGwNCj4gc3RvcCBkb2luZyB0aGF0IGZvciBwZXItY3B1
LWt0aHJlYWRzLiINCj4NCj4gdGhpcyBtZWFuIHdoZW4gY3B1aG90cGx1Zywgc2NoZWR1bGVyIGRv
IG5vdCAgY2hhbmdlICBhZmZpbml0eSBmb3IgcGVyLWNwdS1rdGhyZWFkJ3MgdGFzaywgaWYgd2Ug
bm90IGFjdGl2ZSBzZXR0aW5nIGFmZmluaXR5Pw0KPiBidXQgaWYgcGVyLWNwdS1rdGhyZWFkJ3Mg
dGFzayBpcyBub3QgcnVuIHN0YXRlLCB3aGVuIHdha2UgdXAsICB3aWxsIHJlc2V0IGl0J3MgYWZm
aW5pdHksIHRoaXMgIGlzIGRvbmUgYXV0b21hdGljYWxseS4NCj4NCj4gb3IgaXMgaXQsICB0aGlz
IHBsYWNlIG1vZGlmaWVkIHRvIGZpdCB0aGUgbmV3IG9uZSBob3RwbHVnIG1lY2hhbmlzbSB3aGlj
aA0KPiAoInNjaGVkL2hvdHBsdWc6IENvbnNvbGlkYXRlIHRhc2sgbWlncmF0aW9uIG9uIENQVSB1
bnBsdWciKT8NCg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDIwMTIxNDE1NTQ1Ny4zNDMw
LTEtamlhbmdzaGFubGFpQGdtYWlsLmNvbQ0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDIw
MTIxODE3MDkxOS4yOTUwLTEtamlhbmdzaGFubGFpQGdtYWlsLmNvbQ0KaHR0cHM6Ly9sa21sLmtl
cm5lbC5vcmcvci8yMDIwMTIyNjAyNTExNy4yNzcwLTEtamlhbmdzaGFubGFpQGdtYWlsLmNvbQ0K
aHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDIxMDExMTE1MjYzOC4yNDE3LTEtamlhbmdzaGFu
bGFpQGdtYWlsLmNvbQ0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDIxMDExMjE0NDM0NC44
NTA4NTA5NzVAaW5mcmFkZWFkLm9yZw0K
