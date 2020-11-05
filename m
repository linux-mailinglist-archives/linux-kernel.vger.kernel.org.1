Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA72A88B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgKEVNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:13:15 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46822 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729783AbgKEVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:13:15 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B122BC0004;
        Thu,  5 Nov 2020 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604610794; bh=yRHg81NS+tyXOd7fThZxfKJLuL8NmozKUH1DSQivMGc=;
        h=From:To:CC:Subject:Date:From;
        b=jdJyZX2BjLBUys1MHYNEIUBwFaWWEeBwu4RQFJuoPG2eUp4ZRH/SKHioxyd1XHfGz
         /dqAo8froF6kONITHS2PVU7PHdgXBwUavUo+EjCiCEIMEbASr1NvZRmC62nbuyqBAg
         3ZweK/RDqkShPBTrYA/yiLE++NAsDiVE+f5O7xXv5CINlerrYH4DEZsXTsMtL421zv
         ImF9EGgorbDjBZ/NjEdtKibo+Dep8xDuanQ6qJWAC5OMPn3C5//utP+oQR7zBGTJ1Z
         KR+W6OoNVVxUeFy20pHnnFFl5ikv6EIWvdC7BeCm74Cs2VwFFYJlmBZq4Ua+oNlw76
         zByMdmhWpuVMQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7953AA0099;
        Thu,  5 Nov 2020 21:13:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B52654007C;
        Thu,  5 Nov 2020 21:13:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="n0q4MQww";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNWSQdZ0m9zF3+disuwiSnllgZ/0WkV+bDnw9n+aeaoap//RxaTEqSV1ksPWXvZw5neg3z2AxB4jAg9REctzD7t+OBu9Bnts2OqrTZ1tZO2ZOgP3pty/opcxOyBZPIJT0+c1zMC4JiFiUDta/KeDoIj/Mh+sEHsUdSzbCo9zHC2IFA4mhJzDMJzkoRM7pXcPnm3hu1Zv1/KyEMevppCoAMIVLgplhX33L5QPnZeBYHTbpTGOwqv7m6Z9rqg9IwIHojXHUZ0cZ5CtVeEvqFLnmnWKJGUpnWBfQDOJo49B29BDo/qrkfCl8B4Kg56d7gwcxP3qLbniDYXcwslMtqSRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRHg81NS+tyXOd7fThZxfKJLuL8NmozKUH1DSQivMGc=;
 b=J1/CrDeEOv7zVVLsoKAIcywk7NZpH5p5loXC0+zRXdgvYthcyWMfvvfM9fp/3NhTc5xslMqjaobrCAs7wAWPN0cQF/iTHyZOV+9a0Xr59nz3oe01vDcTiJQNB2ihiRNGxUSmKOVyWvoTdbiy/s5WVR+XwiV3JJv6VWDWL47K4FndUmiRN74aJt6Ff+aO+04cIHxgFUFyq17oGe3lnLv1gZEbH2/Qe5cCt88QpdrMdCOu+F32Q2IpECvAlFUZz8da8eUAp8LMnP3Z3D1FqbyELdSaTuKcaP4JsOliit/owo+MtTiJVBAqvVqaiJPE/Bu/I2kqLkeCw71VmX/8LrCuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRHg81NS+tyXOd7fThZxfKJLuL8NmozKUH1DSQivMGc=;
 b=n0q4MQwwdHr+sx/MKy6DAx60tmetdx2XdnBN1Inh0O36QO9k/b6lZPbT2OP1wzhOKJ5IZqGAR6ZZXMm6B+Xw0yZ/mFoZ38Nw20jVo/UlA9jv5s/9ODf5EXVQGcMrxU+q4NJC4PjcuiFT/lwKsiYWFSSDKN5WuJ+a4f/CTbS14r0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 21:13:08 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3541.021; Thu, 5 Nov 2020
 21:13:08 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ARC fixes for 5.10-rc3
Thread-Topic: [GIT PULL] ARC fixes for 5.10-rc3
Thread-Index: AQHWs7h1G0dc/x2bIkaET9K74WJvjw==
Date:   Thu, 5 Nov 2020 21:13:08 +0000
Message-ID: <06d83e19-7850-b6f2-5728-a778392d3e5c@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 0e1e6603-d2a1-484d-ba29-08d881cf9876
x-ms-traffictypediagnostic: BY5PR12MB4209:
x-microsoft-antispam-prvs: <BY5PR12MB4209BB1E7328B990434794B0B6EE0@BY5PR12MB4209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7pNxzoWpuJfA5f1KJ0E3sUXff1TS3Io2kyVyCrDECBCFFF/oz1i+oYNoA4J3FZgh+UX9bVlLcIT+ikDmdKWhMRFfHmmGMA/laWZz89EuBmJCgIIAlGciOuI+RoOwaM12+ZG6j2rTM9E5o1RNupiAMg+QpJni4Cp/LieYhIfpnXFOx421v/ATPdBkOHI4oCiyrJDjiMcKiLh3GAQVlqsYSPhNCCQBMHxwgo9eEW7ql2klyHqRer7yQ+ASFGQx+MQLDgBNq0PbLUI/pV4Dnt9M8wdWBsinrAFva0dWyBbP960mU/s9d0ts9dC30JzUGMqVYPraLBnLvdecUi6JY/C3l3KP5egeCquaJQu5pdf1h7RuZ/hwiSJJ3gRWHWPNLCU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(2906002)(31696002)(2616005)(26005)(6512007)(186003)(478600001)(316002)(6506007)(4326008)(86362001)(36756003)(83380400001)(76116006)(66556008)(5660300002)(66946007)(64756008)(66446008)(54906003)(66476007)(31686004)(6486002)(6916009)(8936002)(71200400001)(8676002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yPjKCm8f+LBvcejbYKQbYtKyD/JZpni55vjJDYXUV1ArWN/4v93BGzbIvL2cbbxCSSWyqQDQbN1mIHd77CHgrwtMBVpcUag14IbnwjhfJe19ptTGKxMD6W3dxa9jPok1XKYGBBeNQ+xvfRRDbq5duZ0IiO8/o8dzHZZg6lzca7NZAniQGMwogjAMimk8Sgk9kKl8vnPNUpfCCgLuVgJwjhigMxHHFS9nGNEq9f7UyYGgwc5yYmJwIDBzR9/vDkk6tpDLMJaWFq7fhvj39iJL5Y3hHrRbdaTUMLsGMFpJmzOtHcR+KZsDKtwQ2woLvSwn0lwcytXPNwLuHnUUkDEjZ599Ham8GrTcJ2QR2RBTk6lVklUmRJG5pTI4XM+l5jrQ/6g485EZqCRs3JPakOi/qGFK/k9YsqDoE0oopPvetOxI/oR/NOoVA+OjQWMjxCipCuW25IeuNgCE90H7oYHzQEM5rMLRFK8OoOC32Z/Xk+EhvFmZqPHLFvAuUVMr3j8JPsn5w3k5CJUCxlYgBwQ/jcmHSUFmk1C26FE4MzZNZNQ2CF/C6ePCN0nVmk/XmZUC1JBbL1C2k6fdrRAAu7mqJQNCQ6MtnecDrIGYzb2gj6ZtCTjfjoIoSJF96OO/JKAXVt1m9AFz36RfeXeBdVvy9Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <12B312E1FFA1954DB831A4079F30AC3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e6603-d2a1-484d-ba29-08d881cf9876
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 21:13:08.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcQBKca4BTGFmZAV31FdDbUWCHOXwrsmSoR4+Y9C+c9ZtiRed1p23S85EMkYGCKLtnM9erFbcsyDrpIBNUT8bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkEgY291cGxlIG9mIHVyZ2VudCBmaXhlcyBmb3IgQVJDIGZvciA1LjEwLXJj
My4gUGxlYXNlIHB1bGwuDQoNClRoeCwNCi1WaW5lZXQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tPg0K
VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAzY2VhMTFjZDVlM2IwMGQ5MWNhZjBi
NDczMDE5NDAzOWI0NWM1ODkxOg0KDQogwqAgTGludXggNS4xMC1yYzIgKDIwMjAtMTEtMDEgMTQ6
NDM6NTEgLTA4MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogwqAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3ZndXB0
YS9hcmMuZ2l0LyANCnRhZ3MvYXJjLTUuMTAtcmMzDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byAzYjU3NTMzYjQ2MGM4ZGMyMmE0MzI2ODRiN2U4ZDIyNTcxZjM0ZDJlOg0KDQogwqAg
QVJDOiBbcGxhdC1oc2RrXSBSZW1hcCBDQ01zIHN1cGVyIGVhcmx5IGluIGFzbSBib290IHRyYW1w
b2xpbmUgDQooMjAyMC0xMS0wMiAxMTo0NTowOSAtMDgwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQVJDIGZpeGVz
IGZvciA1LjEwLXJjMw0KDQogwqAtIFVuYm9yayBIU0RLdjEgcGxhdGZvcm0gKHdvbid0IGJvb3Qp
IGR1ZSB0byBtZW1vcnkgbWFwIGlzc3VlDQoNCiDCoC0gUHJldmVudCBzdGFjayB1bndpbmRlciBm
cm9tIGluZmluaXRlIGxvb3BpbmcNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVmluZWV0IEd1cHRhICgyKToNCiDCoMKg
wqDCoMKgIEFSQzogc3RhY2sgdW53aW5kaW5nOiBhdm9pZCBpbmRlZmluaXRlIGxvb3BpbmcNCiDC
oMKgwqDCoMKgIEFSQzogW3BsYXQtaHNka10gUmVtYXAgQ0NNcyBzdXBlciBlYXJseSBpbiBhc20g
Ym9vdCB0cmFtcG9saW5lDQoNCiDCoGFyY2gvYXJjL2tlcm5lbC9oZWFkLlPCoMKgwqDCoMKgwqDC
oCB8IDE3ICsrKysrKysrKysrKysrKystDQogwqBhcmNoL2FyYy9rZXJuZWwvc3RhY2t0cmFjZS5j
wqAgfMKgIDcgKysrKysrLQ0KIMKgYXJjaC9hcmMvcGxhdC1oc2RrL3BsYXRmb3JtLmMgfCAxNyAt
LS0tLS0tLS0tLS0tLS0tLQ0KIMKgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAx
OSBkZWxldGlvbnMoLSkNCg==
