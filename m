Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4026F9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIRKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:05:47 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:43425
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRKFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNokvzcnR02bTceMRVagVs1KvCyJdxCYzEiadoiH1Qs=;
 b=2IIwgb3h2h2ctOttg3rVNMa8tnWr3UZnfYgrSg1gAlftA1CU33Pz/BLo9fOL/ysqYGSWTvbR91r/l4zAnFm/9/Q9s0BeSxlgClocNUU+gLdBsIKGEk6iTktsiu6W/bp07aQCOhi82w4YQaPhzKDEKtlehxjHbuj8GpT2xQfoMoA=
Received: from DB8PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:10:100::44)
 by HE1PR0801MB1962.eurprd08.prod.outlook.com (2603:10a6:3:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 10:05:41 +0000
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::4d) by DB8PR06CA0031.outlook.office365.com
 (2603:10a6:10:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 10:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 10:05:40 +0000
Received: ("Tessian outbound 195a290eb161:v64"); Fri, 18 Sep 2020 10:05:40 +0000
X-CR-MTA-TID: 64aa7808
Received: from f07f19517232.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FC5C3833-7BAC-49CD-852B-A6D30CA0F7A3.1;
        Fri, 18 Sep 2020 10:05:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f07f19517232.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Sep 2020 10:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPoye1PWIxAV55W4RuVbDFRyvXdrQUgjv45S5sDU7BzPGuRhi9tAYH5dxGjdd/rEJIsKfGrvlGdmQmqibGbeyElZ77c6oaJcLIMcYxVFkyRVTVHVdixvEvj9n+SIqp90rMwxDOHSyAliCBtyQu1ap6FNIVg30bWTp/2sEX6hR9IZYncR8XfvA0sFdsHGgTNJHN8wRaOsOdui+icjOz8nRPI/eQ+caQJ/dmn2iOSLPLaVFplkJC6aQchFNXZKA08uRUAxrYxBifWSHykuJpbBDYW8omE7EGA84cgxqNx5B+6MxJCTia1ipCw2UQZ/wSZ5HGw8VZVOxIvo+1EedGRKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNokvzcnR02bTceMRVagVs1KvCyJdxCYzEiadoiH1Qs=;
 b=dKpkiHobmHLo6V6eeQOh/wzihUceeynSXDnDFdd/kQw6L3KcJuzr+0ciBCYRcsyiGf8Cxvx9cLkiVQfWBBydKjeJunQ0ILHeJNQRCaU8yZKhBxQjuYlJYBaKnQgt58wRKpbBdF++a22AsRRIUsBC0AE4Tz2uzESGKDc64ugmPQGsNhaDLpF4c47ZkgMPNmF5uoEjgBxEY5ER1vVt6HXFv9HA5LLkK/a26KXSdrEBX2JPzQ2yvcEXW1Knxsunsl0deeTdJ8tOOCiP0bY+s+12wbc1zBgSlPOdpCYLoroBjOCilwR1IxT4m/N0QCKTxBibZ0VJ/qUMSocG7j+XhXYlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNokvzcnR02bTceMRVagVs1KvCyJdxCYzEiadoiH1Qs=;
 b=2IIwgb3h2h2ctOttg3rVNMa8tnWr3UZnfYgrSg1gAlftA1CU33Pz/BLo9fOL/ysqYGSWTvbR91r/l4zAnFm/9/Q9s0BeSxlgClocNUU+gLdBsIKGEk6iTktsiu6W/bp07aQCOhi82w4YQaPhzKDEKtlehxjHbuj8GpT2xQfoMoA=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2554.eurprd08.prod.outlook.com (2603:10a6:3:d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 10:05:33 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 10:05:33 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>, Greg Kurz <groug@kaod.org>
Subject: RE: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Topic: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Index: AQHWinG9C+xn4SZNHU61ZAxGCD89xKluG5xQgAANXQCAAAfugA==
Date:   Fri, 18 Sep 2020 10:05:33 +0000
Message-ID: <HE1PR0802MB25555E46ABF8C53798B4FE5FF43F0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200914083200.GA9259@nautica>
 <HE1PR0802MB255560720A13BD59C11DEA00F43F0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200918093440.GA1877@nautica>
In-Reply-To: <20200918093440.GA1877@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 860EA2A240D8554EBB79B667509C2B1E.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90e77f53-1e89-477f-c22f-08d85bba661d
x-ms-traffictypediagnostic: HE1PR0802MB2554:|HE1PR0801MB1962:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1962273ED2492C6AC73331E4F43F0@HE1PR0801MB1962.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Dz07nSu9xuCbUASJu3ds5kD0O0JeAccXX93femmLV7rUAgp9iUlJrIPrZLdQj4fObGaPypRggfvhCKdT5vIApRVd4bpzPZwvA22aiw1djvNDILmOpDjhMBC13xgO+yIY7mEOC0yqFqu47EF9GC/KDLyj6EW4bLMoBoEsb11O8/4w4FUUmyi3QGNli1IR3bdYOysy5XO6FrECSchCLAkJVmBJD7L29deRivhA1f5kimp17rvyPGSMqQxQI/grvIQc3ZVvCIX0BlWEBmduUIiUhuOq4LHtaz01gkBrlcd5mxN2hmyum+YEVxvFMs4jgAxJxw9jr6mbYj4EYl0+NPXYAwfCELHR3CLCuJfbSEXrafzz0CxoL+Vl+0pgTIxRf7/g
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(186003)(66476007)(7696005)(6916009)(66446008)(64756008)(53546011)(83380400001)(4326008)(66946007)(66556008)(6506007)(71200400001)(2906002)(76116006)(5660300002)(9686003)(52536014)(8936002)(8676002)(86362001)(316002)(55016002)(26005)(33656002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: p8uNiKTvOM690D6qXJ7XlKsE19OzsQBzwL/WrHCnn1jswX3LroubEn3iuwi48G99f6Htw8dqSugCi+j0mrqjDsUfYqOrVgdnPg4xEuXjqPhF3kDvldej+Z5xYF6jkSQfjpaKBJGsej8IoTktBw6+EauQ6ph5l3SWqV88mm4PC80qeUUsAo1sVSQT0iO3C6vaft58v8TSYVIC3uubvTobJHlTH6xKgW79KHHPjzLQdUlKBaNGZxOW4R73VQp0mgx2JAgdfVOE/izfjdCgTBrysNqolSEiwPFSQK6bwlKDJVtkFx6P2LwmbWqQTxgkbfbNpZ0wnVJW72ralUxx66un1owG0KBRNh1K8e9Vi5hIZMGhwMWyKRt3foaXRhV6PQFrhQVzfPDBabijVPj81kvU082G1kjxOdTSddXfht63fJDDOA20vnvvzVxQ5ANJSB/NlDV95ItODIhWZ2w84ekmNDvlpBWyIgN4506yv9jwkwu723rZzVVHueDnte95Ti9r2jlg73fG+rSIkYsugl/c7xTzI1JX0kV6rYsYZMXezu3+UPw9CFn4ynDyCvKScg7pk85IRR2+v0oSbOqfev4RgAu6ynlcovwtpkZTrUO3n4reU0w8RoWrK1+ndkm67RlAQELpdU8PZvvQj7qGODqj9g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2554
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c9ce3ec-27cc-4ed2-e143-08d85bba61d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29WxIWOpx72awwp9Nbzhf3q8Xq5f/di6KiVW0/XtQzYYZLmSGkaIxI/4H6h3TZ4ZzBp/XwmBftc/qMJMZ3yX+7ZQDF10WxdidJsUfXXm3cdOZbT+Bycco0mlQurV176vZ/qP+g0wlkqIzVT9KWMj8plQXbx8IFvAANG19+m0vGVFt5m8aBjmtVaLPszYgs+NnVb2u2t9DzjxAr4nFaGIsx65eUzt4USNtNADIzzo3PVm+GReWv4Y1jd478GgJBi57jLPzC602JYv6op4lO4WV31nN8+9ppRbIIVXdfgM8RhYVn4CBh/WwqgTx+iYFJ5S2E38EivupAxkq8JqQGpIsgSHzHOvc7/QsBphs1gwTxnNFpHPati5Gxj9LJx4An9kxtF1yexTr9nkgrlUNaW5qg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(316002)(9686003)(2906002)(8936002)(54906003)(83380400001)(336012)(4326008)(478600001)(356005)(33656002)(55016002)(82740400003)(52536014)(81166007)(186003)(86362001)(8676002)(70586007)(47076004)(70206006)(82310400003)(26005)(5660300002)(6506007)(107886003)(7696005)(6862004)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 10:05:40.8126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e77f53-1e89-477f-c22f-08d85bba661d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9taW5pcXVlIE1hcnRp
bmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAx
OCwgMjAyMCA1OjM1IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT4N
Cj4gQ2M6IGVyaWN2aEBnbWFpbC5jb207IGx1Y2hvQGlvbmtvdi5uZXQ7IHY5ZnMtDQo+IGRldmVs
b3BlckBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEp1c3RpbiBIZQ0KPiA8SnVzdGluLkhlQGFybS5jb20+OyBHcmVnIEt1cnogPGdyb3VnQGthb2Qu
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyA0LzRdIDlwOiBmaXggcmFjZSBpc3N1ZSBp
biBmaWQgY29udGVudGlvbi4NCj4NCj4gSmlhbnlvbmcgV3Ugd3JvdGUgb24gRnJpLCBTZXAgMTgs
IDIwMjA6DQo+ID4gSWYgd2UgbW92ZSB0aGUgY291bnRlciBkZWNyZWFzZSBjb2RlIGludG8gcDlf
Y2xpZW50X2NsdW5rIGFuZCBwdXQgaXQNCj4gPiBpbnN0ZWFkIG9mIGZpZF9hdG9taWNfZGVjLCB3
ZSBuZWVkIGRlbGV0ZSBmaWQgb2ZmIHRoZSBpbm9kZSB3aGVyZSBpdA0KPiA+IHN0b3JlcyBpbiBw
OV9jbGllbnRfY2x1bmsuDQo+ID4gQnV0IHRoZXJlIGlzIG5vIHdheSBjYW4gd2UgYWNxdWlyZSB0
aGUgaW5vZGUgaW4gcDlfY2xpZW50X2NsdW5rLiBEbw0KPiA+IHlvdSBoYXZlIGFueSBpZGVhPyBJ
IHRoaW5rIGludHJvZHVjZSBhbm90aGVyIHBhcmFtZXRlciBmb3INCj4gPiBwOV9jbGllbnRfY2x1
bmsgSXMgbm90IGdyYWNlZnVsLg0KPg0KPiBZb3UgY2Fubm90IHdyaXRlIGNvZGUgYWJvdXQgdGhl
IGlub2RlIGluIHA5X2NsaWVudF9jbHVuaywgdGhlIHdheSB0aGUgY29kZQ0KPiBpcyBzcGxpdCBm
cy85cCBjYW4gcmVmZXIgdG8gbmV0LzlwIGJ1dCBub3QgdGhlIG90aGVyIHdheSBhcm91bmQgKG1v
ZHVsZS13aXNlLA0KPiA5cCBjYW4gcmVmZXIgdG8gOXBuZXQgYnV0IDlwbmV0IGNhbm5vdCByZWZl
ciB0byA5cCBvciB3ZSB3b3VsZCBoYXZlIGN5Y2xpYw0KPiBkZXBlbmRlbmNpZXMpDQo+DQo+IEhv
d2V2ZXIgSSBkb24ndCBzZWUgd2hhdCBib3RoZXJzIHlvdS4NCj4gdjlmc19kaXJfcmVsZWFzZSBj
YW4gcmVtb3ZlIHRoZSBmaWQgZnJvbSB0aGUgaW5vZGUgYXMgaXQgZG9lcyBjdXJyZW50bHkgYW5k
DQo+IGp1c3QgY2x1bmsgaW1tZWRpYXRlbHkgYWZ0ZXJ3YXJkcy4NCj4NCj4NCj4gSWYgYW5vdGhl
ciB1c2VyIG9mIHRoZSBmaWQgaGFkIGdvdHRlbiB0aGUgZmlkIGZyb20gdGhlIGlub2RlIHByZXZp
b3VzbHksIGl0IGhhcw0KPiBhIHJlZiwgc28gdGhlIGZpZCB3aWxsIG5vdCBiZSBhY3R1YWxseSBj
bHVua2VkIHRoZW4gYnV0IGl0IHdpbGwgYmUgY2x1bmtlZCBsYXRlcg0KPiB3aGVuIGl0IGlzIGRv
bmUgYmVpbmcgdXNlZCAtLSB0aGF0IGlzIHBlcmZlY3RseSBmaW5lID8NCj4NCj4gcDlfY2xpZW50
X2NsdW5rIHNob3VsZCBub3QgaGF2ZSB0byB3b3JyeSBhYm91dCBhbnl0aGluZyBpbiB0aGUgdmZz
Lg0KPg0KWWVhaCwgSSBzZWUuIFRoYXQncyBpdC4NCg0KVGhhbmtzDQpKaWFueW9uZw0KPiAtLQ0K
PiBEb21pbmlxdWUNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWls
IGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJp
dmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRl
bnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3Jl
IG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
