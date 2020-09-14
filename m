Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C443268682
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgINHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:51:02 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:58531
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgINHu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ffXOHBC1jIY8KhYI2PWZk4+g3zyN2pYaENWyAq7pe0=;
 b=CdFIb1U1dhjkSmxMPqBPA8J7JaXEBbj55ySIXuPoqmnbiYvt1Wi2fM8++D0gVEnz9UvurZj43Q5q9tjl47h7U7jbYAv6LqUpfyXHv22OWT5zHjGrtMEzHPDua5D5zNLVXS4izsOG4AzwJ5k6PW/CPXJcxghEk96fCkYL+IyoBcs=
Received: from DB6PR0301CA0043.eurprd03.prod.outlook.com (2603:10a6:4:54::11)
 by VI1PR0801MB1965.eurprd08.prod.outlook.com (2603:10a6:800:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 07:50:43 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:54:cafe::8f) by DB6PR0301CA0043.outlook.office365.com
 (2603:10a6:4:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 07:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 07:50:43 +0000
Received: ("Tessian outbound 7161e0c2a082:v64"); Mon, 14 Sep 2020 07:50:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from ec64f431e5ed.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BD63C22E-1840-446B-BAA4-D484EED929C4.1;
        Mon, 14 Sep 2020 07:50:38 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec64f431e5ed.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Sep 2020 07:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6rpuCbYObeO6Jey6oYGO58YbtKYakC39AHB4xYtKjS2gv8LEiWpmk2BHJs4dOjbrNZHGJsz2ISMOJ28MEst2yB/Mkq9GXQNomMdsggfTqV62OZ+w55pYSGy/slPNVw0ym2COgTvdawJuEbII3Gll0Nx5qdITuhAyh4qJ4ERUpCbwzdqoCBSQZSZ0dbWJEuDqA4s4eayeiAG2224BqrQjNJSNUKqkgLKUUQFNE0gkVMc6jmtSvuCCa9wrobHONGdANaK0ox/EGd1bLQISRQ7VhclepkbfRitukAHcar7re7PD8l6BpjWrOFXWQedsF5GWiBclKEev/FPYy0dUJTQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ffXOHBC1jIY8KhYI2PWZk4+g3zyN2pYaENWyAq7pe0=;
 b=n/YcUe4mSNbryKNMgJySFEBI02t140YoalcMJKpseIxhb9/kaRxa+PPWVE6EqMJc2bYAy1VJzU/7tBqe4aFkz9gru/0fsNqIX+x68KOd7MEQNbkj9eLPyNYOrkNN7QKWE2MfM/3ni6SG+kqxcvTFVXc4wMGxDjct6QooHi5VTcDzRijMeLo0ePdaGOeahE06ZBWUqzTdBocSeBQx8dR4CYxL1D9QjQL1SKKNqfEl90N0VB+oBbg3mrASib0gJeOnVrVk1i3l4M6e2oS5yOV5RnzYmZe1vsJLBfRP3GjJdV2zRU/04TNqOGQVxCSvZXT8Ndu6PalT3Sgc0hqTGS1Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ffXOHBC1jIY8KhYI2PWZk4+g3zyN2pYaENWyAq7pe0=;
 b=CdFIb1U1dhjkSmxMPqBPA8J7JaXEBbj55ySIXuPoqmnbiYvt1Wi2fM8++D0gVEnz9UvurZj43Q5q9tjl47h7U7jbYAv6LqUpfyXHv22OWT5zHjGrtMEzHPDua5D5zNLVXS4izsOG4AzwJ5k6PW/CPXJcxghEk96fCkYL+IyoBcs=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB2105.eurprd08.prod.outlook.com (2603:10a6:3:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 07:50:35 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 07:50:35 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "lucho@ionkov.net" <lucho@ionkov.net>,
        Justin He <Justin.He@arm.com>,
        "ericvh@gmail.com" <ericvh@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>, Greg Kurz <groug@kaod.org>
Subject: RE: [V9fs-developer] [PATCH RFC 4/4] 9p: fix race issue in fid
 contention.
Thread-Topic: [V9fs-developer] [PATCH RFC 4/4] 9p: fix race issue in fid
 contention.
Thread-Index: AQHWikiH87ghgbrgBUG0aFcskfSv7KlnosKAgAAKGYCAABMHsA==
Date:   Mon, 14 Sep 2020 07:50:34 +0000
Message-ID: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914033754.29188-5-jianyong.wu@arm.com> <20200914055535.GA30672@nautica>
 <20200914063143.GA19326@nautica>
In-Reply-To: <20200914063143.GA19326@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: C3ABD42A3D035545A41592098F5451BB.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41abcc71-41d4-4963-26f6-08d85882e239
x-ms-traffictypediagnostic: HE1PR0801MB2105:|VI1PR0801MB1965:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1965F455B7F2B1C8784FC321F4230@VI1PR0801MB1965.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: x2pIYW+5jeu0FdSofYNClucT1h4bbHXS8622R0BulSdc7XftoQ6ardU/y0S1yQe6+6QBrwsuxcAwg+tYZsJiFEKuoUTx5q5MhfCQExh6blsE7QOT4jA6X2vrurQA5cmg8FWNPTv3sCrx/bA0JubSiMuupllQzzZX67kmoiC95M8nF9hdQYb+zRUPr8jOBFY4yK6+jWQp+Sie6s/DtldyAxgzgu653UeT8Irq/zjO1/RitZRUIsFQtYxVFfETLjfaoNI8Z49GLi+rAqYI6nsimhlpARjDLN+aQGyng2iPq6CuLMkYzlm/1nM5zf/OyNKcDmCInxR0wG5yz8Vk9GD0pH5h9KjV20FcMWVf/mjHyZty0vCYYpYln85gtVcS9nRcZW3lwX/tiJYXW86pQHNUVQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(9686003)(66446008)(6916009)(8676002)(186003)(26005)(7696005)(54906003)(2906002)(71200400001)(4326008)(5660300002)(86362001)(76116006)(6506007)(33656002)(478600001)(64756008)(53546011)(52536014)(55016002)(83380400001)(66476007)(8936002)(966005)(316002)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hYmMfNjY+QAX6dqgNXTHwhrrIEyGwa6WPG7nR0tAiMKQzC23CA0dzn2dtL2jkvAr8Fgsj8soNR0di1qAHSc5sfV5eVBzNrH9UosYdsqAMkF/2enxM4sSy4qANbytI3DMgahzt7B3NsJ3OWI0AoL0Om6X8lf2dmCyL2N83a8KxZXKPgjfjWw1U7SoIbw8X86GXbyI10lFRttjWDXcmKTgS7AoYB/jxtYLoG4VB7q+8JPvfVP8NFtJv6XdGlUrMt9twtTAd84SI4Cw33vZaSezIovqPLEII/OWIa+UiD5wlYEmQAYQ3cn73P9baIvTggXstZOAOQ2CJ0B0nt0xeSjc98G787nqTvtd30VYvIOrJuIpyMiqce4vu7Q1es5CMTE6Zbfwb5CBLpa5FmgerqWCCES6t8GXwdaF4lJ+NMKi7Fn9oVGadQJzqgqmwTPPepsQ1Dr6YrsEaRU84kqGP/kZJK9jM/bVBiyz+kCK+x+NB9Wh5aA8faM2d01tFGj4IVvdNcCfN7xU+C1PAuRf1eDDIBeN+JIuzW5WcK1ah8pZNZyq4p3wVkc/P4X2+d+Ous6X8HwXsPXn7xCdwy4bMymH6pCcy55JJsbAV9nm7vdS8WK7hNGqM22y9UrBSyscIzu6PIoRKRaP7J8rX+0o4f24Lw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2105
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6ccd1aff-63f2-493c-5217-08d85882dd1b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZ6hjTYb/iAJMnEGJ0xGxcwZNfxSi8UDMWPdnPrza2bVMvPiWgxar8Hvq9lKE8Sjw2IqkuKf40AaExg6688+o0OdVGJSJyQatp8ltjTPGDi/RmQoMMkyqLZScKhSBivhyKv34gm1M3EsuCed63tzWI0BTVLxosycE4+YrRMD8uJGZgHCrLcMsGY1uCh+kYsEpZ7dpr8n6zxwz1mVYvLA3jr4WAkYLweoZk/8+KhoAB9+RiMQVxLvqESejIFNj95+GxMEfbSCClkza36F/bs/MPjRvDmYnMgXZwhqZ82R2mqaj2qyc8VMwtIrOzcCa+LUBeZqTArbZCoksDTtkw2z59ASuaAori3dh9bI7DBNxcJt5pgIeA8ZPv9ddiu+7GYEYDHBkI1SrXAxUwRc73rmBghMKzG8sB0usJI2yk31wviITUL9cTRO3GaiD8y0C+caQhEvd+l3d8n+m/jgU8OH6Y4+WFrVAPFmHuHSowoiHV8=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966005)(26005)(5660300002)(82740400003)(7696005)(316002)(186003)(336012)(83380400001)(6506007)(55016002)(53546011)(8936002)(8676002)(478600001)(356005)(81166007)(33656002)(9686003)(86362001)(2906002)(4326008)(52536014)(47076004)(54906003)(6862004)(966005)(70206006)(70586007)(82310400003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 07:50:43.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41abcc71-41d4-4963-26f6-08d85882e239
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMTQsIDIwMjAgMjozMiBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25n
Lld1QGFybS5jb20+DQo+IENjOiBsdWNob0Bpb25rb3YubmV0OyBKdXN0aW4gSGUgPEp1c3Rpbi5I
ZUBhcm0uY29tPjsgZXJpY3ZoQGdtYWlsLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgdjlmcy1kZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBHcmVnDQo+IEt1cnog
PGdyb3VnQGthb2Qub3JnPg0KPiBTdWJqZWN0OiBSZTogW1Y5ZnMtZGV2ZWxvcGVyXSBbUEFUQ0gg
UkZDIDQvNF0gOXA6IGZpeCByYWNlIGlzc3VlIGluIGZpZA0KPiBjb250ZW50aW9uLg0KPg0KPiBE
b21pbmlxdWUgTWFydGluZXQgd3JvdGUgb24gTW9uLCBTZXAgMTQsIDIwMjA6DQo+ID4gSmlhbnlv
bmcgV3Ugd3JvdGUgb24gTW9uLCBTZXAgMTQsIDIwMjA6DQo+ID4gIC0gSWRlYWxseSBiYXNlIHlv
dXJzZWxmIG9mIG15IDlwLXRlc3QgYnJhbmNoIHRvIGhhdmUgYXN5bmMgY2x1bms6DQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL21hcnRpbmV0ZC9saW51eC9jb21taXRzLzlwLXRlc3QNCj4gPiBJJ3Zl
IGJlZW4gcHJvbWlzaW5nIHRvIHB1c2ggaXQgdG8gbmV4dCB0aGlzIHdlZWvihKIgZm9yIGEgY291
cGxlIG9mDQo+ID4gd2Vla3MgYnV0IGlmIHNvbWV0aGluZyBpcyBiYXNlZCBvbiBpdCBJIHdvbid0
IGJlIGFibGUgdG8gZGVsYXkgdGhpcw0KPiA+IG11Y2ggbG9uZ2VyLCBpdCdsbCBnZXQgcHVzaGVk
IHRvIDUuMTAgY3ljbGUgYW55d2F5Lg0KPiA+IChJJ2xsIHJlc2VuZCB0aGUgcGF0Y2hlcyB0byBi
ZSBjbGVhbikNCj4gPg0KPiA+PiB0ZXN0czoNCj4gPj4gcmFjZSBpc3N1ZSB0ZXN0IGZyb20gdGhl
IG9sZCB0ZXN0IGNhc2U6DQo+ID4+IGZvciBmaWxlIGluIHswMS4uNTB9OyBkbyB0b3VjaCBmLiR7
ZmlsZX07IGRvbmUgc2VxIDEgMTAwMCB8IHhhcmdzIC1uDQo+ID4+IDEgLVAgNTAgLUl7fSBjYXQg
Zi4qID4gL2Rldi9udWxsDQo+DQo+IGhtcGYsIHNvIHRoYXQgbWFkZSBtZSBpbnNpc3QgYSBiaXQg
b24gdGhpcyB0ZXN0IG9uIG15IHBhdGNoIGFuZCBJIHNlZSBhDQo+IHByb2JsZW0gd2l0aCB0aGF0
IGFzIHdlbGwuIFRoZSBtZSBmcm9tIGEgZmV3IHllYXJzIGFnbyB3YXMgZ29vZCENCj4NCj4gV2l0
aCB0aGF0IHNhaWQgSSdsbCB3YW50IHRvIHdvcmsgYSBiaXQgbW9yZSBvbiB0aGlzLCBzbyBmZWVs
IGZyZWUgdG8gYmFzZSBvZmYNCj4gbWFzdGVyIGFuZCBJJ2xsIGRlYWwgd2l0aCByZWJhc2UgaWYg
cmVxdWlyZWQuDQo+DQo+IFBhcnQgb2YgbWUgdGhpbmtzIGl0J3MgdGhlIHNhbWUgYnVnIHRoYXQg
d2lsbCBiZSBmaXhlZCB3aXRoIHJlZmNvdW50aW5nIGFuZCBJDQo+IGp1c3QgbWFkZSBpdCBlYXNp
ZXIgdG8gaGl0LCBidXQgSSdtIGhvbmVzdGx5IHVuc3VyZSBhdCB0aGlzIHBvaW50IGFuZCB0ZXN0
aW5nDQo+IHdvdWxkIGJhc2ljYWxseSBtZWFuIEkganVzdCBjb2RlIHdoYXQgSSBhc2tlZCB5b3Ug
dG8uLi4NCj4NCj4gV2VsbCwgbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gZG8gdGhlIHJl
ZmNvdW50aW5nLCBidXQgSSdkIHJhdGhlciBsZXQgeW91DQo+IGZpbmlzaCB3aGF0IHlvdSBzdGFy
dGVkLg0KDQpUaGFua3MsIEknbSBoYXBweSB0byB3b3JrIHRoaXMuDQo+SWYgcG9zc2libGUgcHV0
IHRoZSBwYXRjaCBmaXJzdCBpbiB0aGUgc2VyaWVzIHNvIGNvbW1pdHMNCj4gY2FuIGJlIHRlc3Rl
ZCBpbmRlcGVuZGVudGx5Lg0KDQpBaCwgdGhpcyBwYXRjaCBkZXBlbmRzIG9uIHRoZSBwcmV2aW91
cyBwYXRjaGVzLCBob3cgY2FuIEkgcHV0IGl0IGFzIHRoZSBmaXJzdCBvZiB0aGUgc2VyaWVzPw0K
DQpUaGFua3MNCkppYW55b25nDQoNCj4gVGhhbmtzLA0KPiAtLQ0KPiBEb21pbmlxdWUNCklNUE9S
VEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGlt
bWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBw
ZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9y
bWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
