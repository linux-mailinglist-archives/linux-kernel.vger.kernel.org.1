Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26926860B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:33:11 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:33031
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbgINHcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJxkN1EirZvQd8NO8mdOn32GkSfrccGUzllgB/icNvc=;
 b=7bUNFF1bIDEEWyRxXcb7Kg0DZSMZLTC70bCDBADFwB2/EAU+NWgxUkz8Y4NKuWZRozAYfI9I9myT+rP7bTSuAwgR3ZiCSsVtMexckJIBEo1Ol58jXPs83bQwcXQH47c+jn+/HJ1f50XlDbpfgrfy4gLqYMyJr5aJsBpPSREA7ys=
Received: from DB6PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:4:29::14)
 by DB6PR0801MB2006.eurprd08.prod.outlook.com (2603:10a6:4:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 07:32:49 +0000
Received: from DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::7b) by DB6PR0202CA0004.outlook.office365.com
 (2603:10a6:4:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 07:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT011.mail.protection.outlook.com (10.152.20.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 07:32:49 +0000
Received: ("Tessian outbound 7161e0c2a082:v64"); Mon, 14 Sep 2020 07:32:49 +0000
X-CR-MTA-TID: 64aa7808
Received: from edd6cf40f2a7.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BA36377A-7A9D-4471-966C-4DE6F28E5218.1;
        Mon, 14 Sep 2020 07:32:44 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id edd6cf40f2a7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Sep 2020 07:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXfVXf2r+VPgPFCl3ZRfIVs71I74oBl7FbelX63/xZ/wwL9CcMIhlYSRGyipW2nFzE52TrOJc1svNwjoMVmqB6scYolcJmO+rxVzspZn3Z/JjKLiGglw6GzqjVRm8pe9kBBZW1zs697FOzkxzfm1NqtrBLPLNCN+Bg7GrdC0Jhur+ytl1MukUf8go9iWpy6Xi9HnS17fE9jdR97SGZmulbfQ/U8XdHDm/rE5CyWw1xGVqYf+QeYkcjT6ZfemMI30g9MH5RmcSALt0ny4v770qEUzSNgxcVC+YFo7LWI8RXzs8SB/2haKWvZPwEnh/ezW3b9QT5Gx0vG0t2XLLGG2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJxkN1EirZvQd8NO8mdOn32GkSfrccGUzllgB/icNvc=;
 b=Gtb+JqJU/dKYqDapsVelczwDjeJH7SV2W6zEPrq1yyAEtyNq3iV+dcsJ1HsqO+MU85vSrXaDIYsLsBi+f1bCB/Cw0Z/2I1NR3HqhVekIgJBGA9snO7GaPeCvOpC3Z2whNtMuLG8ko/VpqehtxiqZs1QI6CdNT6Zy99jXCN2lVUE22oj8D4RYT6ImrYu/9R9Gl37lhGaIdS+Aog/zYtk1VwPaJKRNHZ9qY/EuON53Z/Wxt4sqZ+VOOoyOAFdKd0c7tt/lbbU4cdUQkuIgpZlIivrm5ECfuzyWQF5+Bo+04ynwsWykvboHhL7MWtNWZIM4sRx8lxOLXwLwS0VRy62eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJxkN1EirZvQd8NO8mdOn32GkSfrccGUzllgB/icNvc=;
 b=7bUNFF1bIDEEWyRxXcb7Kg0DZSMZLTC70bCDBADFwB2/EAU+NWgxUkz8Y4NKuWZRozAYfI9I9myT+rP7bTSuAwgR3ZiCSsVtMexckJIBEo1Ol58jXPs83bQwcXQH47c+jn+/HJ1f50XlDbpfgrfy4gLqYMyJr5aJsBpPSREA7ys=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1980.eurprd08.prod.outlook.com (2603:10a6:3:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 07:32:41 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 07:32:41 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>,
        Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: RE: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Topic: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Index: AQHWikiH87ghgbrgBUG0aFcskfSv7KlnosKAgAAPCGA=
Date:   Mon, 14 Sep 2020 07:32:41 +0000
Message-ID: <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914033754.29188-5-jianyong.wu@arm.com> <20200914055535.GA30672@nautica>
In-Reply-To: <20200914055535.GA30672@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0FFA0596225AE3469DB2D82437014AFA.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d01c46c-38e8-433a-47a9-08d8588061bd
x-ms-traffictypediagnostic: HE1PR0801MB1980:|DB6PR0801MB2006:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2006D13862EBB4AD9B3C7D20F4230@DB6PR0801MB2006.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Jb4MRRkUjjHo5fqEp1SkU/bBq+rMHNVHSwZmEEC4iXxUOANQIjjo6X/Y6W7jvzR1jw+1nRo09ap2a3dhcRmBb+zu1JKiqGVPlz4Ue7YSODoAF4V4LMJb4YkidoxAJ3F2SL4pDJG7+yizVSr074NuZfbBwK0McoFR3s0RsgwtVdQY03T8yP8Zmf0EtAnX5TXAUT5UTz7YmAKtyeoZkibLeQRWvB0IHg0nKG0DPPJSZhg8CBErspjW91xs6Z95AkHafs5euNQGEmK3orMhFU1sx1qiAK01a66qKIMRDyEgssIP81HPdJa971QEtVI4yNYQGPXl4Eyg3plBdbXpWIvzwZVWTpwFtgU0UlArkd5OB0Zo31c1QxKJSBpIKuuxezKSAMZS2IkpLTRdwVanJZwAmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(66476007)(66556008)(64756008)(66446008)(26005)(5660300002)(7696005)(316002)(186003)(83380400001)(6506007)(53546011)(55016002)(8936002)(8676002)(478600001)(33656002)(6916009)(9686003)(86362001)(2906002)(4326008)(52536014)(54906003)(76116006)(966005)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CMLYgc9+PPXMVvhLXQ6wiXcUbonfDg/BhVeWjlfvSbaKTcLct2GjrwEZcj5+bSCmq2Pxfz+oTt0+riGYT2wpS275FmCiBJaKIeXwt5HDMicx65nZCUNVEy33sYvNhEQmZgOKLFgPw4+/n5xY5mRKpQlHIzZJO2VWm+FE+r1nOfJ/Zn3duYNzheBFYDEZJRHdUtRwGChb0uKAMfzqQzeOAuhTWkhOrVQLkaoDrZU8DyzIYQaPc8UI0CtSdyjP1Ijlk6hlIw7bdJmKCB8jfskZ+AAWDG7jExOmryfJdgiFysd1gCn/5lQ7V1SeAk8Zo03o9PxHf/Mxl7mLLmdo3QhiE1hmJLV85X8oY9mub9MzlLUY5GkVmo7r3+rkjPRIH1TKUwZiL+zR/LvfnX3+SEJE5OGEuS4aQdfK4QjU6Fp+P0rkNqOOO5oToTT7CC+yfr1dHeK6zcu+bAVaznGWri9ME26IvpOCK3GhmNedwHriZt45KvCAlhnmyOX0B3euMvv64EuZyRRGcfdeNof8heBu03iKPohqfCgfK8QmWs+njsgXPzzo4wlfAp3iDj8zyLE7AjOKkMgxOeioPRPZi+03W39kuwyas+MrG/boFUr63+lRI/p7jaGY/nqDTtqLWK823pBkDFRePlTZb1RujYl5JA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 82b628c5-9579-4f44-48d7-08d858805d5e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CE/+A4Do1h31Fgnt3PqnXG7gvd6lEjTvnVSaIDs37UyBRHJDp6Yr3372s/E9nHyCethuLdnRRHLDC/3WE98qf5lIzOFdh+apEO5t59wsLQD8wz5iKDm1Z+M5EYYjGVaF/WNR/vtbWe+g67GXhC/bf7kxeKYitiK7fCAoVG+ZukLwqAZT/m1D2U9aA7Y0ZX/4EKc8mehOCsNZfHg/r5iDet6237XTGWCGjLKPOKssMdTnt+sqm70mRnSuIKmsZazNboPypvAc6SVhUt1nViW+EjI/aHEhwZjXVv2JgVFQix2xL2sHRVGs1UKECKtddP2mO+yFaLCn4f5DACj+MtzHP9/AzuMqTlpccj/xlfiTPa5buJ4P5QOidhubGsxFlx26eGns2WljeB+/+JVGSBYj7CmFoWtu7BGUf1WEyclLIP+L3ML8owun7XgtDNb480J1W0l6eUAhSGlZfBEQtvYshHnCSp6NrnWpkJ7pnmCI/sg=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966005)(26005)(52536014)(8936002)(83380400001)(82310400003)(5660300002)(2906002)(4326008)(6862004)(186003)(70586007)(356005)(86362001)(70206006)(81166007)(47076004)(336012)(316002)(82740400003)(478600001)(7696005)(8676002)(53546011)(55016002)(966005)(9686003)(33656002)(54906003)(6506007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 07:32:49.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d01c46c-38e8-433a-47a9-08d8588061bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMTQsIDIwMjAgMTo1NiBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25n
Lld1QGFybS5jb20+DQo+IENjOiBlcmljdmhAZ21haWwuY29tOyBsdWNob0Bpb25rb3YubmV0OyB2
OWZzLQ0KPiBkZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsgR3JlZyBLdXJ6
IDxna3VyekBsaW51eC52bmV0LmlibS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDQv
NF0gOXA6IGZpeCByYWNlIGlzc3VlIGluIGZpZCBjb250ZW50aW9uLg0KPg0KPg0KPiBUaGFua3Mg
Zm9yIGhhdmluZyBhIGxvb2sgYSB0aGlzIQ0KPg0KPiBKaWFueW9uZyBXdSB3cm90ZSBvbiBNb24s
IFNlcCAxNCwgMjAyMDoNCj4gPiBFcmljJ3MgYW5kIEdyZWcncyBwYXRjaCBvZmZlciBhIG1lY2hh
bmlzbSB0byBmaXggb3Blbi11bmxpbmstZipzeXNjYWxsDQo+ID4gYnVnIGluIDlwLiBCdXQgdGhl
cmUgaXMgcmFjZSBpc3N1ZSBpbiBmaWQgY29tdGVudGlvbi4NCj4gPiBBcyBHcmVnJ3MgcGF0Y2gg
c3RvcmVzIGFsbCBvZiBmaWRzIGZyb20gb3BlbmVkIGZpbGVzIGludG8gYWNjb3JkaW5nDQo+ID4g
aW5vZGUsIHNvIGFsbCB0aGUgbG9va3VwIGZpZCBvcHMgY2FuIHJldHJpZXZlIGZpZCBmcm9tIGlu
b2RlDQo+ID4gcHJlZmVyZW50aWFsbHkuIEJ1dCB0aGVyZSBpcyBubyBtZWNoYW5pc20gdG8gaGFu
ZGxlIHRoZSBmaWQgY29tdGVudGlvbg0KPiA+IGlzc3VlLiBGb3IgZXhhbXBsZSwgdGhlcmUgYXJl
IHR3byB0aHJlYWRzIGdldCB0aGUgc2FtZSBmaWQgaW4gdGhlIHNhbWUNCj4gPiB0aW1lIGFuZCBv
bmUgb2YgdGhlbSBjbHVuayB0aGUgZmlkIGJlZm9yZSB0aGUgb3RoZXIgdGhyZWFkIHJlYWR5IHRv
DQo+ID4gZGlzY2FyZCB0aGUgZmlkLiBJbiB0aGlzIHNjZW5hcmlvLCBpdCB3aWxsIGxlYWQgdG8g
c29tZSBmYXRhbCBwcm9ibGVtcywgZXZlbg0KPiBrZXJuZWwgY29yZSBkdW1wLg0KPg0KPiBBaCwg
c28gdGhhdCdzIHdoYXQgdGhlIHByb2JsZW0gd2FzLiBHb29kIGpvYiBmaW5kaW5nIHRoZSBwcm9i
bGVtIQ0KPg0KVGhhbmtzISBWZXJ5IHBsZWFzdXJlLg0KPg0KPiA+IEkgaW50cm9kdWNlIGEgbWVj
aGFuaXNtIHRvIGZpeCB0aGlzIHJhY2UgaXNzdWUuIEEgY291bnRlciBmaWVsZA0KPiA+IGludHJv
ZHVjZWQgaW50byBwOV9maWQgc3RydWN0IHRvIHN0b3JlIHRoZSByZWZlcmVuY2UgY291bnRlciB0
byB0aGUNCj4gPiBmaWQuIFdoZW4gYSBmaWQgaXMgYWxsb2NhdGVkIGZyb20gdGhlIGlub2RlLCB0
aGUgY291bnRlciB3aWxsDQo+ID4gaW5jcmVhc2UsIGFuZCB3aWxsIGRlY3JlYXNlIGF0IHRoZSBl
bmQgb2YgaXRzIG9jY3VwYXRpb24uIEl0IGlzDQo+ID4gZ3VhcmFudGVlZCB0aGF0IHRoZSBmaWQg
d29uJ3QgYmUgY2x1bmtlZCBiZWZvcmUgdGhlIHJlZmVyZW5jZSBjb3VudGVyDQo+ID4gZ28gZG93
biB0byAwLCB0aGVuIHdlIGNhbiBhdm9pZCB0aGUgY2x1bmtlZCBmaWQgdG8gYmUgdXNlZC4NCj4g
PiBBcyB0aGVyZSBpcyBubyBuZWVkIHRvIHJldHJpZXZlIGZpZCBmcm9tIGlub2RlIGluIGFsbCBj
b25kaXRpb25zLCBhDQo+ID4gZW51bSB2YWx1ZSBkZW5vdGVzIHRoZSBzb3VyY2Ugb2YgdGhlIGZp
ZCBpcyBpbnRyb2R1Y2VkIHRvIDlwX2ZpZA0KPiA+IGVpdGhlci4gU28gd2UgY2FuIG9ubHkgaGFu
ZGxlIHRoZSByZWZlcmVuY2UgY291bnRlciBhcyB0byB0aGUgZmlkIG9idGFpbmVkDQo+IGZyb20g
aW5vZGUuDQo+DQo+IElmIHRoZXJlIGlzIG5vIGNvbnRlbnRpb24gdGhlbiBhbiBhbHdheXMtb25l
IHJlZmNvdW50IGFuZCBhbiBlbnVtIGFyZSB0aGUNCj4gc2FtZSB0aGluZy4NCj4gSSdkIHJhdGhl
ciBub3QgbWFrZSBhIGRpZmZlcmVuY2UgYnV0IG1ha2UgaXQgYSBmdWxsLWZsZWRnZWQgcmVmY291
bnQgdGhpbmc7IHRoZQ0KPiBlbnVtIGluIHRoZSBjb2RlIGludHJvZHVjZXMgcXVpdGUgYSBiaXQg
b2YgY29kZSBjaHVybiB0aGF0IGRvZXNuJ3Qgc3RyaWtlIG1lDQo+IGFzIHVzZWZ1bCAoYW5kIEkg
ZG9uJ3QgbGlrZSBpbnQgYXJndW1lbnRzIGxpa2UgdGhpcywgYnV0IGlmIHdlIGNhbiBqdXN0IGRv
IGF3YXkNCj4gd2l0aCBpdCB0aGVyZSdzIG5vIG5lZWQgdG8gYXJndWUgYWJvdXQgdGhhdCkNCj4N
Cj4gTm90IGhhdmluZyBleGNlcHRpb25zIGZvciB0aGF0IHdpbGwgYWxzbyBtYWtlIHRoZSBjb2Rl
IGFyb3VuZA0KPiBmaWRfYXRvbWljX2RlYyBtdWNoIHNpbXBsZXI6IGp1c3QgaGF2ZSBjbHVuayBk
byBhbiBhdG9taWMgZGVjIGFuZCBvbmx5IGRvDQo+IHRoZSBhY3R1YWwgY2x1bmsgaWYgdGhhdCBo
aXQgemVybywgYW5kIHdlIHNob3VsZCBiZSBhYmxlIHRvIGdldCByaWQgb2YgdGhhdA0KPiBoZWxw
ZXI/DQo+DQpTb3JyeSwgSSB0aGluayBhbHdheXMtb25lIHJlZmNvdW50ICB3b24ndCB3b3JrIGF0
IHRoaXMgcG9pbnQsIGFzIHRoZSBmaWQgd2lsbCBiZSBjbHVua2VkIG9ubHkgYnkNCkZpbGUgY29u
dGV4dCBpdHNlbGYgbm90IHRoZSBldmVyeSBjb25zdW1lciBvZiBldmVyeSBmaWQuIFdlIGNhbid0
IGRlY3JlYXNlIHRoZSByZWZjb3VudGVyIGF0IGp1c3Qgb25lDQpzdGF0aWMgcG9pbnQuIEFtIEkg
d3Jvbmc/DQpUaGlzIGVudW0gdmFsdWUgaXMgbm90IGZ1bmN0aW9uYWxseSBuZWNlc3NhcnksIGJ1
dCBJIHRoaW5rIGl0IGNhbiByZWR1Y2UgdGhlIGNvbnRlbnRpb24gb2YgZmlkLCBhcyB0aGVyZSBh
cmUNCnJlYWxseSBsb3RzIG9mIHNjZW5hcmlvcyB0aGF0IGZpZCBmcm9tIGlub2RlIGlzIG5vdCBu
ZWNlc3NhcnkuDQoNCj4NCj4gVGltaW5nIHdpc2UgaXQncyBhIGJpdCBhd2t3YXJkIGJ1dCBJIGp1
c3QgZHVnIG91dCB0aGUgYXN5bmMgY2x1bmsgbWVjaGFuaXNtIEkNCj4gd3JvdGUgdHdvIHllYXJz
IGFnbywgdGhhdCB3aWxsIGNvbmZsaWN0IHdpdGggdGhpcyBwYXRjaCBidXQgbWlnaHQgYWxzbyBo
ZWxwIGEgYml0DQo+IEkgZ3Vlc3M/DQo+IEkgc2hvdWxkIHByb2JhYmx5IGhhdmUgcmVwb3N0ZWQg
dGhlbS4uLg0KPg0KSW50ZXJlc3RpbmchDQoNCj4NCj4gU28gdG8gcmVjYXA6DQo+ICAtIExldCdz
IHRyeSBzb21lIG1vcmUgc3RyYWlnaHQtZm9yd2FyZCByZWZjb3VudGluZzogc2V0IHRvIDEgb24g
YWxsb2MsDQo+IGluY3JlbWVudCB3aGVuIGl0J3MgZm91bmQgaW4gZmlkLmMsIGRlY3JlbWVudCBp
biBjbHVuayBhbmQgb25seSBzZW5kIHRoZQ0KPiBhY3R1YWwgY2x1bmsgaWYgY291bnRlciBoaXQg
MA0KPg0KaXQgbWF5IG5vdCB3b3JrLCBJIHRoaW5rLg0KDQo+ICAtIElkZWFsbHkgYmFzZSB5b3Vy
c2VsZiBvZiBteSA5cC10ZXN0IGJyYW5jaCB0byBoYXZlIGFzeW5jIGNsdW5rOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vbWFydGluZXRkL2xpbnV4L2NvbW1pdHMvOXAtdGVzdA0KPiBJJ3ZlIGJlZW4g
cHJvbWlzaW5nIHRvIHB1c2ggaXQgdG8gbmV4dCB0aGlzIHdlZWvihKIgZm9yIGEgY291cGxlIG9m
IHdlZWtzIGJ1dCBpZg0KPiBzb21ldGhpbmcgaXMgYmFzZWQgb24gaXQgSSB3b24ndCBiZSBhYmxl
IHRvIGRlbGF5IHRoaXMgbXVjaCBsb25nZXIsIGl0J2xsIGdldA0KPiBwdXNoZWQgdG8gNS4xMCBj
eWNsZSBhbnl3YXkuDQo+IChJJ2xsIHJlc2VuZCB0aGUgcGF0Y2hlcyB0byBiZSBjbGVhbikNCj4N
Cj4gIC0gKHBsZWFzZSwgbm8gcG9sbGluZyAxMG1zIHRoZW4gbGVha2luZyBzb21ldGhpbmchKQ0K
Pg0KWWVhaCwgaXQgd2lsbCBsZWFkIGZpZCB0byBsZWFrIHNvbWV0aW1lcywgdW5mb3J0dW5hdGVs
eSwgIEknbSBhZnJhaWQgdGhhdCB0aGUgQ1BVIG1heSBiZSBzdHVjayBoZXJlLiAgd2UNCm11c3Qg
d2FpdCBoZXJlICh2OWZzX2Rpcl9yZWxlYXNlKSBmb3IgdGhlIGNvdW50ZXIgZG93biB0byAwLCBh
cyB0aGlzIGlzIHRoZSBvbmx5IHBsYWNlIHRvIHJlbGVhc2UgdGhlIGZpZC4NClRoYXQncyB0aGUg
cHJvYmxlbS4NCg0KVGhhbmtzDQpKaWFueW9uZw0KPiBUaGFua3MsDQo+IC0tDQo+IERvbWluaXF1
ZQ0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
