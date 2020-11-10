Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D12AD577
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKJLlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:41:18 -0500
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:48644
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgKJLlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGbjmc5QSQtSCna0LEv5/Jpb8HJ+jD6Jmyl1TKyY7A=;
 b=in8BpSwB4zjx+CNHl6tnAhYhcBaK/MZEx8v+OWHkRj3XEnadA7lUZJ8DyNN5jeA1NN/Cgers4MF2A751S4kbFLmvzevZtKqnrQuU86vNqmH4c6KY1CVHBfcROqq8heafz4iRdc69xAJCY06Moz3T0RMxHRT69g7qs2FYaNhsEK8=
Received: from AM5PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:206:1::47)
 by VI1PR08MB3695.eurprd08.prod.outlook.com (2603:10a6:803:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 11:41:11 +0000
Received: from VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::76) by AM5PR04CA0034.outlook.office365.com
 (2603:10a6:206:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Tue, 10 Nov 2020 11:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT009.mail.protection.outlook.com (10.152.18.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Tue, 10 Nov 2020 11:41:10 +0000
Received: ("Tessian outbound fcd5bc555ddc:v71"); Tue, 10 Nov 2020 11:41:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b0a4f5cd3f72ea91
X-CR-MTA-TID: 64aa7808
Received: from 7d54cfe77292.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6A8C51FA-D635-4495-B999-E96102DF811D.1;
        Tue, 10 Nov 2020 11:40:54 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7d54cfe77292.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Nov 2020 11:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYNQJe6o2a2PVnaR6pTOx4oZHupNsN71cTYN/x6QyQZ+Tf6aoPjuyiikXEbaGnPXgFMGWWN4zCaKkplM4qATAhOg5QfOIIghzRUvIr0p1oDeSu8LOSxUwSqHC//bKIUB36BpAyVnwC3OXgYMKZ6AgE5zf1fJuAFujEK4Z3i+wnIhyeV9SIdYtZXMJhoeW8m1gqM0lFGnXO6qGjqhHX4FAWuBid6YpkbPKOd3mkj6qQ1C053aW33rlMKa8quvlLa+/FjFTjwGF5swRCfNOzU7vl8FpdHhAvvOGPcCQ1X/RMFjn6JtMh+q5jOxbHciGrtKCM0claC3ETi1uX/NN8aoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGbjmc5QSQtSCna0LEv5/Jpb8HJ+jD6Jmyl1TKyY7A=;
 b=U6y4LSeUuH7HRBJ6euxYd4C2k+aaL+I+oelFABYczUSf06FTKMf88bAoRbUbJF3CadrwkznW6/77hW9vm0Q/By6lagwDk0xGnbQdsRWNaxlYVhOs6wJE6NFZV3v6PWH4QkZzPW1afeq04dvOoeBip1YgJq8zcJr61zak2MiFOh+6otJkPjZ/rhGPRWOAunMk42kVWkwrJeHKpKRhU7DwrBzLJPK0Sj4Da6ABe53RncjqaCg4z5HCorg5JfynPrOB0aC4uy0jCjItZb7MRO7dAH3lQidqfGVSvTBTBms5bvssXmJxRpc4sXw/PIRWnKKQDkHNuUE9nyeWIdVObsCigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGbjmc5QSQtSCna0LEv5/Jpb8HJ+jD6Jmyl1TKyY7A=;
 b=in8BpSwB4zjx+CNHl6tnAhYhcBaK/MZEx8v+OWHkRj3XEnadA7lUZJ8DyNN5jeA1NN/Cgers4MF2A751S4kbFLmvzevZtKqnrQuU86vNqmH4c6KY1CVHBfcROqq8heafz4iRdc69xAJCY06Moz3T0RMxHRT69g7qs2FYaNhsEK8=
Received: from DBAPR08MB5605.eurprd08.prod.outlook.com (2603:10a6:10:1af::24)
 by DB6PR0802MB2293.eurprd08.prod.outlook.com (2603:10a6:4:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 11:40:49 +0000
Received: from DBAPR08MB5605.eurprd08.prod.outlook.com
 ([fe80::1df9:2d3e:9ec8:2d35]) by DBAPR08MB5605.eurprd08.prod.outlook.com
 ([fe80::1df9:2d3e:9ec8:2d35%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 11:40:49 +0000
From:   John Horley <John.Horley@arm.com>
To:     Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: RE: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization
 for sysreg access
Thread-Topic: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization
 for sysreg access
Thread-Index: AQHWrXgyvJkGzG3NzkOZJFf5TadZqqnAMoqAgAEGNICAAAF/4A==
Date:   Tue, 10 Nov 2020 11:40:49 +0000
Message-ID: <DBAPR08MB56059B545C773F65B249CDD8E3E90@DBAPR08MB5605.eurprd08.prod.outlook.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-24-suzuki.poulose@arm.com>
 <20201109183255.GA3396611@xps15>
 <7370dc60-ca9c-7b58-0b56-6fcef628304f@arm.com>
In-Reply-To: <7370dc60-ca9c-7b58-0b56-6fcef628304f@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [80.3.80.93]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddbc2311-a6d6-4534-6cba-08d8856d8567
x-ms-traffictypediagnostic: DB6PR0802MB2293:|VI1PR08MB3695:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB36953650BBE262FAAFE4528FE3E90@VI1PR08MB3695.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: M+ceGdc5C72p511L5SYVkWGi+BGsQd1sagjaKEyMiDqsDPZyDgRd+5nuiqUq0HaJoWwfGUZ9drlsc0t7bIMUXYDfjRiJQ9xAJcRaOKmIWa0FR3/g7XzJ9uP6n4XH5W4kdXoiY/k+/Z90GO9V7ZALY3UfHq1Jf1g3AZ0tMcPIgp4TYNo+GSz/neWEIArt8ffv61VXa0jYGGOi3evmcEMhD33BCuXbvXf2bkoL+AcJM8mn9U5XRQO6Jro2wp6d5D1z9i/kxL0uUimLAku56U2HRE6A1cQGjbYhGG0G16V2/HkJnIwUldacJW1/SLUa/GNqdL+AAdkzPSAmom2lzbAQ5lLjHUwTXbdz5sv9dN0NDBsHvdbp4Vf5tVx5lNg/5VAyATGJR3BfuquhGEWVERoW3LL8MrI35/Ekl+uUe/WYW98/QjrvVnb3xxMXL3lAiUHiD77oNU8Ise5Y61xIT8ZbnA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5605.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(83380400001)(8676002)(6506007)(86362001)(8936002)(66946007)(66556008)(2906002)(66446008)(4326008)(64756008)(66476007)(316002)(53546011)(55016002)(33656002)(71200400001)(478600001)(186003)(52536014)(110136005)(54906003)(7696005)(9686003)(5660300002)(26005)(76116006)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mx4frFuzLTweRV5QVUvZl2wQ5gkFvnWxdOq2Tz2SctUqPypOQFU/cLKr6aiMRbNsWDP2S+elbeF1Y5UnAp6m+7lHMxr4PuUcXUZE0iiy8P7pmSxOmJuV5aL94Yvv9KU4BJKZSI77abtJJUlZoZmSAblT40kkVz4V8sfx/6VlXblWY8mr9tlf8CfS+pFuu6sXldc1GIFb40ERmoFge1ksPKnlVuISE990l42HLRz2hrCAeqo71YjzcpOg9LJbXIk11Sbl6uO7MZFi/MBxcDLDeSRWxpJna4cgZo2HvueI3pZ6k808yJH/BHwr9KxxHMXPE5XMWJsHV8LH6+2RRQalMPh6sXFI89Pk49sP5HvlBaYiwXDWVA3CQQM8A4Aq1K7acBafvGQdc71nSM2oPpINwHdJZNuGNN2sK7GylyhaqedAra2iQK1tvprHfMPXXjdNOlW+xlasypS9j3C3eWlukPTk/UDzAUxhxOAk8lj9vXq11+fZSSrRbSfAEe4aWp99FynfXYFzscseIAfe7Ykq/NWEhRr/mJZllGtO5lwwzY06sNCB7PtH38PqN8Sil4HvztHKheLxsaw2WN84mx/UWYW2k6wMNWPwP7bpj7GR5uulnXSNcKeEBOm/FsfQe6MmRSluL0SFJbOvhWhAiRBYwg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2293
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e52235fb-717c-4a2e-eead-08d8856d78c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAdMSlmQoUAimHmQlh0oApOHzDW+sSr0kXrsK58fYHEcS/8mZC/2B+ZG+9hN9DXCKz5SRsJbD4RZy2OgolFILN9Mxm+LKWgeWqtC5/dFR6Snmp5ybKsD4HSrLVucbyNvZrMQzbfD9kEZhQ4b9agoS96V0Y49pBRTfGDrixvaNTtzCRAHYAI3U+b6sliVPCBiH7zblTZrOwxTewxAS/j10PhebHKWcC4BpFzFdrQuk+cjq2FXyeKLPn19z1/OabV0ShCy0v3V6pePpF1AvMieEJ1TOpgw+BPMrhVBlX9jY9q0LGtYlA/lNyWgaf3hq6VjQW1MM1wk/G+VbSbIrqRxGos0mipXmECZy32JVsoY+J4LL/+DLIL2KpWiaON1t5mTwJJSedw3PQe4xHzt4G21bT9/ryUdGUvNe3QSDgQEwgh3r7IhAiQzCWcU7wnsRfpwjg4pjR419EkYFTr5qjQteDJVws7RMImA82th0Q/NkTtG0GcM++hgD8PIiExDDZCk
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(55016002)(26005)(52536014)(53546011)(186003)(81166007)(4326008)(9686003)(336012)(107886003)(82310400003)(8936002)(7696005)(86362001)(6506007)(8676002)(110136005)(356005)(33656002)(2906002)(47076004)(82740400003)(83380400001)(478600001)(70206006)(36906005)(54906003)(316002)(70586007)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 11:41:10.7693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc2311-a6d6-4534-6cba-08d8856d8567
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3695
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTAvMjAgMTA6MTEgQU0sIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6DQo+IE9uIDExLzkv
MjAgNjozMiBQTSwgTWF0aGlldSBQb2lyaWVyIHdyb3RlOg0KPj4gT24gV2VkLCBPY3QgMjgsIDIw
MjAgYXQgMTA6MDk6NDFQTSArMDAwMCwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4+PiBBcyBw
ZXIgdGhlIHNwZWNpZmljYXRpb24gYW55IHVwZGF0ZSB0byB0aGUgVFJDUFJHQ1RMUiBtdXN0IGJl
DQo+Pj4gc3luY2hyb25pemVkIGJ5IGEgY29udGV4dCBzeW5jaHJvbml6YXRpb24gZXZlbnQgKGlu
IG91ciBjYXNlIGFuDQo+Pj4gZXhwbGljaXN0IElTQikgYmVmb3JlIHRoZSBUUkNTVEFUUiBpcyBj
aGVja2VkLg0KPj4+DQo+Pj4gQ2M6IE1pa2UgTGVhY2ggPG1pa2UubGVhY2hAbGluYXJvLm9yZz4N
Cj4+PiBDYzogTWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29t
Pg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1l
dG00eC1jb3JlLmMgfCAxMyArKysrKysrKysrKysrDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTMg
aW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHd0cmFjaW5nL2Nv
cmVzaWdodC9jb3Jlc2lnaHQtZXRtNHgtY29yZS5jDQo+Pj4gYi9kcml2ZXJzL2h3dHJhY2luZy9j
b3Jlc2lnaHQvY29yZXNpZ2h0LWV0bTR4LWNvcmUuYw0KPj4+IGluZGV4IGUzNmJjMWM3MjJjNy4u
NGJjMmYxNWI2MzMyIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdo
dC9jb3Jlc2lnaHQtZXRtNHgtY29yZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9od3RyYWNpbmcvY29y
ZXNpZ2h0L2NvcmVzaWdodC1ldG00eC1jb3JlLmMNCj4+PiBAQCAtMTc4LDYgKzE3OCwxNSBAQCBz
dGF0aWMgaW50IGV0bTRfZW5hYmxlX2h3KHN0cnVjdCBldG12NF9kcnZkYXRhICpkcnZkYXRhKQ0K
Pj4+ICAgCS8qIERpc2FibGUgdGhlIHRyYWNlIHVuaXQgYmVmb3JlIHByb2dyYW1taW5nIHRyYWNl
IHJlZ2lzdGVycyAqLw0KPj4+ICAgCWV0bTR4X3JlbGF4ZWRfd3JpdGUzMihjc2EsIDAsIFRSQ1BS
R0NUTFIpOw0KPj4+DQo+Pj4gKwkvKg0KPj4+ICsJICogSWYgd2UgdXNlIHN5c3RlbSBpbnN0cnVj
dGlvbnMsIHdlIG5lZWQgdG8gc3luY2hyb25pemUgdGhlDQo+Pj4gKwkgKiB3cml0ZSB0byB0aGUg
VFJDUFJHQ1RMUiwgYmVmb3JlIGFjY2Vzc2luZyB0aGUgVFJDU1RBVFIuDQo+Pj4gKwkgKiBTZWUg
QVJNIElISTAwNjRGLCBzZWN0aW9uDQo+Pj4gKwkgKiAiNC4zLjcgU3luY2hyb25pemF0aW9uIG9m
IHJlZ2lzdGVyIHVwZGF0ZXMiDQo+Pj4gKwkgKi8NCj4+PiArCWlmICghY3NhLT5pb19tZW0pDQo+
Pj4gKwkJaXNiKCk7DQo+Pj4gKw0KPj4NCj4+IFdoZW4gSSBmaXJzdCByZWFkIHRoZSBkb2N1bWVu
dGF0aW9uIG9uIHN5c3RlbSBpbnN0cnVjdGlvbiBzZWN0aW9uDQo+PiA0LjMuNyByZWFsbHkgZ290
IG1lIHRoaW5raW5nLi4uDQo+Pg0KPj4gQXQgdGhlIHZlcnkgdG9wLCByaWdodCBhZnRlciB0aGUg
dGl0bGUgIlN5bmNocm9uaXphdGlvbiBvZiByZWdpc3Rlcg0KPj4gdXBkYXRlcyIgb25lIGNhbiBy
ZWFkICJTb2Z0d2FyZSBydW5uaW5nIG9uIHRoZSBQRS4uLiIuICBMYXRlciBpbiB0aGUNCj4+IHRl
eHQsIHdoZW4gc3BlY2lmeWluZyB0aGUgc3luY2hyb25pc2F0aW9uIHJ1bGVzLCB0aGUgdGVybSAi
dHJhY2UNCj4+IGFuYWx5emVyIiBpcyB1c2VkLiAgX1R5cGljYWxseV8gYSB0cmFjZSBhbmFseXpl
ciBpcyBhbiBleHRlcm5hbCBib3guDQo+Pg0KPg0KPlZlcnkgZ29vZCBwb2ludC4gVGhlIHRyYWNl
IGFuYWx5emVyIGNvdWxkIHN0aWxsIHVzZSB0aGUgc3lzdGVtIHJlZ2lzdGVyIHRvDQo+cHJvZ3Jh
bSB0aGUgRVRNIGFuZCBjYXVzaW5nIGEgY29udGV4dCBzeW5jaHJvbml6YXRpb24gZXZlbnQgaXMg
dHJpY2t5IGZyb20NCj53aXRoaW4gdGhlIHRyYWNlIGFuYWx5emVyLiBBbmQgSSBhZ3JlZSB0aGF0
IHRoZXJlIGlzIGEgYml0IG9mIGNvbmZ1c2lvbg0KPmFyb3VuZCB0aGUgc3luY2hyb25pemF0aW9u
IGZyb20gYSBzZWxmLWhvc3RlZCBwb2ludCBvZiB2aWV3Lg0KPkkgYmVsaWV2ZSB0aGlzIGlzIHRy
dWUgZm9yIHRoZSBzZWxmLWhvc3RlZCBjYXNlIHRvbyBhbmQgc2hvdWxkIGJlIGNsYXJpZmllZA0K
PmluIHRoZSBUUk0uDQo+DQoNClRoZSBFVE0gYXJjaGl0ZWN0dXJlIHVzZXMgInRyYWNlIGFuYWx5
emVyIiB0byBtZWFuIHNlbGYtaG9zdGVkIHNvZnR3YXJlIGFuZCBhbiBleHRlcm5hbCBkZWJ1Z2dl
ci4gSXQncyBhIHVzZWZ1bCB0ZXJtIHRoYXQgZ2VuZXJpY2FsbHkgY292ZXJzICJ0aGUgdGhpbmcg
dGhhdCdzIGluIGNoYXJnZSBvZiB0cmFjaW5nIiBhbmQgInRoZSB0aGluZyB0aGF0J3MgY2FwdHVy
aW5nIGFuZC9vciBkZWNvZGluZyB0aGUgdHJhY2UiLCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgZWl0
aGVyIG9mIHRoZXNlIGFyZSBleHRlcm5hbCBvciBzZWxmLWhvc3RlZCAob3IgZXZlbiBhIG1peHR1
cmUhKS4NCg0KU28gaW4gNC4zLjcsIHllcyB0aGlzIGRvZXMgbWVhbiB0aGF0IGNvbnRleHQgc3lu
Y2hyb25pemF0aW9uIGV2ZW50cyBhcmUgbmVlZGVkIHRvIHN5bmNocm9uaXplIHJlZ2lzdGVyIHVw
ZGF0ZXMgd2hlbiB1c2luZyBzeXN0ZW0gaW5zdHJ1Y3Rpb25zIHRvIHByb2dyYW0gdGhlIHRyYWNl
IHVuaXQuDQoNCkknbGwgdGFrZSBhIGxvb2sgYXQgd2hhdCB3ZSBjYW4gaW1wcm92ZSBoZXJlIDot
KQ0KDQpDaGVlcnMsIEpvaG4uDQoNCj4+IEFybSBkb2N1bWVudGF0aW9uIGlzIHByZWNpc2UgYW5k
IHVzdWFsbHkgZG9lc24ndCBvdmVybG9vayB0aGF0IGtpbmQgb2YgZGV0YWlsLg0KPj4gVGhlIHF1
ZXN0aW9uIGlzIHRvIHVuZGVyc3RhbmQgaWYgYSBjb250ZXh0IHN5bmNocm9uaXNhdGlvbiBldmVu
dCBpcw0KPj4gYWxzbyBuZWVkZWQgd2hlbiBwcm9ncmFtbWluZyBpcyBkb25lIG9uIHRoZSBQRS4g
IElmIHNvIEkgdGhpbmsgdGhlDQo+PiBkb2N1bWVudGF0aW9uIHNob3VsZCBiZSBhbWVuZGVkLg0K
Pj4NCj4+IEluIHRoYXQgY2FzZToNCj4+DQo+PiBSZXZpZXdlZC1ieTogTWF0aGlldSBQb2lyaWVy
IDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4+DQo+DQo+VGhhbmtzDQo+U3V6dWtpDQo+
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj5Db3JlU2ln
aHQgbWFpbGluZyBsaXN0DQo+Q29yZVNpZ2h0QGxpc3RzLmxpbmFyby5vcmcNCj5odHRwczovL2xp
c3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby9jb3Jlc2lnaHQNCg==
