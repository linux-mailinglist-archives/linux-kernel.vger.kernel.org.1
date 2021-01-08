Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBC2EF7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhAHSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:50:45 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58426 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbhAHSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:50:44 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C84940213;
        Fri,  8 Jan 2021 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610131784; bh=V3p/5/XO1UifNCWZ2bzKhz17qCNaC8XyN4A4E/ceb3A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MT/HuhcL5lP9hbi9daueqsCNchucWpuSAl+k6086Cj/mCJEOAggK75iVUWdHwoFRp
         xWCJQz4TYRcl3RkCrxTqYH71YQxTrzhuC4U0pCnxJ7w0DUOKZfF9XuTv1asNKHyKEH
         50tSUjLN09fKNIVNXKYshxM4JY5+t+rZf9m98bBj9W6TG+Lj0y0zgdbGFwcEoJNJQL
         2RZUrElSnXV99ulWL5vLOpY7acmX8SbacQJfffZjQuVUaIgJkhjkFGP3U14OsKceWi
         ZNovD+4iOAoPEKpn03+2r1jpNm5lR/dg/uUWLWvLGR1QiiLfKM5UPROP8gdP0Rcu4Z
         tkDPqjwAS/6Yw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98D63A0082;
        Fri,  8 Jan 2021 18:49:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C405B80240;
        Fri,  8 Jan 2021 18:49:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MRpmb1iS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6x7K6xVxJfBBDTzTUhKFk+qlp1M16kA57cEp1OKALfQwh55dOJRpeo019EZRQxodC2ueoGpy0ucUm3FthYmCOsjAf+CWqCch9ReQ3YTohcNkyhRW+y09Ry/b0YQCWwraS2RbNjam5XU9yJ4Ophf0lt2AZ1fPqvpL+slEXmuCMPn8wcjdTiEYzZIDRhasAKkGhVTe8raL4gFzfqxHiTwf2EwjWPWC7T48I/trJsQxoEr3P8x2Yewv07fHC/fBcBZyZR/uQhDrh2fL4VbXlsmlUVcCjWTm3ZIgOU7WXFRIhZ4JwlvWWlAWjjl6YSwkqcmMF165ATwz+XAQiT12LMxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3p/5/XO1UifNCWZ2bzKhz17qCNaC8XyN4A4E/ceb3A=;
 b=X8cyPQ25Brv2nijFt3WeEoHaJr8bWsbS55cVv7zhMjvoil3oy0bluzmDeiflwEG1zKJ2ti/ELfa2CpawyLvqtkMVOMn91lnkSX6A+f0AYWDT1RkCMU3FpPkBWg0h3OulPOa7MTEJqwG8mkz3blPBMV4RNYW9RtaSxioR5KGuCeNV5f9lX26Lv1m8ORFjaHiSjqfFVccfh1YGBBcOHP/qwmmzpocOiT9t8HneN9tmZY8Ao3POAHm0ZdqTAM1HTFs+wkntBOoUqoWcGPPkEPJAMpdZMGOR+cJ0szJe4xff/awO8G+z7UX0nP/bZhvrUktLY+UjQIi3/P9uP5KLYpALYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3p/5/XO1UifNCWZ2bzKhz17qCNaC8XyN4A4E/ceb3A=;
 b=MRpmb1iSCS/roAOt0tyyGG6hMBynMT+hjPa1xpWhMhT+mliJRR5LIO6STvU5GE3g+xYOgAdck4pIEuLkMwPD26PsGk1rxSinRSHvrXJWOCXBXHEi3jPLghWVl+IdRZlIbCZvkIkK6dapKSlv7srFm0nilUxe/CoJmRws4V3DSB8=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 18:49:32 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 18:49:31 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Thread-Topic: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Thread-Index: AQHW5RRdvx5wNEjZQUmrFuppzeixTaociRaAgAAGIgCAAXKlgIAAEfmA
Date:   Fri, 8 Jan 2021 18:49:31 +0000
Message-ID: <891f7cb8-7ece-6442-e6eb-c1b2b962e4ae@synopsys.com>
References: <20210107164400.17904-1-pmladek@suse.com>
 <20210107164400.17904-2-pmladek@suse.com> <X/deF3U+LK5YCQT3@kroah.com>
 <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
 <X/iaJw1JKRRGcoX9@alley>
In-Reply-To: <X/iaJw1JKRRGcoX9@alley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4596cb6-ef89-4937-9140-08d8b40622cd
x-ms-traffictypediagnostic: BYAPR12MB3207:
x-microsoft-antispam-prvs: <BYAPR12MB3207F292C0D6B6CC9C345842B6AE0@BYAPR12MB3207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bcr9Bb+UpDF1WXah0V6bs91Kvw9oNipGoWexganOyTPfTi4c78ksxxc+BOFK6/KyvxnJyggqQ8rL975y5vK81qNlh8yHutJ7/+8XInl4F8D+5FWgX7EWlWBQJ81gCwGlZ4n8sSI1LDGwK5pKaTWo/JNC46T6yfaRjV4COjxo2iN7po8r6PGsbVPxP7cKDEM3PGOm2OvGOGMOPOrlD58JfxuHHpKJKj2A+0oK3Xi9RiIXfurHoMvi6y/P0a1BnWVOVCozEJe3C7nW+EsqBy1Oq43vP1zeWjH1/dBTRHNqDFumBYMWuzIrY9caLs4lw/cKLNh4yTURfXwF/YYpcr6FokO7frk5Mg8Wyb9pR4J9TfVc3tSKox6nwyTpYazlB9Atp7Do+FqRaHii2gR9uKlk10HT6ht/swPOiKFc5hvpk8t3KbJORZhcqltnOdeuN5OBhOcjsQo54T0/lTMzRE/4EtQHbAUch935p3rufU8s7vDlqKdhV0cgGR/JYuJKHDeb0gRKH4swBMAeWSC7/ZvhEkVaF+veoY+4iCTPBr37wviCuSrhaETA5sVbCV0XqZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(6486002)(478600001)(966005)(31686004)(36756003)(6506007)(2906002)(8676002)(66556008)(186003)(53546011)(66946007)(110136005)(5660300002)(316002)(54906003)(2616005)(4326008)(26005)(7416002)(31696002)(66446008)(66476007)(64756008)(86362001)(83380400001)(6512007)(76116006)(8936002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0l4NkY5YWd5OWNPcmtrcWhVRzNJb2kxbmFXMkZ4L1lRNE93aFIxbU95Qmk3?=
 =?utf-8?B?ci9mRHVKZFpQTGxmWGlLRE5WY1hiRVRDZmU2b1U3T05ENTlCbHFsMEcvUXF2?=
 =?utf-8?B?eTVPZVc1cno5UWFXUlBNOVdRUWFOaFZjOWZVb3dVbEdGTWZVUExYc3c2bnF6?=
 =?utf-8?B?MFBPeVBORmlOZmZFSHh2QWppc28zekhWSldqWTIrMXVZRmNkUTZrL0Fpb3JL?=
 =?utf-8?B?aTJkRDR5VU1IbklGTmNKbkkxS1VleEhQSkJpeWhtdGY3eXZPTU9vdDVMNVJ0?=
 =?utf-8?B?blFBMytEUUtlTjFzYTVtY21VN0JzNWtNMFY5SHlqOGZMbllEMSsvaWwxSVg2?=
 =?utf-8?B?c0x1R0NxYnhYcHUxNDdiYmhvVEsyUlRVUDU5VGtOOXVNWDlWUVUxbjBYQXJY?=
 =?utf-8?B?b1lidlFkYTA0NG1qU0o5bTE2NWtXQlNob1cvY25sUldHTWlUSUJiNk1xODhX?=
 =?utf-8?B?THJaMXZEcHhIL3JiOWt6S3JyVGZrNlFhaDM4R3FUUFBEME9MUWNad2paZjJW?=
 =?utf-8?B?NERjc1o4L3lRWVROSWVDZmVYd0o3NWsybEFJaFFMMHo5UDVWK0lCSmlMV21s?=
 =?utf-8?B?Q1VYaEN1cS8wZDBseU8xQ1ZaM0xRdnpua3Z0QkF2NUlpZk52R1ZqeVlNa0hL?=
 =?utf-8?B?UWFNUnR6TEJ4R2lxZUZobWNFRUpWRU1VM1VBanFVdnJtQXZIZDV1S21kSnRQ?=
 =?utf-8?B?UHpvejcwbXlIeFByc0FHT1IwcEFySlpxazZ5d1pBU1h6bHRIWUFZQjMyRmR5?=
 =?utf-8?B?bzE5SzJhWGw1T05pbnk1aTRuSE5tSTBQNGJEM2k5Q0xlRlNFc0p6aGlFTVNn?=
 =?utf-8?B?S3U5MkxmMnZ5dEZlRXpRRXJFUTVndUJ6UW9xWHR2WlpuSythVGdMdVlzelYz?=
 =?utf-8?B?RUxXUHRxQmlxWHFpL3RVV1hrTUZPNEppMzFpa0J3SnV3eW5iTlhCUk9CZXJP?=
 =?utf-8?B?WmJTZkNhZFljb1ZHYWdtc0JEU3g2RU4zamRZcGppSlhUZ3lTQUpRQThBZW9D?=
 =?utf-8?B?V3Zoc3Azc00xZXJPcFlwVHdzZGxWOHp6QkZENXZmdjdvaW1PZXB1c3FXbElN?=
 =?utf-8?B?bmlONmJ0SlBIWkJpOW9CRzdwbjF4bGJFZHdsY0RGNmpoc29BOThyNmEyRGo1?=
 =?utf-8?B?eTFmakp2Qi82eDRBV3k1S3F0ZjRjdnFTcy9jeWlFN04zTTNEdHVkbkRiN1NS?=
 =?utf-8?B?RU1zT0liOFBveEtHdUsyM3J4OGp0YTV1TjlwMkYrczI1Z054cU9wcGdqSFJx?=
 =?utf-8?B?RWZYYjg4YUp3TWtMV3J2blhYOHQ1eTVNQTNHb3lGdGlNT3phaEd2dEd3eUI2?=
 =?utf-8?Q?OoZr0P0hXDbQo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E2CC6583939754180101487F6554C58@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4596cb6-ef89-4937-9140-08d8b40622cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 18:49:31.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpldxMRTeiC3dd9lXaE7N0qypFeDcpSNES07krIOhn3bGLNslUdxnHpBcrl4YtU3iXEKx/3RsMyawgLuiyCJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS84LzIxIDk6NDUgQU0sIFBldHIgTWxhZGVrIHdyb3RlOg0KPiBPbiBUaHUgMjAyMS0wMS0w
NyAxMTozODozNiwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+PiBPbiBUaHUsIEphbiA3LCAyMDIx
IGF0IDExOjE1IEFNIEdyZWcgS3JvYWgtSGFydG1hbg0KPj4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiB3cm90ZToNCj4+PiBMaW51cywgY2FuIHlvdSB0YWtlIHRoaXMgZGlyZWN0bHksIG9y
IGlzIHRoaXMgZ29pbmcgdGhyb3VnaCBzb21lIG90aGVyDQo+Pj4gdHJlZT8NCj4+IEkgd2FzIF9h
c3N1bWluZ18gdGhhdCBJJ2QgZ2V0IGl0IHRocm91Z2ggdGhlIG5vcm1hbCBwcmludGsgcHVsbA0K
Pj4gcmVxdWVzdCwgaXQgZG9lc24ndCBzZWVtIHRvIGJlIHRoYXQgdGltaW5nLWNyaXRpY2FsLg0K
Pj4NCj4+IEJ1dCBpZiB0aGVyZSBpcyBub3RoaW5nIGVsc2UgcGVuZGluZywgSSBjYW4gY2VydGFp
bmx5IHRha2UgaXQgZGlyZWN0bHkNCj4+IGFzIHRoYXQgcGF0Y2ggdG9vLg0KPiBUaGlzIGlzIHRo
ZSBvbmx5IHByaW50ay1yZWxhdGVkIGZpeCBhdCB0aGUgbW9tZW50Lg0KPg0KPiBJIGhhdmUganVz
dCBwdXNoZWQgdjIgKHVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UsIHRhZ3MpIGludG8NCj4gcHJpbnRr
L2xpbnV4LmdpdCBmb3IgbGludXgtbmV4dC4gSXQgaXMgdGhlIHBhdGNoIHNlbnQgYXMNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MTAxMDgxMTQ4NDcuMjM0NjktMS1wbWxhZGVrQHN1c2UuY29tL19fOyEhQTRGMlI5R19wZyFQM24x
eHlBbDE1Ni05R3hzOFMta182b2JZcS1YalhZWVdlMV95R1lMVW1DRlJmVTdzcWpCcTRYRTF3dVpv
aVpOJA0KPg0KPiBGZWVsIGZyZWUgdG8gcHVzaCB2MiBkaXJlY3RseS4gT3IgSSB3aWxsIGNyZWF0
ZSBwdWxsIHJlcXVlc3QgdGhlDQo+IGZvbGxvd2luZyB3ZWVrIGFmdGVyIGl0IHNwZW5kcyBmZXcg
ZGF5cyBpbiBsaW51eC1uZXh0Lg0KDQpQbGVhc2UgaGF2ZSBpdCB1cHN0cmVhbSBpbiB0aGUgdXBj
b21pbmcgcmMgc2luY2UgdGhpcyBhZmZlY3RzIEFSQyBib290aW5nLg0KDQotVmluZWV0DQo=
