Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9E2955FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894626AbgJVBR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:17:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34616 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440530AbgJVBR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:17:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D59EC0092;
        Thu, 22 Oct 2020 01:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603329475; bh=mD9MNm46pENzeHPdgeYx3S6YxrjULPVVlp3ZHS51f4A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eoLibB9jdZ18wBfHibVvLuXeUr0NUuE+dK2C937XnErfo05Yi5q6OLEYW3p+xhUP9
         u1tFDcCxHcbXWKI9v3He/CvW5XXiN5gvp3GAstpmMbNv1Zf/hRYZcH/RWqoUz4qME7
         fbuyexBFTGxCXIzBAinwY8ufaDdqDxEX7W/+0tZVg4m3USpH4yJk7+NOcoyipty/B5
         liwk642DAcFr0mYfUvd14xgNP6Cq4MU0RjLgZm2qQXqhPuv4f1NYvbSj5/4gYeU3T7
         VoNQEBqx9atHLePgB+1JhHfUKJl7eDnDz6qgBYspYFfEsLHLtJwFcnYHnGCX9fCugw
         l92tF+40KbUKA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0337AA0060;
        Thu, 22 Oct 2020 01:17:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3431840044;
        Thu, 22 Oct 2020 01:17:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dyDMArxQ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqxAA5L8jVcVe18h1HA/HJn9BsprYsUqPWVuRq6d2R13Vg31E6ncMLHUvhSqRCYzMr3ktZ/Lz7lznX7vKg3635kShhqyZRIBuV6Px4R6Hjvg2DY/1sH0baihRGwUK7NjvT3YNODng0YzV48Z22cZVz1IcgRiuSVaTnk5qBc6OX2Af3UwmWEEh6MiJ6GzVn5fo/4B4InGUf26OD5aCMZjs3hwFiU7wvtCQAbbnIMXk4dbfhigIjF4vz7L5yYvrkdSJcPeua4rPUahusVG/vQWtWXwYALCa4Of31t50PDsjvySU+dpNh3o97vEFdD/aMvept+JzUW+zOtxwMI1qCPY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD9MNm46pENzeHPdgeYx3S6YxrjULPVVlp3ZHS51f4A=;
 b=QWlqyLc0Dg6kGIk52EhCBs/K33AumB2627hrJ4YBblsGdeLB4C/0dqseosVNucpRFqQ5e5o7tJypazYpaVgnb/vlLVyMcZg4eP8D+JVezA+IAg2SCYHMnCMMWhSIX1Oi0PPUXpnbdipYfAQvTBSYSMmrS9/0KYgWyhtWmW7J99wvV15i29zrtY7h8Nkw3s5NMMbOKzI5eoTGIXsv1SM0vW9JM+rMbn5vH29ygvJt1+AAU/zaq/pksU4yeFeXK1zGQTgaOipX/qCMl+nUfS0Gf7oXZqmwygMAFY0t7nuEw7mO0NhHaWckUugznTtD8twZQUbzLva3NWF6B7ZYQSlAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD9MNm46pENzeHPdgeYx3S6YxrjULPVVlp3ZHS51f4A=;
 b=dyDMArxQ0UwKQe3g7U9A8YrQx4crbeKDidworF9j/tsGxTi2I64sPsi4DuUCt3kshjCliX+pjL0pZoJxm9ggx9fNAjzwzHf9gV9FytKJEGesfEi7VcugAjGw7SC1SDM2QB3n1PWY4J94fMPJgFjk67p9T/5tWO0iGQW9Glm7FaU=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 01:17:51 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 01:17:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
Thread-Topic: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
Thread-Index: AQHWp/wCBx/WzG0lD0G/6zZaqZHYK6mi0lqA
Date:   Thu, 22 Oct 2020 01:17:51 +0000
Message-ID: <d9c241a5-f31b-b044-bc15-1c5e4d445a69@synopsys.com>
References: <20201021224619.20796-1-john.stultz@linaro.org>
In-Reply-To: <20201021224619.20796-1-john.stultz@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84e11994-114e-4d0f-b518-08d876284bdd
x-ms-traffictypediagnostic: BYAPR12MB3127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB312739D1CF6D30CFC5FA6658AA1D0@BYAPR12MB3127.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2/Fhjrq5a1Pec8+4TmrQCDjF7jHqEzUt34WkjqxJ6hGvI0mSMdf5mi812HsieKG8mBFqXjkogffw8E44p+a1D1pKeBqNh4iCsJN63YiUgaCDbAuAZvcDz9KNWuNRU8WnOLiWhSBDPNWqfKZN6ocj1IGRGvkFOWnl9m18pbOhPmwlXxHj8C5uxxSBu+9PHhNyatyv08/l1s9ACgiD14ZeWRG0Ch3MPOTBpoOOlbPdUh5ExxcyGWUveylrBonmpSZamnVe4QySzasVAL094rUZuAFGqxkoHJ0Hn0GMANauz2vwYtl1AE9iXvPyWKEWT5HrKepbB4hrirgG2Psh6dJckRfAdh0oymkBcXtAtIkvVKCqfbRDwwADU8UkNoxsbHB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(6506007)(8676002)(6486002)(26005)(8936002)(186003)(2906002)(110136005)(86362001)(478600001)(31696002)(6512007)(316002)(36756003)(7416002)(2616005)(4326008)(71200400001)(64756008)(66556008)(66446008)(66476007)(54906003)(5660300002)(66946007)(76116006)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9Pt5etCRyla8geq9TCT2IcFhtzscMmTSEtP0KJhjg9ZqYgUzWycKqDNXdIzyfOKoHqd9/2sHxkEyj65U3SyEcYNvCjJEIryNJAe5LdZ31jW5lH2r0VNwK6erlBfLKY5V+EOVxklYwnMqdJeS6OJB9r4Y12xIJfjP0mN1L4COEwUZXvlhObHwaGG9KIwIJwBE2XVAe1z1HEyA3lIhGprrzTn76nFrbCbKx2gJQkoPmmiwC3gzNn50SvIOn5E0TzRLEk2KadRl4gVtdF8K2Tq05nWwnuglhAMNEMIjQWG5xrmVntArcTzlMIU8+6qlgvpdRoc+DdeRM+nBz6RlaeLQppuU8HkOkxc4E9QEkr4yBkIr3OzsFuaJFMHQ+RjlbSu/MpH5e7UC/fdhWnCE8a/HvYxC0rSiSLhzmKw+Kd8xvv8fOjLrrlM3iLRZfUs91C4aKCpMCOzcqpfFhGlk6qvZyvsZAFhtKcvtdfmneq0YpSXuYYtMJa+bCW/thyIGto15NiMEfE1TcFKS/OPEOA9Ycde3sBBuytAmQ99nmd87mIpmK8oWRmVXpy1WDXj2+IFjDa2EHlwNsEa27pYEGgbpvetTnwM+rFoP/341Eem2GMYSpUj7DuezGHahBBJNxrQvfnU3EfxDbffDOYc0S5WJWA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB221D15D84C4140972AA7B736D4197A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e11994-114e-4d0f-b518-08d876284bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 01:17:51.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/C1120M7zThXjjyXM0OOZXkce72Hekb9NBKigBqAJOesWY/dueHW3Zb7gRNa9xexMAEDKdsITTL/WX06H8zYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9obiBTdHVsdHogd3JvdGU6DQo+IEZyb206IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+
DQo+DQo+IFdpdGggdGhlIGN1cnJlbnQgZHdjMyBjb2RlIG9uIHRoZSBIaUtleTk2MCB3ZSBvZnRl
biBzZWUgdGhlDQo+IENPUkVJRExFIGZsYWcgZ2V0IHN0dWNrIG9mZiBpbiBfX2R3YzNfZ2FkZ2V0
X3N0YXJ0KCksIHdoaWNoDQo+IHNlZW1zIHRvIHByZXZlbnQgdGhlIHJlc2V0IGlycSBhbmQgY2F1
c2VzIHRoZSBVU0IgZ2FkZ2V0IHRvDQo+IGZhaWwgdG8gaW5pdGlhbGl6ZS4NCj4NCj4gV2UgaGFk
IHNlZW4gb2NjYXNpb25hbCBpbml0aWFsaXphdGlvbiBmYWlsdXJlcyB3aXRoIG9sZGVyDQo+IGtl
cm5lbHMgYnV0IHdpdGggcmVjZW50IDUueCBlcmEga2VybmVscyBpdCBzZWVtZWQgdG8gYmUgYmVj
b21pbmcNCj4gbXVjaCBtb3JlIGNvbW1vbiwgc28gSSBkdWcgYmFjayB0aHJvdWdoIHNvbWUgb2xk
ZXIgdHJlZXMgYW5kDQo+IHJlYWxpemVkIEkgZHJvcHBlZCB0aGlzIHF1aXJrIGZyb20gWXUgQ2hl
biBkdXJpbmcgdXBzdHJlYW1pbmcNCj4gYXMgSSBjb3VsZG4ndCBwcm92aWRlIGEgcHJvcGVyIHJh
dGlvbmFsIGZvciBpdCBhbmQgaXQgZGlkbid0DQo+IHNlZW0gdG8gYmUgbmVjZXNzYXJ5LiBJIG5v
dyByZWFsaXplIEkgd2FzIHdyb25nLg0KPg0KPiBBZnRlciByZXN1Ym1pdHRpbmcgdGhlIHF1aXJr
IFRoaW5oIE5ndXllbiBwb2ludGVkIG91dCB0aGF0IGl0DQo+IHNob3VsZG4ndCBiZSBhIHF1aXJr
IGFuZCBpdCBpcyBhY3R1YWxseSBtZW50aW9uZWQgaW4gdGhlDQo+IHByb2dyYW1taW5nIGd1aWRl
IHRoYXQgaXQgc2hvdWxkIGJlIGRvbmUgd2hlbiBzd2l0Y2hpbmcgbW9kZXMNCj4gaW4gRFJELg0K
Pg0KPiBTbywgdG8gYXZvaWQgdGhlc2UgIUNPUkVJRExFIGxvY2t1cHMgc2VlbiBvbiBIaUtleTk2
MCwgdGhpcw0KPiBwYXRjaCBpc3N1ZXMgR0NUTCBzb2Z0IHJlc2V0IHdoZW4gc3dpdGNoaW5nIG1v
ZGVzIGlmIHRoZQ0KPiBjb250cm9sbGVyIGlzIGluIERSRCBtb2RlLg0KPg0KPiBDYzogRmVsaXBl
IEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPg0KPiBDYzogVGVqYXMgSm9nbGVrYXIgPHRlamFzLmpv
Z2xla2FyQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IFlhbmcgRmVpIDxmZWkueWFuZ0BpbnRlbC5jb20+
DQo+IENjOiBZb25nUWluIExpdSA8eW9uZ3Fpbi5saXVAbGluYXJvLm9yZz4NCj4gQ2M6IEFuZHJ6
ZWogUGlldHJhc2lld2ljeiA8YW5kcnplai5wQGNvbGxhYm9yYS5jb20+DQo+IENjOiBUaGluaCBO
Z3V5ZW4gPHRoaW5obkBzeW5vcHN5cy5jb20+DQo+IENjOiBKdW4gTGkgPGxpanVuLmtlcm5lbEBn
bWFpbC5jb20+DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtl
cm5lbC5vcmc+DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPg0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBZdSBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFN0
dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz4NCj4gLS0tDQo+IHYyOg0KPiAqIFJld29yayB0
byBhbHdheXMgY2FsbCB0aGUgR0NUTCBzb2Z0IHJlc2V0IGluIERSRCBtb2RlLA0KPiAgIHJhdGhl
ciB0aGVuIHVzaW5nIGEgcXVpcmsgYXMgc3VnZ2VzdGVkIGJ5IFRoaW5oIE5ndXllbg0KPg0KPiAt
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXgg
YmRmMDkyNWRhNmI2Li5jYTk0ZjNhMmE4M2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xMTQsMTAg
KzExNCwyNCBAQCB2b2lkIGR3YzNfc2V0X3BydGNhcChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9k
ZSkNCj4gIAlkd2MtPmN1cnJlbnRfZHJfcm9sZSA9IG1vZGU7DQo+ICB9DQo+ICANCj4gK3N0YXRp
YyB2b2lkIGR3YzNfZ2N0bF9jb3JlX3NvZnRfcmVzZXQoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sN
Cj4gKwlpbnQgcmVnOw0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNf
R0NUTCk7DQo+ICsJcmVnIHw9IChEV0MzX0dDVExfQ09SRVNPRlRSRVNFVCk7DQo+ICsJZHdjM193
cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dDVEwsIHJlZyk7DQo+ICsNCj4gKwlyZWcgPSBkd2MzX3Jl
YWRsKGR3Yy0+cmVncywgRFdDM19HQ1RMKTsNCj4gKwlyZWcgJj0gfihEV0MzX0dDVExfQ09SRVNP
RlRSRVNFVCk7DQo+ICsJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dDVEwsIHJlZyk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMgKmR3YyA9IHdvcmtfdG9fZHdjKHdvcmsp
Ow0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJaW50IGh3X21vZGU7DQo+ICAJaW50IHJl
dDsNCj4gIAl1MzIgcmVnOw0KPiAgDQo+IEBAIC0xNTQsNiArMTY4LDExIEBAIHN0YXRpYyB2b2lk
IF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAJCWJyZWFrOw0K
PiAgCX0NCj4gIA0KPiArCS8qIEV4ZWN1dGUgYSBHQ1RMIENvcmUgU29mdCBSZXNldCB3aGVuIHN3
aXRjaCBtb2RlIGluIERSRCovDQo+ICsJaHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RFKGR3
Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFN
UzBfTU9ERV9EUkQpDQo+ICsJCWR3YzNfZ2N0bF9jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gKw0K
DQpJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGRvbmUgaW5zaWRlIHRoZSBzcGluX2xvY2suDQoNCj4g
IAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICANCj4gIAlkd2MzX3Nl
dF9wcnRjYXAoZHdjLCBkd2MtPmRlc2lyZWRfZHJfcm9sZSk7DQoNClRoZSBEUkQgbW9kZSBjaGFu
Z2Ugc2VxdWVuY2Ugc2hvdWxkIGJlIGxpa2UgdGhpcyBpZiB3ZSB3YW50IHRvIHN3aXRjaA0KZnJv
bSBob3N0IC0+IGRldmljZSBhY2NvcmRpbmcgdG8gdGhlIHByb2dyYW1taW5nIGd1aWRlIChmb3Ig
YWxsIERSRCBJUHMpOg0KMS4gUmVzZXQgY29udHJvbGxlciB3aXRoIEdDVEwuQ29yZVNvZnRSZXNl
dA0KMi4gU2V0IEdDVEwuUHJ0Q2FwRGlyKGRldmljZSkNCjMuIFNvZnQgcmVzZXQgd2l0aCBEQ1RM
LkNTZnRSc3QNCjQuIFRoZW4gZm9sbG93IHVwIHdpdGggdGhlIGluaXRpYWxpemluZyByZWdpc3Rl
cnMgc2VxdWVuY2UNCg0KSG93ZXZlciwgZnJvbSBjb2RlIHJldmlldywgd2l0aCB0aGlzIHBhdGNo
LCBpdCBmb2xsb3dzIHRoaXMgc2VxdWVuY2U6DQphLiBTb2Z0IHJlc2V0IHdpdGggRENUTC5DU2Z0
UnN0IG9uIGRyaXZlciBwcm9iZQ0KYi4gUmVzZXQgY29udHJvbGxlciB3aXRoIEdDVEwuQ29yZVNv
ZnRSZXNldA0KYy4gU2V0IEdDVEwuUHJ0Q2FwRGlyKGRldmljZSkNCmQuIDwgbWlzc2luZyBEQ1RM
LkNTZnRSc3QgPg0KZS4gVGhlbiBmb2xsb3cgdXAgd2l0aCBpbml0aWFsaXppbmcgcmVnaXN0ZXJz
IHNlcXVlbmNlDQoNCkl0IG1heSB3b3JrLCBidXQgaXQgZG9lc24ndCBmb2xsb3cgdGhlIHByb2dy
YW1taW5nIGd1aWRlLg0KDQpGb3IgZGV2aWNlIC0+IGhvc3QsIGl0IHNob3VsZCBiZSBmaW5lIGJl
Y2F1c2UgdGhlIHhIQ0kgZHJpdmVyIHdpbGwgZG8NClVTQkNNRC5IQ1JTVCBkdXJpbmcgaW5pdGlh
bGl6YXRpb24uDQoNCkJSLA0KVGhpbmgNCg==
