Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1B2A0F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgJ3UJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:09:46 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43266 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgJ3UIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:08:12 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C808C40515;
        Fri, 30 Oct 2020 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604088491; bh=5jm5Fs+S5cPiDscMAtAMsdDtrAfLf23yC53W/2ZU8mo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J7BZdQKAB9x0ZE0GmpttRVaNI547VdIqdWPm93vRZ+RhdXia5+npgk++WNYsppewr
         viPFhI8AXR7zDzYmni/NUhkffx4kmG+7XujSurM9mgkVptzcxwnRKuAiFVju6PzkkV
         086svqEl+xitgEPF0REFL81bNhlya4MRIAzaLmmvxd6aBYbADZTP+aY1QsqLEqGz5E
         OdnCr+nG15ex69MZp6iODi+oBlO258AE7d7xnbY9r5riM78eUgsNDkrqhwC0VsfBkY
         rBqHDIzIYxjAIi/j4iiE9JuBMdYKBq58gBEHqjg4v92Ih1pQEuadclnY8dWJSpACEk
         KJfKB8N8vmy0g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D9109A0096;
        Fri, 30 Oct 2020 20:08:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D042F80292;
        Fri, 30 Oct 2020 20:08:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="L7SEammn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFDNJL8x0aKnAAZGvgBeIdMpaFb0UidbXtoOaq+A4moT7T/5gzuOpoicdi0p4uMUlE4kFvgIWegH6XGh9Igb2lI+0UsCrC3pYh13h/v+R0pISPohj3gF8D8uvFcozvE29NZKQ2WDQVbF9YU4DvEkTosL0WxNiA9Y3Dy3w+8PkXDdCt/UKKthp7QGHfFTu9Vkq65c0Vs39FN0r9VMPCeR9GTvH53MEIgjjLTgZ6Feadiglcpci3cWJBzYZpcKQfkxDTdtaCHRkdlv8jTzVDBBEyEwTAHUWsr2jUi1zSkvhZlzS7V2Utmim4Jsh5udzoRBp/lYmbdEAOTTGuutdbko9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jm5Fs+S5cPiDscMAtAMsdDtrAfLf23yC53W/2ZU8mo=;
 b=f+hAj/N+Daj9tv0pu5GD6O376h2SmZmKKkbqUu6f1EeNPYz1XbFEa0fKj22WtxhBxkU8jQqX3PSPOAZcqvfJf/nF2Iu04n+dIKq5DnIuWjJ/iTo4+VHkOOENi7e1AaYoPOpzcKU0PLS4MWuPkDb83W/ePPuwb3dggVMwN47v804ulZmKBaw0mB0vV8ezgDUKY6hE3bDqtBiSeYFIAZGkJMmna8SIoj3wWFKxSD26U9gGkQKnXC6uy1khwNy16h7IuTH1hfCokb2RcCmKDBRcuTdcc2avY7N0IeTvbiUe8Zpr95FrE6bpWvCqTTOr20rQ5yINbNu49nJXPpmDvoiWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jm5Fs+S5cPiDscMAtAMsdDtrAfLf23yC53W/2ZU8mo=;
 b=L7SEammnxUKULWr6ogZyiMvzD/g4Tk4ZyKsS4XiqvtTVKOw3hQjVeVlzXH05LJMx33xSjs1n+VWVDRHd7heOSbE3IqzDAm/MqTpaKzPOlb26CLIbOmS/y0sxmX8zyWtrczSCTkFbngkv8cegprNbm6hhwcpU4JLcOaB9ynGRQ+A=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3256.namprd12.prod.outlook.com (2603:10b6:a03:135::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 30 Oct
 2020 20:08:06 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 20:08:06 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arc: add support for TIF_NOTIFY_SIGNAL
Thread-Topic: [PATCH] arc: add support for TIF_NOTIFY_SIGNAL
Thread-Index: AQHWrg31QcbIo8s3W0SB8T9Bc5NeLKmwfi8AgAABtQCAABTBgA==
Date:   Fri, 30 Oct 2020 20:08:06 +0000
Message-ID: <f1a8b2c9-3a72-75c6-f504-18723689fabd@synopsys.com>
References: <6b89e805-c645-e738-794f-05ba6be68d60@kernel.dk>
 <faa0272e-9719-8fd4-323c-b32fd4c9ccb6@synopsys.com>
 <5d59c0f2-3a5e-478a-e0e4-4f487a4718a6@kernel.dk>
In-Reply-To: <5d59c0f2-3a5e-478a-e0e4-4f487a4718a6@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cb637ca-91f7-4d52-3712-08d87d0f8428
x-ms-traffictypediagnostic: BYAPR12MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3256EBE9930975B528CDC00FB6150@BYAPR12MB3256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6SHm2tg21jZuwxuZVD2AIWHOVymBh3R9oeSIHY1PsvoGJPEDEUTHY9SkKg2GAqSEpB/iDX9dCJYo/fwY1ogc3NBM8yAqSi12X2dhGKsTmz3HURUSbPreOFjmVgC6NMgjI5Lob+RSleWGrDaZNELjfcW2z8sWXfB9Q9S80SIG9Lh4K2OddHnzi7Xw+NlZoMDHCLCt7kkdziLyEtD1nAIAuTInRcG/HprujRtRrvpHUzYrR++rZ1BKTBqlzXup8J5Drm1wjl/3zg1DhryoCDIgNHOiJo8l0USlNnyjvwTIhhsSt3sNOMMD1XJc2WxDOCmZTeuyZIB4H5S+uswuNk7DL19MoYa95Rbh4zSTXl/iwpGqnu6ANAOU/bhzk8ShZxeUmJgftjWIjAqgtfeVEG/oEnHne44PawcwWQvv0nzelAwvGA9QzjY4hqAII7Na2zRi8+x5cOutPd+lzXhjIxygg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(966005)(64756008)(66946007)(66446008)(2906002)(6506007)(8676002)(31696002)(66556008)(76116006)(66476007)(6512007)(53546011)(4326008)(6486002)(26005)(316002)(478600001)(83380400001)(2616005)(186003)(86362001)(36756003)(31686004)(71200400001)(5660300002)(110136005)(8936002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cX0fuHpOLbDv04z7MslRunCJNeHiW1nBycNL1p6zNKQVqHAi4N5lsPJ5mFYgmO/z6ajNbjbi4BniJOOUQFOLDBGpbUoQDVxkTYbCIJNLPqA8YQh5s4+daeROjMo5vz5rYZE/iSbBO+OH5nG2Q5ullz2umvph2fF0zDNl/WyB67tCDVfa4cvLiU2W45rqR1JSIQfi0Z8wyQo6F80Odaqd3SC7MqYEpZEUsEZNibAqwJacg2aAECeJ4JQcM9VXYwjeXtoSARjFQa3MWN3CHd2cgrqEqLrPMRT+PQ1CIYXe2ts0D7TRWGt6hEF42FIbEk08EjQ56C7zwxujh7u/312TN430lZJg0pFa7koz2kjKWGUtW9duNZIzxgbPTnpos2lqq3Kp7VqKqpvJJVZuPboCoIjPlvs5IExpsAkHRfkOGAtUC8W9PA7Sh3RnVsBoMxuREqN4z0s6aFNYg395N0M8ePmt6WD0IBH6dO68zjAIdY2YoYEfEAp4gazzfto6M9DKdnloTBJV6JyyQ/WiMbW9M1X1okaRCsGnwsWtzOUo5zGiJiu7vpQKcRN1awNn8rJ0GAveHI+HRvPSKnTjYRojlhgnjs6R5kgJx1Tl8L/S4MYSfTQ/0Su9fOqzv0XCaSQF11qqVXHwvW7lZwhNeOaF7g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6353B9C4431B7F40A714EBA6148C90B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb637ca-91f7-4d52-3712-08d87d0f8428
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 20:08:06.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdG5fE2p/YomTTAMsHdAzA9xy+TKf/yzh6g0pzlqoe1rPxV8/5C6xgT3nekQzUSnWuYWhg+SE+dZGbH9KSj3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMzAvMjAgMTE6NTMgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+DQo+IEFoIHRoYW5rcywg
SSdsbCBtYWtlIHRoYXQgY2hhbmdlLiBIYXJkIGZvciBtZSB0byB0ZXN0IGEgbG90IG9mIHRoZXNl
LCBzbw0KPiBJIHJlYWxseSBhcHByZWNpYXRlIHNvbWVvbmUga25vd2xlZGdhYmxlIHRha2luZyBh
IGxvb2sgYXQgaXQuDQoNClN1cmUsIGdsYWQgdG8gaGVscCwgdGh4IHRvIHlvdSBmb3Igd3JpdGlu
ZyB0aGUgYXJjaCBwYXRjaGVzIGluIGZpcnN0IA0KcGxhY2UuIEl0IHRha2VzIGEgYml0IG9mIGRh
cmluZyB0byB2ZW50dXJlIGluIHVuY2hhcnRlcmVkIHdhdGVycyA7LSkNCg0KVGhlc2UgZGF5cyBp
dCBpcyBzdXBlciBlYXN5IHRvIGdldCB5b3VyIGhhbmRzIG9uIGEgQVJDIGNyb3NzIHRvb2xjaGFp
bi4gDQpXZSBkb24ndCBoYXZlIHRoZW0gc2hpcHBpbmcgYXMgcmVndWxhciBkaXN0cm8gcGFja2Fn
ZXMganVzdCB5ZXQsIGJ1dCB5b3UgDQpjYW4gZG93bmxvYWQgYSBwcmVidWlsdCBADQpodHRwczov
L2dpdGh1Yi5jb20vZm9zcy1mb3Itc3lub3BzeXMtZHdjLWFyYy1wcm9jZXNzb3JzL3Rvb2xjaGFp
bi9yZWxlYXNlcy9kb3dubG9hZC9hcmMtMjAyMC4wOS1yZWxlYXNlL2FyY19nbnVfMjAyMC4wOV9w
cmVidWlsdF9nbGliY19sZV9hcmNoc19saW51eF9pbnN0YWxsLnRhci5neg0KDQpPciB5b3UgY2Fu
IGp1c3QgYnVpbGQgdXBzdHJlYW0gZ2NjICsgYmludXRpbHMgZm9yIEFSQyBpZiB5b3Ugc28gcHJl
ZmVyLg0KDQoNCj4+PiAgICANCj4+PiAgICAJOyBOb3JtYWwgVHJhcC9JUlEgZW50cnkgb25seSBz
YXZlcyBTY3JhdGNoIChjYWxsZXItc2F2ZWQpIHJlZ3MNCj4+PiAgICAJOyBpbiBwdF9yZWcgc2lu
Y2UgdGhlICJDIiBBQkkgKGtlcm5lbCBjb2RlKSB3aWxsIGF1dG9tYXRpY2FsbHkNCj4+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcmMva2VybmVsL3NpZ25hbC5jIGIvYXJjaC9hcmMva2VybmVsL3NpZ25h
bC5jDQo+Pj4gaW5kZXggMmJlNTVmYjk2ZDg3Li5hNzhkOGY3NDVhNjcgMTAwNjQ0DQo+Pj4gLS0t
IGEvYXJjaC9hcmMva2VybmVsL3NpZ25hbC5jDQo+Pj4gKysrIGIvYXJjaC9hcmMva2VybmVsL3Np
Z25hbC5jDQo+Pj4gQEAgLTM2Miw3ICszNjIsNyBAQCB2b2lkIGRvX3NpZ25hbChzdHJ1Y3QgcHRf
cmVncyAqcmVncykNCj4+PiAgICANCj4+PiAgICAJcmVzdGFydF9zY2FsbCA9IGluX3N5c2NhbGwo
cmVncykgJiYgc3lzY2FsbF9yZXN0YXJ0YWJsZShyZWdzKTsNCj4+PiAgICANCj4+PiAtCWlmIChn
ZXRfc2lnbmFsKCZrc2lnKSkgew0KPj4+ICsJaWYgKHRlc3RfdGhyZWFkX2ZsYWcoVElGX1NJR1BF
TkRJTkcpICYmIGdldF9zaWduYWwoJmtzaWcpKSB7DQo+Pj4gICAgCQlpZiAocmVzdGFydF9zY2Fs
bCkgew0KPj4+ICAgIAkJCWFyY19yZXN0YXJ0X3N5c2NhbGwoJmtzaWcua2EsIHJlZ3MpOw0KPj4+
ICAgIAkJCXN5c2NhbGxfd29udF9yZXN0YXJ0KHJlZ3MpOwkvKiBObyBtb3JlIHJlc3RhcnRzICov
DQo+Pg0KPj4gSSd2ZSBub3Qgc2VlbiB5b3VyIGVudGlyZSBwYXRjaHNldCwgYnV0IGl0IHNlZW1z
IHdlIGFyZSBub3cgaGl0dGluZw0KPj4gZG9fc2lnbmFsKCkgZm9yIGVpdGhlciBvZiBUSUZfe1NJ
R1BFTkRJTkd8Tk9USUZZX1NJR05BTH0gYnV0IHRoZW4gb25seQ0KPj4gaGFuZGxpbmcgc2lnbmFs
IGZvciBUSUZfU0lHUEVORElORywgc28gd2h5IGV2ZW4gYm90aGVyIHRvIGNvbWUgaGVyZS4gRG8N
Cj4+IHlvdSBwbGFuIHRvIGFkZCBhZGRpdGlvbmFsIGFyY2ggaGFuZGxpbmcgbGF0ZXIgPw0KPiBO
b3BlLCB0aGF0J3MgYWxsIHRoYXQncyBuZWVkZWQgZm9yIGVhY2ggYXJjaC4gVGhlIGJlaGF2aW9y
IHlvdSBkZXNjcmliZQ0KPiBpcyBob3cgaXQgd29ya3MuIEl0IG1ha2VzIGl0IHNvIHRoYXQgVElG
X1NJR1BFTkRJTkcgd2lsbCBkbyB0aGUgc2lnbmFsDQo+IGRlbGl2ZXJ5IGFuZCBzeXNjYWxsIHJl
c3RhcnQgYXMgaXQgYWx3YXlzIGhhcyBkb25lLCBidXQNCj4gVElGX05PVElGWV9TSUdOQUwgd2ls
bCBvbmx5IGRvIHRoZSBzeXNjYWxsIHJlc3RhcnQuIFRoZSBsYXR0ZXIgaXMgdGhlDQo+IGludGVu
dCwgaGVuY2UgVElGX05PVElGWV9TSUdOQUwgcHJvdmlkZXMgYSB3YXkgdG8gaW50ZXJydXB0IGEg
cHJvY2Vzcw0KPiBhbmQgaGF2ZSBpdCBwcm9jZXNzIHRhc2tfd29yayB3aXRob3V0IGdvaW5nIHRo
cm91Z2ggc2lnbmFsIGRlbGl2ZXJ5IGxpa2UNCj4gdGFza193b3JrIHdpdGggVFdBX1NJR05BTCBk
b2VzIHRvZGF5Lg0KDQpOaWNlLCB0aHggZm9yIGV4cGxhaW5pbmcgdGhhdC4NCg0KPg0KPiBVcGRh
dGVkIHZlcnNpb24gYmVsb3c6DQo+DQo+DQo+IGNvbW1pdCAzYzYyMzk2NDdkOTVkMDNkMTQzNmJj
ODI2YTAwNDc5MWMzZjA0NjE3DQo+IEF1dGhvcjogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
Pg0KPiBEYXRlOiAgIE1vbiBPY3QgMTIgMDc6MTU6MzcgMjAyMCAtMDYwMA0KPg0KPiAgICAgIGFy
YzogYWRkIHN1cHBvcnQgZm9yIFRJRl9OT1RJRllfU0lHTkFMDQo+ICAgICAgDQo+ICAgICAgV2ly
ZSB1cCBUSUZfTk9USUZZX1NJR05BTCBoYW5kbGluZyBmb3IgYXJjLg0KPiAgICAgIA0KPiAgICAg
IENjOiBsaW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ICAgICAgU2lnbmVkLW9m
Zi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KDQpBY2tlZC1ieTogVmluZWV0IEd1
cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9p
bmNsdWRlL2FzbS90aHJlYWRfaW5mby5oIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vdGhyZWFkX2lu
Zm8uaA0KPiBpbmRleCBmOWVlZjBlOGYwYjcuLmMwOTQyYzI0ZDQwMSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcmMvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0KPiArKysgYi9hcmNoL2FyYy9pbmNs
dWRlL2FzbS90aHJlYWRfaW5mby5oDQo+IEBAIC03OSw2ICs3OSw3IEBAIHN0YXRpYyBpbmxpbmUg
X19hdHRyaWJ1dGVfY29uc3RfXyBzdHJ1Y3QgdGhyZWFkX2luZm8gKmN1cnJlbnRfdGhyZWFkX2lu
Zm8odm9pZCkNCj4gICAjZGVmaW5lIFRJRl9TSUdQRU5ESU5HCQkyCS8qIHNpZ25hbCBwZW5kaW5n
ICovDQo+ICAgI2RlZmluZSBUSUZfTkVFRF9SRVNDSEVECTMJLyogcmVzY2hlZHVsaW5nIG5lY2Vz
c2FyeSAqLw0KPiAgICNkZWZpbmUgVElGX1NZU0NBTExfQVVESVQJNAkvKiBzeXNjYWxsIGF1ZGl0
aW5nIGFjdGl2ZSAqLw0KPiArI2RlZmluZSBUSUZfTk9USUZZX1NJR05BTAk1CS8qIHNpZ25hbCBu
b3RpZmljYXRpb25zIGV4aXN0ICovDQo+ICAgI2RlZmluZSBUSUZfU1lTQ0FMTF9UUkFDRQkxNQkv
KiBzeXNjYWxsIHRyYWNlIGFjdGl2ZSAqLw0KPiAgIA0KPiAgIC8qIHRydWUgaWYgcG9sbF9pZGxl
KCkgaXMgcG9sbGluZyBUSUZfTkVFRF9SRVNDSEVEICovDQo+IEBAIC04OSwxMSArOTAsMTIgQEAg
c3RhdGljIGlubGluZSBfX2F0dHJpYnV0ZV9jb25zdF9fIHN0cnVjdCB0aHJlYWRfaW5mbyAqY3Vy
cmVudF90aHJlYWRfaW5mbyh2b2lkKQ0KPiAgICNkZWZpbmUgX1RJRl9TSUdQRU5ESU5HCQkoMTw8
VElGX1NJR1BFTkRJTkcpDQo+ICAgI2RlZmluZSBfVElGX05FRURfUkVTQ0hFRAkoMTw8VElGX05F
RURfUkVTQ0hFRCkNCj4gICAjZGVmaW5lIF9USUZfU1lTQ0FMTF9BVURJVAkoMTw8VElGX1NZU0NB
TExfQVVESVQpDQo+ICsjZGVmaW5lIF9USUZfTk9USUZZX1NJR05BTAkoMTw8VElGX05PVElGWV9T
SUdOQUwpDQo+ICAgI2RlZmluZSBfVElGX01FTURJRQkJKDE8PFRJRl9NRU1ESUUpDQo+ICAgDQo+
ICAgLyogd29yayB0byBkbyBvbiBpbnRlcnJ1cHQvZXhjZXB0aW9uIHJldHVybiAqLw0KPiAgICNk
ZWZpbmUgX1RJRl9XT1JLX01BU0sJCShfVElGX05FRURfUkVTQ0hFRCB8IF9USUZfU0lHUEVORElO
RyB8IFwNCj4gLQkJCQkgX1RJRl9OT1RJRllfUkVTVU1FKQ0KPiArCQkJCSBfVElGX05PVElGWV9S
RVNVTUUgfCBfVElGX05PVElGWV9TSUdOQUwpDQo+ICAgDQo+ICAgLyoNCj4gICAgKiBfVElGX0FM
TFdPUktfTUFTSyBpbmNsdWRlcyBTWVNDQUxMX1RSQUNFLCBidXQgd2UgZG9uJ3QgbmVlZCBpdC4N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2tlcm5lbC9lbnRyeS5TIGIvYXJjaC9hcmMva2VybmVs
L2VudHJ5LlMNCj4gaW5kZXggZWEwMGM4YTE3ZjA3Li4xZjUzMDhhYmYzNmQgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJjL2tlcm5lbC9lbnRyeS5TDQo+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9lbnRy
eS5TDQo+IEBAIC0zMDcsNyArMzA3LDggQEAgcmVzdW1lX3VzZXJfbW9kZV9iZWdpbjoNCj4gICAJ
bW92IHIwLCBzcAk7IHB0X3JlZ3MgZm9yIGFyZyB0byBkb19zaWduYWwoKS9kb19ub3RpZnlfcmVz
dW1lKCkNCj4gICANCj4gICAJR0VUX0NVUlJfVEhSX0lORk9fRkxBR1MgICByOQ0KPiAtCWJiaXQw
ICByOSwgVElGX1NJR1BFTkRJTkcsIC5MY2hrX25vdGlmeV9yZXN1bWUNCj4gKwlhbmQuZiAgMCwg
IHI5LCBUSUZfU0lHUEVORElOR3xUSUZfTk9USUZZX1NJR05BTA0KPiArCWJ6IC5MY2hrX25vdGlm
eV9yZXN1bWUNCj4gICANCj4gICAJOyBOb3JtYWwgVHJhcC9JUlEgZW50cnkgb25seSBzYXZlcyBT
Y3JhdGNoIChjYWxsZXItc2F2ZWQpIHJlZ3MNCj4gICAJOyBpbiBwdF9yZWcgc2luY2UgdGhlICJD
IiBBQkkgKGtlcm5lbCBjb2RlKSB3aWxsIGF1dG9tYXRpY2FsbHkNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJjL2tlcm5lbC9zaWduYWwuYyBiL2FyY2gvYXJjL2tlcm5lbC9zaWduYWwuYw0KPiBpbmRl
eCAyYmU1NWZiOTZkODcuLmE3OGQ4Zjc0NWE2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMva2Vy
bmVsL3NpZ25hbC5jDQo+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9zaWduYWwuYw0KPiBAQCAtMzYy
LDcgKzM2Miw3IEBAIHZvaWQgZG9fc2lnbmFsKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiAgIA0K
PiAgIAlyZXN0YXJ0X3NjYWxsID0gaW5fc3lzY2FsbChyZWdzKSAmJiBzeXNjYWxsX3Jlc3RhcnRh
YmxlKHJlZ3MpOw0KPiAgIA0KPiAtCWlmIChnZXRfc2lnbmFsKCZrc2lnKSkgew0KPiArCWlmICh0
ZXN0X3RocmVhZF9mbGFnKFRJRl9TSUdQRU5ESU5HKSAmJiBnZXRfc2lnbmFsKCZrc2lnKSkgew0K
PiAgIAkJaWYgKHJlc3RhcnRfc2NhbGwpIHsNCj4gICAJCQlhcmNfcmVzdGFydF9zeXNjYWxsKCZr
c2lnLmthLCByZWdzKTsNCj4gICAJCQlzeXNjYWxsX3dvbnRfcmVzdGFydChyZWdzKTsJLyogTm8g
bW9yZSByZXN0YXJ0cyAqLw0KPg0KDQo=
