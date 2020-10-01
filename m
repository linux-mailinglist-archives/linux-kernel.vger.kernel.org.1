Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58472280116
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgJAOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:15:15 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:2722 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbgJAOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601561713; x=1633097713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kMNjzJjRj8LDl65NeVvuA4I20E1pUR9vPdaM1vX418Y=;
  b=yjF8xD0tkUEzisqpuASktCXGlWIlgNHiEzV0NsGziz6HCxyUK5l/5nJO
   Z98ifA1df5JzciZzQ97KFiD49/1q/STV7Edkic4t3h4M59C8d+KXhHaSY
   B2wxwwo7zQTF+1eF8wnXzUReIRNeHaHvZir5oxtTEzfUfGRw2wLseKXT/
   Tp7KDVM1RJ39LdLMIqGbC2rQEtbtzEOoFm5RTjZyPfsK0b/4PVDeJQm4B
   8Ay/ueqvtwk5mKz9I10lVLjcSOAQB+enxuySr1fRQWDHBoSpZV4tzhFsg
   qO/jkmw0xiua7ZSqLgUVraYFSWWtAms0FnOxbrk3xhxfU894v/pfKhsPA
   g==;
IronPort-SDR: cuBMwyPTRth0BhZMy1z1+0BdRe6LDuuwK8r5SZQh0+nR+nmKiCehTOFWHRQewkLbR2dP2gzCGQ
 O87GM5IeAWyhhN/YqqGvweUw3iR/JAGVzMfOTCxgfMNjhqHIgJq84hgrIAaGcXXRTjgda672u4
 gbGj6GCUfs89Hm+xc+i7i13JBIvgMXjZ8rPAJQpMwV6nWdgvfqb5hy3h1pWAFGBApDkZxZvmYK
 oPNGgNriz36GKschUjHon59LY3+fxpDRSNPxqv5u8a9351ULhRoMnfXGaP2ls61XIgZocEK3zX
 mII=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="28385796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 07:15:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 07:15:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 07:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaRQwNe9ALWuhcHRZ9Vx3jsR40NYwdpMo/GJa5EDmkIiFUFzvkTD7Epgkzd8rwNKwqFbkpP0GQKizDA+usX/IfYocKj1Jt2Xy6yT/CKP7Q7NoW6E76xtvmPdV0ldgaowe0ipb4ZINX9z0nFG1Cp3HFxiaf4kBhdkUPFzG8TvGOrsy/DJwTKri90kOgsFaMS5mLv+IjrjdE95FLTcIH7aWIBufzc/+CrAXnQW4guZ9EfY37cfDqMtW2KS5mhGrJEcdo3f193X/quhSlswIz7ccC1r14iGunQ6BW4yq3yUp0KeWlKLUuH+qcVR9SLcQqKBTsK/W9IUjF63qrSEszGttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMNjzJjRj8LDl65NeVvuA4I20E1pUR9vPdaM1vX418Y=;
 b=Tttj9BtBg7LHeW6TkTq1kt1QVNf7a52/dsCp/dN3qLX9lQmMDq3KjNVs23fKDLnGsFP4i+otyI9RTvcJND0I8fjZOOqPhr0/CcaNkxMrQao7MOx7k4A2zFXDVkK/1xinAUd9d52L6Kct6Gl/ftI1XC+2gktiCE7apz6pUCW0qneUGE8Xrtb1LOD25b5ud+PmGYPXGvYHZxsiYCu+GVueQbPYLXSHAPc2oOHlmhb6SO0mTjEVz/gNtPWQUiIMusBtbrLr2h6GIl5Y+5ZxH2UG535WGb3OIUn4eqLLPK1JpJrNqO3ZuHdTQDYq11wuANoFOO/E5TPMyOztA/OTDGl7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMNjzJjRj8LDl65NeVvuA4I20E1pUR9vPdaM1vX418Y=;
 b=Ra2HgNeUf03JF+vrFHI9DepcDgpiu0igQQl42pHE5E/CmePr9GgrhLAbmLuHUeIV8AbsPrHKwdl+hscaAiQbThLTjtYlqEZLzNew9dcb/6lFE086V990uG0bzEytDJ3BXElYpRDy7iwIG8/GM8FZ8hKuMUhIyIqmAUA4dhnErXI=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 1 Oct
 2020 14:15:09 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:15:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <bert@biot.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Topic: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Index: AQHWl/1EX2rNJEczUkGjcv47/rFXbw==
Date:   Thu, 1 Oct 2020 14:15:09 +0000
Message-ID: <b52a0d85-050e-1947-1a18-d2dd5aec4482@microchip.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
In-Reply-To: <20201001063421.qcjdikj2tje3jn6k@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a493ca31-edda-4086-4e66-08d86614679a
x-ms-traffictypediagnostic: DM6PR11MB4236:
x-microsoft-antispam-prvs: <DM6PR11MB42360F6EF04E3E5460CA8485F0300@DM6PR11MB4236.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bR9UxmHoUrLJoe1KzVKl6Q63kfwIPA1jweQPh5DA0ehzIHxZ0/X0+bD3dw0uyRdnfXJIRgU7lQicF5prgA9N484ekVZfQhPrnu7rA6MHS7IcTllWD+aku1xL6xGMW8Tx2GMG80qDWgDBYqNublKPlcLAJeRP9guf7v77JabP/mEKpeL6K+OlOUIgNOMTsfRWOgEfN3UUdeCCFsx4uwukwfq2paN2Dimri8uc8ZN+u0BMjLRr9YtT39hmc6LhDXb/nMpAJoBFtAOHj0cLjOglw62Oc7y2RQfCS9LcTkn76U1xLszQ+er83daJzUPD+s8SRBhOV41B6Ze4GAw9UxdcbgF8DpPm2FkNoqJtGr/gYTHfrX+7i8ZovVr/kH70ZId4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(8676002)(110136005)(54906003)(316002)(76116006)(66946007)(91956017)(2616005)(83380400001)(66476007)(53546011)(26005)(66446008)(5660300002)(66556008)(186003)(6506007)(6512007)(64756008)(36756003)(6486002)(31686004)(71200400001)(8936002)(4326008)(478600001)(2906002)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ehSDz8pnj6DRpQB/fFK4fbknXFZ/OMWyw+9y+1SrzWvI7C05mQGTthDwu12a/iihipmx/wH6WcYyGn+MUYv2FomFRwX0O8I2PCnhsZgLATSgIIOxbesSj3YcVs+Krgy25uu26KiBCQVvp5kj8G4gFnWRHiaYuWVWUrfezhb6LoIYfYdQPmkzQ90DekTVguavUWpT1/jzMqg36kgl4fqEwBQgEeBF8A+fVY97iMYAUArRAgTEobvNmEvfzMu64BMr1g7SSpSaEWaeik9w8Qs6okb8mt7rPCAVHSPOYa7qcMmDMaX7i3xMgYLQyVHNqdy87APYzs2NVnnUZkjQWYsbk1oWyMQxA7RcODQlUSeHtHBcJVC5ViZp9x4PNIV10k1osWTFTcr/bQOx43w5XFDoYA2mD7viILIhXUHH78CfogUlbndbLUd3FZLUOSynRemyw83RQEORI8rilIB50UizPFNFuHdGZ8y67hPZNrvJ9aH8QkVmBo/ABb3vYXBH7qZB4pMh8Ih1NuST3OQj1E0Gl8x3ONEwBf2lbf2hr3Ax41Ty5lk5BGDM7uW3jVAkBFaSrLIyGaYizEWQhCakFew5XIwE41JTvTJiwt28rtsBb7pGMpMPAtJNJJQvtzR7qvgEN7QmhUnkPtURsRQGdduPsQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B883D29CA17E42865A2061B6586621@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a493ca31-edda-4086-4e66-08d86614679a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 14:15:09.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COZm3QQ+sP9OW3GVnH6a4FhbNI6UIsX4Lk0vtBWRbYAou0tcJlWqaECaJ4CEM8RT42Vv3ntdPFYRIBGH4yWQ+FwRHOzN/ATns8keoOQGv5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4236
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCA5OjM0IEFNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDAxLzEwLzIwIDAxOjU2
QU0sIEJlcnQgVmVybWV1bGVuIHdyb3RlOg0KPj4gRmxhc2ggY2hpcHMgdGhhdCBhbm5vdW5jZSBC
RlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNfT1JfNCBjYXBhYmlsaXR5DQo+PiBnZXQgYW4gYWRk
cl93aWR0aCBvZiAzLiBUaGlzIGJyZWFrcyB3aGVuIHRoZSBmbGFzaCBjaGlwIGlzIGFjdHVhbGx5
DQo+PiBsYXJnZXIgdGhhbiAxNk1CLCBzaW5jZSB0aGF0IHJlcXVpcmVzIGEgNC1ieXRlIGFkZHJl
c3MuIFRoZSBNWDI1TDI1NjM1Rg0KPj4gZG9lcyBleGFjdGx5IHRoaXMsIGJyZWFraW5nIGFueXRo
aW5nIG92ZXIgMTZNQi4NCj4+DQo+PiBzcGktbm9yIG9ubHkgZW5hYmxlcyA0LWJ5dGUgb3Bjb2Rl
cyBvciA0LWJ5dGUgYWRkcmVzcyBtb2RlIGlmIGFkZHJfd2lkdGgNCj4+IGlzIDQsIHNvIG5vIDQt
Ynl0ZSBtb2RlIGlzIGV2ZXIgZW5hYmxlZC4gVGhlID4gMTZNQiBjaGVjayBpbg0KPj4gc3BpX25v
cl9zZXRfYWRkcl93aWR0aCgpIG9ubHkgd29ya3MgaWYgYWRkcl93aWR0aCB3YXNuJ3QgYWxyZWFk
eSBzZXQNCj4+IGJ5IHRoZSBTRkRQLCB3aGljaCBpdCB3YXMuDQo+Pg0KPj4gSXQgY291bGQgYmUg
Zml4ZWQgaW4gYSBwb3N0X2JmcHQgZml4dXAgZm9yIHRoZSBNWDI1TDI1NjM1RiwgYnV0IHNldHRp
bmcNCj4+IGFkZHJfd2lkdGggdG8gNCB3aGVuIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19P
Ul80IGlzIGZvdW5kIGZpeGVzIHRoZQ0KPj4gcHJvYmxlbSBmb3IgYWxsIHN1Y2ggY2FzZXMuDQo+
IA0KPiBKRVNEMjE2RC4wMSBzYXlzOiAiMDFiOiAzLSBvciA0LUJ5dGUgYWRkcmVzc2luZyAoZS5n
LiwgZGVmYXVsdHMgdG8NCj4gMy1CeXRlIG1vZGU7IGVudGVycyA0LUJ5dGUgbW9kZSBvbiBjb21t
YW5kKSINCj4gDQo+IFNvIHVzaW5nIGFuIGFkZHJlc3Mgd2lkdGggb2YgNCBoZXJlIGlzIG5vdCBu
ZWNlc3NhcmlseSB0aGUgcmlnaHQgdGhpbmcNCj4gdG8gZG8uIFRoaXMgY2hhbmdlIHdvdWxkIGJy
ZWFrIFNNUFQgcGFyc2luZyBmb3IgYWxsIGZsYXNoZXMgdGhhdCB1c2UNCj4gMy1ieXRlIGFkZHJl
c3NpbmcgYnkgZGVmYXVsdCBiZWNhdXNlIFNNUFQgcGFyc2luZyBjYW4gaW52b2x2ZSByZWdpc3Rl
cg0KPiByZWFkcy93cml0ZXMuIE9uZSBzdWNoIGRldmljZSBpcyB0aGUgQ3lwcmVzcyBTMjhIUyBm
bGFzaC4gSW4gZmFjdCwgdGhpcw0KPiB3YXMgd2hhdCBwcm9tcHRlZCBtZSB0byB3cml0ZSB0aGUg
cGF0Y2ggWzBdLg0KPiANCj4gQmVmb3JlIHRoYXQgcGF0Y2gsIGhvdyBkaWQgTVgyNUwyNTYzNUYg
ZGVjaWRlIHRvIHVzZSA0LWJ5dGUgYWRkcmVzc2luZz8NCj4gQ29taW5nIG91dCBvZiBCRlBUIHBh
cnNpbmcgYWRkcl93aWR0aCB3b3VsZCBzdGlsbCBiZSAwLiBNeSBndWVzcyBpcyB0aGF0DQo+IGl0
IHdvdWxkIGdvIGludG8gc3BpX25vcl9zZXRfYWRkcl93aWR0aCgpIHdpdGggYWRkcl93aWR0aCBz
dGlsbCAwIGFuZA0KPiB0aGVuIHRoZSBjaGVjayBmb3IgKG5vci0+bXRkLnNpemUgPiAweDEwMDAw
MDApIHdvdWxkIHNldCBpdCB0byA0LiBEbyBJDQo+IGd1ZXNzIGNvcnJlY3RseT8NCj4gDQo+IElu
IHRoYXQgY2FzZSBtYXliZSB3ZSBjYW4gZG8gYSBiZXR0ZXIgam9iIG9mIGRlY2lkaW5nIHdoYXQg
Z2V0cyBwcmlvcml0eQ0KPiBpbiB0aGUgaWYtZWxzZSBjaGFpbi4gRm9yIGV4YW1wbGUsIGdpdmlu
ZyBhZGRyX3dpZHRoIGZyb20gbm9yLT5pbmZvDQo+IHByZWNlZGVuY2Ugb3ZlciB0aGUgb25lIGNv
bmZpZ3VyZWQgYnkgU0ZEUCBjYW4gc29sdmUgdGhpcyBwcm9ibGVtLiBUaGVuDQo+IGFsbCB5b3Ug
aGF2ZSB0byBkbyBpcyBzZXQgdGhlIGFkZHJfd2lkdGggaW4gdGhlIGluZm8gc3RydWN0LCB3aGlj
aCBpcw0KPiBjZXJ0YWlubHkgZWFzaWVyIHRoYW4gYWRkaW5nIGEgZml4dXAgaG9vay4gVGhlcmUg
bWF5IGJlIGEgbW9yZSBlbGVnYW50DQo+IHNvbHV0aW9uIHRvIHRoaXMgYnV0IEkgaGF2ZW4ndCBn
aXZlbiBpdCBtdWNoIHRob3VnaHQuDQo+IA0KDQpJIGRvIGFncmVlIHdpdGggUHJhdHl1c2ggdGhh
dCB3ZSBzaG91bGQgZm9sbG93IHRoZSBTRkRQIHN0YW5kYXJkDQphbmQgZG9uJ3QgY2hhbmdlIGl0
LiBTbyB0aGUgY2hhbmdlIGlzIG5vdCBhY2NlcHRhYmxlLiBUaGUgc3RhbmRhcmQNCmlzIHRoZSAi
bGF3Ii4gSWYgbWFudWZhY3R1cmVycyBtZXNzIHdpdGggaXQsIGFuZCBmaWxsIGJpdHMgd2l0aG91
dA0KcmVzcGVjdGluZyB0aGUgc3RhbmRhcmQsIHRoZW4gd2UgaGF2ZSB0byBmaXggaXQgdmlhIHRo
ZSBwb3N0IHNmZHANCmZpeHVwIGhvb2suIFNGRFAgaXMgYWJvdmUgbm9yLT5pbmZvIGZsYWdzLCBk
b24ndCBjaGFuZ2UgdGhlIG9yZGVyDQpvZiB0aGUgaWZzLg0KDQpDaGVlcnMsDQp0YQ0KDQo=
