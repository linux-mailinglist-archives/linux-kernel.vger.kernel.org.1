Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E922F219F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhAKVQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:16:34 -0500
Received: from mail-eopbgr60104.outbound.protection.outlook.com ([40.107.6.104]:8746
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbhAKVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:16:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H33lCOMkVPcw2KjStL44QgfS6DgDB0lWnL1rPu7XkI5rBlaWjbsuPBgCghpx7ibY97Krgp1Aekmo3PCO9E2C78WgtiRBDi8KSl7LaqRFrYd3fsn++xwkYIF+gmvk4/Hz2YBjmKDQPcstgeLTYMxwZUUXA5ODDWr+i14OO53dq305gJx4L25zvszTi5MNI+AbeSYqx3Gl6NPXjiT1MAsTeTNMZ2Cp/+H4lA32nU0ZtIllxc158BFgWCXYzRAtB8p1avfx170neI5nh87fEso4DfqQ27MAnKbEaWNNDF/g4pTqS5Zvjk/8lDtttlerfDdIZjrm0eSz7Wcgw8OGxulw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsf9ih2Kdd4Da2h7CJDfRuFHGhWcDpneRxXaKEuy0p4=;
 b=VlrXW7WXebDZnjajRi1ClVp6hZjEQYKR+H/DPOQOAvNFkDnnZgKZ12i/vJ8tZgIJ4Zh8JAMXQqqsIkIDwZCKGuKFNZqQi3Zq4dRMhMdbcEhh9o1duT+p9FAEsKy/apNrbqp4rpw8TXCE91nsb1nKLoP0dbDMQlm4rtsp7lN/A1SgGquoTjJGASWgh7XVH37ezQ+Lw6xKLeG6gLZlxMdIhiWwXnG80oJVSOmTbC02jyKrbnIYPBZdsjWmnXtzL2eSIut4kliSDJCwCAEoWTlcy4U+0g6x1sbBw6x4H6U6Twxli+Xuw4ao82VW7nF8UXz4pMmVudD9RSdItzzS8FSQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=se.com; dmarc=pass action=none header.from=se.com; dkim=pass
 header.d=se.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=se.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsf9ih2Kdd4Da2h7CJDfRuFHGhWcDpneRxXaKEuy0p4=;
 b=O1K2O/iS2CiuumY+ECNp/vxa7gK1ChEdCkktrK5MpFBE3REb1vdTYMxPYrTPKaWAsrbHyBA0XXk02G0C1uqApFFnlQEckpCbcX4XzU7cdG1mZNk6SqObIVJZPcwNv/+mKqK3notN6rekY8VsUU6LzyrC/lMww6MBXJrXtSy4qgccAQn6cc+c0bjUf7h8Dc71pgj79+2v2ZsgJ5u+pXjpmWJxp3ihTbw1J8LHW5EeVCT6aeqh9bUkf9XOlmH3KDxl1RnXYno37DXqX9rbbpWK7gHeKAnHWT93x7YzsqrNtofqHEakAqfEmA0Yc/CD4xRtXyv9btMrH2BYyzVpGVS0Mg==
Received: from AM0PR04MB5569.eurprd04.prod.outlook.com (2603:10a6:208:115::28)
 by AM0PR0402MB3489.eurprd04.prod.outlook.com (2603:10a6:208:16::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 21:15:48 +0000
Received: from AM0PR04MB5569.eurprd04.prod.outlook.com
 ([fe80::41ea:ffc:6424:dc37]) by AM0PR04MB5569.eurprd04.prod.outlook.com
 ([fe80::41ea:ffc:6424:dc37%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:15:47 +0000
From:   Mattias Wallin <mattias.wallin@se.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: RE: Old platforms: bring out your dead
Thread-Topic: Old platforms: bring out your dead
Thread-Index: AQHW6Apux1bxb/0va0mVRwmRUXq8qaoi2FiAgAAK6lA=
Date:   Mon, 11 Jan 2021 21:15:47 +0000
Message-ID: <AM0PR04MB556964159EEB85C87124E4A7EBAB0@AM0PR04MB5569.eurprd04.prod.outlook.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210111111047.mgrdho7frjukxfze@vireshk-i7>
 <CAK8P3a0j2XrV9a0Rm_3LaKAgKW8Kzneu-KXcfSU0zHS6S9ou8w@mail.gmail.com>
In-Reply-To: <CAK8P3a0j2XrV9a0Rm_3LaKAgKW8Kzneu-KXcfSU0zHS6S9ou8w@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=se.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fbd8898-5e70-47bc-bf7c-08d8b67610cb
x-ms-traffictypediagnostic: AM0PR0402MB3489:
x-microsoft-antispam-prvs: <AM0PR0402MB34893F11AE6173870BA721FEEBAB0@AM0PR0402MB3489.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0hKfi05VZ1T5YvxvBTXi9ZlDWrEUeRXzpO+k3nJY+3Uf2gkVuJdLKDB0V15Y9pUQgssFJ/XGb8zQ8yEjL6nXRaWXN/aAormhTG1rSV447Td53fa/tNAzQ62r3GmO5EnoWSj9th6+C1FiH9kFQAbLWu2YVPTxtggvt0x0S373GH+04TS6/DXwuJm1i7tpEQQmdnXcq+gH7gUk9KBh0nzY7a+6/PAiIayUMZfkoaVgFRa1H6+DZZrzHjrsD36Gn3yyrKF9hgKrjsIK3IUUAsPZdItQ4GS5d9ECvkLODNEGiiKWxYX6ZMLCbR/KD8kAUwapwBmmWg94lXSZYRaYY2cHcvkSYdNOaPzTodR+XS//97wwbhLcxNuVOuGv1V/af0J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5569.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(71200400001)(26005)(7416002)(55236004)(8676002)(7406005)(8936002)(44832011)(66476007)(76116006)(478600001)(4326008)(316002)(6506007)(53546011)(64756008)(66446008)(186003)(66946007)(9686003)(66556008)(33656002)(110136005)(55016002)(52536014)(83380400001)(5660300002)(54906003)(86362001)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aW9HS3VtYkxaZG9kbURxTE1pOHJwRjBYa1F2TEdiamx0U0VlSmNIZHp4aStn?=
 =?utf-8?B?SGpuZUY3dVVsSVJzTGZ3bURxNkhuNXluU3F1WW9DeVlJZ250R2g1dFNKK1d1?=
 =?utf-8?B?TFpVMG45d0ZIdngwUzJ0aHozTGUyNjRJMXRkSmFwTis5RWhzM1ZvZEVxWVBB?=
 =?utf-8?B?VnkrQXU4cjgzampDam1kZWNiUUN5dEk5WkhUNFNiYndKaVBtZWxiWnkyb3JB?=
 =?utf-8?B?Q28rZkRqbzZGZHlSNVV6RzMyektwT01jNHFDYkkxazVzcDAxVndYVVMyazVF?=
 =?utf-8?B?NWFNbXIxaVEyM203MWpGekJGaVpCMWhhS0dnNkxkWmxXQzJKeWtEZ25ha1dO?=
 =?utf-8?B?enUwU3dVRmRXNm1MN0FENGZrWU9XeVg5WHFQNWt3QUZ6eFo2aDFHL2lGZVlk?=
 =?utf-8?B?KzdpVjJBRXR2M3pFU01ickMwY1AxSDBkcjBnNkFsTktReWRlVmdLRGdPSGp1?=
 =?utf-8?B?WnhYNklVNmM2Ky9YWUlJREhwU1NTQ3FxTituUUF6VDdLeUlRbFZFWkxJbXN3?=
 =?utf-8?B?djRrRUFKZUgxM0FmYm80OFRYM3VSSlBJc044R0JMbER6YjBNUHNZT2xFd2Q0?=
 =?utf-8?B?VEY2SWFmT2J0REtEb3kycktadE5lTExTaDYyUktxelRMcW5qcFNxVGR3Wmtw?=
 =?utf-8?B?aDVTSVVxZlhRM3hNekthSG56OFZraFBNeUpCdnFsdmdFQmx4QUlPY0lrbDlI?=
 =?utf-8?B?U2k0bGtBUmVRbWVTMnFDbDFvT0IrZi9LNmwwZUp4eTBKb1BXa1JnOFd0RmNy?=
 =?utf-8?B?MURmWjI1ejhualZ0Y0xjZzVkRGVNS3gwTTFGazljUWdGS1BEalZtRXNURzVH?=
 =?utf-8?B?WEdWRWgwamhYWlN1NmpVRlpGL0p0b3UvdVVqc3Q3bkx6L1l6MmkvS2dQQ3hs?=
 =?utf-8?B?VWRNTEVhWWVOWjQ5c0xTYUV6RnlsdXM3RjdZUE1lWGNXUzJzZFJteFFWRUk2?=
 =?utf-8?B?MisvNWliY3BXV1ZsOC83TVh1YWIvZ3ZVbUk0Y1Z1YkI0WnlvTlpLeFowdUJx?=
 =?utf-8?B?VE0yeDhBOXhXQStwSEdVSDFWQWxySUZnajJVbFo0WWt4OWluNWw5dTBraUph?=
 =?utf-8?B?K1haUU4xL1R0c05XeGt4RS96Z3ZLWmQ5dlVqcXhpWlhWbWovaDZTNk1Lb1hL?=
 =?utf-8?B?Y3F4ZUxpb3VDYVVKQ1JlQVRBOE5QTC9UTjFpaXN5Y21UZ2t5ZU11cjEvZElK?=
 =?utf-8?B?cGkwRzRQWFRGTmJNVTdOR3YrakdubFkyY2dHbGRTUGtqL2s2NnJ6ZXBBa2Vq?=
 =?utf-8?B?eEpVVFZLV2M3ZkUvZWZiSzc5R0tCUG5SUTZFV280MGV6bkozaHp5SFJQMTdU?=
 =?utf-8?Q?STbH04il21sc4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5569.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd8898-5e70-47bc-bf7c-08d8b67610cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 21:15:47.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmYKWO4zwNSvjxY0nJa/oLHOQT76lFwwzVSiP92mT4qSLfqznGGOo9l5btt5fNZeb8puOhK0nuOkNn219LDWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMTI6MTAgUE0gVmlyZXNoIEt1bWFyIDx2aXJlc2gu
a3VtYXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+PiBPbiAwOC0wMS0yMSwgMjM6NTUsIEFybmQgQmVy
Z21hbm4gd3JvdGU6DQo+PiA+ICogc3BlYXIgLS0gYWRkZWQgaW4gMjAxMCwgbm8gbm90YWJsZSBj
aGFuZ2VzIHNpbmNlIDIwMTUNCj4+DQo+PiBJIHN0YXJ0ZWQgYW4gZW1haWwgY2hhaW4gd2l0aCB0
aGUgU1QgZm9sa3MgdG8gc2VlIGlmIHRoZXJlIGFyZSBhbnkNCj4+IGNvbmNlcm5zIHdpdGggdGhp
cyBnZXR0aW5nIHJlbW92ZWQgYW5kIGl0IHdhcyBjb25maXJtZWQgYnkgTWF0dGlhcw0KPj4gKENj
J2QpIGZyb20gU2NobmVpZGVyIEVsZWN0cmljIChvbmUgb2YgU1BFQXIncyBjdXN0b21lcnMpIHRo
YXQgdGhleQ0KPj4gaW5kZWVkIHVzZSBtYWlubGluZSBvbiBzcGVhcjMyMHMgYW5kIHRoZSBzcGVh
cjEzODAgYm9hcmRzLCB3aGlsZSB0aGV5DQo+PiBhbHNvIGhhdmUgYWNjZXNzIHRvIHNwZWFyMTMx
MCBib2FyZCB3aGljaCB0aGV5IGRvbid0IHVzZSB0aGF0IG9mdGVuLg0KDQo+IFRoYW5rIHlvdSBm
b3IgcmVhY2hpbmcgb3V0IHRvIHRoZW0hDQoNCj4gRG8gd2UgYWN0dWFsbHkgc3VwcG9ydCBzcGVh
cjEzODAgd2l0aCB0aGUgbWFpbmxpbmUga2VybmVsPyBJJ3ZlDQo+IG5ldmVyIHNlZW4gYW55dGhp
bmcgb3RoZXIgdGhhbiAxMzEwIGFuZCAxMzQwIG1vZGVscyBtZW50aW9uZWQuDQo+IElmIFNjaG5l
aWRlciBoYXZlIGFkZGl0aW9uYWwgcGF0Y2hlcyBvbiB0b3Agb2YgbWFpbmxpbmUgZm9yIHRoaXMs
DQo+IGl0IHdvdWxkIGJlIGdvb2QgdG8gZ2V0IHRob3NlIG1lcmdlZCBhcyB3ZWxsLiBJcyB0aGVy
ZSBhIGtlcm5lbA0KPiBzb3VyY2UgdHJlZSBhdmFpbGFibGUgc29tZXdoZXJlPw0KDQo+IFJvYiBI
ZXJyaW5nIGhhZCBtZW50aW9uZWQgdGhhdCBpdCB3b3VsZCBiZSBuaWNlIHRvIHNlZSBTUEVBcg0K
PiBnZXQgcmVtb3ZlZCBldmVudHVhbGx5IGJlY2F1c2UgaXQgd2FzIG9ubHkgcGFydGlhbGx5IGNv
bnZlcnRlZA0KPiB0byBkZXZpY2V0cmVlLCB3aXRoIHNvbWUgQVVYREFUQSgpIChvbiAzMDAvMzEw
LzMyMC82eHgpIGFuZA0KPiBzb21lIGRtYWVuZ2luZSBjaGFubmVsIGRhdGEgc3RpbGwgaW4gc291
cmNlIGZvcm1hdC4gVGhlc2UgbmVlZA0KPiB0byBiZSBmaW5pc2hlZCBiZWZvcmUgd2UgY2FuIGtp
bGwgb2ZmIEFVWERBVEEuDQoNClRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIEFybmQgYW5kIFZp
cmVzaA0KDQpUaGUgc3BlYXIxMzgwIGlzIG5vdCBzdXBwb3J0ZWQgaW4gbWFpbmxpbmUgYnV0IGl0
J3MgcXVpdGUgc2ltaWxhciB0byAxMzEwIGFuZCAxMzQwLg0KVGhlIHNwZWFyMTN4eCBjb21lcyBp
biBhIGZldyBmbGF2b3JzLiAxMzEwIGFuZCAxMzQwIGFyZSB0aGUgc3RhbmRhcmQgb25lcyBzb2xk
IGJ5IFNUIGFuZCB0aGUgMTM4MCBhcmUgdGhlIGN1c3RvbWl6ZWQgdmVyc2lvbiBmb3IgU2NobmVp
ZGVyIEVsZWN0cmljIG5lZWRzLiBPbmUgcGFydCBvZiB0aGUgY2hpcCBpcyBjdXN0b21pemFibGUg
YnV0IHRoZSBiYXNlIGlzIHRoZSBzYW1lIGluIGFsbCAxM3h4LiBTbyBhIGZldyBJUCBibG9ja3Mg
ZGlmZmVyIGJldHdlZW4gdGhlIGZsYXZvcnMuIEkgY2FuIHRyeSB0byBzZW5kIHlvdSB0aGUgMTM4
MCBzdHVmZiBhcyB3ZWxsLg0KIA0KVGhlcmUgaXMgY3VycmVudGx5IG5vIGV4dGVybmFsIHNvdXJj
ZSB0cmVlIGZvciBvdXIga2VybmVsIGVhc3kgYXZhaWxhYmxlLg0KDQpJZiB0aGUgQVVYREFUQSBv
biAzeHggaXMgYSBwcm9ibGVtIEkgY2FuIHRyeSB0byBzdGFydCBmb2N1cyBvbiBzZW5kaW5nIGZv
ciBwYXRjaGVzIGluIHRoYXQgYXJlYS4gV2UgaGF2ZSBwYXRjaGVzIHRoYXQgbW92ZSBzb21lIG1v
cmUgcGFydHMgb3ZlciB0byBkZXZpY2V0cmVlIChjb21wYXJlZCB0byBtYWlubGluZSkgYnV0IHdl
IGhhdmVuJ3QgY29udmVydGVkIGFsbC4gSSB3aWxsIGludmVzdGlnYXRlIGlmIHdlIGhhdmUgc29t
ZXRoaW5nIHRoYXQgaGVscHMgaW4gdGhhdCBhcmVhLg0KDQpUaGFua3MsDQpNYXR0aWFzIFdhbGxp
bg0KDQo=
