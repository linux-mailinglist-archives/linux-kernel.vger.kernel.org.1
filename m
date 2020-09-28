Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEA27B484
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1Scb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:32:31 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36512 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgI1Sca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:32:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1CCD8401EF;
        Mon, 28 Sep 2020 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1601317949; bh=kzxBlVYKvuvIUN72q7LqflV+0C7Qfq65k6NMrjp5QYU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZTqLywuiMEM/VYUfuCyjicA2T4466lbyYClNjoAqTcktICRaY2Xq0porcEGjth8xV
         5TgWG4Epbo8TxI1kzIAaQ7OJambuDJiAV+vu1YcT8uoj0kqy0JQqyHA3c9fO+r83YB
         Oxne1lB1Q/nVxpFt56NhE+MM7kZmgqQtw8rJX17L+tbtDLzpo8n7H4+FbrkcZpmfAL
         69NVwQz15/Z26FOsYE0i1dWn+3o/Dry63lphxxcKdsS3+wbMdepnlCeiBimrAgJh8k
         MI4umDxHtjjowp6h2Inli1mKEa+U/u5xxJPCXYE2HK5W2RqAGdVhWZn6A2afpPW24B
         x/audsiygQ6ow==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4E56EA0063;
        Mon, 28 Sep 2020 18:32:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6FAC4400D6;
        Mon, 28 Sep 2020 18:32:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nXT7Lhh0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmWN/UwRWbzp6Ly42C9AB+iei3xyTgyA+iNWnrnsXombnfg2ZBySuscg+n/wK0aoMQUrGcM4+cL3vBqfTWPL3/wbEO8twrDyUbTrJBQ/ogpTl98XuO9mFvT1S4bfC0+m6ans0OBlBLLoVoW1urxz+haWXlN8UwLr44B3tzkl+5isFy+S7AOiH6t28pei6jrD7Qa1MrZPvrGjT0qiIcXkMUR2ZqpDWySyIx098QqKLNvNyUtqmzJUuSHPep2Kw7p4lp8//1DTHvLAFYs2igWAewWLoqa5eO8VedGmou7mj8YlLRLhJFDBV7eabSSiwWJKhpTBXAKIo9SCvs4Oc2JoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzxBlVYKvuvIUN72q7LqflV+0C7Qfq65k6NMrjp5QYU=;
 b=TwRl0Bi2/nsE4j9TZqAnZ9/oW5KhoYNZ8tN8m9bXKmHDXJaxz7mbA7q/Rv8mWl541tLWwbWJBhs5KAwL75VQnK6Wii56yPG/XfLwSPNaZSu7/YRVJGOobURxmI6eNIqcf7Ms9fVzy5kBOa8MaTbtaq8N/uGy2U3lR8R0o3jNft7952+oCYonlXicJkOwaEkbwTQWRVnP3j42aLIt2kwfv+9cDQi4ugshpirZsCsUFjQQmMEUwlvRfxGC+qEKzbkwGnQv/fsbColezJf0f3ZwTrrIlq+g2TNPq/Br15Ft50f0tSZ0VdLEnLwpFUZoGR+1fuvp6LBv6S/jCq+3FUg7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzxBlVYKvuvIUN72q7LqflV+0C7Qfq65k6NMrjp5QYU=;
 b=nXT7Lhh0ke90UiaATU291GTYJAqnEHjRQASewNLfxGnJ4emOFecaz0twiWCJCr7PfWuktla/ckmEl2SpRmqguWOAFVCed3XgWGhTy3iXW60nz5KwVxtQeE8HzBe86IhbP+JLcmZpX2K+hX0T277hmTs8KK9Sbsn+Vst5sZMWWW0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3922.namprd12.prod.outlook.com (2603:10b6:a03:195::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 18:32:22 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0bb:1c2d:ecb9:547]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0bb:1c2d:ecb9:547%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 18:32:22 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 6/6] ARC: [dts] fix the errors detected by dtbs_check
Thread-Topic: [PATCH v6 6/6] ARC: [dts] fix the errors detected by dtbs_check
Thread-Index: AQHWkkMTokVrmxXtIUSqHdkCu+PNUql+ZuGA
Date:   Mon, 28 Sep 2020 18:32:22 +0000
Message-ID: <28f41f05-2d09-9155-a609-507874cf4b0b@synopsys.com>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
 <20200924071754.4509-7-thunder.leizhen@huawei.com>
In-Reply-To: <20200924071754.4509-7-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfab8b91-21da-47cc-fe8b-08d863dcd710
x-ms-traffictypediagnostic: BY5PR12MB3922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB392292119EDD6DFF4A4E811DB6350@BY5PR12MB3922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2CttlLzBys8AcBnLTg8yi4nYTvd7kIaZFPAdHoQKyEklZd9KG3PZc3I5gdByPKJVc2pOwojNrlyEOEzSu3TNgrjn/4LmBSqcdb6yOICX1i0IasqRuqqV7GRJmJtg8Wy0b7WpB4eDoSd31VpYO6KKHzgTCV6IJwFQCdzUVsPFIKjbpA4eG2v3D0/pX8wW3mtcpGxAsTHsAPvyuwn0kF2TV/5gsLI6YA74nX4qE1XOHkxj0lJZ9egGs06n2JwA967eipLuTi/Rg1R9KFqZboGRG8tyIJIHwAZAVy1Z3epwOWezK4CyG3X5Jec2uPQi9PmkpAq2J3IOc+DNDT6447+BkR+BUCqK9UNy/+7bTVR/IiILWl0VBY57TrUBswKHEFCRkWFO9oFXegGx6vd/VTdvt2RGzm4K2gxGnVxiHtP3ReJKt9/CSm9hzbKtm/xFZo7aS5Auim7L2iP36rCXoVf3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8936002)(71200400001)(2616005)(6486002)(2906002)(6512007)(110136005)(83380400001)(36756003)(186003)(54906003)(53546011)(6506007)(7416002)(26005)(316002)(5660300002)(31696002)(66446008)(66476007)(66556008)(64756008)(86362001)(31686004)(76116006)(478600001)(4326008)(8676002)(66946007)(21314003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HQwmT1QeI82cGsJeIZZSi8sPhH7N4/KJ1b36pyo8NilRuiFw4IwsWhfLlt/gEer37w0l8LoQiL6MjqfKb62erPtISxqrD86Dlwi8dJ203tsFnLX4h4SeV+7hI2GYSAMFODwhGMnYrm0n4u0CNw/pxfmW7LqhY50QLfmUYQwfLlMY2H3UUVXhxuPyV42fNDvwXqxlYYCiPcYlYHZZdTqmET584xjCd3uVgWV4zEkFkjYanZW+p8dlMWRkMXGfkoGaOt1vWUD/91aJqfUYSSOlWXz6LmrMOWdRrRy557r9Thiw5NV4S+FTCQfUxmH2vaFxuIBWJjlmY0evC0wYuc9L6DgC73FbXQgkl6/Zp89ytbbKBZbzRE2rm0HRh7YPjNP7M7S0itGxLQSe842JIVmwM/15b/tY1sC730jqPtGXICxu1nGdK1kXm4TkP1QDcrBSGW1YT+5BuXPPpZS8fe28NevDwmVdC1QfRpVdm/ccKVc6CvJ4DgYDxEFEeH7xrKFlnJE0ZTYwC4QkVNV1vhIbATlqDR9qOL+eGSxIHFAC1P1fC0tRWJNQcJAVCn3H6SOEOzmOs8RX8Oyr13ZaHL7rG6cE2qv3b0aC0cfXUGvl/j5AfxmEIXzEpayX+W8yYaMELPIb7uxl8ZNKJvAZiElfjw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <036461496500CA45B0A0608A2351F052@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfab8b91-21da-47cc-fe8b-08d863dcd710
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 18:32:22.3236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeR/UM+Usy2DICH7dQfT1naVMtH6zGDcCr8PBCpEfltiIZsRD/4qKeRT38SeHLGLmtPaDJIGEVwZ7SIAffMm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNC8yMCAxMjoxNyBBTSwgWmhlbiBMZWkgd3JvdGU6DQo+IHh4eC9hcmMvYm9vdC9kdHMv
YXhzMTAxLmR0LnlhbWw6IGR3LWFwYi1pY3RsQGUwMDEyMDAwOiAkbm9kZW5hbWU6MDogXA0KPiAn
ZHctYXBiLWljdGxAZTAwMTIwMDAnIGRvZXMgbm90IG1hdGNoICdeaW50ZXJydXB0LWNvbnRyb2xs
ZXIoQFswLTlhLWYsXSspKiQnDQo+IEZyb20gc2NoZW1hOiB4eHgvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvc25wcyxkdy1hcGItaWN0bC55YW1sDQo+IA0KPiBUaGUgbm9kZSBuYW1lIG9mIHRoZSBpbnRl
cnJ1cHQgY29udHJvbGxlciBtdXN0IHN0YXJ0IHdpdGgNCj4gImludGVycnVwdC1jb250cm9sbGVy
IiBpbnN0ZWFkIG9mICJkdy1hcGItaWN0bCIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExl
aSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+DQoNClRoeCwgSSd2ZSBxdWV1ZWQgdGhpcyB1
cCB0byBBUkMgZm9yLWN1cnIuDQoNCi1WaW5lZXQNCg0KPiAtLS0NCj4gIGFyY2gvYXJjL2Jvb3Qv
ZHRzL2F4YzAwMS5kdHNpICAgICAgICAgfCAyICstDQo+ICBhcmNoL2FyYy9ib290L2R0cy9heGMw
MDMuZHRzaSAgICAgICAgIHwgMiArLQ0KPiAgYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAzX2lkdS5k
dHNpICAgICB8IDIgKy0NCj4gIGFyY2gvYXJjL2Jvb3QvZHRzL3Zka19heGMwMDMuZHRzaSAgICAg
fCAyICstDQo+ICBhcmNoL2FyYy9ib290L2R0cy92ZGtfYXhjMDAzX2lkdS5kdHNpIHwgMiArLQ0K
PiAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAxLmR0c2kgYi9hcmNoL2FyYy9i
b290L2R0cy9heGMwMDEuZHRzaQ0KPiBpbmRleCA3OWVjMjdjMDQzYzFkYTcuLjJhMTUxNjA3YjA4
MDU3YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAxLmR0c2kNCj4gKysr
IGIvYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAxLmR0c2kNCj4gQEAgLTkxLDcgKzkxLDcgQEANCj4g
IAkgKiBhdm9pZCBkdXBsaWNhdGluZyB0aGUgTUIgZHRzaSBmaWxlIGdpdmVuIHRoYXQgSVJRIGZy
b20NCj4gIAkgKiB0aGlzIGludGMgdG8gY3B1IGludGMgYXJlIGRpZmZlcmVudCBmb3IgYXhzMTAx
IGFuZCBheHMxMDMNCj4gIAkgKi8NCj4gLQltYl9pbnRjOiBkdy1hcGItaWN0bEBlMDAxMjAwMCB7
DQo+ICsJbWJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZTAwMTIwMDAgew0KPiAgCQkjaW50
ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiAgCQljb21wYXRpYmxlID0gInNucHMsZHctYXBiLWljdGwi
Ow0KPiAgCQlyZWcgPSA8IDB4MCAweGUwMDEyMDAwIDB4MCAweDIwMCA+Ow0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAzLmR0c2kgYi9hcmNoL2FyYy9ib290L2R0cy9heGMw
MDMuZHRzaQ0KPiBpbmRleCBhYzhlMWI0NjNhNzA5OTIuLmNkMWVkY2Y0Zjk1ZWZlNiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcmMvYm9vdC9kdHMvYXhjMDAzLmR0c2kNCj4gKysrIGIvYXJjaC9hcmMv
Ym9vdC9kdHMvYXhjMDAzLmR0c2kNCj4gQEAgLTEyOSw3ICsxMjksNyBAQA0KPiAgCSAqIGF2b2lk
IGR1cGxpY2F0aW5nIHRoZSBNQiBkdHNpIGZpbGUgZ2l2ZW4gdGhhdCBJUlEgZnJvbQ0KPiAgCSAq
IHRoaXMgaW50YyB0byBjcHUgaW50YyBhcmUgZGlmZmVyZW50IGZvciBheHMxMDEgYW5kIGF4czEw
Mw0KPiAgCSAqLw0KPiAtCW1iX2ludGM6IGR3LWFwYi1pY3RsQGUwMDEyMDAwIHsNCj4gKwltYl9p
bnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlckBlMDAxMjAwMCB7DQo+ICAJCSNpbnRlcnJ1cHQtY2Vs
bHMgPSA8MT47DQo+ICAJCWNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItaWN0bCI7DQo+ICAJCXJl
ZyA9IDwgMHgwIDB4ZTAwMTIwMDAgMHgwIDB4MjAwID47DQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
Yy9ib290L2R0cy9heGMwMDNfaWR1LmR0c2kgYi9hcmNoL2FyYy9ib290L2R0cy9heGMwMDNfaWR1
LmR0c2kNCj4gaW5kZXggOWRhMjFlN2ZkMjQ2ZjlmLi43MDc3OTM4NmNhNzk2M2EgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJjL2Jvb3QvZHRzL2F4YzAwM19pZHUuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
Yy9ib290L2R0cy9heGMwMDNfaWR1LmR0c2kNCj4gQEAgLTEzNSw3ICsxMzUsNyBAQA0KPiAgCSAq
IGF2b2lkIGR1cGxpY2F0aW5nIHRoZSBNQiBkdHNpIGZpbGUgZ2l2ZW4gdGhhdCBJUlEgZnJvbQ0K
PiAgCSAqIHRoaXMgaW50YyB0byBjcHUgaW50YyBhcmUgZGlmZmVyZW50IGZvciBheHMxMDEgYW5k
IGF4czEwMw0KPiAgCSAqLw0KPiAtCW1iX2ludGM6IGR3LWFwYi1pY3RsQGUwMDEyMDAwIHsNCj4g
KwltYl9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlckBlMDAxMjAwMCB7DQo+ICAJCSNpbnRlcnJ1
cHQtY2VsbHMgPSA8MT47DQo+ICAJCWNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItaWN0bCI7DQo+
ICAJCXJlZyA9IDwgMHgwIDB4ZTAwMTIwMDAgMHgwIDB4MjAwID47DQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FyYy9ib290L2R0cy92ZGtfYXhjMDAzLmR0c2kgYi9hcmNoL2FyYy9ib290L2R0cy92ZGtf
YXhjMDAzLmR0c2kNCj4gaW5kZXggZjhiZTdiYThkYWQ0OTljLi5jMjFkMGViMDdiZjY3MzcgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2Jvb3QvZHRzL3Zka19heGMwMDMuZHRzaQ0KPiArKysgYi9h
cmNoL2FyYy9ib290L2R0cy92ZGtfYXhjMDAzLmR0c2kNCj4gQEAgLTQ2LDcgKzQ2LDcgQEANCj4g
IA0KPiAgCX07DQo+ICANCj4gLQltYl9pbnRjOiBkdy1hcGItaWN0bEBlMDAxMjAwMCB7DQo+ICsJ
bWJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZTAwMTIwMDAgew0KPiAgCQkjaW50ZXJydXB0
LWNlbGxzID0gPDE+Ow0KPiAgCQljb21wYXRpYmxlID0gInNucHMsZHctYXBiLWljdGwiOw0KPiAg
CQlyZWcgPSA8IDB4ZTAwMTIwMDAgMHgyMDAgPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2Jv
b3QvZHRzL3Zka19heGMwMDNfaWR1LmR0c2kgYi9hcmNoL2FyYy9ib290L2R0cy92ZGtfYXhjMDAz
X2lkdS5kdHNpDQo+IGluZGV4IDBhZmEzZTUzYTRlMzkzMi4uNGQzNDg4NTNhYzdjNWRjIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FyYy9ib290L2R0cy92ZGtfYXhjMDAzX2lkdS5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJjL2Jvb3QvZHRzL3Zka19heGMwMDNfaWR1LmR0c2kNCj4gQEAgLTU0LDcgKzU0LDcg
QEANCj4gIA0KPiAgCX07DQo+ICANCj4gLQltYl9pbnRjOiBkdy1hcGItaWN0bEBlMDAxMjAwMCB7
DQo+ICsJbWJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZTAwMTIwMDAgew0KPiAgCQkjaW50
ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiAgCQljb21wYXRpYmxlID0gInNucHMsZHctYXBiLWljdGwi
Ow0KPiAgCQlyZWcgPSA8IDB4ZTAwMTIwMDAgMHgyMDAgPjsNCj4gDQoNCg==
