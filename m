Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5C2A77B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgKEHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:05:38 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:11489
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbgKEHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o3dosGdndAFHC2eyJH6rKlL+GChcGRd1P2nYQegn6o=;
 b=QtK6FqaAbw/Bg7fylvYYg8JO7egixo6lft96JTM9TMXV3Q/5xoLAD8ydSk39ZRunB/BPUCxB6v50dOANwtQQhPo3sM4bVN9lR/ugZiOeIfPJ/eHFguhQ3MOKhpYHFX5r22Z/SGV08V/QflUY0V6C+2YeZ0mAJa9eYFaBVg60aDE=
Received: from AM6PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:20b:92::25)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 07:05:31 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::81) by AM6PR04CA0012.outlook.office365.com
 (2603:10a6:20b:92::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 5 Nov 2020 07:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Thu, 5 Nov 2020 07:05:31 +0000
Received: ("Tessian outbound e6c55a0b9ba9:v64"); Thu, 05 Nov 2020 07:05:30 +0000
X-CR-MTA-TID: 64aa7808
Received: from f545cf7d6ce4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 38E20ED5-B40A-4C02-9CB7-35D9B1858DAF.1;
        Thu, 05 Nov 2020 07:05:25 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f545cf7d6ce4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Nov 2020 07:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBPmeOKyUuf9yfc+sfmcLY1FYjCGbPhMzFU+pTiPCFI38AZvAfx6FPvvPL2qNT4aRe4clSoFb/qu/EB2mjCheekoT83G1FO0IisH0TvkpGvBZ5reNAaRCNZp3zGFoauizQ/gbVgDzMAqbx+sKzrnn5aQAj4MBuKv7Pon4C9Ylb2H/Rh4HgSDA3tqkWXr0xT+vq+e1zXtuzlT+hc3H1losLawyQFX63rYBZgYObz1XipW9zTe9sqS2NzL8o74uPXue6zj+xE8+oMImGyzVt/PAtzF0U9Aaj3qb7jU5KNBq4nZlYpq9/f7cboIK4OvukYswovDYSFu1hAlrmpbzcYTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o3dosGdndAFHC2eyJH6rKlL+GChcGRd1P2nYQegn6o=;
 b=Uviu1/w3jY5I2s+h9XoHk4YsIlg+0IRgA+CRN/bpKLXxBaX6e3bHD3ZAS4A3UOIU4V0EAbHOUmy47OeQoqDJTwo4PIg9KcGMrL9YGt8GODrJUNW09L/T37AOtcESTKyhzc5tL7mkWna+Ssck2uDtMhFiMxOPi74RDxRjjgx7ZEzRth76zBOcyM852AkObAQlanBS02n8xVB8on7LRyF//EPsKTrGw5I07am/T0iLcIf2h29c8eGUnFOov52DUHHJXL2xWyIUj/e4a0p7wpk4Ee+hQdhuoY2VKs7Id9KmTmor82Qq3vnb2MH52dzpAX/Ns4GRTbex8oWt06Fkw8Edtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o3dosGdndAFHC2eyJH6rKlL+GChcGRd1P2nYQegn6o=;
 b=QtK6FqaAbw/Bg7fylvYYg8JO7egixo6lft96JTM9TMXV3Q/5xoLAD8ydSk39ZRunB/BPUCxB6v50dOANwtQQhPo3sM4bVN9lR/ugZiOeIfPJ/eHFguhQ3MOKhpYHFX5r22Z/SGV08V/QflUY0V6C+2YeZ0mAJa9eYFaBVg60aDE=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1977.eurprd08.prod.outlook.com (2603:10a6:3:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.30; Thu, 5 Nov
 2020 07:05:24 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9930:b22f:9e8c:8200]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9930:b22f:9e8c:8200%5]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:05:23 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "qemu_oss@crudebyte.com" <qemu_oss@crudebyte.com>,
        "groug@kaod.org" <groug@kaod.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: RE: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Thread-Topic: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Thread-Index: AQHWkbOl16CkOw3tJ0mFRMvqqCi+c6m2eE8AgALmhqA=
Date:   Thu, 5 Nov 2020 07:05:23 +0000
Message-ID: <HE1PR0802MB2555B7618328CA57EFE30789F4EE0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com> <20201103104116.GA19587@nautica>
In-Reply-To: <20201103104116.GA19587@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E00F84D367DCCA4796D6C666C63973C7.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cc0cda3-7425-4a30-fd89-08d881592f12
x-ms-traffictypediagnostic: HE1PR0801MB1977:|DB8PR08MB5401:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB54018EB2DE0255F56C7BC73CF4EE0@DB8PR08MB5401.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uZaqOYwDCZrn9DEc2dT7aE6MzEkiM0YNa4En8uGGt/+S+hlz9SZMn/n5cN/MbX5KZoAcGaEUVpv9CzGckEP11rIDtSFwq7+/C8JXerbzUn72ZsCES3tnuOc+Yc/lueZTkaYbYg/r3CymEBBv8+mhpggGbIlpdENVgaJB3YwWI5pGLnnyDY8ew+d94scHwO1VbG+ODPdtD4RxOgMHNEGHNemCDpiWv5SGhRbKaMEsfltLoslBYuubSPc94nW3Ubgjv8byaEsh6laGZfPu7C3nqHPOzBWalKbwxOuUViuEY7k3Xo+q8C1g4ubK2eqtfucjfMH/8cwNWIKeB4AWyFagJw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(2906002)(86362001)(71200400001)(7696005)(26005)(52536014)(186003)(83380400001)(6506007)(53546011)(66946007)(66446008)(76116006)(66556008)(66476007)(64756008)(8936002)(9686003)(55016002)(6916009)(4326008)(5660300002)(478600001)(316002)(33656002)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: E0NaKN+zs1G42paHcGn+hjFV+E/JaDrOLh0dZv0wARdQt/yMeF1Dd3ELEN2thumPZm4gX+2Wq0RrvyL7qKezEa85jwsV+OYbNXGxeaNpMuhNWfZAkF9YNZVbHD2S1VIwB36IIm3BCA7TJxhojQnT3lwskmcElNdmaH14f9rvr66URZCXUx+yuA5bZKcqvcf5NAlGxmjLg3MKU7H3DgN0kvBau1ytUGhnnueWkcWHLbZk9uxAH60NVwODscm/H7KqpT2i88QUEP417ntoRemgAPVahaRCFzIoUKbwLz81nRlhfdg6yPyG9gVmJDSicc+tDN6/xIWwML+RsotQ78NweDKqA01xZ4DtMxWABjFlBB51j0/yGcNCYJjzuEij6wc/sDIo2C10qZW+8CESbmp5zn18lE32KLv8+oX87C+cLpRYInVD3PTaknFRUJi+bNEnMBk9pPA9IaUCKMySOHe1UVKTiM4IqaOWiYfJ2Xjs/KPKuh3NCUQ/2RBLohn3lkx2cX6OuBshFFYiPBjMgkFqZ1/GjhsiEEb1OVV148IVez2nDWainQzQOCubLht3245ED/weuQfTlNk2UEyrC3Nr6witRLAy2YePGczft365Mx57zEUSoOoj7/K6r/a8jbK2oj/b8KuqgnqYu38+FNZohQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d3af7a2a-b09d-4927-7ea0-08d881592a95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLfXvsZEP0vIQMrgkNGFV52+p765cz/goXbH+2rFt4AkTfQgQCnpWc5iEIdSm34zreKvDpxM0e7rkY81JcAZueyJn72SSGZHm1UDwBTDW4Dmj/4PsxqVrnxpq4ziBUDuQ4TutH7cCTMqbl1xxWUn3B8iLkEmtxpD4wMGzIQBpFzKe3eaeLZYkuhZ54eyWtEktNnFsVz9S6SSLDtAfzCdVe8aqhIkoaPGUDHJgkcTf9ZikfHmb1C6boc6aJM7CpCUrjVtVWGJnjWYH2/NOvGQ6A2BfZEChrCkeNECe2seMkmiW+36cOv3ESOit3kRaTB3ReLiM6FL78w31wPpPMBF2PaMQPRXHYxq18ogkEB/mHxENkWgfpHLFki9XuBLe1PLeXOTmgC/1oY2l087crVgMQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(33656002)(356005)(70586007)(82310400003)(70206006)(83380400001)(478600001)(7696005)(81166007)(82740400003)(8676002)(47076004)(55016002)(336012)(52536014)(5660300002)(2906002)(36906005)(186003)(4326008)(8936002)(9686003)(316002)(53546011)(6862004)(6506007)(86362001)(54906003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 07:05:31.4211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc0cda3-7425-4a30-fd89-08d881592f12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQpHb29kIE5ld3MhDQpJJ20gaGFwcHkgdG8gc2VlIHRoYXQgeW91IGhh
dmUgdGltZSB0byBwaWNrIHRoaXMgdXAgYWdhaW4uIEFsbCB0aGUgY2hhbmdlcyBhcmUgT0sgZm9y
IG1lLg0KDQpUaGFua3MNCkppYW55b25nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogRG9taW5pcXVlIE1hcnRpbmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBT
ZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAzLCAyMDIwIDY6NDEgUE0NCj4gVG86IEppYW55b25nIFd1
IDxKaWFueW9uZy5XdUBhcm0uY29tPg0KPiBDYzogZXJpY3ZoQGdtYWlsLmNvbTsgbHVjaG9AaW9u
a292Lm5ldDsgcWVtdV9vc3NAY3J1ZGVieXRlLmNvbTsNCj4gZ3JvdWdAa2FvZC5vcmc7IHY5ZnMt
ZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggUkZDIHYyIDQvNF0gOXA6IGZpeCByYWNlIGlzc3VlIGluIGZpZCBjb250ZW50aW9uLg0K
Pg0KPiBKaWFueW9uZywNCj4NCj4gSmlhbnlvbmcgV3Ugd3JvdGUgb24gV2VkLCBTZXAgMjMsIDIw
MjA6DQo+ID4gRXJpYydzIGFuZCBHcmVnJ3MgcGF0Y2ggb2ZmZXIgYSBtZWNoYW5pc20gdG8gZml4
IG9wZW4tdW5saW5rLWYqc3lzY2FsbA0KPiA+IGJ1ZyBpbiA5cC4gQnV0IHRoZXJlIGlzIHJhY2Ug
aXNzdWUgaW4gZmlkIGNvbXRlbnRpb24uDQo+ID4gQXMgR3JlZydzIHBhdGNoIHN0b3JlcyBhbGwg
b2YgZmlkcyBmcm9tIG9wZW5lZCBmaWxlcyBpbnRvIGFjY29yZGluZw0KPiA+IGlub2RlLCBzbyBh
bGwgdGhlIGxvb2t1cCBmaWQgb3BzIGNhbiByZXRyaWV2ZSBmaWQgZnJvbSBpbm9kZQ0KPiA+IHBy
ZWZlcmVudGlhbGx5LiBCdXQgdGhlcmUgaXMgbm8gbWVjaGFuaXNtIHRvIGhhbmRsZSB0aGUgZmlk
IGNvbXRlbnRpb24NCj4gPiBpc3N1ZS4gRm9yIGV4YW1wbGUsIHRoZXJlIGFyZSB0d28gdGhyZWFk
cyBnZXQgdGhlIHNhbWUgZmlkIGluIHRoZSBzYW1lDQo+ID4gdGltZSBhbmQgb25lIG9mIHRoZW0g
Y2x1bmsgdGhlIGZpZCBiZWZvcmUgdGhlIG90aGVyIHRocmVhZCByZWFkeSB0bw0KPiA+IGRpc2Nh
cmQgdGhlIGZpZC4gSW4gdGhpcyBzY2VuYXJpbywgaXQgd2lsbCBsZWFkIHRvIHNvbWUgZmF0YWwg
cHJvYmxlbXMsIGV2ZW4NCj4ga2VybmVsIGNvcmUgZHVtcC4NCj4gPg0KPiA+IEkgaW50cm9kdWNl
IGEgbWVjaGFuaXNtIHRvIGZpeCB0aGlzIHJhY2UgaXNzdWUuIEEgY291bnRlciBmaWVsZA0KPiA+
IGludHJvZHVjZWQgaW50byBwOV9maWQgc3RydWN0IHRvIHN0b3JlIHRoZSByZWZlcmVuY2UgY291
bnRlciB0byB0aGUNCj4gPiBmaWQuIFdoZW4gYSBmaWQgaXMgYWxsb2NhdGVkIGZyb20gdGhlIGlu
b2RlIG9yIGRlbnRyeSwgdGhlIGNvdW50ZXINCj4gPiB3aWxsIGluY3JlYXNlLCBhbmQgd2lsbCBk
ZWNyZWFzZSBhdCB0aGUgZW5kIG9mIGl0cyBvY2N1cGF0aW9uLiBJdCBpcw0KPiA+IGd1YXJhbnRl
ZWQgdGhhdCB0aGUgZmlkIHdvbid0IGJlIGNsdW5rZWQgYmVmb3JlIHRoZSByZWZlcmVuY2UgY291
bnRlcg0KPiA+IGdvIGRvd24gdG8gMCwgdGhlbiB3ZSBjYW4gYXZvaWQgdGhlIGNsdW5rZWQgZmlk
IHRvIGJlIHVzZWQuDQo+ID4NCj4gPiB0ZXN0czoNCj4gPiByYWNlIGlzc3VlIHRlc3QgZnJvbSB0
aGUgb2xkIHRlc3QgY2FzZToNCj4gPiBmb3IgZmlsZSBpbiB7MDEuLjUwfTsgZG8gdG91Y2ggZi4k
e2ZpbGV9OyBkb25lIHNlcSAxIDEwMDAgfCB4YXJncyAtbiAxDQo+ID4gLVAgNTAgLUl7fSBjYXQg
Zi4qID4gL2Rldi9udWxsDQo+ID4NCj4gPiBvcGVuLXVubGluay1mKnN5c2NhbGwgdGVzdDoNCj4g
PiBJIGhhdmUgdGVzdGVkIGZvciBmKnN5c2NhbGwgaW5jbHVkZTogZnRydW5jYXRlIGZzdGF0IGZj
aG93biBmY2htb2QgZmFjY2Vzc2F0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcg
V3UgPGppYW55b25nLnd1QGFybS5jb20+DQo+DQo+IE9rIHNvIEkndmUgZmluYWxseSB0YWtlbiBz
b21lIHRpbWUgdG8gdGVzdCAtLSBzb3JyeSBmb3IgdGhlIGRlbGF5Lg0KPiBJIGRpZG4ndCBib3Ro
ZXIgd2l0aCBxZW11IGJ1dCB0aGUgdXNlLWFmdGVyLWNsb3NlIGYqIGNhbGxzIHdvcmsgd2l0aCBu
ZnMtDQo+IGdhbmVzaGEgYW5kIGl0IGRvZXNuJ3QgaW50cm9kdWNlIGFueSBvYnZpb3VzIHJlZ3Jl
c3Npb24gd2l0aCB0aGUgY3VycmVudA0KPiBxZW11IGVpdGhlciwgc28gdGhpcyBpcyBnb29kIGZv
ciBtZS4NCj4NCj4gR3JlZywgQ2hyaXN0aWFuIC0gZnJvbSB3aGF0IEkgdW5kZXJzdG9vZCAoaW4g
cHJpdmF0ZSwgaG9wZWZ1bGx5IEknbSBhbGxvd2VkIHRvDQo+IHJlcGVhdCEpLCBoZSB3b24ndCBi
ZSBhYmxlIHRvIGNvbnRyaWJ1dGUgdG8gcWVtdSBiZWNhdXNlIG9mIGNvbXBhbnkNCj4gcG9saWNp
ZXMgYW5kIEknbSB1bmxpa2VseSB0byB0YWtlIHRoZSB0aW1lIGVpdGhlciByaWdodCBub3cuDQo+
IEkgZG9uJ3QgdGhpbmsgaXQncyBhIHByb2JsZW0gdG8gY29udGludWUgYXMgaXMgdGhvdWdoLCB3
ZSBjYW4gbGFuZCBsaW51eCBrZXJuZWwNCj4gc3VwcG9ydCAoaXQncyBzdGlsbCB1c2VmdWwgZm9y
IG5vbi1xZW11IHNlcnZlcnMpIGFuZCBpZiBzb21lb25lIGlzIGludGVyZXN0ZWQNCj4gbGF0ZXIg
b24gdGhleSdsbCBqdXN0IG5lZWQgdG8gZmluaXNoIHRoYXQgYml0Lg0KPg0KPg0KPiBJJ20gbm90
IHNlZWluZyBhbnkgb2J2aW91cyBwcm9ibGVtIG5vdyBzbyBJJ2xsIHRha2UgdGhlc2UgcGF0Y2hl
cyBpbiAtbmV4dA0KPiB3aXRoaW4gdGhlIG5leHQgZmV3IGRheXMsIHdpdGggdGhpcyBleHRyYSBw
YXRjaCBvbiB0b3AgdGhhdCBiYXNpY2FsbHkgYXBwbGllcw0KPiB0aGUgcmVxdWVzdHMgSSBoYWQ6
DQo+ICAtIHJlbW92aW5nIHRoZSBleHRyYSBhdG9taWNfc2V0IGluIGZzLzlwL2ZpZC5jDQo+ICAt
IGNvbnZlcnQgZnJvbSBhdG9taWMgdG8gcmVmY291bnQgQVBJIChvdmVyZmxvdyBjaGVja3MpDQo+
ICAtIHJlbmFtZSBhIG5vLWNvbXBvc2FudCB3YWxrIHRvIGNsb25lX2ZpZCgpDQo+DQo+IEknbGwg
anVzdCBydW4gc29tZSBtb3JlIGluc3RydW1lbnRlZCB0ZXN0cyBmaXJzdCB0byBjaGVjayB3ZSdy
ZSBub3QgbGVha2luZw0KPiBhbnl0aGluZyBidXQgc28gZmFyIEkgaGF2ZW4ndCBmb3VuZCBhbnkg
cHJvYmxlbS4NCj4NCj4gSWYgeW91IG5vdGljZWQgYW55dGhpbmcgZWxzZSBwbGVhc2Ugc3BlYWsg
dXAuDQo+IFRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGZpbmlzaCB0aGlzISA6KQ0KPiAt
LS0NCj4gIGZzLzlwL2ZpZC5jICAgICAgICAgICAgIHwgMTAgKysrKy0tLS0tLQ0KPiAgZnMvOXAv
ZmlkLmggICAgICAgICAgICAgfCAgMiArLQ0KPiAgaW5jbHVkZS9uZXQvOXAvY2xpZW50LmggfCAg
MiArLQ0KPiAgbmV0LzlwL2NsaWVudC5jICAgICAgICAgfCAgNCArKy0tDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9mcy85cC9maWQuYyBiL2ZzLzlwL2ZpZC5jDQo+IGluZGV4IDg5NjQzZGFiY2RhZS4uNTAxMThl
YzcyYTkyIDEwMDY0NA0KPiAtLS0gYS9mcy85cC9maWQuYw0KPiArKysgYi9mcy85cC9maWQuYw0K
PiBAQCAtMjgsNyArMjgsNiBAQA0KPg0KPiAgc3RhdGljIGlubGluZSB2b2lkIF9fYWRkX2ZpZChz
dHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBwOV9maWQgKmZpZCkgIHsNCj4gLWF0b21pY19z
ZXQoJmZpZC0+Y291bnQsIDEpOw0KPiAgaGxpc3RfYWRkX2hlYWQoJmZpZC0+ZGxpc3QsIChzdHJ1
Y3QgaGxpc3RfaGVhZCAqKSZkZW50cnktDQo+ID5kX2ZzZGF0YSk7ICB9DQo+DQo+IEBAIC02Miw3
ICs2MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcDlfZmlkICp2OWZzX2ZpZF9maW5kX2lub2RlKHN0cnVj
dCBpbm9kZQ0KPiAqaW5vZGUsIGt1aWRfdCB1aWQpDQo+ICB9DQo+ICB9DQo+ICBpZiAocmV0ICYm
ICFJU19FUlIocmV0KSkNCj4gLWF0b21pY19pbmMoJnJldC0+Y291bnQpOw0KPiArcmVmY291bnRf
aW5jKCZyZXQtPmNvdW50KTsNCj4gIHNwaW5fdW5sb2NrKCZpbm9kZS0+aV9sb2NrKTsNCj4gIHJl
dHVybiByZXQ7DQo+ICB9DQo+IEBAIC03Nyw3ICs3Niw2IEBAIHN0YXRpYyBzdHJ1Y3QgcDlfZmlk
ICp2OWZzX2ZpZF9maW5kX2lub2RlKHN0cnVjdCBpbm9kZQ0KPiAqaW5vZGUsIGt1aWRfdCB1aWQp
ICB2b2lkIHY5ZnNfb3Blbl9maWRfYWRkKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdA0KPiBw
OV9maWQgKmZpZCkgIHsNCj4gIHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQo+IC1hdG9taWNf
c2V0KCZmaWQtPmNvdW50LCAxKTsNCj4gIGhsaXN0X2FkZF9oZWFkKCZmaWQtPmlsaXN0LCAoc3Ry
dWN0IGhsaXN0X2hlYWQgKikmaW5vZGUtPmlfcHJpdmF0ZSk7DQo+ICBzcGluX3VubG9jaygmaW5v
ZGUtPmlfbG9jayk7DQo+ICB9DQo+IEBAIC0xMTAsNyArMTA4LDcgQEAgc3RhdGljIHN0cnVjdCBw
OV9maWQgKnY5ZnNfZmlkX2ZpbmQoc3RydWN0IGRlbnRyeQ0KPiAqZGVudHJ5LCBrdWlkX3QgdWlk
LCBpbnQgYW55KQ0KPiAgaGxpc3RfZm9yX2VhY2hfZW50cnkoZmlkLCBoLCBkbGlzdCkgew0KPiAg
aWYgKGFueSB8fCB1aWRfZXEoZmlkLT51aWQsIHVpZCkpIHsNCj4gIHJldCA9IGZpZDsNCj4gLWF0
b21pY19pbmMoJnJldC0+Y291bnQpOw0KPiArcmVmY291bnRfaW5jKCZyZXQtPmNvdW50KTsNCj4g
IGJyZWFrOw0KPiAgfQ0KPiAgfQ0KPiBAQCAtMjAxLDcgKzE5OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cDlfZmlkICp2OWZzX2ZpZF9sb29rdXBfd2l0aF91aWQoc3RydWN0DQo+IGRlbnRyeSAqZGVudHJ5
LA0KPiAgfQ0KPiAgLyogSWYgd2UgYXJlIHJvb3Qgb3Vyc2VsZiBqdXN0IHJldHVybiB0aGF0ICov
DQo+ICBpZiAoZGVudHJ5LT5kX3NiLT5zX3Jvb3QgPT0gZGVudHJ5KSB7DQo+IC1hdG9taWNfaW5j
KCZmaWQtPmNvdW50KTsNCj4gK3JlZmNvdW50X2luYygmZmlkLT5jb3VudCk7DQo+ICByZXR1cm4g
ZmlkOw0KPiAgfQ0KPiAgLyoNCj4gQEAgLTI1MCw3ICsyNDgsNyBAQCBzdGF0aWMgc3RydWN0IHA5
X2ZpZCAqdjlmc19maWRfbG9va3VwX3dpdGhfdWlkKHN0cnVjdA0KPiBkZW50cnkgKmRlbnRyeSwN
Cj4gIGZpZCA9IEVSUl9QVFIoLUVOT0VOVCk7DQo+ICB9IGVsc2Ugew0KPiAgX19hZGRfZmlkKGRl
bnRyeSwgZmlkKTsNCj4gLWF0b21pY19pbmMoJmZpZC0+Y291bnQpOw0KPiArcmVmY291bnRfaW5j
KCZmaWQtPmNvdW50KTsNCj4gIHNwaW5fdW5sb2NrKCZkZW50cnktPmRfbG9jayk7DQo+ICB9DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9mcy85cC9maWQuaCBiL2ZzLzlwL2ZpZC5oDQo+IGluZGV4IDFm
ZWQ5NjU0NjcyOC4uZjdmMzM1MDllMTY5IDEwMDY0NA0KPiAtLS0gYS9mcy85cC9maWQuaA0KPiAr
KysgYi9mcy85cC9maWQuaA0KPiBAQCAtMjgsNyArMjgsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVj
dCBwOV9maWQgKnY5ZnNfZmlkX2Nsb25lKHN0cnVjdCBkZW50cnkNCj4gKmRlbnRyeSkNCj4gIGlm
ICghZmlkIHx8IElTX0VSUihmaWQpKQ0KPiAgcmV0dXJuIGZpZDsNCj4NCj4gLW5maWQgPSBwOV9j
bGllbnRfd2FsayhmaWQsIDAsIE5VTEwsIDEpOw0KPiArbmZpZCA9IGNsb25lX2ZpZChmaWQpOw0K
PiAgcDlfY2xpZW50X2NsdW5rKGZpZCk7DQo+ICByZXR1cm4gbmZpZDsNCj4gIH0NCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbmV0LzlwL2NsaWVudC5oIGIvaW5jbHVkZS9uZXQvOXAvY2xpZW50Lmgg
aW5kZXgNCj4gNThlZDliZDMwNmJkLi5lMWMzMDhkOGQyODggMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbmV0LzlwL2NsaWVudC5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0LzlwL2NsaWVudC5oDQo+IEBA
IC0xNDksNyArMTQ5LDcgQEAgZW51bSBmaWRfc291cmNlIHsNCj4gIHN0cnVjdCBwOV9maWQgew0K
PiAgc3RydWN0IHA5X2NsaWVudCAqY2xudDsNCj4gIHUzMiBmaWQ7DQo+IC1hdG9taWNfdCBjb3Vu
dDsNCj4gK3JlZmNvdW50X3QgY291bnQ7DQo+ICBpbnQgbW9kZTsNCj4gIHN0cnVjdCBwOV9xaWQg
cWlkOw0KPiAgdTMyIGlvdW5pdDsNCj4gZGlmZiAtLWdpdCBhL25ldC85cC9jbGllbnQuYyBiL25l
dC85cC9jbGllbnQuYyBpbmRleA0KPiBhNmM4YTkxNWUwZDguLmJhNDkxMDEzOGM1YiAxMDA2NDQN
Cj4gLS0tIGEvbmV0LzlwL2NsaWVudC5jDQo+ICsrKyBiL25ldC85cC9jbGllbnQuYw0KPiBAQCAt
OTAxLDcgKzkwMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcDlfZmlkICpwOV9maWRfY3JlYXRlKHN0cnVj
dCBwOV9jbGllbnQNCj4gKmNsbnQpDQo+ICBmaWQtPmNsbnQgPSBjbG50Ow0KPiAgZmlkLT5yZGly
ID0gTlVMTDsNCj4gIGZpZC0+ZmlkID0gMDsNCj4gLWF0b21pY19zZXQoJmZpZC0+Y291bnQsIDEp
Ow0KPiArcmVmY291bnRfc2V0KCZmaWQtPmNvdW50LCAxKTsNCj4NCj4gIGlkcl9wcmVsb2FkKEdG
UF9LRVJORUwpOw0KPiAgc3Bpbl9sb2NrX2lycSgmY2xudC0+bG9jayk7DQo+IEBAIC0xNDY2LDcg
KzE0NjYsNyBAQCBpbnQgcDlfY2xpZW50X2NsdW5rKHN0cnVjdCBwOV9maWQgKmZpZCkNCj4gIGR1
bXBfc3RhY2soKTsNCj4gIHJldHVybiAwOw0KPiAgfQ0KPiAtaWYgKCFhdG9taWNfZGVjX2FuZF90
ZXN0KCZmaWQtPmNvdW50KSkNCj4gK2lmICghcmVmY291bnRfZGVjX2FuZF90ZXN0KCZmaWQtPmNv
dW50KSkNCj4gIHJldHVybiAwOw0KPg0KPiAgYWdhaW46DQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRo
ZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVu
dGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBk
byBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBm
b3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBt
ZWRpdW0uIFRoYW5rIHlvdS4NCg==
