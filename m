Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909C3276C21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgIXIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:38:15 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:60675
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbgIXIiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgKNFw/6wgrRtqN/2mjZ7kbNTT6PkQnREKdOrAAhGL0=;
 b=EL0AfQ63R8Ah5c43IOs/XOd48oUPHgs+fUeeYec3c3Jz3iEnC6pKC9GA7iLr+85uXwprxS+CIVkkmueoHWNOJ2emV0VixKNaDT9navLYCDTdAI1AUPhUEjIgBUhfwTQPvfH/DbVTPlmElVRoCpXWay4053n/5l9vchLxfrnDlCM=
Received: from MR2P264CA0082.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::22)
 by VI1PR08MB5342.eurprd08.prod.outlook.com (2603:10a6:803:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 24 Sep
 2020 08:38:09 +0000
Received: from VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:32:cafe::ce) by MR2P264CA0082.outlook.office365.com
 (2603:10a6:500:32::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 08:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT056.mail.protection.outlook.com (10.152.19.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 08:38:09 +0000
Received: ("Tessian outbound 195a290eb161:v64"); Thu, 24 Sep 2020 08:38:08 +0000
X-CR-MTA-TID: 64aa7808
Received: from 108a3aa5bf99.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1EB855B-75B8-4EAC-B80F-C71AAC8ABBA7.1;
        Thu, 24 Sep 2020 08:38:03 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 108a3aa5bf99.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Sep 2020 08:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOndHwBkOagYHnlcR1STGyVLIcOB4vs6JrKV3vkbElJvW9kAygzyHV6ypXmgu+d3oCZiEQK0vYXNeMvPvqVPUzJ7TYMCRqGJSkb9HjlF7fK/qM3jl8HsD9a2Bv55Ws8YY31D/64ytpls73TPs9/XNOivczgnjJ0dm4QHGjzj7Sz9cY8twUinZeIfYsLE1zw8NOOli0UMgvE1P/nFCk69qoBpNKZEg1GZKD7TOsXlO7nu+tsVd2iZlMnBv0C8ShF3cj28PiJAHgTp9fTsWu+q6328oyNUNep7OnZbzBUgtV5kud6dhmgBINL1g+DeIVSTyv+WH+vEXs+ILvA2P0+0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgKNFw/6wgrRtqN/2mjZ7kbNTT6PkQnREKdOrAAhGL0=;
 b=XFYd88n/6cUCPCdP0Avj4gHjfg6vYiUaphv9NT4eCehFNvzQ2dzaN7C4AU4F+WagEe0r+R3/IvpGDyq1P33gj9lMSrhChXc/zXeZmlYqKsGa4Bs4CBbVK0zbwaizaYz1p8Nj+LcRJ0m/VCLmfzq2qSraPjmUR23uAXbmGW8vrVit3pMcTn/zGsYBPqnaaCeebteY1sFDaAfZaQb9ov3yaJbH+56K9HOKY9FKXOLwvILouQ2WFGVlIbvqrtQhK+uQMr1iLxIFZ8IRxmnQXi8TvMlvETby0RG/q7yXF8q/MLb+yndGRuTYPeHqgjZ/xA1xgpfw5cZce57dGGQ9jmEFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgKNFw/6wgrRtqN/2mjZ7kbNTT6PkQnREKdOrAAhGL0=;
 b=EL0AfQ63R8Ah5c43IOs/XOd48oUPHgs+fUeeYec3c3Jz3iEnC6pKC9GA7iLr+85uXwprxS+CIVkkmueoHWNOJ2emV0VixKNaDT9navLYCDTdAI1AUPhUEjIgBUhfwTQPvfH/DbVTPlmElVRoCpXWay4053n/5l9vchLxfrnDlCM=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB2121.eurprd08.prod.outlook.com (2603:10a6:3:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 08:38:02 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 08:38:01 +0000
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
Thread-Index: AQHWkbOl16CkOw3tJ0mFRMvqqCi+c6l2Ti+AgAEYjZA=
Date:   Thu, 24 Sep 2020 08:38:01 +0000
Message-ID: <HE1PR0802MB25556D1AAF1336F4EE3CA8DBF4390@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com> <20200923144953.GA1685@nautica>
In-Reply-To: <20200923144953.GA1685@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B7BAA80F9ACCDF42900B542623F775B3.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c30253f7-ec9b-485c-c35b-08d860652a7b
x-ms-traffictypediagnostic: HE1PR0801MB2121:|VI1PR08MB5342:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB534234616A8AAAD35F5E1E5DF4390@VI1PR08MB5342.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: l2Q0+VJDDO7jOKeXSJzozo6cbvstTosf5Wd87UA//mitH9isqbCyxQplKbNGwD7hxv/ZuEthWM146WH4iMutaPjzg2FFqo0hEMFTP4z2ILSu62mIUWHJ6I99578L9B0JygUlIHA3vah7wtRv6lvpqGL4Ub0TKrD3XBxp4c2XQQztBMK6lT/pp1ZLuilC8OS9/T+zhEuyUTgktlW6sXNNPOGqyEpQcJVvLw7527khB1DoII6sFJQDr6kTbP7D+DA/h7yTmGazApwSqEyHCtDF3CY18jjqkGaihKfUb+bLGS7doo/UKRea1wakDB+RjQ4/nMwaQyejutwaUFZYs8MampaYpHtguKE0LgjkLcaFi6OOa3+1VCxfOi+yvcVKsrwsl0QKUGRF41RhQ0LAEJ8R6272JybyoPc9TsO6+bSkvITV6mmp+mF/tXQYfoqHaCP9ODiZt8sxY/J99JJ2BWpEcg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(8936002)(478600001)(8676002)(9686003)(86362001)(71200400001)(52536014)(7696005)(53546011)(55016002)(316002)(6916009)(186003)(6506007)(64756008)(66556008)(4326008)(76116006)(66946007)(2906002)(966005)(33656002)(66446008)(66476007)(54906003)(5660300002)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4GItvosIzZ6rGPZdKOMW9kNQSDhe33ggl5BhYRSdzjdpVHHuPAcfo1T4y1VmMQ2yJFn5tF0iT3WHtAWAPJQypIWe43mpc/FwyozlhfNPd2eA+h4199mT5xbdHfa2q46fo/nwiBr38tcJzgLKo+8J4FssYnO7wCsoLFeVx6mJKvqzThwJQIeTKjgvoG11hS7ua6RQhCqtMGyNDa2WfEwmHQtrRPb6NMp2SnGHbLvJiBDzTe82yaXb9NPSYykFE20l2xCsEQLX+NVkHoe9sMZYx+fzNQvyOXVJKhLUGDqO95VglQADrUIg7Wa0pxKDQPgximxM02xMZBK/2nQ3X3CsdMKddrCmlpJ6rNcAIpeczHy1tsj53jILZeKHty4UoulzHHzutGVUPLagiiyGtNNWKXzMv+cavtCADs3jah5lzsWI4RCHOiUVXoTFOcgEKuZADngimTipk9VWO1u7i8z3+Kn7nEJjWlLakeLAOfR+FDm7tY4UM6OVUR3indtN5uxCoihbAV1iJhS/shqoEuQOuL8IA6bYeB+sCtsGNkw8CcGzVCjx93NwfmVUT8WcS+AHSwOhCwKJk6wQ9sE5ClqffJdKFgR8J/E3QZzxXbG/oqBtGzrEkVcJMXqwcbDzluCmQhyoufsTeGj4qEocSVxXcg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2121
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7b2ee4e8-460f-4ff0-c623-08d860652610
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HyMbgP0kjK21IBFYRJTuwgTC27Pm7OnPgjveFUwESSDlYjmFZVeCdVI0iUwEEZbojoORvbTp8Vn3VZsSk7YI+8CXoGKCxJpKOKwUFloznRY8g76jcR3gjMXbjSYalp9xG1lCzRdiSXYS4bDdRTKxCQtXGAbBB4b+3+iCDM9WPpceINBXzAQobNVWzCigUBp/gmrkCy9v3MpeQ1WVWaup3CjG8Tj+5vGQyphfO46MpyshoIT+gPjTB3AECC+vhUrBSOxznBeNXGWrtspV4sYgkl5qFEPDUbn5lQ+D2Plvev10ozixT1KFfu41EAjqs5eWNlx1LU5X/zlUUe/aLaa62Fqa3e0LOFaJbNEVxZ6IHE0ppX/3tH7Rw+FA/d1ask1ZHNeHae+FoMaMX+4poETzdJPmLeyEcP/IT5JhrhrdXa9hbJ64DJcAuimbUTMp9qZj6i+sDwWEnFXGs0Wja2BSHFuZi0NcW0ZBCKFhBIiE+lc4IODNQGovfIyFhF6a6FZRIT2yh9O7aDOF9awsoZ1XQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(52536014)(8676002)(33656002)(356005)(6862004)(7696005)(316002)(82310400003)(2906002)(70206006)(36906005)(70586007)(83380400001)(81166007)(86362001)(9686003)(54906003)(186003)(478600001)(26005)(4326008)(82740400003)(8936002)(6506007)(55016002)(336012)(966005)(47076004)(5660300002)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 08:38:09.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30253f7-ec9b-485c-c35b-08d860652a7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjAgMTA6NTAgUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFu
eW9uZy5XdUBhcm0uY29tPg0KPiBDYzogZXJpY3ZoQGdtYWlsLmNvbTsgbHVjaG9AaW9ua292Lm5l
dDsgcWVtdV9vc3NAY3J1ZGVieXRlLmNvbTsNCj4gZ3JvdWdAa2FvZC5vcmc7IHY5ZnMtZGV2ZWxv
cGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
UkZDIHYyIDQvNF0gOXA6IGZpeCByYWNlIGlzc3VlIGluIGZpZCBjb250ZW50aW9uLg0KPg0KPg0K
PiBPdmVyYWxsIGxvb2tzIGdvb2Q7IGEgZmV3IGNvbW1lbnRzLg0KDQpUaGFua3MNCj4NCj4gSmlh
bnlvbmcgV3Ugd3JvdGUgb24gV2VkLCBTZXAgMjMsIDIwMjA6DQo+ID4gb3Blbi11bmxpbmstZipz
eXNjYWxsIHRlc3Q6DQo+ID4gSSBoYXZlIHRlc3RlZCBmb3IgZipzeXNjYWxsIGluY2x1ZGU6IGZ0
cnVuY2F0ZSBmc3RhdCBmY2hvd24gZmNobW9kIGZhY2Nlc3NhdC4NCj4NCj4gR2l2ZW4gdGhlIG90
aGVyIHRocmVhZCwgd2hhdCBkaWQgeW91IHRlc3QgdGhpcyB3aXRoPw0KRXIsIEkganVzdCB1c2Ug
R3JlZydzIHFlbXUgb2YgaHR0cHM6Ly9naXRodWIuY29tL2drdXJ6L3FlbXUuZ2l0OiA5cC1hdHRy
LWZpeGVzLiBJIHNob3VsZCBoYXZlIHJlZmVyZW5jZWQgaXQgaW4gY29tbWl0IG1lc3NhZ2UuDQoN
Cj4gU2luY2UgcWVtdSBkb2Vzbid0IHdvcmsgYXBwYXJlbnRseSBkbyB5b3UgaGF2ZSBhIGluLWhv
dXNlIHNlcnZlciBhdCBhcm0gSQ0KPiBjb3VsZCB0ZXN0Pw0KPiAoSSdsbCB0cnkgd2l0aCBnYW5l
c2hhIG90aGVyd2lzZSwgaXQga2VlcHMgZmlsZXMgb3BlbiBzbyBpdCBzaG91bGQgd29yayBJIHRo
aW5rLi4uKQ0KPg0KWWVhaCwgSSB0ZXN0IHRoaXMgb24gbXkgYXJtIHNlcnZlci4gQnV0IGFzIHRo
ZXNlIGNvZGVzIGFyZSBhcmNoLWZyZWUsIHdlIGNhbiB0ZXN0IGl0IGluIHdoYXRldmVyIGEgbWFj
aGluZS4NCihhbHNvIHRoZSBzZXJ2ZXIgaW4gYXJtIGNhbid0IGJlIGFjY2Vzc2VkIGJ5IG91dGVy
IHNwYWNlLCBzbyBzb3JyeSkNCkJ1dCBJIHRoaW5rIHRoYXQgdGhpcyB0ZXN0IGFyZSBmYXIgZnJv
bSBzZXJpb3VzIGFuZCBjb21wbGV0ZS4NCg0KPiA+ICthdG9taWNfc2V0KCZmaWQtPmNvdW50LCAx
KTsNCj4NCj4gSSBraW5kIG9mIGxpa2UgdGhlIHJlZmNvdW50IEFQSSBiZWNhdWVzZSBpdCBoYXMg
c29tZSBleHRyYSBvdmVyZmxvdyBjaGVja3M7DQo+IGJ1dCBpdCByZXF1aXJlcyBhIGJpdCBtb3Jl
IHdvcmsgYXJvdW5kIGNsdW5rIChpbnN0ZWFkIG9mIGJhaWxpbmcgb3V0IGVhcmx5IGlmDQo+IGNv
dW50ZXIgaGl0cyAwLCB5b3UgbmVlZCB0byBoYXZlIGl0IGNhbGwgYSBzZXBhcmF0ZSBmdW5jdGlv
biBpbiBjYXNlIGl0IGRvZXMpDQo+DQo+IFRoYXQncyBtb3N0bHkgZXN0aGV0aWNzIHRob3VnaCBJ
J20gbm90IGdvaW5nIHRvIGZ1c3Mgb3ZlciB0aGF0Lg0KPg0KU29ycnksIEknbSBub3Qgc3VyZSB3
aGF0J3MgdGhlIGNvbnRleHQgb2YgdGhpcyBsaW5lLCBkb2VzIHRoaXMgbGluZSBsaWUgaW4gIl9f
YWRkX2ZpZOKAnS4gSSdtIG5vdCBzdXJlIGFib3V0DQp3aHkgaXQgZG8gaGFybSB0byBjbHVuaz8N
Cg0KPiA+IEBAIC03NCw2ICs3Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgcDlfZmlkICp2OWZzX2ZpZF9m
aW5kX2lub2RlKHN0cnVjdA0KPiA+IGlub2RlICppbm9kZSwga3VpZF90IHVpZCkgIHZvaWQgdjlm
c19vcGVuX2ZpZF9hZGQoc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiBzdHJ1Y3QgcDlfZmlkICpm
aWQpICB7DQo+ID4gIHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQo+ID4gK2F0b21pY19zZXQo
JmZpZC0+Y291bnQsIDEpOw0KPg0KPiBIbSwgdGhhdCBzaG91bGQgYmUgZG9uZSBhdCBmaWQgY3Jl
YXRpb24gdGltZSBpbiBuZXQvOXAvY2xpZW50LmMgcDlfZmlkX2NyZWF0ZSA7DQo+IG5vID8NCj4g
KHlvdSBkbyBpdCB0aGVyZSBhbHJlYWR5LCBJIGRvbid0IHNlZSB3aGF0IHJlc2V0aW5nIGNvdW50
IGhlcmUgYnJpbmdzIGV4Y2VwdA0KPiBjb25mdXNpb24pDQo+DQpJIHB1dCB0aGlzIGNvdW50ZXIg
c2V0IG9wIGJlZm9yZSB0aGUgZmlkcyBhcmUgYWRkZWQgdG8gaGxpc3QuIFNvIEkgY2FuIG1ha2Ug
c3VyZSB0aGUgY291bnRlciB2YWx1ZSBpcyAxIGJlZm9yZQ0KZmlkcyBhcmUgdXNlZC4gSXQncyBy
ZWR1bmRhbnQgY29kZS4gSSBjYW4gcmVtb3ZlIGl0IGluIGJvdGggIl9fYWRkX2ZpZCIgYW5kICJ2
OWZzX29wZW5fZmlkX2FkZCIsIGJ1dCB3ZSBtdXN0IHRha2UgY2FyZSBvZiBpdCB0aGF0DQpubyBj
bHVuayBpcyBjYWxsZWQgYmV0d2VlbiBmaWRzIGFyZSBjcmVhdGVkIGFuZCBhZGRlZCB0byBobGlz
dC4gQm90aCBhcmUgZ29vZCBmb3IgbWUuDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvOXAvZmlkLmgg
Yi9mcy85cC9maWQuaCBpbmRleA0KPiA+IGRmYTExZGYwMjgxOC4uMWZlZDk2NTQ2NzI4IDEwMDY0
NA0KPiA+IC0tLSBhL2ZzLzlwL2ZpZC5oDQo+ID4gKysrIGIvZnMvOXAvZmlkLmgNCj4gPiBAQCAt
MjIsNiArMjIsMTQgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcDlfZmlkICpjbG9uZV9maWQoc3Ry
dWN0DQo+ID4gcDlfZmlkICpmaWQpICB9ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBwOV9maWQgKnY5
ZnNfZmlkX2Nsb25lKHN0cnVjdA0KPiA+IGRlbnRyeSAqZGVudHJ5KSAgew0KPiA+IC1yZXR1cm4g
Y2xvbmVfZmlkKHY5ZnNfZmlkX2xvb2t1cChkZW50cnkpKTsNCj4gPiArc3RydWN0IHA5X2ZpZCAq
ZmlkLCAqbmZpZDsNCj4gPiArDQo+ID4gK2ZpZCA9IHY5ZnNfZmlkX2xvb2t1cChkZW50cnkpOw0K
PiA+ICtpZiAoIWZpZCB8fCBJU19FUlIoZmlkKSkNCj4gPiArcmV0dXJuIGZpZDsNCj4gPiArDQo+
ID4gK25maWQgPSBwOV9jbGllbnRfd2FsayhmaWQsIDAsIE5VTEwsIDEpOw0KPg0KPiBJIHRoaW5r
IHlvdSBjbG9uZV9maWQoKSBoZXJlIGlzIHNsaWdodGx5IGVhc2llciB0byB1bmRlcnN0YW5kOyBl
dmVyeW9uZSBkb2Vzbid0DQo+IGtub3cgdGhhdCBhIHdhbGsgd2l0aCBubyBjb21wb25lbnQgaXMg
YSBjbG9uZS4NCj4gVGhlIGNvbXBpbGVyIHdpbGwgb3B0aW1pemUgdGhhdCBJU19FUlIoZmlkKSBp
cyBjaGVja2VkIHR3aWNlLCBpdCdzIGZpbmUuDQo+DQpFciwgSSByZXdyaXRlIGl0IGJlY2F1c2Ug
SSBtdXN0IGFjcXVpcmUgdGhlIGludGVybWVkaWEgZmlkIGZyb20gdjlmc19maWRfbG9va3VwIGFu
ZCBjbHVuayBpdC4NCg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC85cC9jbGllbnQuaCBi
L2luY2x1ZGUvbmV0LzlwL2NsaWVudC5oIGluZGV4DQo+ID4gY2U3ODgyZGE4ZTg2Li41OGVkOWJk
MzA2YmQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9uZXQvOXAvY2xpZW50LmgNCj4gPiArKysg
Yi9pbmNsdWRlL25ldC85cC9jbGllbnQuaA0KPiA+IEBAIC0xNDAsMTAgKzE0MCwxNiBAQCBzdHJ1
Y3QgcDlfY2xpZW50IHsNCj4gPiAgICoNCj4gPiAgICogVE9ETzogVGhpcyBuZWVkcyBsb3RzIG9m
IGV4cGxhbmF0aW9uLg0KPiA+ICAgKi8NCj4gPiArZW51bSBmaWRfc291cmNlIHsNCj4gPiArRklE
X0ZST01fT1RIRVIsDQo+ID4gK0ZJRF9GUk9NX0lOT0RFLA0KPiA+ICtGSURfRlJPTV9ERU5UUlks
DQo+ID4gK307DQo+DQo+IGxlZnRvdmVycyBmcm9tIHByZXZpb3VzIGl0ZXJhdGlvbi4NCj4NClNv
cnJ5LCBuZWVkIHJlbW92ZSBpdC4NCg0KPg0KPiBPdmVyYWxsIGxvb2tzIGdvb2QgdG8gbWUuDQo+
IEknZCBuZWVkIHRvIHNwZW5kIHNvbWUgdGltZSBjaGVja2luZyB0aGUgYWN0dWFsIGNvdW50aW5n
IHBhcnQgJiBoYW1tZXJpbmcNCj4gdGhlIGZzIGEgYml0IHRoZW4gY29uZmlybWluZyBubyBmaWQg
Z290IGZvcmdvdHRlbiAodGhlcmUncyBhIHByX2luZm8gYXQgdW1vdW50DQo+IHRpbWUpIGJ1dCBJ
J20gaGFwcHkgd2l0aCB0aGlzIDsgdGhhbmtzIQ0KPg0KWWVhaCwgaXQncyBhIHRlZGlvdXMgam9i
IHRvIGRvIHRoYXQuIEFsc28gd2UgbmVlZCB0byBmaW5kIGEgcmVsaWFibGUgdGVzdCBzdWl0LiBU
aGVuIHdlIGNhbiBjaGVjaw0KdGhpcyBwYXRjaCBib3RoIGZyb20gY29kZSBhbmQgdGVzdC4NCg0K
VGhhbmtzDQpKaWFueW9uZw0KPiAtLQ0KPiBEb21pbmlxdWUNCj4NCj4NCj4NCg0KSU1QT1JUQU5U
IE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBh
cmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRp
YXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNv
biwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRp
b24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
