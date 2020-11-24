Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F222C1A41
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKXAw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:52:29 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55430 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgKXAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:52:28 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4B655C0978;
        Tue, 24 Nov 2020 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1606179148; bh=Cj/fR8fXnKfYiSuIoKJYkAiCE2dctkS28hle+VBha1A=;
        h=From:To:CC:Subject:Date:From;
        b=N4ykXx6UbYHmF0Xdtwc6PM2rIUb2pN439RhX3wZOYWQKFBgCjWQYFoYu1NQFtiSOo
         msKbGIkHIcXcGFMxcLawpFRhCbASXMMvI7d260HfuUREOxOVPiPWdjt8wYLEuvn/AY
         881TJ2uZGfXJmvSgG1x0onHgEJcXn+S4mA1fJMBwqkWz+tHYiQzVGnBGWv/C+UdOzQ
         DvaYCYYn7US6lMApD/FQHvw6QPuGrPlZdEw0lUyz05RSs3vAq5cB0U3NDCVdJusP8d
         pSQ784SZBpw4WGsDD6sn9HfrVHLPH9bl1yEUPWiPotSparMF+Uc0tTwT4aay/72oYy
         cAwg9NBAzA5+g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3C00CA0071;
        Tue, 24 Nov 2020 00:52:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6A13340095;
        Tue, 24 Nov 2020 00:52:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Poix/JBx";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4GEmVOQ+bIDHpVE+rWCsi8jyYb+ukw6kUqQHhL2wRMr+12GNb46hP1dWD6UmFgDRIes8XIPRSrWwXe7CEQwdjxLxj4vJHRIAqj1rO6ZMF0eizIKnqDJVinm2rrAXt9xqkfF1k+tEfRGpbjSpWUMbSwBevtOyd5y++hb5LZIXEaAgnXPu76thK1lbY0yDMcm/n9MJrBlIMdfAhaJCsUGuIJp1VAP9D7EkyO3BaCqbEKf8p57mACqqjpSPPcZbgIQg6PAitQpvgqOfWC1UBFZsNPyld+HL/ZnlLYYd5wvLLk50awRvUsjhAiSf/VABNTYCVNCXdKPMsbpqzDWGzi+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj/fR8fXnKfYiSuIoKJYkAiCE2dctkS28hle+VBha1A=;
 b=V6d9jfopMQD13Mj6Y3THrV/ZAHLuOxUGONkFlccbHtgp/BZqsNOGnEoSOvUajIs9EWSHW21oGAihOi7O7vh5hdNBFiWBXanctG8xxFlz9IyoL2R6sMcV+TN5Z4P6BQ51m46Bom7hq/fCGaoqdfIb+CUAhRmc78nhu7euH9wDi9z6gTU4vWD8ngjDEmDqJerYAU2B76jLZDf/TqQYGxXB8ZgWAV1JIXaj7UcDwEtaVkWTbpV9Zl6KJy11lI0ta4EIsgBn3YVRcC86VXcHv6swrOsuT93r08oDTh9USa8lVKn5HmbdR5mCjwdgRmxgLV0Lv66dqWq1EJoWiaF6ioi9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj/fR8fXnKfYiSuIoKJYkAiCE2dctkS28hle+VBha1A=;
 b=Poix/JBxqIwnE7hURHXAXwPEjvQ+jCsJSnIsn41cgxN6Hs5T7fRznXIJgr0cYjOhb8isWc8qAunOqsTD7jjXcZYebHbVwfBDcDC0LFdYMEst3uUn794njKUmERo0ykpL7UaffW43uq2pi6sVFYauvcSWllXHi+0azpbbZZBROxk=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3352.namprd12.prod.outlook.com (2603:10b6:a03:a8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Tue, 24 Nov
 2020 00:52:20 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 00:52:20 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [GIT PULL] ARC fixes for 5.10-rc6
Thread-Topic: [GIT PULL] ARC fixes for 5.10-rc6
Thread-Index: AQHWwfwQ0P+F/mr09UuieSUiYg1DhA==
Date:   Tue, 24 Nov 2020 00:52:20 +0000
Message-ID: <e02b2e57-720a-758a-bea9-1d9c03fba539@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9cbbd1c-f423-4114-4a31-08d8901332d2
x-ms-traffictypediagnostic: BYAPR12MB3352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB335280968A59617599ECFE5BB6FB0@BYAPR12MB3352.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ks32VsPrQqRG+XyQ1rZEazya7KYbSCKF1qPspZss8RtYRuw+OOSWCjHhuQ+L/bIOJjh4iVkxvvV0cXoM1XGMZQNzmFhVzlh3CcDHEArWYhqMuoqZawxKF5o5vQWTfvQTVmyICpa+leAGGqWXPApa69YQDkjSbkbx/Pyckt4mgveDmWK6dSBViq21l2lrJNm4iku3E7ZtbJw/PWt36fHZYOqnfJSyBt+630PshSM53P6oTJ+3Q8c1rd5pL6XAvisnBUZQL1EaTONknOgDfZnO6zkS5rp2zeDW/DJgGS1lp+XI2T9sykZP5YnbvqzGuCUZmZNlc1QTG+HY1WwGbZeXRBPy0xuK9K+qTteRQ+pOWysa9UoxqAhgSjpiFSQoWtB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(66446008)(316002)(64756008)(66556008)(31686004)(36756003)(4326008)(76116006)(31696002)(86362001)(186003)(71200400001)(478600001)(6512007)(2616005)(26005)(5660300002)(8676002)(66946007)(66476007)(4001150100001)(6916009)(2906002)(8936002)(83380400001)(54906003)(6486002)(6506007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Fa3JfdbvuOBolNCGYMuaPFbo7uv6aOvImtl6wFd/y8S6aa0cip4fzoJ1vg0vRWEPQTqzMGFmGqppGz/yu4QHFsY9mDG1FNpJwOSjzRB6D5jGzXHWAcsV+NFfyQqnO8lMmxXhCi4b7agJFqFH41WAe2uxcW1Y1nUCV3iQr8rTy6k+ta94gIKqnyT2lZMKU62l6V61NBq8bxs+Y8gEStaBdhjz6eWsq8G2LbT3yySO5A1Nt4U5qhbCH0e9wDhV34MyLeU9GjpU7tmTtDNqwfGl9kYDDTJVplWKtji8wgfKuQYrxKZUx09wITxHbzxSCKZCmqqitL0AsGuIka4x2BST7/AObduUD5U7Ai5vqvoA8jK0oUT+cDlEPoJhdyydxJGuL42OKgwJnBpYQgFaMpM+tJ3hoVbc506t/iZMcvu01Mqf49TrB3DHKsI0dCZrNTutS5Ddegy9CIGpMvLyXY6OYzCJyCGcF+5aIo0eMQ42/8QKmaNcK2PpWdLd3nxgxk6IRSw/vgGI2WhTeB7FudfrgFfupFONMjctn0jAl0FRbpeZn19nwD3N3CtgsNMXTD+JtDq/qeqQEGGnJyN0s7RZVGmBR0kKbvg1Echm38vbsJRlZTeTQc/Hujxqv9+ICBy8GJpXR93HnuUoS6Ki/gDqUV61TSKxfS09Qay97Txmv0k17mYfHGREj5Q5C0CsPslBDwUqvlpw1ZdBS/Sy0eFP+YgAxiLxp7R2/VkIa9MPdn0bMW6PFr2f5074x4mFDoaLT7MtLOLy9yqtmU0aHN5+8BgBMMlnpoJZJCWQM0OVZUNljdOeKn3bVe/x9/kN6q47TS7gC0qtTa3EDqZQVhMEOvji+HnLGDPkCM6lU4wB32zSdn3zy6/XRB5LfrG+lbe2K9oCOX1keTtOWj2dr6lyFw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CA2B7D5A7273240B92EF562036E7B4F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cbbd1c-f423-4114-4a31-08d8901332d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 00:52:20.3226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLgeJsE3O4w1pk31eAxwXhpXbm5I1NT9r78FqCjEi9q+bz8UtLR1EHNs6FZOR0weHBY5cFonszO1vq13DRNjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkEgY291cGxlIG1vcmUgc3RhY2sgdW53aW5kZXIgcmVsYXRlZCBmaXhlcy4g
UGxlYXNlIHB1bGwgIQ0KDQpUaHgsDQotVmluZWV0DQotLS0tLS0tLS0tLS0tLS0+DQpUaGUgZm9s
bG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDNiNTc1MzNiNDYwYzhkYzIyYTQzMjY4NGI3ZThk
MjI1NzFmMzRkMmU6DQoNCiAgIEFSQzogW3BsYXQtaHNka10gUmVtYXAgQ0NNcyBzdXBlciBlYXJs
eSBpbiBhc20gYm9vdCB0cmFtcG9saW5lIA0KKDIwMjAtMTEtMDIgMTE6NDU6MDkgLTA4MDApDQoN
CmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogICBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIA0KdGFn
cy9hcmMtNS4xMC1yYzYNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGY3Mzc1NjFj
NzA5NjY3MDEzZDgzMjMxNmRkMzE5OGE3ZmUzZDEyNjA6DQoNCiAgIEFSQzogc3RhY2sgdW53aW5k
aW5nOiByZW9yZ2FuaXplIGhvdyBpbml0aWFsIHJlZ2lzdGVyIHN0YXRlIHNldHVwIA0KKDIwMjAt
MTEtMTcgMjA6MTI6MDEgLTA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFSQyBmaXhlcyBmb3IgNS4xMC1yYzYN
Cg0KICAtIE1vcmUgc3RhY2sgdW53aW5kaW5nIHVwZGF0ZXMNCg0KICAtIE1pc2NsbCBtaW5vciBm
aXhlcw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpGbGF2aW8gU3VsaWdvaSAoMSk6DQogICAgICAgQVJDOiBtbTogZml4
IHNwZWxsaW5nIG1pc3Rha2VzDQoNCkd1c3Rhdm8gUGltZW50ZWwgKDEpOg0KICAgICAgIEFSQzog
Yml0b3BzOiBSZW1vdmUgdW5lY2Vzc2FyeSBvcGVyYXRpb24gYW5kIHZhbHVlDQoNClZpbmVldCBH
dXB0YSAoMik6DQogICAgICAgQVJDOiBzdGFjayB1bndpbmRpbmc6IGRvbid0IGFzc3VtZSBub24t
Y3VycmVudCB0YXNrIGlzIHNsZWVwaW5nDQogICAgICAgQVJDOiBzdGFjayB1bndpbmRpbmc6IHJl
b3JnYW5pemUgaG93IGluaXRpYWwgcmVnaXN0ZXIgc3RhdGUgc2V0dXANCg0KICBhcmNoL2FyYy9p
bmNsdWRlL2FzbS9iaXRvcHMuaCB8ICA0ICstLS0NCiAgYXJjaC9hcmMva2VybmVsL3N0YWNrdHJh
Y2UuYyAgfCA1NiANCisrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0N
CiAgYXJjaC9hcmMvbW0vdGxiLmMgICAgICAgICAgICAgfCAyNCArKysrKysrKystLS0tLS0tLS0t
DQogIDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQo=
