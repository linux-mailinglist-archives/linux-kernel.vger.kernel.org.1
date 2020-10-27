Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36E529A24C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 02:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504049AbgJ0Bps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 21:45:48 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33918 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440652AbgJ0Bpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 21:45:47 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BAC96400BF;
        Tue, 27 Oct 2020 01:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603763147; bh=GNoMBtyhkPRDN5QEfc16qmxVVCWzjaaxtdmxzYbgKiU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RgpV+ff1jOUZDrBwNYCI8j5k22z77a3PZIYEvNuDjzYyNaRPUkEs3xPq8IPwYexI7
         gpk9Nu3fZ0NxEvfYYmfdOOTtRotbPV62XpXS8T/wnU/BvFO7dWYWMumw6wVu9/PFdj
         0cZ+hKma/fEPE0BqQFWPUwjO/LNWWwGhFclUvDCYuWcQeBS7RhpBcrphrCwEqwWlxa
         2Auw/zD5M/JVszdNNsduV1EvG+TpFj4/Z4cpbtgxVtimUtzeCg7lpksLU8XP55v4pV
         Dit//y+4VPJQ3u2z1GKoMH010J5Rk3pemL3fOg1CZ9eFA9qsZ1d023SJehb4q7SacO
         grRlDnxpRU4qg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 21151A0071;
        Tue, 27 Oct 2020 01:45:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4EA19800C9;
        Tue, 27 Oct 2020 01:45:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gbACpv2k";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFbCshXt7edBVEN8zbDHr+9EktfDpn0H0rxiQ2n+/HElQIropPl3Fy8BPUc+QfR/2AdU7yUUGNjN5Y5w5OEfZQtH0PFR8jowPNVMy3yoQV06IBXFzPEwbJijQbHuq5LzAo+CRY/GV3aCFEtaniJ+1ZAbbUDjyYPRCie/aQp2vtAo4BCIyhL9q54me1oLdb4kdZlfaj5t5n1NadRAtGGoPgRTbq9lDKXDsrjHVBSfNlVthegMbOiu3+KCQctIQwvvudo7jYbLHQjI3hSrrYYIhdKn1TXS1ojS+j58UgYy1+3vk51QUOGMdSt8HnXqwskb5snqQq1Jp6TYCcw/CzW/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoMBtyhkPRDN5QEfc16qmxVVCWzjaaxtdmxzYbgKiU=;
 b=E2fDKab5CQsoXeoFxYF36lt1/502+HAa1mpg+eppNo9Vt9W1gdDR30RFrZ9w/JhRv/wd9zjzwHxWAfsrLuLdHQLrfrc1/MOHETg71hmgMSM8gRM+XC2aa4Rq1p09AdoiuwWP2fY38vdHJ0mrsk6n1PUTP6QrbRcfmMVPI++f5y9nfe4MjwLyQWoNGTiozB4McGC9X+kzJrCjLwwYaYDIAoTdssc/USWJ/1irVE85VWQfINatnfRZsahqTEQKiv+3JWjbmsonaVWp/4gkfhDoJd6LC1LQG86NC1F+Gro3V2frU06Et5WWeAX+YD1MDVMjj7J+3cPuu4qYcJlJ/VIiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoMBtyhkPRDN5QEfc16qmxVVCWzjaaxtdmxzYbgKiU=;
 b=gbACpv2kAwFhMJ7TSIk7Bk4+JP2mb+eoBvfGGw70zMNrWjE/kauvqVCU+uRzUrpmA/z/5Lesm087Ob2TwyEs0Bf3o0DdxIRcGOuZiE+nXB7A2b+aSUULfDAbBq5UZ1+YeDXsZ7SjaeQTT+vUtrDfhIpj9tmY86PFplYzlsfje5Y=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 01:45:39 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 01:45:39 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: Build regressions/improvements in v5.10-rc1
Thread-Topic: Build regressions/improvements in v5.10-rc1
Thread-Index: AQHWq31I6sUC2w0KikO4S+PwHkx5uamqrsIA
Date:   Tue, 27 Oct 2020 01:45:38 +0000
Message-ID: <c235619b-d4be-e064-c74a-ea67a5d70bcd@synopsys.com>
References: <20201026081811.3934205-1-geert@linux-m68k.org>
 <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
In-Reply-To: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e392331c-acb9-4d6a-6411-08d87a1a01cf
x-ms-traffictypediagnostic: BY5PR12MB4258:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42586001C068C3558279A160B6160@BY5PR12MB4258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krVuI8Yf8XvDFdxNeINHB/A0YwD8VksK1B04aGEpajWlCN3zWlXJlzTDinpnVImtbT7rSH5d4tgjP71w4W0aVwoD8gwTqpzegH/qLwTlijjCWbuIeLiqSuPoe2+2InGY0eM9aWMsGwQAeKvoKJg2Jk9+2yHLbV6uZ1XHTxcuO1AkMvf2KnGjtS9SWBwHarD5EnbcnqZleMfkVJ2LdWdtj/xAPesw6P7JMKUSzFR/NHbTd0xJu2OAo9goPVG1L4QLqA/qGZ2RR8dDuohVcv9BhJh+nspOlvmPNmNUL+NDKFtyJOCbCT62adMRPuWcSBeGpgPLLY6ssijG775U9zLkg4QoK2DctU9Raynv9MuMSzsKwxC9OJ1BRSOzmw2UxG9/OhSmhJihLqLUo8vbnRB56i3L6nnRco08nmrtuIQvpQdUYgB/8eCv7hhoEhjgbOM7Eg4NRXlMLyIDS16SWGAmew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(186003)(66556008)(8936002)(4326008)(76116006)(2906002)(66946007)(5660300002)(66446008)(6512007)(316002)(66476007)(110136005)(71200400001)(64756008)(54906003)(2616005)(6636002)(31696002)(83380400001)(86362001)(36756003)(6506007)(966005)(53546011)(8676002)(31686004)(478600001)(26005)(6486002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: swCYHIixrAcYEIwrASU+FQn0JIwX4FthplF/pMt4hMEWjxmskEvdlptI0toYln8Wr1SUrrPCQIBvDGsCAV9/nqIZ72JskcQ4SbHL8cNyYLg/utP8/N9cUSLjhVw/UcbGb/zgBhgIw3fOe/bH4vFzEtaHiujRmjcSsxLUEkOKRA5Dz5w7Um/5/MkIIE0V+FeCjSQN60ylPYgzVMDDYbApWKsduc0T4Ss97yhWdvSvkIe9a8cChzFRuoqB/ehRnQUQMgHxMrAUh6M0t3Zm7bkP22QSQ9CzmsIeQaTa4+LYh2a9aMrd9GuICggOEEaBji4T+JXLFK5w3LgWwwzsD0Cmmq4YIAJAPGrUqrFAU1pbwv5dWbkOzsaHc7qxtty/sSkFqMawXCwJDJkWqT/QA/+k8K9JKUhAy/DCftD6nGfq9fZ9VetmovJMBUdx5OF+VNGs9EO05SeydArR0E3HG3d+cB99ixlAC5y+muWB8GjJwQ8fepvgZaE5QtMuQnXuR4DKXOAZRydyftuE4wVnoT4u5vjy1oPK5KVnHLjOCF5Ye/0iyF7sJ5QSdNvfhFeMuT2uL7QewdeY3h37Ojl9gtRXRzK7jOCUzS/xp+sSI8nR/hH+WQpd+k8/Ob89Boa01VSKGfnBqB+3C4RyBx7S+FYW2Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AC154D5EE6490448ADDFE68F796CB75@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e392331c-acb9-4d6a-6411-08d87a1a01cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 01:45:38.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRqV7xBk0Tld/JFjM6TB3hxCEP+vuzfslNiPxv2gvD9on3Yccg75bDM6sEC8GSqd4xzl4wa0ygImp6eX9ITTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDEwLzI2LzIwIDI6NDggQU0sIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gT24gTW9uLCBPY3QgMjYsIDIwMjAgYXQgMTA6NDYgQU0gR2VlcnQgVXl0dGVyaG9ldmVu
DQo+IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+PiBCZWxvdyBpcyB0aGUgbGlzdCBv
ZiBidWlsZCBlcnJvci93YXJuaW5nIHJlZ3Jlc3Npb25zL2ltcHJvdmVtZW50cyBpbg0KPj4gdjUu
MTAtcmMxWzFdIGNvbXBhcmVkIHRvIHY1LjlbMl0uDQo+Pg0KPj4gU3VtbWFyaXplZDoNCj4+ICAg
LSBidWlsZCBlcnJvcnM6ICszLy03DQo+PiAgIC0gYnVpbGQgd2FybmluZ3M6ICsyNi8tMjgNCj4+
DQo+Pg0KPj4gICArIHtzdGFuZGFyZCBpbnB1dH06IEVycm9yOiBpbmFwcHJvcHJpYXRlIGFyZ3Vt
ZW50cyBmb3Igb3Bjb2RlICdhZGMnOiAgPT4gMTcwDQo+IGFyYy1nY2MxMC9heHMxMDFfZGVmY29u
ZmlnDQoNClRoeCBmb3IgYnJpbmdpbmcgdGhpcyB0byBvdXIgbm90aWNlLiBBbGV4ZXkgLyBDbGF1
ZGl1IC0gYXJlIHdlIHRlc3RpbmcgZ2NjLTEwIGZvcg0KQVJDNzAwIC0gSXQgc2VlbXN2NS4xMC1y
Y1gga2VybmUgaXMgdW5lYXJ0aGluZyBzb21lIHNvcnQgb2YgY29tcGlsZXIgaXNzdWUNCg0KaHR0
cDovL2tpc3NrYi5lbGxlcm1hbi5pZC5hdS9raXNza2IvYnJhbmNoL2xpbnVzL2hlYWQvMzY1MGIy
MjhmODNhZGRhN2U1ZWU1MzJlMmI5MDQyOWMwM2Y3YjllYy8NCmh0dHA6Ly9raXNza2IuZWxsZXJt
YW4uaWQuYXUva2lzc2tiL3RhcmdldC8xODk0MjUvDQpodHRwOi8va2lzc2tiLmVsbGVybWFuLmlk
LmF1L2tpc3NrYi9idWlsZHJlc3VsdC8xNDM4NDQ4Ny9sb2cvDQoNCi0tLS0tLS0tPg0KDQojIDwg
bWFrZSAtcyAtaiAyNCBBUkNIPWFyYyBPPS9raXNza2IvYnVpbGQvbGludXNfYXhzMTAxX2RlZmNv
bmZpZ19hcmMtZ2NjMTAgQ1JPU1NfQ09NUElMRT0vb3B0L2Nyb3NzL2tpc3NrYi9rb3JnL2djYy0x
MC4xLjAtbm9saWJjL2FyYy1saW51eC9iaW4vYXJjLWxpbnV4LSAgaGVscA0KIyBtYWtlIC1zIC1q
IDI0IEFSQ0g9YXJjIE89L2tpc3NrYi9idWlsZC9saW51c19heHMxMDFfZGVmY29uZmlnX2FyYy1n
Y2MxMCBDUk9TU19DT01QSUxFPS9vcHQvY3Jvc3Mva2lzc2tiL2tvcmcvZ2NjLTEwLjEuMC1ub2xp
YmMvYXJjLWxpbnV4L2Jpbi9hcmMtbGludXgtICBvbGRkZWZjb25maWcNCiMgbWFrZSAtcyAtaiAy
NCBBUkNIPWFyYyBPPS9raXNza2IvYnVpbGQvbGludXNfYXhzMTAxX2RlZmNvbmZpZ19hcmMtZ2Nj
MTAgQ1JPU1NfQ09NUElMRT0vb3B0L2Nyb3NzL2tpc3NrYi9rb3JnL2djYy0xMC4xLjAtbm9saWJj
L2FyYy1saW51eC9iaW4vYXJjLWxpbnV4LSAgDQp7c3RhbmRhcmQgaW5wdXR9OiBBc3NlbWJsZXIg
bWVzc2FnZXM6DQp7c3RhbmRhcmQgaW5wdXR9OjE3MDogRXJyb3I6IGluYXBwcm9wcmlhdGUgYXJn
dW1lbnRzIGZvciBvcGNvZGUgJ2FkYycNCm1ha2VbMl06ICoqKiBbL2tpc3NrYi9zcmMvc2NyaXB0
cy9NYWtlZmlsZS5idWlsZDoyODM6IGZzL3JlbWFwX3JhbmdlLm9dIEVycm9yIDENCm1ha2VbMl06
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQptYWtlWzFdOiAqKiogWy9raXNz
a2Ivc3JjL01ha2VmaWxlOjE3OTk6IGZzXSBFcnJvciAyDQptYWtlWzFdOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KbWFrZTogKioqIFtNYWtlZmlsZToxODU6IF9fc3ViLW1h
a2VdIEVycm9yIDINCkNvbW1hbmQgJ21ha2UgLXMgLWogMjQgQVJDSD1hcmMgTz0va2lzc2tiL2J1
aWxkL2xpbnVzX2F4czEwMV9kZWZjb25maWdfYXJjLWdjYzEwIENST1NTX0NPTVBJTEU9L29wdC9j
cm9zcy9raXNza2Iva29yZy9nY2MtMTAuMS4wLW5vbGliYy9hcmMtbGludXgvYmluL2FyYy1saW51
eC0gICcgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMg0KIyBybSAtcmYgL2tpc3NrYi9i
dWlsZC9saW51c19heHMxMDFfZGVmY29uZmlnX2FyYy1nY2MxMA0KIyBCdWlsZCB0b29rOiAwOjAx
OjIxLjE3OTExOQ0KDQo=
