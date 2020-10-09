Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04955288090
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgJIC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:58:07 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:52865
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728854AbgJIC6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epnZcjci8h4U4JAwxfttP5QNdmVBwoKa10kBV/xfWGWRh79ydLwTmBPirqYbjayY5eWt9EPVRrDA+LnzwepRZZN10t6hoMnEi12nl47cuavz/3JS/JhugUo71wswDFDvjSm5xbGcmATg4InGVIXy7JFGCkLqabdsN4UFpTEjeLb98N6TuI+2y6WhFXy1VOSGRTZ8AH7oJtEGORBdtK6yMGefds+oLGW8aDJ/5Q7Dx2mxqhrjClQewp8ngqgck6SpLjEs/Vzf5Cp2p5tj/J+E6nx1JF3ugJY4PoNlsP1ybsHq/o6+8Yg84rNwEkpeixozHDFvvPfcLROPkhTdxwf7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhOVTv6ZSzQsYHb6qtvtRKsk0eZdaZaCo+spbH5mjYI=;
 b=c3SmyfWlrnYSWpbLciHlBk0Rp76x+WFSmV8TwVAPnkzmGR17mPArEi6DHPelMRT64JYDviejDSj2utONHI601IxFqlNH6HUBOmdS+o2UR5iqEjJ7aWjS1VIKKdnwqDBimnee1uRspCKpsSeNgwFxUGrOKiCiksENIAX5dlA5DV+6E4GUWqtmk0uVkMbL8Z+NY4fXOBhBTRhvQwoTlE9U153HFckqQ5CFOcA0434YsivmKxJmQuXf1XYi+2vGhmgqjr7Sh0e12d1VvqYBVGUlE5MbTvmAvxXXbgFYkw46Yod1HCvGW8leE2zW6cGlwxQ1AZzo9KkEO/GzDs96OuXPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhOVTv6ZSzQsYHb6qtvtRKsk0eZdaZaCo+spbH5mjYI=;
 b=fZH9/LeTUA3bJwXkdYrzQLs93dJB//lfLvsu+lMR7gBWN6aHkvZwbhsDfgNN+0sKaPKf6wexLz2xcdUftFNqKgkrllqAU4t45UUUsQ/8sA62nlKRBKJy+ohQxawrbxwG4ij8FpdtdH+XKEAGpcgGLpa9BgAUC3lOENdrLBOWBr8=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VI1PR0402MB2912.eurprd04.prod.outlook.com (2603:10a6:800:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 02:58:01 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7%4]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 02:58:01 +0000
From:   Jun Li <jun.li@nxp.com>
To:     ChiYuan Huang <u0084500@gmail.com>, Jun Li <lijun.kernel@gmail.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Subject: RE: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
Thread-Topic: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Thread-Index: AQHWnAEP61hqDMcgWUCo9++n9QPVoamK1ygAgAO+JsA=
Date:   Fri, 9 Oct 2020 02:58:01 +0000
Message-ID: <VE1PR04MB6528420A09336546A4AFBB9D89080@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net>
 <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
 <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com>
 <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com>
 <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
In-Reply-To: <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2e7452a-c1fa-49cd-0d3b-08d86bff22d1
x-ms-traffictypediagnostic: VI1PR0402MB2912:
x-microsoft-antispam-prvs: <VI1PR0402MB29125437C234215A40DD285189080@VI1PR0402MB2912.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rBu4yXUwj21W++xcQeHvxpgRVij5hsQmxpxGIkw9QqcGy3yyBmvBJbDX4V1EndzlbmcKe7HxAD5ZFzFI0b4RAs3XLnOfdVVBU4/F5afPqBZbqp8KQfouQPlzlCNfhoEZWMN5Dbk34RitSAjx77YNUiSIukGtV6ctTE4PUvKUoenA40qaCW1chZW5WTDjurbXKb9+D3WQgpV7Q+SFKFyYNc1HYikW0TLheGpO5/OGWSs74PoactYUdlZYWkoBvENov+2fjcqxdqejNKo8tk+jljxlLn/Qe46KRnHocc3cOJFsZI1FaoXaimyQWfVdRSboYkLpje6VUcAPzuOVOC8Mtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(9686003)(76116006)(110136005)(83380400001)(2906002)(316002)(7696005)(66946007)(66446008)(66476007)(66556008)(478600001)(64756008)(8936002)(8676002)(71200400001)(55016002)(33656002)(26005)(54906003)(186003)(5660300002)(4326008)(53546011)(44832011)(6506007)(52536014)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RNZxnaotX85Rlt3Hg+jS9ja3+39LLTyESFx+SjWKXa0mkOP+s6YPrbMJOEZO6CwKDQijSYkG0Iq37eCR7QsXbgBz5avP6b3snex4HzFULb9zHpau36CuazxPvePvIBPqGvCuw1CNLP7Iasvtt+jE2FXOoT4LwUYnZwnr0UaVdMhoKg1tEU1/gRJlvLfu7TSYdyhVtwWkg+Ba5v4+rixfVbC7quXIc/a/gq1ovPug2qCLGF1XaBs2gQ+20d1yRtTgVYilGD1X+Yst3/V2kBdQlS7sS7BRZoRETPTFcc3EfPAwFnCMgwE39CV4JbZWOA1H7qYKs4L/7uEIImHZeEb6qQiUaM+NSVJNp4KaNnRLrnucmoCGzoR8jNfUD0/4mY911DzaAgiDMwjddx/Y2y1mleSotbOqrfXcuEUQ5OGbYXRcbdaQWn8c7nIiZWgsikKpiW2MvU0sELpdPPw6dIkMlto/aKc9wGvfv3Tx/9NOdw+jgZNSzHPhdIEXPvL933O/lS7DG6b9ntkj0nP0bBOdhASvzqWDjdN9Uwb1SIY0jiqldolDNOJoEyfRQU5pbe+czkhqhBg7eBCDw10hCa2P6twj8bKKMQ99t7qzUrc1hfc6NFl0jp7A+PhD4dpUgsVOfTLcA5cwcAAugFOJElCBRg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e7452a-c1fa-49cd-0d3b-08d86bff22d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 02:58:01.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGOB3cqVB+/xkLlERbetNWs3E7aKLpylhvgoqCCJUDNdUqx3sh1Wi6ENZJoSZVxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2912
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hpWXVhbiBIdWFuZyA8
dTAwODQ1MDBAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNywgMjAyMCAx
OjM5IEFNDQo+IFRvOiBKdW4gTGkgPGxpanVuLmtlcm5lbEBnbWFpbC5jb20+DQo+IENjOiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBHcmVnIEtIDQo+IDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IEhlaWtraSBLcm9nZXJ1cw0KPiA8aGVpa2tpLmtyb2dlcnVzQGxpbnV4
LmludGVsLmNvbT47IExpbnV4IFVTQiBMaXN0DQo+IDxsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
PjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGN5X2h1YW5nIDxjeV9o
dWFuZ0ByaWNodGVrLmNvbT47IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHVzYjogdHlwZWM6IHRjcG06IEZpeCBpZiB2YnVzIGJlZm9yZSBjYywgaGFyZF9y
ZXNldF9jb3VudA0KPiBub3QgcmVzZXQgaXNzdWUNCj4gDQo+IEp1biBMaSA8bGlqdW4ua2VybmVs
QGdtYWlsLmNvbT4g5pa8IDIwMjDlubQxMOaciDfml6Ug6YCx5LiJIOS4iuWNiDEyOjUy5a+r6YGT
77yaDQo+ID4NCj4gPiBDaGlZdWFuIEh1YW5nIDx1MDA4NDUwMEBnbWFpbC5jb20+IOS6jjIwMjDl
ubQxMOaciDbml6Xlkajkuowg5LiL5Y2IMTI6MzjlhpnpgZPvvJoNCj4gPiA+DQo+ID4gPiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IOaWvCAyMDIw5bm0MTDmnIg15pelIOmAseS4
gCDkuIvljYgxMTozMOWvqw0KPiDpgZPvvJoNCj4gPiA+ID4NCj4gPiA+ID4gT24gMTAvNS8yMCA0
OjA4IEFNLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiBbIC4uLiBdDQo+ID4gPiA+ID4+PiBXaGF0
IGV2ZXIgaGFwcGVuZWQgd2l0aCB0aGlzIHBhdGNoLCBpcyB0aGVyZSBzdGlsbCBkaXNhZ3JlZW1l
bnQ/DQo+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBZZXMsIHRoZXJlIGlzLiBJ
IHdvdWxkbid0IGhhdmUgYWRkZWQgdGhlIGNvbmRpdGlvbmFsIHdpdGhvdXQNCj4gPiA+ID4gPj4g
cmVhc29uLCBhbmQgSSBhbSBjb25jZXJuZWQgdGhhdCByZW1vdmluZyBpdCBlbnRpcmVseSB3aWxs
IG9wZW4gYW5vdGhlcg0KPiBwcm9ibGVtLg0KPiA+ID4gPiA+PiBGZWVsIGZyZWUgdG8gYXBwbHks
IHRob3VnaCAtIEkgY2FuJ3QgcHJvdmUgdGhhdCBteSBjb25jZXJuIGlzDQo+ID4gPiA+ID4+IHZh
bGlkLCBhbmQgYWZ0ZXIgYWxsIHdlJ2xsIGdldCByZXBvcnRzIGZyb20gdGhlIGZpZWxkIGxhdGVy
IGlmIGl0DQo+IGlzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT2ssIGNhbiBJIGdldCBhbiBhY2sg
c28gSSBrbm93IHdobyB0byBjb21lIGJhY2sgdG8gaW4gdGhlIGZ1dHVyZQ0KPiA+ID4gPiA+IGlm
IHRoZXJlIGFyZSBpc3N1ZXM/ICA6KQ0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE5vdCBm
cm9tIG1lLCBmb3IgdGhlIHJlYXNvbnMgSSBzdGF0ZWQuIEkgd291bGQgYmUgb2sgd2l0aCBzb21l
dGhpbmcNCj4gbGlrZToNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICBpZiAodGNwbV9wb3J0X2lz
X2Rpc2Nvbm5lY3RlZChwb3J0KSkNCj4gPiA+ID4gKyAgICAgICBpZiAodGNwbV9wb3J0X2lzX2Rp
c2Nvbm5lY3RlZChwb3J0KSB8fA0KPiA+ID4gPiArICAgICAgICAgICAodGNwbV9jY19pc19vcGVu
KHBvcnQtPmNjMSkgJiYNCj4gPiA+ID4gKyB0Y3BtX2NjX2lzX29wZW4ocG9ydC0+Y2MyKSkpDQo+
ID4gPiA+DQo+ID4gPiA+IHRvIG5hcnJvdyBkb3duIHRoZSBjb25kaXRpb24uDQo+ID4gPg0KPiA+
ID4gSSBoYXZlIHRyaWVkIHRoZSBhYm92ZSBjb21tZW50IGFuZCBJdCBkb2Vzbid0IHdvcmsuDQo+
ID4gPiBIb3cgYWJvdXQgdG8gY2hhbmdlIHRoZSBqdWRnZW1lbnQgbGlrZSBhcyBiZWxvdw0KPiA+
ID4NCj4gPiA+IC0gICAgICAgaWYgKHRjcG1fcG9ydF9pc19kaXNjb25uZWN0ZWQocG9ydCkpDQo+
ID4gPiArICAgICAgIGlmICh0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHBvcnQpIHx8ICFwb3J0
LT52YnVzX3ByZXNlbnQpDQo+ID4gPg0KPiA+ID4gVGhlIGhhcmRfcmVzZXRfY291bnQgbm90IHJl
c2V0IGlzc3VlIGlzIGZvbGxvd2luZyBieSB0aGUgYmVsb3cgb3JkZXINCj4gPiA+IDEuIFZCVVMg
b2ZmICggYXQgdGhlIHNhbWUgdGltZSwgY2MgaXMgc3RpbGwgZGV0ZWN0ZWQgYXMgYXR0YWNoZWQp
DQo+ID4gPiBwb3J0LT5hdHRhY2hlZCBiZWNvbWUgZmFsc2UgYW5kIGNjIGlzIG5vdCBvcGVuDQo+
ID4gPiAyLiBBZnRlciB0aGF0LCBjYyBkZXRhY2hlZC4NCj4gPiA+IGR1ZSB0byBwb3J0LT5hdHRh
Y2hlZCBpcyBmYWxzZSwgdGNwbV9kZXRhY2goKSBkaXJlY3RseSByZXR1cm4uDQo+ID4NCj4gPiBJ
ZiB0Y3BtX2RldGFjaCgpIHJldHVybiBkaXJlY3RseSwgdGhlbiBob3cgeW91ciBwYXRjaCBjYW4g
cmVzZXQNCj4gPiBoYXJkX3Jlc2V0X2NvdW50Pw0KPiA+DQo+IFllcywgaXQgY2FuLiBXZSBrbm93
IHZidXNfcHJlc2VudCBjaGFuZ2UgZnJvbSB0cnVlIHRvIGZhbHNlIGFuZCBjYyBkZXRhY2gNCj4g
Ym90aCB0cmlnZ2VyIHRjcG1fZGV0YWNoLg0KPiBNeSBjaGFuZ2UgaXMgd2hlbmV2ZXIgdGNwbV9k
ZXRhY2ggdG8gYmUgY2FsbGVkLCBoYXJkX3Jlc2V0X2NvdW50IHdpbGwgYmUNCj4gcmVzZXQgdG8g
emVyby4NCg0KWW91ciBwYXRjaCBpcyBiYXNlZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IHRjcG1f
ZGV0YWNoKCkgaXMgY2FsbGVkIHdpdGgNCnBvcnQtPmF0dGFjaGVkIGlzIHRydWUsIGJ1dCB0Y3Bt
X3Jlc2V0X3BvcnQoKSBtYXkgaGFwcGVuIGJlZm9yZSB0aGF0LA0KaW4gdGhhdCBjYXNlLCB0Y3Bt
X3Jlc2V0X3BvcnQoKSBjbGVhciBwb3J0LT5hdHRhY2hlZCBmbGFnIHNvIHRjcG1fZGV0YWNoDQp3
aWxsIHJldHVybiBkaXJlY3RseS4NCg0KPiANCj4gPiBJIGFtIHNlZWluZyB0aGUgc2FtZSBpc3N1
ZSBvbiBteSBwbGF0Zm9ybSwgdGhlIHByb3Bvc2VkIGNoYW5nZToNCj4gPiAtICAgICAgIGlmICh0
Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHBvcnQpKQ0KPiA+IC0gICAgICAgICAgICAgICBwb3J0
LT5oYXJkX3Jlc2V0X2NvdW50ID0gMDsNCj4gPiArICAgICAgIHBvcnQtPmhhcmRfcmVzZXRfY291
bnQgPSAwOw0KPiA+IGNhbid0IHJlc29sdmUgaXQgb24gbXkgcGxhdGZvcm0uDQo+ID4NCj4gSSdt
IG5vdCBzdXJlIHdoYXQncyB5b3VyIGNvbmRpdGlvbi4gQ291bGQgeW91IGRpcmVjdGx5IHBhc3Rl
IHRoZSB0Y3BtIGxvZw0KPiBmb3IgdGhlIGNoZWNrPw0KDQpbICAgNDcuMTI3NzI5XSBTZXR0aW5n
IHZvbHRhZ2UvY3VycmVudCBsaW1pdCAwIG1WIDAgbUENClsgICA0Ny4xMjc3MzldIHBvbGFyaXR5
IDANClsgICA0Ny4xMjkzMzNdIFJlcXVlc3RpbmcgbXV4IHN0YXRlIDAsIHVzYi1yb2xlIDAsIG9y
aWVudGF0aW9uIDANClsgICA0Ny4xMzA1MTZdIHN0YXRlIGNoYW5nZSBTTktfUkVBRFkgLT4gU05L
X1VOQVRUQUNIRUQNClsgICA0Ny4xMzExODFdIENDMTogMCAtPiAwLCBDQzI6IDMgLT4gMCBbc3Rh
dGUgU05LX1VOQVRUQUNIRUQsIHBvbGFyaXR5IDAsIGRpc2Nvbm5lY3RlZF0NClsgICA0Ny4xMzEx
OTRdIHN0YXRlIGNoYW5nZSBTTktfVU5BVFRBQ0hFRCAtPiBQT1JUX1JFU0VUDQpbICAgNDcuMTM0
NzAxXSBTZXR0aW5nIHZvbHRhZ2UvY3VycmVudCBsaW1pdCAwIG1WIDAgbUENClsgICA0Ny4xMzQ3
MDldIHBvbGFyaXR5IDANClsgICA0Ny4xMzYyOTFdIFJlcXVlc3RpbmcgbXV4IHN0YXRlIDAsIHVz
Yi1yb2xlIDAsIG9yaWVudGF0aW9uIDANClsgICA0Ny4xMzY4NzNdIGNjOj0wDQpbICAgNDcuMTM3
NDQ2XSBwZW5kaW5nIHN0YXRlIGNoYW5nZSBQT1JUX1JFU0VUIC0+IFBPUlRfUkVTRVRfV0FJVF9P
RkYgQCAxMDAgbXMNClsgICA0Ny4xMzgwODRdIENDMTogMCAtPiAwLCBDQzI6IDAgLT4gMCBbc3Rh
dGUgUE9SVF9SRVNFVCwgcG9sYXJpdHkgMCwgZGlzY29ubmVjdGVkXQ0KWyAgIDQ3LjIzOTE0M10g
c3RhdGUgY2hhbmdlIFBPUlRfUkVTRVQgLT4gUE9SVF9SRVNFVF9XQUlUX09GRiBbZGVsYXllZCAx
MDAgbXNdDQpbICAgNDcuMjM5MTUxXSBzdGF0ZSBjaGFuZ2UgUE9SVF9SRVNFVF9XQUlUX09GRiAt
PiBTTktfVU5BVFRBQ0hFRA0KWyAgIDQ3LjIzOTE1NF0gRW50ZXJpbmcgdGNwbV9kZXRhY2ggZGly
ZWN0bHkgcmV0dXJuIGhlcmUgPC0tLS0tLS0tLS0tLQ0KWyAgIDQ3LjIzOTE1N10gU3RhcnQgdG9n
Z2xpbmcNClsgICA0Ny4yNDAxNTBdIHN0YXRlIGNoYW5nZSBTTktfVU5BVFRBQ0hFRCAtPiBUT0dH
TElORw0KDQpMaSBKdW4NCj4gPiBIb3cgYWJvdXQgcmVzZXQgaGFyZF9yZXNldF9jb3VudCBpbiBT
TktfUkVBRFk/DQo+ID4gQEAgLTMzMjUsNiArMzMyOSw3IEBAIHN0YXRpYyB2b2lkIHJ1bl9zdGF0
ZV9tYWNoaW5lKHN0cnVjdCB0Y3BtX3BvcnQNCj4gKnBvcnQpDQo+ID4gICAgICAgICBjYXNlIFNO
S19SRUFEWToNCj4gPiAgICAgICAgICAgICAgICAgcG9ydC0+dHJ5X3Nua19jb3VudCA9IDA7DQo+
ID4gICAgICAgICAgICAgICAgIHBvcnQtPnVwZGF0ZV9zaW5rX2NhcHMgPSBmYWxzZTsNCj4gPiAr
ICAgICAgICAgICAgICAgcG9ydC0+aGFyZF9yZXNldF9jb3VudCA9IDA7DQo+ID4gICAgICAgICAg
ICAgICAgIGlmIChwb3J0LT5leHBsaWNpdF9jb250cmFjdCkgew0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHR5cGVjX3NldF9wd3Jfb3Btb2RlKHBvcnQtPnR5cGVjX3BvcnQsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRUNfUFdSX01PREVf
UEQpOw0KPiA+DQo+ID4gY2FuIHRoaXMgcmVzb2x2ZSB5b3VyIHByb2JsZW0/DQo+IEknbSBub3Qg
c3VyZS4gSXQgbmVlZCB0byBoYXZlIGEgdHJ5LCB0aGVuIEkgY2FuIGFuc3dlciB5b3UuDQo+IEJ1
dCBmcm9tIFVTQlBEIHNwZWMsIHRoZSBoYXJkX3Jlc2V0X2NvdW50IG5lZWQgdG8gcmVzZXQgemVy
byBvbmx5IHdoZW4gMS4NCj4gQXQgc3JjIHN0YXRlLCBwZV9zcmNfc2VuZF9jYXAgYW5kIHJlY2Vp
dmUgR29vZENSQyAyLiBBdCBzbmsgc3RhdGUsDQo+IHBlX3Nua19ldmFsdWF0ZV9jYXAgbmVlZCB0
byByZXNldCBoYXJkX3Jlc2V0X2NvdW50DQo+ID4NCj4gPiBMaSBKdW4NCj4gPiA+DQo+ID4gPiBB
bmQgdGhhdCdzIHdoeSBoYXJkX3Jlc2V0X2NvdW50IGlzIG5vdCByZXNldCB0byAwLg0KPiA+ID4g
Pg0KPiA+ID4gPiBHdWVudGVyDQo=
