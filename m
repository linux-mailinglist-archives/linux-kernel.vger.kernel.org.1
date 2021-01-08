Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577E82EFAD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAHWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:05:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37664 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbhAHWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:05:32 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BABA3404AE;
        Fri,  8 Jan 2021 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610143471; bh=guaqM/5Hqze97vqt8VcPd6BgQMUSUd9s//9SJOMtB9E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=A/RryGtOLh2mrO2XGVSSrQq1dl8O4nTyfhDsIGYAoYKPSbo0gsqRmdvqfBAxSGX8q
         QsnSf+rCWlLQJnG6T8Aoxh4fqM63d1rSbRSsYf68hrXp42YEpXU3BzH72icQEV07ou
         /EynJ8R5VC/kRI6gtWc3AR53ItHGjB8AZxNPYy46c5G/r5oF30l21u8tvsVBVbG0rU
         RX8Ywi7MX+9UjX7rjPjnNOWgyldC39XdBF9AF3XQMov3lSQwny4AGCsPkg0lbz279R
         q4W0kyRJebgT7CHokxuCTZs+6WootMv8xWkWBpHLnunwKwWiNr4VgRxMSq0eyl2mu6
         RaajfyuWwWvTg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2C4C1A0082;
        Fri,  8 Jan 2021 22:04:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1BFC9400B9;
        Fri,  8 Jan 2021 22:04:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uxPj8+CZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV9i4IWD4P89xxb+UBYpMdOm+EgpLzQe1jghNgRxl822fShGrw1Aj+3iZfWtEYTH6NQvcVS/rw52FpZtzTmpDKUT97mqDYEiiZDm8sqT4Pa4LHeFj9XqnzThInA82n6kJFE91AdYDUNBHDpeFj5Ojki5UuOR6dW5J9P1x3CuZ9iyvW5tn4Fpln4QxVAtAJQ/7JFNThyjdR08tpODEhbJaz2danRWr7Yva+bki5jnLwCKCry02M8PYT15lFB9+CRu1qaHhFfLxNEOXj0pbR9v3piVImc9VNVF8d2UYGITXOhZCeBokbHAFTquGI6ybD7/X9997Cx2X3Fu7cOVC3+9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guaqM/5Hqze97vqt8VcPd6BgQMUSUd9s//9SJOMtB9E=;
 b=cufL5S4q7y7cGdEgLhXtxq/wQbtncHO4uqOUNj+SpYWptQ64PPKropfNcp14s6SZXWoa1Zkh1M2uB6B63DEySWRZlyvPiP4u+Sh4x1aVrji5nQiTJS7UDzyNZwiu1dLckp/ItygeKjhbyhJrdLPvZkZWqDBIBOGpIqswmZoZmZsPiolgG2RsWAZVDOPj8YQVG8HSfdT5Xfv+TKLb2cpkbhzMRRFKsMQ+Nu8enqG2z/H9xIRsx8K46Lw9xozdJRdCNXWih11xr5KQ450eKTnHunHowSj08ErdIfmfQRBpmI9gPWg4DNsGMDMTPgZGO3dyL0S/jpYz7zQetiFdrwpp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guaqM/5Hqze97vqt8VcPd6BgQMUSUd9s//9SJOMtB9E=;
 b=uxPj8+CZNWqm/np6MMec7ZQP9okWxC/HKi5xuO+1SJecmsf+umYVPjFWkvCZLnJKEi4wO/5BytpdHiaa7b/TDBgdbv9ZTuYL5XvNUsKbkq0vn1u5bPrO3o6/RHTZT0AX776CTUZs0dwJI875asoAEMHbI6N5OrreeOysH+frBG4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2903.namprd12.prod.outlook.com (2603:10b6:a03:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 22:04:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 22:04:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Topic: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Index: AQHW3jcavZZjl2yfjUafWGuOXYrMeaoZDPEAgAQAA4CAAGkygIAA4eAA
Date:   Fri, 8 Jan 2021 22:04:27 +0000
Message-ID: <3973a6ef-ef5f-3ba6-c2a3-76fb9a24165e@synopsys.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
 <87k0srcyq7.fsf@kernel.org>
 <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
 <20210108083559.GD31406@jackp-linux.qualcomm.com>
In-Reply-To: <20210108083559.GD31406@jackp-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c41919e-e158-4d1a-dd3c-08d8b4215dd3
x-ms-traffictypediagnostic: BYAPR12MB2903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2903362F352438877045D109AAAE0@BYAPR12MB2903.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYFDfcBuzX0jaKmN/FgS97MZ/WJRygGXXwvkL8TyqB01mnsAzsiY3AS12Jen0TqLarG42DU6xTSWTLD3PE/pcLGUAJOpex2vZ5ddrRlLO6dVPPnDl/buK8HnO1xP6J/l5FbCRLjmUAQbAxAe6Mjgmy1ljFKkckvzFuHHA8zb+RwIvlcyMF9/LwpJC0KLwoKULdHzXi+j5GeZJMEt69NugIm1qymE8iT8hd/MR5BBjjqeq0cam9ZfLMImtUe+1BUNllk0eSw3diQhK7N/Sx2n65a9o0Z7gLbfAs7sAR5NJKmkfJQgMiC43hwu2iGUXU+ukLp0WUYMEGJhjja5dSQUfywYgxUBcAaGg3HQtjNmfeTDRbr3cCjQee3Z23CE3/b6L9MkK0NIj516ZwhiLDTSMLX5Z9E58Sk6Em+6c4TkhojX7P+D9ax+GEeS7CMDBj6DksqBOqAcHZOD6Weyp7qkwMH0pwYUuyZbCvl3IAYzMPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(366004)(136003)(2616005)(110136005)(31686004)(316002)(4326008)(6506007)(83380400001)(54906003)(76116006)(6512007)(478600001)(31696002)(64756008)(66476007)(36756003)(66446008)(66946007)(6486002)(66556008)(186003)(26005)(8936002)(86362001)(2906002)(71200400001)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SEt1Mmx3Y0dJUEZwSkc0MTFteDg3MGZFSlAwTVo5aUdPYW5KT2lhU0kraUFa?=
 =?utf-8?B?eTRwVXcxY3RQT1JwRjBDMjJuZEhnVUZBNEZzL2lnTEpzTENHcWcwU3l1QTVL?=
 =?utf-8?B?aHRCWXpUYmFXeDV1d3FTM2tuL0VsR25yemlmeU9EeTIwTmFqSmcxb2o4NWVa?=
 =?utf-8?B?dzJUS0xOTXIzbVJKNjFuYzVTa3QraC9wMWdkbG9tS0lnRFVaczQ0SGkwREZJ?=
 =?utf-8?B?Q3BVNzk0ekpNV1lwRWNvRjFZSlMyWkc4R1lTdENGUWd1UkZCdUwrbm5PcUNO?=
 =?utf-8?B?OTV1VHNTVUNJbTFRR1FZYmRPQndPN0ZxNkZISTlvQVUvZmI4RmFJeHlFNHMw?=
 =?utf-8?B?M0FnSzlwa0tGdWg2ZGZuSVU4eE9SNFc5YmlEejQzQWVsSWNkU3dzMEtQYWdk?=
 =?utf-8?B?ekZUajhSUEJVYUhTNDVjVGkvdmFCVmRGZFlIV3ErUHlrMmlPWjNETDhwZ2ov?=
 =?utf-8?B?NlNYdTJUS3FSNTUrdE1TTmFoMkJJK05YUURZZGhTL2M2cVU5MERkdHhPallQ?=
 =?utf-8?B?WVNnWVJrS0M1dk0xbTJZa2VVL1lqd21iQkxJcVhMM2Y2N3NrZnI3VzY1djQw?=
 =?utf-8?B?SXJLWTJSUVkwMG5HUmovZzlJQ3Jlb0s1cXg3aTZKSm1JVFNZeHRqT1BRck5n?=
 =?utf-8?B?TVVHWEVteUVCUlBJbEhPKzIzRUpIVkNRRjdxQmxFVi9PeTNTcFhVS2MrbzZw?=
 =?utf-8?B?QXJtZHluWm9VUHlhbFduZWFIemlqMlk3OG56TVRSa0E2UzY4dXY5YXN3dG54?=
 =?utf-8?B?aVhvNGFWTC9BZ2paZk1wSFFzbC9pS29XQlpBekl4YnJDNFU3V24yaTNzNDZk?=
 =?utf-8?B?TUlacllhTDBHaGU5aEpEWmFjaGZHM0VCcHdFaWRUNTJuWUI3UlB6SWtQd1R2?=
 =?utf-8?B?RlhHYWN1Z0NsRkpEK2lnWjc3UDYxbXJBdmxDS2I0YjlhaGQzRG9BSDNWSU9D?=
 =?utf-8?B?UEtQZmpjMjlUQmpBMjMrUmoxS0w4bGZ4T0lhR0J6YzdzdkhaTEozZThwRmpo?=
 =?utf-8?B?UGt2d0tpUkNsSWZVSWlUeDkyekVqOFgxSUZSWE5VY2FtUHM5czF0ZmVyWjQw?=
 =?utf-8?B?b3dCcEZyeXRVWXNLUUM3TjRQd1MxWVRtcG9tZ0R4RmVMaVNBNFAxZnlaMkdx?=
 =?utf-8?B?ZVc5TzY2Vyt3b09XSGQyUlBESkZTU3ZDS0VnZHZOcFFGcGtFRW5lVUN1amJR?=
 =?utf-8?B?eDFLWWlLbUl3U04rMnA2dnpoaTVOZjhLek94R0tWRDM1c2tpMjhyUEJreG1u?=
 =?utf-8?B?Wnl3Vk9sSlk1OEJUQzVhM3M1dUh4UkV4dFhyYlQ5RjYwWnUzYTJvaW5DMVRm?=
 =?utf-8?Q?PNCfH1sUOf8UM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C4A7C4237E0114FB89559DF0D610811@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c41919e-e158-4d1a-dd3c-08d8b4215dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 22:04:27.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+sNl9ROuyKav4vpL1HukN5jfbIqnhrWLSJSlUtIT4ACDLjBbP+XwEGdFR+U1LnyI2zq5VKZO5wUR5PRznyxvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmFjayBQaGFtIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4NCj4gT24gRnJpLCBKYW4gMDgsIDIwMjEg
YXQgMDI6MTk6MzBBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gSGkgV2VzbGV5LA0K
Pj4NCj4+IEZlbGlwZSBCYWxiaSB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+IFdlc2xleSBDaGVu
ZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPiB3cml0ZXM6DQo+Pj4+ICt2b2lkIGNvbXBvc2l0ZV9y
ZXNldChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPj4+PiArew0KPj4+PiArCS8qDQo+Pj4+
ICsJICogU2VjdGlvbiAxLjQuMTMgU3RhbmRhcmQgRG93bnN0cmVhbSBQb3J0IG9mIHRoZSBVU0Ig
YmF0dGVyeSBjaGFyZ2luZw0KPj4+PiArCSAqIHNwZWNpZmljYXRpb24gdjEuMiBzdGF0ZXMgdGhh
dCBhIGRldmljZSBjb25uZWN0ZWQgb24gYSBTRFAgc2hhbGwgb25seQ0KPj4+PiArCSAqIGRyYXcg
YXQgbWF4IDEwMG1BIHdoaWxlIGluIGEgY29ubmVjdGVkLCBidXQgdW5jb25maWd1cmVkIHN0YXRl
Lg0KPj4+IFRoZSByZXF1aXJlbWVudHMgYXJlIGRpZmZlcmVudCwgdGhvdWdoLiBJIHRoaW5rIE9U
RyBzcGVjIGhhcyBzb21lIGV4dHJhDQo+Pj4gcmVxdWlyZW1lbnRzIHdoZXJlIG9ubHkgOG1BIGNh
biBiZSBkcmF3biBtYXguIFlvdSBuZWVkIHRvIGNoZWNrIGZvciB0aGUNCj4+PiBvdGcgZmxhZy4g
TW9yZW92ZXIsIFVTQjMrIHNwZWMgaGFzIHVuaXRzIG9mIDE1MG1BIG1lYW5pbmcgdGhlIGRldmlj
ZQ0KPj4+IGNhbid0IGRyYXcgMTAwbUEgKElJUkMpLg0KPj4+DQo+PiBXZSBzZWUgaXNzdWUgd2l0
aCB0aGlzIHBhdGNoIHNlcmllcy4gRm9yIG91ciBkZXZpY2UgcnVubmluZyBhdCBTU1AsIHRoZQ0K
Pj4gZGV2aWNlIGNvdWxkbid0IHJlY292ZXIgZnJvbSBhIHBvcnQgcmVzZXQgYW5kIHJlbWFpbmVk
IGluIGVTUy5JbmFjdGl2ZQ0KPj4gc3RhdGUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgaXMg
YWxyZWFkeSBpbiBHcmVnJ3MgdXNiLXRlc3RpbmcuIFBsZWFzZSByZXZpZXcgYW5kDQo+PiBoZWxw
IGZpeCBpdC4NCj4+DQo+PiBXZSBjYW4gc2VlIHRoZSBmYWlsdXJlIG9uY2UgdGhlIHBhdGNoICJ1
c2I6IGdhZGdldDogY29uZmlnZnM6IEFkZCBhDQo+PiBzcGVjaWZpYyBjb25maWdGUyByZXNldCBj
YWxsYmFjayIgaXMgaW50cm9kdWNlZC4NCj4gSG1tLiBEb2VzIHlvdXIgZGV2aWNlIHVzZSBhIGxl
Z2FjeSBVU0IyIFBIWSAobm90IGdlbmVyaWMgUEhZKSBkcml2ZXIsDQo+IGFuZCBkb2VzIGl0IGlt
cGxlbWVudCB0aGUgdXNiX3BoeV9zZXRfcG93ZXIoKSBjYWxsYmFjaz8gQmVjYXVzZQ0KPiBvdGhl
cndpc2UgdGhpcyBuZXcgY29uZmlnZnNfY29tcG9zaXRlX3Jlc2V0KCkgY2FsbGJhY2sgd291bGQg
bm90IGhhdmUNCj4gY2hhbmdlZCBmcm9tIHRoZSBvcmlnaW5hbCBiZWhhdmlvciBzaW5jZSB0aGUg
bmV3bHkgaW50cm9kdWNlZCAoaW4gcGF0Y2gNCj4gMS8zKSBkd2MzX2dhZGdldF92YnVzX2RyYXco
KSBjYWxsYmFjayB3b3VsZCBzaW1wbHkgYmUgYSBuby1vcCBpZg0KPiBkd2MtPnVzYjJfcGh5IGlz
IG5vdCBwcmVzZW50Lg0KPg0KPiBJZiBpdCBkb2VzIHR1cm4gb3V0IHRvIGJlIHNvbWV0aGluZyB3
aXRoIHlvdXIgUEhZIGRyaXZlcidzIHNldF9wb3dlcigpLA0KPiBpdCdzIHN0aWxsIHB1enpsaW5n
IHNpbmNlIGl0J3MgZGlyZWN0ZWQgdG8gb25seSB0aGUgdXNiMl9waHksIHNvIEknbQ0KPiBjdXJp
b3VzIGhvdyB0ZWxsaW5nIGl0IHRvIGRyYXcgMTAwbUEgY291bGQgYWZmZWN0IFNTUCBvcGVyYXRp
b24gYXQgYWxsLg0KPg0KPiBUaGFua3MsDQo+IEphY2sNCg0KU28sIEkgcmFuIHNvbWUgbW9yZSB0
ZXN0cy4gSXQgc2VlbXMgbGlrZSB0aGlzIG5ldyBjaGFuZ2UgYWZmZWN0cyBzb21lDQp0aW1pbmcg
aW4gbXkgc2V0dXAgdGhhdCB0cmlnZ2VycyB0aGlzIGZhaWx1cmUuIEkgdHJpZWQgdG8gYWRkIHNv
bWUNCnByaW50b3V0cyB0byBsb29rIGludG8gaXQgZnVydGhlciwgYnV0IHNvbWVob3cgdGhhdCBy
ZWR1Y2VzIHRoZSBmYWlsdXJlDQpyYXRlIHNpZ25pZmljYW50bHkuIFRoaXMgZG9lc24ndCBzZWVt
IHJlbGF0ZWQgdG8gcG93ZXIgZHJhd2luZyBhcyBpdA0KZG9lc24ndCB1cGRhdGUgdXNiMl9waHkg
Zm9yIFNTUCBhcyB5b3Ugc2FpZC4NCg0KQWZ0ZXIgc3dpdGNoaW5nIG15IEhXIHNldHVwLCB0aGUg
cHJvYmxlbSBzZWVtcyB0byBnbyBhd2F5LiBJIGd1ZXNzIHdlDQpjYW4gaWdub3JlIHRoaXMgc2lu
Y2UgdGhlIGNvZGUgcGF0aCBsb29rcyB0byBiZSB0aGUgc2FtZSBhcyBwcmV2aW91cy4NCg0KQlIs
DQpUaGluaA0K
