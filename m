Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB42932E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgJTB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:57:31 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34384 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgJTB5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:57:30 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0F5BBC0090;
        Tue, 20 Oct 2020 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603159049; bh=iU/PKHvFdzyGz0EhGBTR5K7eKPXhzNFCvm/aGhdKZ60=;
        h=From:To:CC:Subject:Date:From;
        b=D6UFbeU+FLAEJp0JoNu82fxQxuTTQXMZgjI4QZ+9OWs5AevsQev45hcnZSBc4jPvQ
         ZEeHj10fZV0/60PMr0z1zqyb5htJ6CYjR68JizCO7L+omd3+gpPW10j/EBw/5NgNU6
         i0PqiJtviLGlEq3P1dOJUSAFddt6nRweehSO7ERWtTZIT5HXw/KlJoyLeTCLRXPYAG
         gOOXo5GDGnwH89MfpNTCVy3eoUS/vXrFv0jTZrFV+yrDmePXkt9DhO0BBuCDTSea70
         s7CeSoFQtZX+01sTtqYQC12xF7fTfUrinqY/G/9xAcyBB/Fo+FyJyNSQ/y84nuoi3O
         hXI0235APzeaw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5BEECA0082;
        Tue, 20 Oct 2020 01:57:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AF1EB8027A;
        Tue, 20 Oct 2020 01:57:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MBkYguBl";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHTTY255UHXpnjOUVZTV0CtnaGad/vQpsqz44Pb95aOFbh/4M5vBeQEGsYURFWgEUXuMa0DLUHP8eHN/hVJ4GmXSc9+c03faFH02+eY+oC9vF1+LjHUFgLs0W8ZirVZ3cQKnVdFndDKENiXWOBVOjLSHTv++dft+TKHNhKkJ7DfK4YFxxZOi5N9T8698pE2MoKZBA8NehGrHiVm6f3Byo/oyT22McaMv/YGV2Oa7+YZt9iEA1lML3BBBjxZVRKLLwOrUBGKSiohazhzeNWBxDFqweSUMrBqu1Ns9hjK/sXxP65QSK3CqInOC93/SxRGAf++QE5UvZBaTK7zBylq5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU/PKHvFdzyGz0EhGBTR5K7eKPXhzNFCvm/aGhdKZ60=;
 b=nlgR+97PRZ+ZuXlLB0mnvXP+WwQOngfZ5ti1gAXZUJJKlwLkFfj42/3CO/exwgH6sR50iWnenn47gsvSF4Ke0S7OdRwipygboQwamJry/0FFgh+4uiYdptCjUhXYfz1X6bFeDs5dCJ0cGkD8E9e5AMuqJSwUfmWWAUa18FPzRExziZT1frz73S5/KSw1Qb/K7bHOIUssve6sSytGbeHmSYpqlw1iP6jnwj46rz3wUXZkTj5LMhXOYzCLRVefx7boyczRhTV6YMSzLlqkoMj9xAPg5CXkp0gh7ms9/Ywdmv/9D1xRrqsmcmxyNkdQtj0Z14D+gtUAyXr1sSwDwjrykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU/PKHvFdzyGz0EhGBTR5K7eKPXhzNFCvm/aGhdKZ60=;
 b=MBkYguBlSJRyJR8YEoA3ze+RmtrU2yB61l8UhOuubRltePjEx9k14y4FFISS6+9KypdWXS4mv30mXih8M5KRRXaQf/Xu9YBsQ93mmDcE2P1EKWDxfN07YfIPxUSGvMQWpgb1jCb8xn+M9LFXk0SbQhnqILuTN7DGnr3sVK47y34=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 01:57:22 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 01:57:22 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        "Ofer Levi(SW)" <oferle@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Noam Camus <noamikong@gmail.com>
Subject: [GIT PULL] ARC changes for 5.10-rc1
Thread-Topic: [GIT PULL] ARC changes for 5.10-rc1
Thread-Index: AQHWpoRZixk2WDqDYEeW5nFZeTt7TA==
Date:   Tue, 20 Oct 2020 01:57:21 +0000
Message-ID: <bbd3efb4-39d2-1d2f-b4c5-0f68dd6f481f@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32db04ac-b990-4478-e8c6-08d8749b7bf4
x-ms-traffictypediagnostic: BYAPR12MB3350:
x-microsoft-antispam-prvs: <BYAPR12MB3350BA6961CA2322AE11FD78B61F0@BYAPR12MB3350.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWkCpTdnGSocVjtpV/MfOd/A1O9WW4EGj/t+W3Yf96NvrVFC+eyofHAjHAebNm7TdWTXeBonlKw9QkI4juHKkLz74RVcjTF+kFb7AZyjZbZVcTtNew8z3sInibO97c39kGRirrOXcjqQDRBiLt1boXuAu1PazumJqqCqR4ii4VNlaEmYjaHsMgdM/i7cRpeBiUjRV45U1XvXUFzeLiWtSin6NLdSIXrnRtf4vXpSXfTec8sa2K+f2odfkRUyzLeFm/sX6ztXQBCPs0/QfaBno644ddtjeN3x/IjDroLhk6IKk/qGKzpWGjz79tNSj6OTQRmbfaVgZuVZAySGKBDhZE0WExDD4xdnINYC6MRK1h1lry3UhU+xtG7fvBnbXFLo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(54906003)(316002)(2906002)(2616005)(36756003)(4326008)(66556008)(6916009)(66946007)(64756008)(31696002)(66476007)(76116006)(66446008)(8936002)(6486002)(8676002)(86362001)(7416002)(26005)(6506007)(186003)(71200400001)(83380400001)(5660300002)(31686004)(6512007)(478600001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KsupqFw0Ti1X/k86mQs6D6XwacKa/tyBW4TuwPdIbVPlhRncXvN+yV6BxCjQAQ1XwWML/hyQsy2xhgK0+SXDEm3iwfWFYTYzm+sMIOICK5TFQ5INAY07MZeQZOSr6S5HqGPnP4YV4wBSgoDpXmXLPLa86FRwDzV88N8xQ1U/MvxOSfvsawon7+dpIorAModEezTiPHFpGam+8UGMbx0gRq068dtBVrfUiKkBGvO6SieZj7IYu1b3GvhxwTulSHVKRX+1SWbBAHXasnQSIsJt42hdaCd1GG3F8Y8MxppDd1MhcadjG8G/RcIdUB4EsWWsyzw1+VOQEccSV09EDmxjX/+f+m47bLUGlSJ9kxpKmKmO2Wd7+SaDfLbwqqrtWLXTHYvVwDaXjjQ7xY839QzAdUx6y7vxi0gerqz4uwaRCoofyIPhsrsWVI2V8HVuwoW0Y+s5YqWEvVk5c3o7nmaU+zK2XCbavor9Schx6+HL8C/3/jxCilDjXruPlCwPDUEHU326QV/T/XkGzN31P4ssxF9V6MjUMJ1N4v2SKWAjqHmana87MMf3tlMmrKRUnQWRXPv/xqmUfjY1SzurDN8OnwmrFKzlWpjaHHXRV1UxTH8LkvL0EgKqKVwaOu9TxMfiHvn0iJp5CQJTOyt7Bo4y7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <627C7372E621EE4DA4DE4E60B4A00D22@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32db04ac-b990-4478-e8c6-08d8749b7bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 01:57:21.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNqos6a1L4qhpcsbV2Sohu37LhFwTPaZubg+mgiNe/XSuRp3KDXMIS/G1DpBy8BCH71jxEdciVLbb4cY474+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBidWxrIG9mIEFSQyBwdWxsIHJlcXVlc3QgaXMgcmVtb3ZhbCBvZiBF
WkNoaXAgTlBTIHBsYXRmb3JtIHdoaWNoIHdhcyBzdWZmZXJpbmcNCmZyb20gY29uc3RhbnQgYml0
cm90LiBJbiByZWNlbnQgeWVhcnMgRVpDaGlwIGhhcyBnb25lIHRob3VnaCBtdWx0aXBsZSBzdWNj
ZXNzaXZlDQphY3F1aXNpdGlvbnMgYW5kIEkgZ3Vlc3MgdGhpbmdzIGFuZCBwZW9wbGUgbW92ZSBv
bi4gSSB3b3VsZCBsaWtlIHRvIHRha2UgdGhpcw0Kb3Bwb3J0dW5pdHkgdG8gcmVjb2duaXplIGFu
ZCB0aGFuayBhbGwgdGhvc2UgZ29vZCBmb2xrcyAoR2lsYWQsIE5vYW0sIE9mZXIuLi4pIGZvcg0K
Y29udHJpYnV0aW5nIG1ham9yIGJpdHMgdG8gQVJDIHBvcnQgKFNNUCwgQmlnIEVuZGlhbikNCg0K
UGxlYXNlIHB1bGwuDQoNClRoeCwNCi1WaW5lZXQNCi0tLS0tLS0tLS0tLS0tLS0tPg0KVGhlIGZv
bGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1NDk3MzhmMTVkYTBlNWEwMDI3NTk3NzYyM2Jl
MTk5ZmJiZjdkZjUwOg0KDQogIExpbnV4IDUuOS1yYzggKDIwMjAtMTAtMDQgMTY6MDQ6MzQgLTA3
MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92Z3VwdGEvYXJjLmdpdC8g
dGFncy9hcmMtNS4xMC1yYzENCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDYzNjRk
MWI0MWNjMzgyZGIzYjAzY2YzM2M1N2I2MDA3ZWU4ZjA5Y2Y6DQoNCiAgYXJjOiBpbmNsdWRlL2Fz
bTogZml4IHR5cG9zIG9mICJ0aGVtc2VsdmVzIiAoMjAyMC0xMC0wNSAyMTowMjoyOSAtMDcwMCkN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQVJDIGNoYW5nZXMgZm9yIDUuMTANCg0KIC0gRHJvcCBzdXBwb3J0IGZvciBF
WkNoaXAgTlBTIHBsYXRmb3JtDQoNCiAtIG1pc2NsbCBvdGhlciBmaXhlcw0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpN
aWtlIFJhcG9wb3J0ICgxKToNCiAgICAgIEFSQzogU01QOiBmaXggdHlwbyBhbmQgdXNlICJjb21l
IHVwIiBpbnN0ZWFkIG9mICJjb21ldXAiDQoNCk5lY2lwIEZhemlsIFlpbGRpcmFuICgxKToNCiAg
ICAgIGFyYzogcGxhdC1oc2RrOiBmaXgga2NvbmZpZyBkZXBlbmRlbmN5IHdhcm5pbmcgd2hlbiAh
UkVTRVRfQ09OVFJPTExFUg0KDQpSYW5keSBEdW5sYXAgKDEpOg0KICAgICAgYXJjOiBpbmNsdWRl
L2FzbTogZml4IHR5cG9zIG9mICJ0aGVtc2VsdmVzIg0KDQpWaW5lZXQgR3VwdGEgKDEpOg0KICAg
ICAgQVJDOiBbcGxhdC1lem5wc106IERyb3Agc3VwcG9ydCBmb3IgRVpDaGlwIE5QUyBwbGF0Zm9y
bQ0KDQpaaGVuIExlaSAoMSk6DQogICAgICBBUkM6IFtkdHNdIGZpeCB0aGUgZXJyb3JzIGRldGVj
dGVkIGJ5IGR0YnNfY2hlY2sNCg0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgNyAtLQ0KIGFyY2gvYXJjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiAtDQogYXJjaC9hcmMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgIHwgICA1IC0N
CiBhcmNoL2FyYy9ib290L2R0cy9heGMwMDEuZHRzaSAgICAgICAgICAgfCAgIDIgKy0NCiBhcmNo
L2FyYy9ib290L2R0cy9heGMwMDMuZHRzaSAgICAgICAgICAgfCAgIDIgKy0NCiBhcmNoL2FyYy9i
b290L2R0cy9heGMwMDNfaWR1LmR0c2kgICAgICAgfCAgIDIgKy0NCiBhcmNoL2FyYy9ib290L2R0
cy9lem5wcy5kdHMgICAgICAgICAgICAgfCAgODQgLS0tLS0tLS0tLS0tLQ0KIGFyY2gvYXJjL2Jv
b3QvZHRzL3Zka19heGMwMDMuZHRzaSAgICAgICB8ICAgMiArLQ0KIGFyY2gvYXJjL2Jvb3QvZHRz
L3Zka19heGMwMDNfaWR1LmR0c2kgICB8ICAgMiArLQ0KIGFyY2gvYXJjL2NvbmZpZ3MvbnBzX2Rl
ZmNvbmZpZyAgICAgICAgICB8ICA4MCAtLS0tLS0tLS0tLS0NCiBhcmNoL2FyYy9pbmNsdWRlL2Fz
bS9hdG9taWMuaCAgICAgICAgICAgfCAxMDggKy0tLS0tLS0tLS0tLS0tLS0NCiBhcmNoL2FyYy9p
bmNsdWRlL2FzbS9iYXJyaWVyLmggICAgICAgICAgfCAgIDkgKy0NCiBhcmNoL2FyYy9pbmNsdWRl
L2FzbS9iaXRvcHMuaCAgICAgICAgICAgfCAgNTggKy0tLS0tLS0tDQogYXJjaC9hcmMvaW5jbHVk
ZS9hc20vY21weGNoZy5oICAgICAgICAgIHwgIDcyICstLS0tLS0tLS0tDQogYXJjaC9hcmMvaW5j
bHVkZS9hc20vZW50cnktY29tcGFjdC5oICAgIHwgIDI3IC0tLS0tDQogYXJjaC9hcmMvaW5jbHVk
ZS9hc20vcHJvY2Vzc29yLmggICAgICAgIHwgIDM3IC0tLS0tLQ0KIGFyY2gvYXJjL2luY2x1ZGUv
YXNtL3B0cmFjZS5oICAgICAgICAgICB8ICAgNSAtDQogYXJjaC9hcmMvaW5jbHVkZS9hc20vc2V0
dXAuaCAgICAgICAgICAgIHwgICA0IC0NCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9zcGlubG9jay5o
ICAgICAgICAgfCAgIDYgLQ0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3N3aXRjaF90by5oICAgICAg
ICB8ICAgOSAtLQ0KIGFyY2gvYXJjL2tlcm5lbC9jdHhfc3cuYyAgICAgICAgICAgICAgICB8ICAx
MyAtLQ0KIGFyY2gvYXJjL2tlcm5lbC9kZXZ0cmVlLmMgICAgICAgICAgICAgICB8ICAgMiAtDQog
YXJjaC9hcmMva2VybmVsL3Byb2Nlc3MuYyAgICAgICAgICAgICAgIHwgIDE1IC0tLQ0KIGFyY2gv
YXJjL2tlcm5lbC9zbXAuYyAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGFyY2gvYXJjL21t
L3RsYmV4LlMgICAgICAgICAgICAgICAgICAgICB8ICAgNyAtLQ0KIGFyY2gvYXJjL3BsYXQtZXpu
cHMvS2NvbmZpZyAgICAgICAgICAgICB8ICA1OCAtLS0tLS0tLS0NCiBhcmNoL2FyYy9wbGF0LWV6
bnBzL01ha2VmaWxlICAgICAgICAgICAgfCAgIDggLS0NCiBhcmNoL2FyYy9wbGF0LWV6bnBzL2N0
b3AuYyAgICAgICAgICAgICAgfCAgMjEgLS0tLQ0KIGFyY2gvYXJjL3BsYXQtZXpucHMvZW50cnku
UyAgICAgICAgICAgICB8ICA2MCAtLS0tLS0tLS0NCiBhcmNoL2FyYy9wbGF0LWV6bnBzL2luY2x1
ZGUvcGxhdC9jdG9wLmggfCAyMDggLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBh
cmNoL2FyYy9wbGF0LWV6bnBzL2luY2x1ZGUvcGxhdC9tdG0uaCAgfCAgNDkgLS0tLS0tLS0NCiBh
cmNoL2FyYy9wbGF0LWV6bnBzL2luY2x1ZGUvcGxhdC9zbXAuaCAgfCAgMTUgLS0tDQogYXJjaC9h
cmMvcGxhdC1lem5wcy9tdG0uYyAgICAgICAgICAgICAgIHwgMTY2IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiBhcmNoL2FyYy9wbGF0LWV6bnBzL3BsYXRmb3JtLmMgICAgICAgICAgfCAgOTEg
LS0tLS0tLS0tLS0tLS0NCiBhcmNoL2FyYy9wbGF0LWV6bnBzL3NtcC5jICAgICAgICAgICAgICAg
fCAxMzggLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogYXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcg
ICAgICAgICAgICAgIHwgICAxICsNCiAzNiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCAxMzYyIGRlbGV0aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNoL2FyYy9ib290L2R0
cy9lem5wcy5kdHMNCiBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMvY29uZmlncy9ucHNfZGVm
Y29uZmlnDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL3BsYXQtZXpucHMvS2NvbmZpZw0K
IGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNoL2FyYy9wbGF0LWV6bnBzL01ha2VmaWxlDQogZGVsZXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJjL3BsYXQtZXpucHMvY3RvcC5jDQogZGVsZXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJjL3BsYXQtZXpucHMvZW50cnkuUw0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FyYy9wbGF0LWV6bnBzL2luY2x1ZGUvcGxhdC9jdG9wLmgNCiBkZWxldGUgbW9kZSAxMDA2NDQg
YXJjaC9hcmMvcGxhdC1lem5wcy9pbmNsdWRlL3BsYXQvbXRtLmgNCiBkZWxldGUgbW9kZSAxMDA2
NDQgYXJjaC9hcmMvcGxhdC1lem5wcy9pbmNsdWRlL3BsYXQvc21wLmgNCiBkZWxldGUgbW9kZSAx
MDA2NDQgYXJjaC9hcmMvcGxhdC1lem5wcy9tdG0uYw0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FyYy9wbGF0LWV6bnBzL3BsYXRmb3JtLmMNCiBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMv
cGxhdC1lem5wcy9zbXAuYw0K
