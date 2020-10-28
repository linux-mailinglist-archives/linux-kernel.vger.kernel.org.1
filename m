Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393C629D669
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgJ1WOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:14:45 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:48720
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730978AbgJ1WMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuDqx5TYhKBj1m5XZxWjkU2qwepnJ2ccvMCe+HRv8yjpOxaDGi+ArKcsrLimWDD88OswJLKVG5fOWSB2P6Ywn6NGc9YAVkHE50tvzzctdHL+OLfdGdbgXAw/vwtXjSL7raYP5yiEB74pubmTMMIVgFOoc4tEFY/awGe8x03G2CgZZHvp49HAHN28byXiwvi0HmiTFOeyX9pqQF9Dm96sWKBLOJLQJ+sFGiHM1RMGgJ0yWwj5pVKDwQBKt9Q0D97M+vAGP68EEfpCShNeoaQ/g+vNPlpHW0xCoEaGs+bwhmb+mnE1tmg/EZB23362QHakNSTX+6iZLjGa2EjiuazD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlwvxMn9VUWtzpPWsbp0EyQ5l4d2sdMSm0AnKBItD40=;
 b=myBflMKkUZoKICuph+XF3pPUJlvRJ0GHfAFQRLOlxNtYh29d2FZv7rFxXMTq4ni0Tqz0auHD+MNSqM3UuCLnwGWzcEs3SoCxjN25i7A94u9Zh+uv+i2LifHFeJtFnstrkUVLEhq7Sfj1x4f3Sb244xvo5hOlgpWGyR5bgAOpFtZwNCI6AO/018w5QDjKTlUWDIZp9v9KYEvAVWqQYKcxyLiVSBhiqLsz6IZJhQD8tmPskk5XqGg/nGOHkg5oFKy7V2HG5IoOdL4HdqRxOPtS2ZtoXTKkIhE6OjldxZPKLcbNz4D497xcyUrp/YOnM7xCXxQ+PcC8gGlmVcfr8b9vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlwvxMn9VUWtzpPWsbp0EyQ5l4d2sdMSm0AnKBItD40=;
 b=AdeqdouBqET0p65qM2G2oYFOzlsiV6D+M6MJufLHrswyyvOJIxumSBylJuIfARl/lrbpdG3N48aPqVadEc2JUMqHBLNCw5QfOTDOOmBdVJLOgGi1JY44bi6E9VrKZetjQa6Db34jVW5RMlJjfwKEPYqiYvnsA3V6DgiVVkwFGmc=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 08:45:36 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.037; Wed, 28 Oct 2020
 08:45:36 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBrdGhyZWFkX3dvcmtlcjogcmUtc2V0IENQVSBh?=
 =?gb2312?Q?ffinities_if_CPU_come_online?=
Thread-Topic: [PATCH v2] kthread_worker: re-set CPU affinities if CPU come
 online
Thread-Index: AQHWrPw9OwuDy1fQzkmcP0zoeTZ8vamsryIAgAADXxY=
Date:   Wed, 28 Oct 2020 08:45:36 +0000
Message-ID: <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201028073031.4536-1-qiang.zhang@windriver.com>,<874kme21nv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kme21nv.fsf@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 501cde7a-6261-4866-9fc9-08d87b1dd71d
x-ms-traffictypediagnostic: SJ0PR11MB4846:
x-microsoft-antispam-prvs: <SJ0PR11MB48463EAF938A4BDEBD5591EBFF170@SJ0PR11MB4846.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLKCB9Ll31GeGWxiRxJjSWfXKsQvmQNS6ZQt51wbS8v76bUTtF5fjnKi50jiYQLWXnOvJVL1hDLgNISeS7n701NLXryB9jsMVRsrR/BMFZdgrW8QFt85OfU3qsHkNq28hg0EM/pv/4T2a58g1/ykg0vzACjnO49BugTditwfi0EsRUEva5Tx4m0V1SPzI5M48VBX6dyuQE3BXbo+EsqmRqh6nG33dtBxEd4KPyIEhQbJ4x5Gs/lOcIovf1B75RQ0jotvZcMDSOqLm0c6JKpjiXmb4Dg9AFM5rW/gkU23cVkjt+FYo2aFPGP/WUY+Pi9rCHumtlSWTIaNRZOMi2B/RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(376002)(396003)(366004)(346002)(186003)(26005)(76116006)(91956017)(7696005)(6506007)(316002)(71200400001)(110136005)(9686003)(55016002)(66946007)(54906003)(478600001)(224303003)(8936002)(2906002)(86362001)(33656002)(66446008)(66556008)(66476007)(4326008)(64756008)(5660300002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oEte/qIW1jUWkVJc63trucPQJvTXHc18Ns2UWYoH3GbXU/FP6J70eygPS5+DsXZwPtxS674LUVMRLhpzU6QSlAR1pAhNPL4nEVt4t814xFrO+C9e2yfev4/kMTHM4GLIVsqAK1mdSKGLNGfANy+R/eXbbi1v7h9lZ4PMmVOw18IUkPg0VQkQRqDCW5dAd7BSnY4k6bQQxrNrsQ6srtjprKFjDtW+dOUNxXqkFA87JHVlNbxI14Y7lQurepkaMSULdPgfCF1lvjsV/ZURVhctfz2SETsLvxw5zp7HbVcZf8CCMziZZa39iITLgeo0TVXsnbzxHgzIVIu3+E9w15nWwZgvPk5z5SDhvvMC+LeDQB4Wve/SpF4ApLex7AYXN70ATZ+yjyhv8wgXSDPl93bPboHIuWQPVTDj9g79lmaW3HOBwWE9Ig8RXqh0+pEXVh1taDupLH9SeAhvECJMABmPh/c/cNmhjDiy/bzqh8vZPkujjeH5QlDs6ECwQKPmD619cuCN+EQIp63c+uKe1gQyLP43ukSf714w/yo4WeUR/1Vg03ryNCouxNhgnSn4/M4cxiGsACo+ZRK8eiplwc2UWdP7T6gTM9/o/6FtE4Gn76oU3yApIHjMr20884DEivj30oxT6BFHdsFvAeKl0zsA9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501cde7a-6261-4866-9fc9-08d87b1dd71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 08:45:36.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJiM5vtPuERhw1E+pfpkPX6WlgeokL04JLI5laVXQ09H0nxXOOhU2e4B6s+BKNyvLWZ9RC4kd8N5ppB0J+i3xyy7WrAOmoaPcjWsqayDFJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Creiy83KsbzkOiAyMDIwxOoxMNTCMjjI1SAx
NjozMArK1bz+yMs6IFpoYW5nLCBRaWFuZzsgcG1sYWRla0BzdXNlLmNvbTsgdGpAa2VybmVsLm9y
ZwqzrcvNOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogUmU6IFtQQVRDSCB2Ml0ga3RocmVhZF93
b3JrZXI6IHJlLXNldCBDUFUgYWZmaW5pdGllcyBpZiBDUFUgY29tZSBvbmxpbmUKCltQbGVhc2Ug
bm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNzXQoKT24g
V2VkLCBPY3QgMjggMjAyMCBhdCAxNTozMCwgcWlhbmcgemhhbmcgd3JvdGU6Cj4gRnJvbTogWnFp
YW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgo+Cj4gV2hlbiBzb21lb25lIENQVSBvZmZs
aW5lZCwgdGhlICdrdGhyZWFkX3dvcmtlcicgd2hpY2ggYmluZCB0aGlzIENQVSwKPiB3aWxsIHJ1
biBhbnl3aGVyZSwgaWYgdGhpcyBDUFUgb25saW5lLCByZWNvdmVyeSBvZiAna3RocmVhZF93b3Jr
ZXInCj4gYWZmaW5pdHkgYnkgY3B1aHAgbm90aWZpZXJzLgo+Cj4gU2lnbmVkLW9mZi1ieTogWnFp
YW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgo+IC0tLQo+ICB2MS0+djI6Cj4gIHJlbmFt
ZSB2YXJpYWJsZSBrd29ya2VyX29ubGluZSB0byBrdGhyZWFkX3dvcmtlcl9vbmxpbmUuCj4gIGFk
ZCAnY3B1aHBfbm9kZScgYW5kICdiaW5kX2NwdScgaW5pdCBpbiBLVEhSRUFEX1dPUktFUl9JTklU
Lgo+ICBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcgZm9yIFdBUk5fT05fT05DRS4KCj5Ib3cgaXMg
dGhhdCBhZGRyZXNzaW5nIGFueSBvZiB0aGUgY29tbWVudHMgSSBtYWRlIG9uIFYxIG9mIHRoaXM/
CgpEbyB5b3UgbWVhbiB0aGUgZm9sbG93aW5nIHByb2JsZW06CiAKIlRoZSBkeW5hbWljIGhvdHBs
dWcgc3RhdGVzIHJ1biBsYXRlLiBXaGF0J3MgcHJldmVudGluZyB3b3JrIHRvIGJlIHF1ZXVlZApv
biBzdWNoIGEgd29ya2VyIGJlZm9yZSBpdCBpcyBib3VuZCB0byB0aGUgQ1BVIGFnYWluPyIKClRo
YW5rcwpRaWFuZwo+Cj5UaGFua3MsCj4KPiAgICAgICB0Z2x4CgoK
