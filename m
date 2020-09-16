Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422826BC13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIPGAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:00:25 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:38592
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgIPGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPYLF6SdmVaB5Qoa4DkdF0IxqDvxFVjH4XMTvX95LjCXWLWxqXaukJBW+mk+WcJVdWceP8wfcu2ubzTNbMEl1tpJ62LNfaaI0DmfFR9S+iXW6iMc2Pq9SzSUH20ZCALhoJBh3WSjxRWzjG7KbGG6aiwY8WCyxj3zxNLJi0pCW8+wHf4CnZGYuuHap5bVOVLeyiZag1wRtHa+BaCHDv5TCy4Oawm8VIIhl/xtvDzUM7IL0qS3uWc98TF9DSQsaPJU/+6glrMMZYb9mcSzSAOj1uU2ye9xxu1exVSybhEZJqcTVRAyUcyeKNfXi37WCfqJvRl+4sqrU9NnMYuqSZcckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4bfFT5ivX32wU9bXX5BsU0nL2cE12bGyZPa6O9BruU=;
 b=kdB/XUGSeEq8f9Dr/rjN6isGFs/a7z0MaO1cFwQBCrYelDGZHpBLT5/qZwPg9q8OBDisfTcDxayjhN6ZHigyo3e/p3EI5R7Hlu2GQeBykFsZm4u67ZXpkGEf5RDifeXI3n16YcTzCZ9QMjf8WEjmeDlo3tG7IxLmpr1CkthJGQNphuCSMwqfJcJOBIWXE1AftbX61P7lDJgGeQYNOa4y40yS19do1dUdttdVOcLccBcUN0iLTLFigQ/eyVSA12KVnaWY/V7TZS7KwrZPEpvZqEM3HycImVdBZXhiYqYVdeef5Rzbvjw2KaWifz07lh42pq8YCEu1Kij2zL/21EzpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4bfFT5ivX32wU9bXX5BsU0nL2cE12bGyZPa6O9BruU=;
 b=pTi+xF1TNc6oUobOmUD5phfjzbR1jYKaBn+uml/0V8wbwsO62vg+JofildXWrI5R43bA211EqYcaeQDDtoWvaxNanBKRi8qUcxUfd/KGAPBVoAQLQPetutWbB8m02xw46GtRUhP55CjV3qtNLisLaBaRrLHDzxC770aohAzWRgw=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3110.namprd11.prod.outlook.com (2603:10b6:a03:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 06:00:16 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 06:00:16 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "elver@google.com" <elver@google.com>,
        Waiman Long <longman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwg?=
 =?gb2312?Q?CPU_hotplug_callback?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgQ1BVIGhv?=
 =?gb2312?Q?tplug_callback?=
Thread-Index: AQHWhak78PcybWLZjESEa6PIBhrPbqlfDv6AgAINe3WAABJ7gIAJogUz
Date:   Wed, 16 Sep 2020 06:00:15 +0000
Message-ID: <BYAPR11MB2632C3497A72E60496BEDAEDFF210@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200908062709.11441-1-qiang.zhang@windriver.com>
 <3bcdacd0-10c4-78c0-6e63-a73811a0ced6@redhat.com>
 <BYAPR11MB26324FE54B890DD73417F6B8FF270@BYAPR11MB2632.namprd11.prod.outlook.com>,<fc7702c8-6d85-66ee-3220-8c1a3e9acf0b@redhat.com>
In-Reply-To: <fc7702c8-6d85-66ee-3220-8c1a3e9acf0b@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89d38cbb-2e69-4e53-8591-08d85a05c8aa
x-ms-traffictypediagnostic: BYAPR11MB3110:
x-microsoft-antispam-prvs: <BYAPR11MB311049BBFE15835A39A3D748FF210@BYAPR11MB3110.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbbsZCTIqzeK+A7Xvouze0AZbHxcJZ/YFuWhQsZj+EZC1iAyS/+uk7CzN50PKTZghbhtai4RY+nd2kpHX5o2tWEGGDX+dXw6OhfjNBzQJxgCcURUfsktLkzWNnlkkq/VNWlNGriK93U5td/kFgA/5IGLOQzjapdZoDgSnDv+YgI+nqAGWlMsBe2V9ETvU8QeFzUt2XJ5qPBLm6p/kBY2JCYwFH1JzgTDXJc8mj5PoCOfFruAQUaRgpFgFHo53HrwyVZsvPEFJvnmwYDQCq5J71uWDqIqBOiy1jPHhWZa8GoJwPdVyodXTPqcgXCjGrP2IP6UCbjng/ZJxQpgFHlDaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39850400004)(346002)(376002)(86362001)(7696005)(186003)(66946007)(64756008)(66446008)(66476007)(53546011)(6506007)(66556008)(2906002)(4326008)(91956017)(9686003)(316002)(55016002)(76116006)(478600001)(52536014)(5660300002)(83380400001)(26005)(33656002)(71200400001)(110136005)(224303003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2WN7m2YokZu+3L4zQhaJxAdEa42y6b4ATnZVC5ePCwSI+xZjgAenk9Z07EyhQSFQMB7m/brxawRq611Lf6VTuhlMActWsv6TMNL3VZ3N2CA1gkwxUdkitczG5ePnrsxv9s1O10axvbdOxFEFVFb+Ojs8QRHX9MVIJDR6V+9sElAhCz4QI9qElDJN6boPHetCSygSMpLb3iIwJGJxdYYJFlsH/qsL5AATla9taj86TP1hVTYuFVg4sB9l524Xblm0o45mFHaFjd5Ya39CQ23rBt191bImgjovc0haOeENSj9zyXSx0BF7z7YY9yp142uOivOT6hQUqkJOVIpgBtJfOh3bxnB5zzihURUnSnBa2UcogG68OPikLbqAY2qySlbpRe9eKDAQcQenngtUWWprtapfAl5U0BZMQFOSA30Oh12P4+pYX8MRvTFmLdC1PA4XQX72knaM8uxGYEbckKL/CaPcF9/9XW5bdq1OuJKhN2A3HZf86xx1bctisTL+dhpyfEAaCzb9RXFXBH+XMIXSU6+3mN/F+rhEnbS/oQVmcOgSxlGIcuYMe2VTJ4YJTA1Ea+Olt879CcmQ2Dz+iEG9zwE/wWJwUBelFtlx30PXopASPW4LazdoUSX+FePwuFswfJwmx4j3jxFOdLLHjmuYhQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d38cbb-2e69-4e53-8591-08d85a05c8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 06:00:15.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nkiDz22ZkPpT9LqFQU9vVxG42iw1dSwvi82M9q4noSoMa69NNXjDOfFSsgjDrIxB0fbS1foz2j7PO/g/PHSsOEpdNwvK6gxLiXXX2DaiX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogV2FpbWFu
IExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4Kt6LLzcqxvOQ6IDIwMjDE6jnUwjEwyNUgMTA6NTAK
ytW8/sjLOiBaaGFuZywgUWlhbmc7IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29Aa2VybmVsLm9y
ZzsgZWx2ZXJAZ29vZ2xlLmNvbQqzrcvNOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCtb3
zOI6IFJlOiC72Li0OiBbUEFUQ0ggdjNdIGRlYnVnb2JqZWN0czogaW5zdGFsbCBDUFUgaG90cGx1
ZyBjYWxsYmFjawoKT24gOS85LzIwIDk6NDggUE0sIFpoYW5nLCBRaWFuZyB3cm90ZToKPgo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiC3orz+yMs6IFdhaW1hbiBM
b25nIDxsb25nbWFuQHJlZGhhdC5jb20+Cj4gt6LLzcqxvOQ6IDIwMjDE6jnUwjnI1SAyOjIzCj4g
ytW8/sjLOiBaaGFuZywgUWlhbmc7IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29Aa2VybmVsLm9y
ZzsgZWx2ZXJAZ29vZ2xlLmNvbQo+ILOty806IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
PiDW98ziOiBSZTogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgQ1BVIGhvdHBsdWcg
Y2FsbGJhY2sKPgo+IE9uIDkvOC8yMCAyOjI3IEFNLCBxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29t
IHdyb3RlOgo+PiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj4+Cj4+
IER1ZSB0byBDUFUgaG90cGx1ZywgaXQgbWF5IG5ldmVyIGJlIG9ubGluZSBhZnRlciBpdCdzIG9m
ZmxpbmUsCj4+IHNvbWUgb2JqZWN0cyBpbiBwZXJjcHUgcG9vbCBpcyBuZXZlciBmcmVlLiBpbiBv
cmRlciB0byBhdm9pZAo+PiB0aGlzIGhhcHBlbmluZywgaW5zdGFsbCBDUFUgaG90cGx1ZyBjYWxs
YmFjaywgY2FsbCB0aGlzIGNhbGxiYWNrCj4+IGZ1bmMgdG8gZnJlZSBvYmplY3RzIGluIHBlcmNw
dSBwb29sIHdoZW4gQ1BVIGdvaW5nIG9mZmxpbmUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFpxaWFu
ZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPj4gLS0tCj4+ICAgIHYxLT52MjoKPj4gICAg
TW9kaWZ5IHN1Ym1pc3Npb24gaW5mb3JtYXRpb24uCj4+Cj4+ICAgIHYyLT52MzoKPj4gICAgSW4g
Q1BVIGhvdHBsdWcgY2FsbGJhY2sgZnVuYywgYWRkIGNsZWFyIHBlcmNwdSBwb29sICJvYmpfZnJl
ZSIgb3BlcmF0aW9uLgo+PiAgICBjYXBpdGFsaXplICdDUFUnLCBhbmQgdXNlIHNob3J0ZXIgcHJl
cHJvY2Vzc29yIHNlcXVlbmNlLgo+Pgo+PiAgICBpbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaCB8
ICAxICsKPj4gICAgbGliL2RlYnVnb2JqZWN0cy5jICAgICAgICAgfCAyNCArKysrKysrKysrKysr
KysrKysrKysrKysKPj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaCBiL2luY2x1ZGUvbGludXgv
Y3B1aG90cGx1Zy5oCj4+IGluZGV4IDMyMTUwMjNkNDg1Mi4uMGMzOWQ1N2U1MzQyIDEwMDY0NAo+
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4
L2NwdWhvdHBsdWcuaAo+PiBAQCAtMzYsNiArMzYsNyBAQCBlbnVtIGNwdWhwX3N0YXRlIHsKPj4g
ICAgICAgIENQVUhQX1g4Nl9NQ0VfREVBRCwKPj4gICAgICAgIENQVUhQX1ZJUlRfTkVUX0RFQUQs
Cj4+ICAgICAgICBDUFVIUF9TTFVCX0RFQUQsCj4+ICsgICAgIENQVUhQX0RFQlVHX09CSl9ERUFE
LAo+PiAgICAgICAgQ1BVSFBfTU1fV1JJVEVCQUNLX0RFQUQsCj4+ICAgICAgICBDUFVIUF9NTV9W
TVNUQVRfREVBRCwKPj4gICAgICAgIENQVUhQX1NPRlRJUlFfREVBRCwKPj4gZGlmZiAtLWdpdCBh
L2xpYi9kZWJ1Z29iamVjdHMuYyBiL2xpYi9kZWJ1Z29iamVjdHMuYwo+PiBpbmRleCBmZTQ1NTc5
NTVkOTcuLmJiNjlhMDJjM2U3YiAxMDA2NDQKPj4gLS0tIGEvbGliL2RlYnVnb2JqZWN0cy5jCj4+
ICsrKyBiL2xpYi9kZWJ1Z29iamVjdHMuYwo+PiBAQCAtMTksNiArMTksNyBAQAo+PiAgICAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPgo+PiAgICAjaW5jbHVkZSA8bGludXgvaGFzaC5oPgo+PiAgICAj
aW5jbHVkZSA8bGludXgva21lbWxlYWsuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9jcHUuaD4KPj4K
Pj4gICAgI2RlZmluZSBPREVCVUdfSEFTSF9CSVRTICAgIDE0Cj4+ICAgICNkZWZpbmUgT0RFQlVH
X0hBU0hfU0laRSAgICAoMSA8PCBPREVCVUdfSEFTSF9CSVRTKQo+PiBAQCAtNDMzLDYgKzQzNCwy
NCBAQCBzdGF0aWMgdm9pZCBmcmVlX29iamVjdChzdHJ1Y3QgZGVidWdfb2JqICpvYmopCj4+ICAg
ICAgICB9Cj4+ICAgIH0KPj4KPj4gKyNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKPj4gK3N0YXRp
YyBpbnQgb2JqZWN0X2NwdV9vZmZsaW5lKHVuc2lnbmVkIGludCBjcHUpCj4+ICt7Cj4+ICsgICAg
IHN0cnVjdCBkZWJ1Z19wZXJjcHVfZnJlZSAqcGVyY3B1X3Bvb2w7Cj4+ICsgICAgIHN0cnVjdCBo
bGlzdF9ub2RlICp0bXA7Cj4+ICsgICAgIHN0cnVjdCBkZWJ1Z19vYmogKm9iajsKPj4gKwo+PiAr
ICAgICBwZXJjcHVfcG9vbCA9IHBlcl9jcHVfcHRyKCZwZXJjcHVfb2JqX3Bvb2wsIGNwdSk7Cj4+
ICsgICAgIGhsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUob2JqLCB0bXAsICZwZXJjcHVfcG9vbC0+
ZnJlZV9vYmpzLCBub2RlKSB7Cj4+ICsgICAgICAgICAgICAgaGxpc3RfZGVsKCZvYmotPm5vZGUp
Owo+PiArICAgICAgICAgICAgIGttZW1fY2FjaGVfZnJlZShvYmpfY2FjaGUsIG9iaik7Cj4+ICsg
ICAgIH0KPj4gKyAgICAgcGVyY3B1X3Bvb2wtPm9ial9mcmVlID0gMDsKPj4+IEZvciBwb2ludGVy
LCBpdCBpcyBiZXR0ZXIgdG8gdXNlIE5VTEwgZm9yIGNsYXJpdHkuCj4+PiBDaGVlcnMsCj4+PiBM
b25nbWFuCj4gRG8geW91IG1lYW4gIi0+b2JqX2ZyZWUiIHZhcmlhYmxlID8gICB0aGlzIHJlcHJl
c2VudHMgdGhlIG51bWJlciBvZiBmcmVlIG9iamVjdHMgaW4gIHBlcmNwdV9wb29sIC4KPgo+Pllv
dSBhcmUgcmlnaHQuIEkgZ290IGNvbmZ1c2VkLiBTb3JyeSBmb3IgdGhlIG5vaXNlLgoKPj5DaGVl
cnMsCj4+TG9uZ21hbgoKSGVsbG8gdGdseCwgbWluZ28KCiBJcyB0aGlzIHBhdGNoIGFjY2VwdGFi
bGU/IAoKVGhhbmtzIAoKUWlhbmc=
