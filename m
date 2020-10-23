Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1E29688A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374702AbgJWCfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:35:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39442 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374295AbgJWCfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:35:39 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED127C054E;
        Fri, 23 Oct 2020 02:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603420538; bh=VIP1cRP1yu93+SmT2c3c3lItvR5rgDoj4Wehjf47yvs=;
        h=From:To:CC:Subject:Date:From;
        b=OE/OdGx7LoE6fUGII4VIPuicSNAYK1FWrzR+V18Nz0GHEjCSO+Zp98bcPv78CiLlz
         OA+BGIX7rajTIn0742DNI40xA9d6ATAwXduLPkAiUBPNQPwM5UYi33m2SaYFgiGU9V
         pXDvLBZjHyLEId7zvH9ojQRWhjSmGYkXR2UF7mtVVGTzwsxUla52yF28/AgHhU4ojz
         v4ve7vQwrMm8PvMSBxMQGa3Svor/J3v5+KktJZg5y5SQ7ooQm+bICpV3n/6LVcVZ05
         gPUq8mAVwFuGQFOEZElJ+up9hV6/mplX12yBzahlu5cKMHE8sriw8nIhRkp35/AykV
         Oer/c3aciC/wg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4F5B6A0068;
        Fri, 23 Oct 2020 02:35:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 76D84400C9;
        Fri, 23 Oct 2020 02:35:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HWfviiVF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI/9a4ekLJCxOVUygbm6lBehp0YuezfftM85Z90R2Lt22CR40hybOWz0RQwJCc9G34KgqljGZypRetcVv5POqmIzR+pQuWasPzeeKPWYYfF9s3fG1mLthipWfbNZICwQaq0CCWj+6yNx188k5XFBWLpChO2Kf3Vlh//BB94orrhuzzOv9ED+oSAqo0FT/ZNXm8C5ESz1m19gmk1Ml8D2uq3ha+Gk1tZVioHvBkRnI9aLNyFrZmdYUVJ9WHR7ELWzDZDBkx8XHS1xfQXCHl3qMrKAAu91ESRUPId1DwAeiTEr/fH/qTxN9LsIWnzM20iv+OArQjwPaGsellWOMFcuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIP1cRP1yu93+SmT2c3c3lItvR5rgDoj4Wehjf47yvs=;
 b=DTOlevukP+5YpqfLH8vzSMXG7eygTqyosJEvxZyFmkRVpd9HixIQRpmgcxtq2ht3qLnKxBZF88qy57upzmYypgI/D84awbjGtb8tyqoRZqtqGL9N8eXZ111lrN05hWW0DkKTd3E4Xn1cmSgvbvF2yaAtf9jT2fLHrj8pxZyscPHOlnFez8SMR3f3CDAdWvdoA9XqAADyYxUNvf42ApewVPz5vInfvvsaCDOQdNLeeeDZmr8XKo7Yg/K4di+9w63vZQJFN7eTuI4v/IgbyJwT3h5Gz23sEybL8gA62eBDd/0dK78mdwBFTCNm/NfbxuY4/NIK5402IlAVfJwmoWj/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIP1cRP1yu93+SmT2c3c3lItvR5rgDoj4Wehjf47yvs=;
 b=HWfviiVFcMs2VglSua6cl6H4GcNK4FzVQcYb4hLXBUCi6N+3a2VeeOncs1tIPErrsh2409EvEyD21Nf4WOtUdd1zaFoM+NZNp/C/naI75sAKBHQEg5Xq4qNrv2X11arqtyiQlRTYu8bhDycMcooNCwx4XNOuV0Egkge3MPgbsek=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3477.namprd12.prod.outlook.com (2603:10b6:a03:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 02:35:33 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 02:35:33 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: [GIT PULL] ARC fix for 5.10-rc1
Thread-Topic: [GIT PULL] ARC fix for 5.10-rc1
Thread-Index: AQHWqOUuDkpUarYknUu/NJxjRrJMZA==
Date:   Fri, 23 Oct 2020 02:35:33 +0000
Message-ID: <cb7b01ac-abf5-b6df-3f15-a7a20533a89f@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 147ee2de-0fa9-453f-eff2-08d876fc50ec
x-ms-traffictypediagnostic: BYAPR12MB3477:
x-microsoft-antispam-prvs: <BYAPR12MB3477AD7E50BD26292289A025B61A0@BYAPR12MB3477.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kt2NuCZ2Go8IjX4vA9P2xfP3kA48yuGd+HoUZb9JIYGPlMMOefozFWwRv9VrrgqDcYhTRcZC0VT5mOs8PEJRzkPMvOQZMp1fJ2YShXdL2EP0vhG39ae3hDjNmtvmHz8uDY95kMZ4dPMNwi2/4kJRBtfggrbdRDLD8pZESCXSnZdDMHrmagcWgju4cPws8wT4d3i6Ip1+ub90VHQA8FtjkHmKf6le0qgWjeiF+phjU4yJy5R8k+TQE+TtPkq+/rdUUdWkluLtjTqoSMLI4zXO8j5Us8syMHZSmhMiRFhiA/Qk+SHKP3S2Zw3C7qQoi+iamc1pt+3McN/yRSB14Ep16pYFz2Xerd8WcR6szdgt4+Pf+v0nK9MqZNUC/Yb1hqj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(64756008)(6486002)(186003)(6512007)(66476007)(66556008)(66446008)(66946007)(26005)(31696002)(83380400001)(76116006)(8676002)(4001150100001)(8936002)(71200400001)(4326008)(5660300002)(478600001)(6916009)(86362001)(2616005)(36756003)(31686004)(54906003)(2906002)(316002)(6506007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N1E1uDqTjEYuyQQe/xDYVp0OWT4+HARf14dyvBkv0Xybsa+V2YC4J+5GT8vZ7xkokCtRlsk86wcHTE1hOD1WKoG0vinOdJEnWXJ2ieuHGZ9STy+m6PKSf6tuZldbIdK6q32oPtr+pSrhsy4eekgKCuwl/vg31VWqR2b6Finnzgo9us4l/w7doR8BxLEoWr97UmZGNwmn5QDHb+6shVQw2Dj/o96nySe107gxPW/6eA7WjS3LiOidGAxO+wXDl2Hwd8J6ie3siz1dhGZutO/uBumwZV5nndcHtYs6raob754kbjPHIQjr4nwbfJ1t7cxSEjcXWzpcH5EVAB4YKPIgoTylFj9PZ+tbWKF1T9BM7adaJZccvR6bBUfz+L2aoJMVaew8AsF9Z7GepX94LnZf55VHB4Nd0d13H0oFIGnhn2Nj2OLCzy7JSZHXtEycej3I8RGeNaxb620Y1LR6awqaoZyCZRMGdhUztyGmOYNKZNLaPsrkICsPwmJqolEL+52s8QMQADG485XNLuMAi6oSiEIrXj9hx6eBp3wSjy6qRH74oEieYNez4AUcezKGa8ysi5hHtEGc3B6jl80IoFYYvD6eaduu65lNFARUQ4Afq6RANz8m7LK5lwuHmwZvG1w5rxm1SZj5kTZySlcy6CiUCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7535DCE0D00248877E1725C973AD96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ee2de-0fa9-453f-eff2-08d876fc50ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 02:35:33.3017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LulaKQGF4pK53qENyqrppEUeqHEWGmMHgrYh5Ktm8RDULtQDd8NmAFQyuUWbzEKntBrn4zmMo0TgfVryZXA1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoaXMgaXMgYW4gdW51c3VhbCAybmQgcHVsbCByZXF1ZXN0IGZvciBtZXJn
ZSB3aW5kb3cuIEkgZm91bmQgYSBzbmFmdSBpbiBwZXJmDQpkcml2ZXIgd2hpY2ggbWFkZSBpdCBp
bnRvIDUuOS1yYzQgYW5kIHRodXMgdGhlIGZpeCBjb3VsZCBnbyBpbiBub3cgdGhhbiB3YWl0IGZv
cg0KNS4xMC1yYzIuIFNvcnJ5IGZvciB0aGUgdHJvdWJsZS4NCg0KVGh4LA0KLVZpbmVldA0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2
MzY0ZDFiNDFjYzM4MmRiM2IwM2NmMzNjNTdiNjAwN2VlOGYwOWNmOg0KDQogIGFyYzogaW5jbHVk
ZS9hc206IGZpeCB0eXBvcyBvZiAidGhlbXNlbHZlcyIgKDIwMjAtMTAtMDUgMjE6MDI6MjkgLTA3
MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92Z3VwdGEvYXJjLmdpdC8N
CnRhZ3MvYXJjLTUuMTAtcmMxLWZpeGVzDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byA4YzQyYTVjMDJiZWM2YzdlY2NmMDg5NTdiZTNjNmM4ZmNjZjk3OTBiOg0KDQogIEFSQzogcGVy
ZjogcmVkbyB0aGUgcGN0IGlycSBtaXNzaW5nIGluIGRldmljZS10cmVlIGhhbmRsaW5nICgyMDIw
LTEwLTIyIDEwOjU3OjU4DQotMDcwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVXJnZW50IHBlcmYgQVJDIGZpeA0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpWaW5lZXQgR3VwdGEgKDEpOg0KICAgICAgQVJDOiBwZXJmOiByZWRvIHRoZSBw
Y3QgaXJxIG1pc3NpbmcgaW4gZGV2aWNlLXRyZWUgaGFuZGxpbmcNCg0KIGFyY2gvYXJjL2tlcm5l
bC9wZXJmX2V2ZW50LmMgfCAyNyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg==
