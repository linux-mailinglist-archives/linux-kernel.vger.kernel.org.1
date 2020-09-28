Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5427B6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgI1VXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:23:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56980 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbgI1VXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:23:52 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0FF2C00D4;
        Mon, 28 Sep 2020 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1601328231; bh=JsT4TK90b7ICkkSxknS6EKH4XFwDAHA9RR+lIyUjHfQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k31nfk+bjJCwQ1otjf2uLHI843cv10tWmEEQnu4EWfyRHszGwsMhJ09KFPfY0rA+i
         g28jQO1BCJc/TDyxdevJ0eFcOTSyP6iMXeoQlV/SYEPdjNwhAjY0Xku0L1vWyNhA/a
         I6AfYTgODBpvgFaY5r98i1hm7fjeUcQ/GVeStEk/5uLfJwL2bhGnl1TZbYP8LSRnXd
         bMHqUwwpj2kDBmSWYy91WiMOgO8N+nCqKoCe7AXYjZ94ZoRWMW1RaPsuWndZ+lmzjw
         VUpJr20/Njn/pVM8suoXYWfTVszgZgN5F2DvbYVA/jd6EdB5OtAy6rNWPzbgihLRnP
         7b2LuWAJnaQog==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA266A0077;
        Mon, 28 Sep 2020 21:23:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 72953801DE;
        Mon, 28 Sep 2020 21:23:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Cn2gJ2o4";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS5BZoZtKI3e4nJawSfdnm1xeOpre3+PhoU86rDIiv/HHYVcaSr+/olED4zyirbiAdK2zEzDjRtSZ3ijqGi4gguCe4SZLj9R5xaBfBz6H94iDS9vpiN1MiED9tz16Ttzg+CgdVC30UiJ6rBiHqNKQFArJZppLJShDVG9FeWS/SewhFsJEMrJ6V6Ab17K1VKeCIzGsNwHiCblQe98fG3n76os2pi2SoTw3zPXk14irvcM8SxuvlSN5KeHV5LL+ffpIdgNwPY6FvAK1Zm731EVibRtonXJEyCSuA4iz5fXvbk6eN5msQRZxJxZSCeSu+yooxNExUMEnFzs2nZD3LCXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsT4TK90b7ICkkSxknS6EKH4XFwDAHA9RR+lIyUjHfQ=;
 b=REY5d4MhOVVjd9wjTVJUzEKH8R7BzfPpn173Qv+YRPvgRE/CircTccIfWa3Rjz+YNDFmeBIndk3FMLjttm1E7gcPszOvp/i7uGM5hCKqwG7urqahPYXSuOR/rbZAr5GHhFrjo6D8MUvQ3WqtVQPKdgFMbZgR08yNUiqYdahkDZ+HsKHKH/knVjfNdnyPdrOIhlK3mX+wZz1FG0LGkAi8E1FI67x7Q3qQ4jPZ/bsKuc1Y/3imuSZI7IcRR+3WJv4BQ0oEsWatTEqT8Q3b+lDGA4swppJ6Pa6Dg1EWa2T8mj10U/UCZ3DDuwPuxTOsDFOmNTkZsCCJsC51N5yjlnzXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsT4TK90b7ICkkSxknS6EKH4XFwDAHA9RR+lIyUjHfQ=;
 b=Cn2gJ2o4/IRXavT/D4qhEOCARNUx/HZ1FPl7IhsuYV4UY5v49LCsJjaFTu/Wzba2M+CogYejFqBJGuyRRLEBXLObkodS8tFPUn1ik9NRFNlKBPbumyEMR7Qau89JgdY/m1Gr97P0oFwRkILpDfhvomHHvJu3eU6xz6Lg3cAO5Zs=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 21:23:43 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0bb:1c2d:ecb9:547]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0bb:1c2d:ecb9:547%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 21:23:43 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: ARC: allmodconfig: Error: inappropriate arguments for opcode
 'mpyd'
Thread-Topic: ARC: allmodconfig: Error: inappropriate arguments for opcode
 'mpyd'
Thread-Index: AQHWkioluo2nQ3w1D0WxUzFglNmDoql+lvMA
Date:   Mon, 28 Sep 2020 21:23:43 +0000
Message-ID: <8bdfc9a1-904c-d58a-8925-de55d9c3f628@synopsys.com>
References: <CA+G9fYv0+NPwkT0r-T_nk5T0UE-GAbN_8Fh3VSLW8P+Prsv_4g@mail.gmail.com>
In-Reply-To: <CA+G9fYv0+NPwkT0r-T_nk5T0UE-GAbN_8Fh3VSLW8P+Prsv_4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe0eb82a-51ae-416d-504f-08d863f4c6de
x-ms-traffictypediagnostic: BY5PR12MB3681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3681FA169C656B8DB09A971AB6350@BY5PR12MB3681.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXX+cO2eHH189ycKkQTWRtK1CpdZBU+7qzZScMaEaIViRKLgPMWpzpLq/+tqmgrh9dVRyPRqIqYi63G5YWgaZDp0QScCaaenVBLKPIx19v8nhbqIGuGhQtCjUAmkBZTkOngFaAt2KovIblg8/E0Hagev1quk9qDS+0Og8kGEqgnjcga9Df43U8EQv3X11jPWsgP3acSaBTw8g4n5a+9cv9lxeX8Nmdp7xKhIHM90lFZ2L4V6cCMRZZZ78C4MmlpJ6pKUbCkwKh97b4BtgQup8yOBFJeUCjnxTn2zZcyDfafufSkCcptTIPkDUvmaHROUPkisx3I0TtaQv0eSKcSaq7iP/AIw4f9Azyagdy9Kt2EryjO5VeoKMbz38tTCcUFVUL1W+XWj9LIMIATlzIEDa5MxVHx1ZCtfk1ssQenfsZQ6/Ja554kJgvrWNCSQoZTiffZIfvPlbHXaHB4rtDTDbAHLOAa6ixocLJeTaF9uR6sy1rCsYUCHK4PRXrTLUZ9W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(478600001)(8936002)(2616005)(966005)(31696002)(316002)(76116006)(186003)(83380400001)(86362001)(6512007)(66556008)(26005)(66446008)(64756008)(53546011)(6506007)(66476007)(4326008)(6486002)(5660300002)(4744005)(54906003)(66946007)(110136005)(71200400001)(8676002)(31686004)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 75FQxSMtsv0Tr/og1bL3X3cXBn1ZnhjYG0n5yNuH5LWIaQx+wrDSDy1M9sxV3+G2DEM+hTVMdAN2h+mfSTX0Uf1J2LXvoROB4G7Ng8p7xfo6forzi6mNnd5phyh0A4DyOexOrChylfq2MlUJ+WvX3VXSzkRdoFSi/aTg/JPIYS1A4Mg02umzYACWI8J6AEPgtPaitzuuGGvfJzIR92SzrQxAr/Puh4F0ON7GJf29Wkm0cWmA6q3+jYUuZ/ATOqB3z9Vh5r2mQURtBQ7oDoduc2GJ6hEhAl9yJ9BTatI3ewFKzzvzJx2E0J4q3MshnqcVWNNK8biAwxhG+qwyTLnyL/NZRm5i9vFdA6vz73FCclAoWedb4MVWEizfH1VIOSSN+iuBQC6A5a7ZpKTpvcFACvOgTGGqTUzZIOGSb+C9PRnr1GU1ij+B2wGeh1Ks/K0Ug3+yfjZ+B2fGF21N4f0Zy0xqAbhRq56D2glwF2ZaxXYjE6Y6kgrThdHPBq9rK5sFcJsZSyomqp7f/1nEMFJXvFTn1zt/w/og3w3QApzSUXWy8cbqjKyNlQpt42PRezsT7BOzyev5bnj0DqWTvQQJo0X9yJp8A260mriQYX46GxfH1X1i9BM3gXLFNGUNQ4KY24cJLaLdmNnUO8pFlV3M0A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4B9385A0A56354993AFCAD5EC1CA2E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0eb82a-51ae-416d-504f-08d863f4c6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 21:23:43.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he2FKKqabgukh4BaAZ4dfdbDZH/+H7IrpDGq2tdsMeciNwn95YfSu+8zkmnPjOf2V8xf3uUhXClLZM7enpVdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmFyZXNoLA0KDQpPbiA5LzIzLzIwIDk6MjAgUE0sIE5hcmVzaCBLYW1ib2p1IHdyb3RlOg0K
PiBhcmM6YWxsbW9kY29uZmlnIGJ1aWxkIGZhaWxlZCB3aXRoIGdjYy04LCBnY2MtOSBhbmQgZ2Nj
LTEwIG9uIExpbnVzJ3MNCj4gbWFpbmxpbmUgdHJlZS4NCj4gDQo+IEJ1aWxkIGxvZzoNCj4gLS0t
LS0tLS0tLS0tDQo+IG1ha2UgLXNrIEtCVUlMRF9CVUlMRF9VU0VSPVR1eEJ1aWxkIC1DL2xpbnV4
IEFSQ0g9YXJjDQo+IENST1NTX0NPTVBJTEU9YXJjLWVsZjMyLSBIT1NUQ0M9Z2NjIENDPSJzY2Nh
Y2hlIGFyYy1lbGYzMi1nY2MiIE89YnVpbGQNCj4gYWxsbW9kY29uZmlnDQo+IA0KPiBtYWtlIC1z
ayBLQlVJTERfQlVJTERfVVNFUj1UdXhCdWlsZCAtQy9saW51eCAtajE2IEFSQ0g9YXJjDQo+IENS
T1NTX0NPTVBJTEU9YXJjLWVsZjMyLSBIT1NUQ0M9Z2NjIENDPSJzY2NhY2hlIGFyYy1lbGYzMi1n
Y2MiIE89YnVpbGQNCj4gdUltYWdlDQo+IA0KDQouLi4NCg0KPiB7c3RhbmRhcmQgaW5wdXR9OiBB
c3NlbWJsZXIgbWVzc2FnZXM6DQo+IHtzdGFuZGFyZCBpbnB1dH06OTM2MDogRXJyb3I6IGluYXBw
cm9wcmlhdGUgYXJndW1lbnRzIGZvciBvcGNvZGUgJ21weWQnDQo+IG1ha2VbM106ICoqKiBbLi4v
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyODM6IGtlcm5lbC9zY2hlZC9jb3JlLm9dIEVycm9yIDEN
Cg0KVGh4IGZvciB0ZXN0aW5nIHRoaXMgYW5kIGJyaW5naW5nIHRvIG91ciBhdHRlbnRpb24uDQpJ
J3ZlIGNyZWF0ZWQgYSBnaXRodWIgaXNzdWUgZm9yIGdjYy4NCg0KaHR0cHM6Ly9naXRodWIuY29t
L2Zvc3MtZm9yLXN5bm9wc3lzLWR3Yy1hcmMtcHJvY2Vzc29ycy90b29sY2hhaW4vaXNzdWVzLzMw
MA0KDQpXZSB3aWxsIGFsc28gbG9vayBhdCBidW5jaCBvZiBvdGhlciB3YXJuaW5ncyBiZWluZyBz
cGl0IG91dC4NCg0KVGh4LA0KLVZpbmVldA0K
