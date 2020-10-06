Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C628447F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgJFEHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:07:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:41220 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgJFEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:07:18 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6A937C033A;
        Tue,  6 Oct 2020 04:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1601957237; bh=onpG1+1rfs2DFjaoqCSy6h/kavcUGdB5nwgYTQ1meHk=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=cqiH1sPqecvams6SYq2vqVMyXs0oOAbkFbz0GAouE98ogSHfyUa4VHyxExqlAUNUQ
         kIMWjH+bEEYTB2GkbEMdZ55F5WCpBoXDKd9DXT8yZY+iyUtiyxIPpAqML9WkSgl6Ob
         SnyAnymidZfPh4SPtzKYAds2S72bYCyjFHnKWll01xppDTar8ah9w+XYku+iI3F+1g
         v074fnPROCddPYVV5q3rgIRa8PEBck5+vuJVyrv7R66XwOOp4B+CjCt9lwp2NEmEEj
         N/GPLC0JMuJhXLCi0HYkjc66l9/Eeq2x49hsQ4ZxX0CzCfU3Lwu3XwuhTMo3hyx0Xi
         iYB0RsHHOfWpw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7E32AA0096;
        Tue,  6 Oct 2020 04:07:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C77748109C;
        Tue,  6 Oct 2020 04:07:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gHBjCKBW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkiSyq4TMeriOuer0pBedxAPyA5hw0p5DNgxQltHVF4sOmYKa6tFsR29Bya7qbYr5wKVg+8Ec5F7lfab1+0jzcpy6TnzcM4xcdESvlGmShOEUwlF188NKFXpAsO6ennTtw/GgzWV1o6ecZ0DNuDRxpJvi3gVPJXjiW+/c4BVx3AAX1REct7rUAeShyf/x1ieVfTmbAvdDptBScFpgbK7pBbPRELH5l8wQkq8YlnJ/RoaDNVCjQYIjCL7ybOtHlGOisp6a7q9xcAEpa764HUvjXVDD2/jNgVqtcJfI54MPwUPbp9QdsbGml/j3xHizyj/6drMvKBtI6iPzL6HANj78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onpG1+1rfs2DFjaoqCSy6h/kavcUGdB5nwgYTQ1meHk=;
 b=hg/Dvx2wCJT4xU7bc+2YUOYfXvGGnbRgxE67vB7Q46p6nANyove4rsHymrEEwqyTMlGkkOQLOwdag+NvTs0t9gdtwKEKfMN5x+R4+PFzrgz0cNlLvq/geGamOP/ZSwDXDsxwmzeMMAtlxe5SqVvTeVsoklic4ujF1o46bZNAXONL8sQ1eK8fqCBymJ3EWZC0zQvg64R2zCQjIkZVx/xmYpybmdZ/XNnPuJUnmmWgWKndbLxAf6Ww6bu1zEDS3Fz3sQkguB51DuntWOSupGCDHpCG66kF6Edx4T2BWif2Gliu7cMxnsEwBILMKz++9Dui2/DVSsCMv4EacA9nsQJcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onpG1+1rfs2DFjaoqCSy6h/kavcUGdB5nwgYTQ1meHk=;
 b=gHBjCKBWnGjfZfZduTFGuQfAiF5DnE0cW9CZh1c8KjeQrCX/fcQE9iGV3Ipdce5V4UhE7JgUQLiS9NyUQ0Lwq5Ce+9vDKNP9qLl8oRp4LvulFJSK7uEeqQ2y2gjTK8aaQtO1GkgP1j0SsoOOCg4NvUVzjVj19JxcSE0TMfoRmlc=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 04:07:11 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8%5]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 04:07:11 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] arc: include/asm: fix typos of "themselves"
Thread-Topic: [PATCH] arc: include/asm: fix typos of "themselves"
Thread-Index: AQHWm5D/doUTYFsBwkuHXQQagIqAmKmJ9TEA
Date:   Tue, 6 Oct 2020 04:07:11 +0000
Message-ID: <6364c89f-8381-c019-d3d7-0abad902e99d@synopsys.com>
References: <610cc0df-deac-e2f6-e9ce-b19b3cba9501@infradead.org>
In-Reply-To: <610cc0df-deac-e2f6-e9ce-b19b3cba9501@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47bf2515-58d5-4e5b-3116-08d869ad4cf3
x-ms-traffictypediagnostic: BY5PR12MB3924:
x-microsoft-antispam-prvs: <BY5PR12MB3924FAA9F2EBC72FEA41E531B60D0@BY5PR12MB3924.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7Oyj+nK+UYuizXYOdxRYdeL8BjjMNQA9ccrPegU1oexwsBadc4AGPmtwPJvwY/I9NiFWAxueBn4QUQTJW9pm4qBN4rF7eXFTeEcYFOYNRxe2E6yyWhxBLUkKmh/+WVvQuc6gOIkbcR5GUy4nNImGxPLGLT2UurY5O+ZNFKCmdk5pH3KP3ThgV04tGpU3nzO0k8sWwKl9hYgePGqyFd3LKSvXDaVpbH+/nvU2VHnfY4ESTDB+uCcHEwjvTbh+NdQ4v9vXBMdiIckkmNkqq/7okyFN4GiF1GmCzSinVs4jbd+ObzF8vI6YqgGXksytrASQU+nMaAQrNzaTy6aelKdm0XHWRUGrME6U+q+bx+8WZoN3YxhdWZWrXEweUeqw3qK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(8676002)(8936002)(2906002)(83380400001)(5660300002)(31696002)(6486002)(71200400001)(31686004)(26005)(2616005)(186003)(76116006)(66556008)(53546011)(64756008)(6512007)(66446008)(66946007)(6506007)(478600001)(66476007)(316002)(36756003)(110136005)(86362001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: biP/onVxm0Iu/n/SbuZVnyhkMteVnEoliY5HO/xETCETqZGxDVTibYXGns0gK6acQqvGiOelT1BH2FTt/0WeHt+rPjbEUwuLs8RowICEa0F86r1Iv88IRDFbUaht4U0qMUFzVaTAa7xWQH3/hUD4yQ8TUftq9QBekGo7Vx/THs99Hpv0gPl/jksizJAMhPE7I3gxvlOvXNbmHHvS68Fu7y22R+1BLcNU8j6yvQ0z9tmIjDz8IjEXTFiTi7nBZrAX3TE/nAQLN5MzQKW+F839aIaPdnfE7y9lL7V0NvT7ZRXvBD7h2TlHCvOEanatSoelwz+3QYk3x2nnhv8nR37/6MIuwf0Luj5y6Q2aOzhN/jlmnDf6zqHdI5ULOFxz/Hxx5E8F0jm3pUfUmSUdThz8EXiXQskXKZFFTdiNk3ioUke0U5o1yRUVKKdg1mqg+DY56bzqYsuEGkPV9n/amHyv6NRORaSs2HrfjzRgWAGjE3/T6CVZDYejFw3Sd8di/xB0J80EllSUqhUVdW5GPp1kSqXOIffkjOPOmyE+mCB+YQLA/vxWi27ZlpARC5Kzgv027mJIXR8V7Aj6uvKcGuRtFgrDeyW5Jw9KKIPX6NJi465cJdb/4qPXz27v9vaBJC4bbr6W6ZoQ1Zx0hLpeRX+T2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E26E1842011B6044B93CAB36E17EBAFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bf2515-58d5-4e5b-3116-08d869ad4cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 04:07:11.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnRi72eI99Nimn8Ri81bRVbtGJpn64Ew5Myb8jvE5sjUvsq9/nR5Tth2D7GMtQwZtErRFkGCZHLuTqLlV1XGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMCA4OjMwIFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IEZyb206IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gRml4IGNvcHkvcGFzdGUgc3BlbGxv
IG9mICJ0aGVtc2VsdmVzIiBpbiAzIHBsYWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5
IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBDYzogVmluZWV0IEd1cHRhIDx2Z3Vw
dGFAc3lub3BzeXMuY29tPg0KPiBDYzogbGludXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KDQpUaHggZm9yIHRoZSBmaXggUmFuZHkuIEFkZGVkIHRvIGZvci1jdXJyLg0KLVZpbmVldA0K
DQo+IC0tLQ0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmggIHwgICAgNCArKy0tDQo+
ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9jbXB4Y2hnLmggfCAgICAyICstDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBsbngtNTkt
cmM3Lm9yaWcvYXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmgNCj4gKysrIGxueC01OS1yYzcv
YXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmgNCj4gQEAgLTQ1LDcgKzQ1LDcgQEAgc3RhdGlj
IGlubGluZSBpbnQgYXRvbWljXyMjb3AjI19yZXR1cm4oaQ0KPiAgCQkJCQkJCQkJXA0KPiAgCS8q
CQkJCQkJCQlcDQo+ICAJICogRXhwbGljaXQgZnVsbCBtZW1vcnkgYmFycmllciBuZWVkZWQgYmVm
b3JlL2FmdGVyIGFzCQlcDQo+IC0JICogTExPQ0svU0NPTkQgdGhtZXNlbHZlcyBkb24ndCBwcm92
aWRlIGFueSBzdWNoIHNlbWFudGljcwlcDQo+ICsJICogTExPQ0svU0NPTkQgdGhlbXNlbHZlcyBk
b24ndCBwcm92aWRlIGFueSBzdWNoIHNlbWFudGljcwlcDQo+ICAJICovCQkJCQkJCQlcDQo+ICAJ
c21wX21iKCk7CQkJCQkJCVwNCj4gIAkJCQkJCQkJCVwNCj4gQEAgLTcxLDcgKzcxLDcgQEAgc3Rh
dGljIGlubGluZSBpbnQgYXRvbWljX2ZldGNoXyMjb3AoaW50DQo+ICAJCQkJCQkJCQlcDQo+ICAJ
LyoJCQkJCQkJCVwNCj4gIAkgKiBFeHBsaWNpdCBmdWxsIG1lbW9yeSBiYXJyaWVyIG5lZWRlZCBi
ZWZvcmUvYWZ0ZXIgYXMJCVwNCj4gLQkgKiBMTE9DSy9TQ09ORCB0aG1lc2VsdmVzIGRvbid0IHBy
b3ZpZGUgYW55IHN1Y2ggc2VtYW50aWNzCVwNCj4gKwkgKiBMTE9DSy9TQ09ORCB0aGVtc2VsdmVz
IGRvbid0IHByb3ZpZGUgYW55IHN1Y2ggc2VtYW50aWNzCVwNCj4gIAkgKi8JCQkJCQkJCVwNCj4g
IAlzbXBfbWIoKTsJCQkJCQkJXA0KPiAgCQkJCQkJCQkJXA0KPiAtLS0gbG54LTU5LXJjNy5vcmln
L2FyY2gvYXJjL2luY2x1ZGUvYXNtL2NtcHhjaGcuaA0KPiArKysgbG54LTU5LXJjNy9hcmNoL2Fy
Yy9pbmNsdWRlL2FzbS9jbXB4Y2hnLmgNCj4gQEAgLTIwLDcgKzIwLDcgQEAgX19jbXB4Y2hnKHZv
bGF0aWxlIHZvaWQgKnB0ciwgdW5zaWduZWQgbA0KPiAgDQo+ICAJLyoNCj4gIAkgKiBFeHBsaWNp
dCBmdWxsIG1lbW9yeSBiYXJyaWVyIG5lZWRlZCBiZWZvcmUvYWZ0ZXIgYXMNCj4gLQkgKiBMTE9D
Sy9TQ09ORCB0aG1lc2VsdmVzIGRvbid0IHByb3ZpZGUgYW55IHN1Y2ggc2VtYW50aWNzDQo+ICsJ
ICogTExPQ0svU0NPTkQgdGhlbXNlbHZlcyBkb24ndCBwcm92aWRlIGFueSBzdWNoIHNlbWFudGlj
cw0KPiAgCSAqLw0KPiAgCXNtcF9tYigpOw0KPiAgDQo+IA0KPiANCg0K
