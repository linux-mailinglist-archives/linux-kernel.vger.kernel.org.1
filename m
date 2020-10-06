Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D928447E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFEG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:06:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49310 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgJFEG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:06:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5C9EF4011D;
        Tue,  6 Oct 2020 04:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1601957215; bh=JI3w52hfc17eokkuPBtz9+dhVlPp+6QXiRkEU5ZojKw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hJZ9r8O+PPMYIiw6lSIt+H51VUW3RIelEFHrvwcZ8KyB09dwor9lSYOrN4m5otvQK
         sajCGJuTT1WvJ8WslbELOlyxvrWq7lNfg2eO4ctB8/e1LmdPmUbi1HxTTlCPbfwQGN
         Wpg0Qna2VksgrpuujIkbZNMqbXqNLOXSVnSPMAkHgDCuNWav3TNC/b6SpQ8lQjYuHV
         jGXKVckCtvtJUrYbbzsv5z+LIZq6kLe7MzgYcqCnzSEQMES4aH8aMthW03hItwcBRk
         VZKZHez0jQRtRnuUet6diw+rg8oafvfrXYMZCnTgfoCL/914oJDLhG4XzB7FEy6UtS
         kL4YP1OQFQI9Q==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5A4F9A0060;
        Tue,  6 Oct 2020 04:06:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7C3978109C;
        Tue,  6 Oct 2020 04:06:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JQb8UnsT";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwkpesWo2ekuDVyOWZXkknsPUEgYbT72j82JivJeKnLXmcGwG/5OkGFLucOd+XQDVV6XQcR0vRV4T3MvCsvrDPI4ZDkDGNTk2/4QGdd9U6VoJp9FPB8H9kTIpl2wVjxmMEEo2cXhjt1U9FsW/GfhlyrFWh8A1HED3SnrV5wkNVTGtj3Jjs1SDCB5wngoF5a2Hr2RCyBZRuaGAkjWCYarDNfRmyESzChqapNBMcQIc13ftI5LX/fat0MDKohJvEPNPQ3PQ3KEvNc2PpFL3P64E+rhp95eMIMOK47vzQjR7VBHsrWDGHwTsAGfU71modqyAilvxGIrj6KvMRJx9JhJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI3w52hfc17eokkuPBtz9+dhVlPp+6QXiRkEU5ZojKw=;
 b=IPpC55+MGsdNhqDiHoEF4R/d4vgGVHjIbJ7510YF0NR2MiKJjYglQcfa8Uv8apIsa/wQYBLZF9x9TovID3ug2WuqooW5w6L7P0guo2NUAppZH5uow01nXGhsuJDAdiHpnpPmknOCfIpnnhk2bdBxD1H9Td6FA9w8cAT5DCiKhH4NPb3T28X1sIrLbxoMozQzltLyQt9Y3ZTyC3yM1Bc/KbSALIrxJtoPyjOUOWNtFh2Oe4CcUWH6pZeYKrKSVnpCxvWea7MGCK3U3jAS5zooGqUU92Gbsub3qAG3UB/5/MOG00qRXQviIRj9LOxY2sry2g7YK2qdDjVXI7tbW33cFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI3w52hfc17eokkuPBtz9+dhVlPp+6QXiRkEU5ZojKw=;
 b=JQb8UnsTjVUlLNAVRAbMKED4k7GlVUaiUKIHIAYiw4JT7il3k7zVBFrhoKRjqMusktgLWSjnjwf2Uxlh28IaNJwwXwq7nfcqio7GGsDo/AmmEvgEfnNu1xooVmGncqFOGpsVVkMK2tAkz3QR0YIKqG/S54wp/yDjn8Cf5nu71hQ=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 04:06:49 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8%5]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 04:06:49 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] ARC: SMP: fix typo and use "come up" instead of "comeup"
Thread-Topic: [PATCH] ARC: SMP: fix typo and use "come up" instead of "comeup"
Thread-Index: AQHWmzJekZM2xBo6ukGeKV7KQTBq56mJ9dQA
Date:   Tue, 6 Oct 2020 04:06:49 +0000
Message-ID: <71c1df03-569f-a698-516a-212e767f8c5d@synopsys.com>
References: <20201005161237.196566-1-rppt@kernel.org>
In-Reply-To: <20201005161237.196566-1-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fef1052-c201-4f9c-5a01-08d869ad3fb0
x-ms-traffictypediagnostic: BY5PR12MB3924:
x-microsoft-antispam-prvs: <BY5PR12MB392475FB0028EC1A7EB3B516B60D0@BY5PR12MB3924.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2d4JYX3qVgfbtgB2dUnvh679OSCEJnKl+Np2GWCsq3yJ+w0eIJ9K+XDoaY6qJ5nsfLHw5L7nglcqcTzSh17Z2kgQ67l24heNWoIbkVycnBrpKa3XfsFNmQ8EyZXlWg0O/BL3d6GgCS4AC1zn2V5PyroR309qsaCzlp1kEXcdH48cmHd69weUGHiRqWCV3ksWEJZZfAAOxtp49IP+b/AZwuGk8n5LF78X54MUzcEIo2EXurrwU9XnVlS1+Wnjbmin5e58QhIpQIEW7tg2glvH4YECknvUKeliAdjoYwGiBY4jk+D59c7Uvwegyj2oBiR7cBgQmkRnbMl5zKm8a8Mgsqz3ZeD4uLIbIYrNPNtCSj0iwWucxVQJGPyYoQaYxKw/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(8676002)(8936002)(2906002)(83380400001)(5660300002)(31696002)(6486002)(71200400001)(31686004)(26005)(2616005)(6916009)(186003)(76116006)(66556008)(53546011)(64756008)(6512007)(66446008)(66946007)(6506007)(4326008)(478600001)(66476007)(316002)(54906003)(36756003)(4744005)(86362001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vxlk6s0Iuzcc2dr83+gt6GspzYsm/zvdXBD8DWeKuoFmF640s+K6YnOJf/HrHourtp0H7WHiQ0ZsbLiUbRy1d++F6pjr9Zde57Sb8g768JX1sFVu9ByuFFzS2Q/pk1vNqHqS/6zTQpc3yFLpKm2jMoLriuWO1MHEJ8xr0tGuv+B4GqKQNpRxEyIdiHbubfkusVgutuxq9LfA9TYrmU3856rnMQazC9m9LJSa/dcHgXWUPMeoafFABIsN3jfAfvSyPcm4TTzl/qjA/8zmdlSWUKFt//nvLwbPlQ1M4q8dErqvT7Yi+Mw5tkvjQ43dc2OgYhDEklDaEFN+JL6umzvZhP15ka9X+OgvX/ZgZsxl6BYEJBIsXGPklxY+RoxqCAAd09/Bo1wgPsR/1p8r4wtgmG7qpuJmGWoGZRKjvCN8VaPBwc3nSL6VYcnonObksnNP6jKSEBkJ4dW5zpOrgTNxRlAFcgsks0USl65avPV/L5oeW1KPov50PPti1JgG3wTE+PaiYgiq3ImFHbkLfwETXaGAjdCZEgt8e6X6UYyl3mvrSu2ftqXtQuwSWzKEygfItAHx6u3rM9m/oCXnsUnuvoftGjZjUUVpmzmvYxXjy30hDdptfQNJoV9dUpQVopAikjFzLcO5e19+yA0HgZlbIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F11F1FF4A511C1419CEBEFF209DDD1C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fef1052-c201-4f9c-5a01-08d869ad3fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 04:06:49.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9i5gswg3tCAGq595kj6VJcmRyckL0K7FLnAyw4DuO1+8WbNS27/LE/I5LKIcvDCvK3AOGI7LzpjTJ8fmT3zTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMCA5OjEyIEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBGcm9tOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBXaGVuIGEgc2Vjb25kYXJ5IENQVSBm
YWlscyB0byBjb21lIHVwLCB0aGVyZSBpcyBhIG1pc3Npbmcgc3BhY2UgaW4gdGhlDQo+IGxvZzoN
Cj4gDQo+IAlUaW1lb3V0OiBDUFUxIEZBSUxFRCB0byBjb21ldXAgISEhDQo+IA0KPiBGaXggaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+
DQoNClRoeCBmb3IgdGhlIGZpeCBNaWtlLiBBZGRlZCB0byBmb3ItY3Vyci4NCi1WaW5lZXQNCg0K
PiAtLS0NCj4gIGFyY2gvYXJjL2tlcm5lbC9zbXAuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJjL2tlcm5lbC9zbXAuYyBiL2FyY2gvYXJjL2tlcm5lbC9zbXAuYw0KPiBpbmRleCBlY2EzNWUw
MmNlMDYuLjUyOTA2ZDMxNDUzNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMva2VybmVsL3NtcC5j
DQo+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9zbXAuYw0KPiBAQCAtMjI2LDcgKzIyNiw3IEBAIGlu
dCBfX2NwdV91cCh1bnNpZ25lZCBpbnQgY3B1LCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmlkbGUpDQo+
ICAJfQ0KPiAgDQo+ICAJaWYgKCFjcHVfb25saW5lKGNwdSkpIHsNCj4gLQkJcHJfaW5mbygiVGlt
ZW91dDogQ1BVJXUgRkFJTEVEIHRvIGNvbWV1cCAhISFcbiIsIGNwdSk7DQo+ICsJCXByX2luZm8o
IlRpbWVvdXQ6IENQVSV1IEZBSUxFRCB0byBjb21lIHVwICEhIVxuIiwgY3B1KTsNCj4gIAkJcmV0
dXJuIC0xOw0KPiAgCX0NCj4gIA0KPiANCg0K
