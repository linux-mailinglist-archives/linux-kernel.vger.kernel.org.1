Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C19B27BCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgI2F5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:57:19 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:56603 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbgI2F5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:57:19 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 01:57:17 EDT
IronPort-SDR: hcif3n0ZR/BjWNamzZPummQEo7d6VQBKdVBf23Jj2YRiBmb1uCe1e7gUwZiUO85BCP9aKTxY9w
 qX/icTSAAlYmXPjYarTC/ua2qQYMPEBnAVJ/HC/G57T8ax7FYQkZZ+4UI7kT2JcdxQsyWe/fCR
 Um5aoHHTcIyzbTABt6ERzY/12r8zRLGkWAiey/dkZGfXvu3xu9V8xCaLwTRLhbRVkcWUbLcdMK
 QD3SHmmE84IfShIzmu9eCSfJTBV+WVzfBuJ803CpgG96NCHeJ++ncRXsKWVERVNpPe1ZQMHLoj
 Y9Y=
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="18776477"
X-IronPort-AV: E=Sophos;i="5.77,317,1596466800"; 
   d="scan'208";a="18776477"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:50:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flBVCBKddXWNavCEeyw3pl2j4qVDoL0wzCXGtHn7vcc4ZHJVdWqd9RLGccoEyeMR+nhVF+h9fBoKxTw7rj6942RkusMg1UCL1YMYZfMInd3CnfBp1XC6nUDunwpv4n2VeFawa+DBf/8r4UEPTkOIJhHw4qR9eJn6/CSGXNWv/kxpOop77j5AROnhqq6MPA1ijVOZU1+If9mKDtl2yPPBhlM74KICew7cXtaS3mPaImfRSy4fFLtdEVz/IeY2gBidfpFfxekbkIEbycMGwKN2huT+tITokz2W633TokVLh3Kdx8/+cmOk7YwjqlTM7H2f1sOCjDRKGE5wLqfwThh5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAgDDDQtvFGe2EtE+pnDFkUpSDNX5nDBh3uddJ+daR8=;
 b=eB7RzfEK1rZC9k4yKfaRVAUtTYsyRV55l5Qy0ouNmlwel+59M08iDQX1kv8s4DzvzzGohMbmeZF6fpRj6SfKHJcmBCE/X5LavWcF/QXi0iKCPr/bZkh3RnX08r7hVFbYoouTQjVMjpeqC68YEqo5LKr6PlMe/1n6dUHZw4EfTOk5DLLYLWyh6+o7HNJUcYhVyQxuaxCTwp/O/zfPhy2uj+LXw4t2gr8fWbm7NDRa0A4Gp8wTZfHdje1eaA9nZ+TjzQfA26AfIz0d56Wyj2m0xJUws9cWIMq0mLX/1/C4HC9MezTByxJWSk6OauWIQfuSn0OwUVnYqLx7syTsBi8Gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAgDDDQtvFGe2EtE+pnDFkUpSDNX5nDBh3uddJ+daR8=;
 b=RriFybXh+ZUFP+2yhJMorgRyhl6mJhAZ/0epF13aVS5KzQFyzXR8dmBPsitZ+WxUAEbX6gWbBOaOCffz0qk9SueFiX8WZYegkWNV0TMcVtCLFRctzkyi5dK7MP8pWBAUHsjwwqPySonnghdS62129BmqD5y/pB8eoGks2b6X5Sw=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSAPR01MB3123.jpnprd01.prod.outlook.com (2603:1096:604:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 05:50:04 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 05:50:04 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     'Marc Zyngier' <maz@kernel.org>
CC:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Topic: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Index: AQHWki1OzvWvE6qquUyffKCpvoCHGKl9XDZAgABqwgCAAQTGkA==
Date:   Tue, 29 Sep 2020 05:50:04 +0000
Message-ID: <OSAPR01MB4227204DB45A285761B520998F320@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
 <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
 <498b10b51f5c961f00b3d18e17c52e94@kernel.org>
In-Reply-To: <498b10b51f5c961f00b3d18e17c52e94@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf219747-9839-414e-ead0-08d8643b837a
x-ms-traffictypediagnostic: OSAPR01MB3123:
x-microsoft-antispam-prvs: <OSAPR01MB3123A057476BAE7DADF513188F320@OSAPR01MB3123.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjtTyg0v85jgGAQMikP744nuK5tdotJLCymxp7S9OY6Ws7Nn4HM55BOlEpjxoR4u0AFQc27sKZ1TFbIzkrWzpwjwpZT34IZDDVR513HiaDkvRsnhioYdTw9WNGPeBNWn8HA8cEc3eDdFYbD0s6J9F4Uas6fa96GkelCnJNdiMv6U4+nWXRpEsBlunGxtv25ZxV0ShNVZxPaExv16dgmrSoNOaoT00b7+mJb2Vc3OEnODLGOGVp9ZaXCU/Pew+fePYax346c1cJ6zHTx/+FSXmVWm3Y3oMwQUKVz0P+uC6mMM+gB3FkWocD0goL8n71SH3c1jZXn04PwD2kGBzy73d64VV8nJwq1yrZc4CeQbCKqZEbiP4EzKWCtQaQEqR6JFkliDTPMyG6LV+qWRBT5HBh5eVXCAFDYtLVbMFSQ0iCA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(33656002)(55016002)(9686003)(8936002)(6916009)(8676002)(52536014)(478600001)(76116006)(71200400001)(66946007)(5660300002)(85182001)(26005)(54906003)(86362001)(316002)(4326008)(186003)(83380400001)(66446008)(6506007)(53546011)(66476007)(66556008)(64756008)(2906002)(7696005)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: n/ALgT8MrufD1w7xxJycSVJgULlxJkFOhMZViUq03jVgaIb02Wz8WEt7Mff+O4Y1xCqPlMhT6PR7a9SITc64VMoLEC0tlUKi6UXOwZ6FFjfAple4c25mIuDw1pZM21e2ByQFBY7A67lLXNZouw9ECsNhaprjj3UmU5x5eHkXTmpk72ZN27s0QPNrGdh65/CQYTybIUWYpWVi2K3ASvWY3YobmL0BqetSVUW7Vp+BRh4mAS0uVLmzR3SYgFIhZHyE+XA9ywB6NZKG+C/Q/D8DjzPn6hib6zbqMDA/pxK3ML0+qbIVZQaYBQFYeXn54P7y011CeAA48v5lVq8oe7jY1V3+b2xhbSBOmTa+uMbgdB12H9+8ytfjVusUWLm6fhk9yjmcxCURDTRXf8rqeccv5yBfuPXog5GCYQoCXtg1M7wylObbVVx9UEeI1LDZN3mO7C5VBCdl6+J7KsKYLHXtb+pK26DNKlsQfV+9rXbKRQfbOZh93a2sRM1oaRpXxxaHegI/8R/DvS1IIMmSFbRSSTnBNfBXip34n9mXEmSuCmENV8hOWc9IDMU6InxEzFMn+1cafUdfkm0/xuVlreEHSBR0b91bwrHWt8XL9DUGvY1crdJWXGfhSdHg0Sbp0w6jWs/NGAmoAyfEuCsikN7Xhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf219747-9839-414e-ead0-08d8643b837a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 05:50:04.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYKlJAepV+YiKzXiEJNxWE+0EpV0wz9dJbYxVBVYXRxY2PIpBn2Jc1/JCVhV/hJ/w5XFE2XTJvABwfqT8P61lta1WkCe3gxefm1f0r4sBM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gT24gMjAyMC0wOS0yOCAw
Mzo0MywgaXRvLXl1aWNoaUBmdWppdHN1LmNvbSB3cm90ZToNCj4gPiBIaSBNYXJjLCBTdW1pdA0K
PiA+DQo+ID4gSSB3b3VsZCBhcHByZWNpYXRlIGlmIHlvdSBoYXZlIGFueSBhZHZpY2Ugb24gdGhp
cyBwYXRjaC4NCj4gDQo+IEkgaGF2ZW4ndCBoYWQgYSBjaGFuY2UgdG8gbG9vayBpbnRvIGl0LCBh
cyBJJ20gbm90IGV2ZW4gc3VyZSBJJ2xsIHRha2UgdGhlIGNvcmUNCj4gc2VyaWVzIGluIHRoZSBm
aXJzdCBwbGFjZSAodGhlcmUgYXJlIG91dHN0YW5kaW5nIHJlZ3Jlc3Npb25zIEkgY2FuJ3QgcmVw
cm9kdWNlLA0KPiBsZXQgYWxvbmUgZml4IHRoZW0pLg0KPiANCg0KSSB1bmRlcnN0YW5kIGl0Lg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlzIGFueXRoaW5nIEkgY2FuIGRvLg0KSSBzaW5j
ZXJlbHkgaG9wZSB0aGF0IHlvdXIgcGF0Y2hlcyB3aWxsIGJlIG1lcmdlZCBpbnRvIHRoZSBtYWlu
bGluZS4NCg0KPiA+DQo+ID4gWXVpY2hpIEl0bw0KPiA+DQo+ID4+IEVuYWJsZSBzdXBwb3J0IElQ
SV9DUFVfQ1JBU0hfU1RPUCB0byBiZSBwc2V1ZG8tTk1JDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2hz
ZXQgZW5hYmxlcyBJUElfQ1BVX0NSQVNIX1NUT1AgSVBJIHRvIGJlIHBzZXVkby1OTUkuDQo+ID4+
IFRoaXMgYWxsb3dzIGtkdW1wIHRvIGNvbGxlY3Qgc3lzdGVtIGluZm9ybWF0aW9uIGV2ZW4gd2hl
biB0aGUgQ1BVIGlzDQo+ID4+IGluIGEgSEFSRExPQ0tVUCBzdGF0ZS4NCj4gPj4NCj4gPj4gT25s
eSBJUElfQ1BVX0NSQVNIX1NUT1AgdXNlcyBOTUkgYW5kIHRoZSBvdGhlciBJUElzIHJlbWFpbiBu
b3JtYWwNCj4gPj4gSVJRcy4NCj4gPj4NCj4gPj4gVGhlIHBhdGNoIGhhcyBiZWVuIHRlc3RlZCBv
biBUaHVuZGVyWC4NCj4gDQo+IFdoaWNoIFRodW5kZXJYPyBUWDIgKGF0IGxlYXN0IHRoZSBpbmNh
cm5hdGlvbiBJIHVzZWQgaW4gdGhlIHBhc3QpIHdhc24ndCBhYmxlDQo+IHRvIGNvcnJlY3RseSBk
ZWFsIHdpdGggcHJpb3JpdGllcy4NCg0KSSB0cmllZCBpdCB3aXRoIFRodW5kZXJYIENOODg5MC4N
CklmIHlvdSB0ZWxsIG1lIHN0ZXBzIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBvZiBUWDIsIEkg
d2lsbCBpbnZlc3RpZ2F0ZSBpdCB3aXRoIFRYIGFzIHdlbGwuDQoNCj4gICAgICAgICAgTS4NCj4g
LS0NCj4gSmF6eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4NCg0KVGhhbmsg
eW91IGFuZCBiZXN0IHJlZ2FyZHMsDQoNCll1aWNoaSBJdG8NCg==
