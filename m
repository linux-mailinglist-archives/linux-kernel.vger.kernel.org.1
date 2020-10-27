Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC929A6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509193AbgJ0Im6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:42:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39221 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505142AbgJ0Im5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603788177; x=1635324177;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jby9/8whFks9bsJr7zWsRdItlb75VD37/uaNpkeb1As=;
  b=ZMgOFY7qGN78kBihKS6+CEKrkcCLnpdfUtp6qKpjKNrvOhfFrDxPC4ae
   jMc/4BpenVa/MJR4fpimWz3npbDEmH+VJDrHmOJBiYrenjHsTkoshAJuC
   ljfy3v89Z6C+MQgx0GtQaD3xdp3Ua+Xe1Y6OUE90dJNGcUzA8eg/FO7Cs
   TxRxgyIBXLaMf4R4i696ROReBxq1a4DJTqX347dPQ3xPnIPmoj4b9NAvJ
   fwuDiaE+wo6lDshKvBZMP9wAb+apUiEX02Ewukbui/Qe7giu33kemXxF/
   LtT5u9tctNu11Apw6UGf7UWqalc/Qm0Fjuw0BqUe6KVY2rb9/RPnT9Si/
   g==;
IronPort-SDR: MvEmskrAR6XJ1HY+fOMDAbuLBB52qTOC/uUeinay+VYfLzpORgpyPVZW5zbo9ii0Pk7TMJOOuj
 eJK069q+yKCNp3+s6ZLsRxLnhPfnUABClEOALudZ7Feq8OcXqc41KsS3oqVUQ8edhmofBEq+HR
 PuKRnkxfwbSqeOsW0hdviD/F9UcRMTlOBqDp9xm36RtHx3i8p18HMZk4kLntuUektE6rojcQcN
 PfvO2ctlfTswvottuJDsNQ+TXNXSdqJ3ZdHNJ263OHicPYmLMEny7DN9PD4zU94OOyZaRuj7pU
 NH8=
X-IronPort-AV: E=Sophos;i="5.77,423,1596470400"; 
   d="scan'208";a="152195058"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 16:42:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsPomTQaoyL68iYw+ymOMmC4NUtskSPl0th66zl4oFvbWN+idcK/1SLCQ5xTWJmUHOW1tzuNycJxmWfmK9/J/Z7xx/XrcO3ibjjW1oK0/s9aovZxnRp8fYtxzhbn5+Ju4rkwwx8FLdUQDpYE7pCcsr6f0CuHMN6QltBWaTfxnHw4eDaJqnYeCU1APdkPCfgh1LjW/rFzIMCfqeEf+gZox+9BKP6lc/94Av8w7PfpjdDGlgbWiZenwxze1LAYuG0EJVjto8+kN7Fcd7b/YtzzQlaWjmun3zIrpOxMO6e6KqcZgjwhCSCFAm7JdsN7NkI3dv1iwOzFvKDqL8xDfd8IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jby9/8whFks9bsJr7zWsRdItlb75VD37/uaNpkeb1As=;
 b=X291p5upnx0Um6mdS50P+Em94AYNbxNqHHAsJsFqvBo2vJ+Lc8Ly70aY6oPIL0Jcxd+cGEjWPJBqwWqEBURNQapUpRV4S4tUnNK7jhv9Uiuj4CAD5oi5dz3pNNHWgUZ4Mns8qCZuvrRmh9zV3wEvkWcY7s+kT8Yc+F6mdbUPLTc/Jbc6dJsgQxuG6EPybPfMsU4s2F7/kR1KOBqff2pocWmBHepdYw1aG2C+Hqi4/fQe+R6s1fepARvmJSRpeuEiniZFxPO5gsfOhTT3LtPZXPs+DPKWDkOOLpALY7yyNmTNqdnrEzthBY4Hv7d1ghlcjA1Rcpk8YZWt2XhqjlvmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jby9/8whFks9bsJr7zWsRdItlb75VD37/uaNpkeb1As=;
 b=FaP3PtZAEwDsQjuBQ6NaDPp3M9b5PxZ6poC1D+tWxRLvrETW1PDby3URVFYehlxy8WsfRVYT648VTxfysqzlQouph2+jn/PASXRQ26Sn+rtEEOmRwzZ8g+Za6wb3C5MAu+smmxEHKcldnVXn8EDeTrp+jvq6foiEbhBeDlp8lBA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4398.namprd04.prod.outlook.com
 (2603:10b6:805:32::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 08:42:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 08:42:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     AGeissler <Andreas.Geissler@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "crustyaw@gmx.de" <crustyaw@gmx.de>
Subject: Re: [PATCH RESEND] MAINTAINERS: Update maintainer entries for MEN HW
Thread-Topic: [PATCH RESEND] MAINTAINERS: Update maintainer entries for MEN HW
Thread-Index: AQHWrD0o9NhausrnrkClMYR/TbFHSw==
Date:   Tue, 27 Oct 2020 08:42:52 +0000
Message-ID: <SN4PR0401MB3598F84B3C60AF1BCBF67A249B160@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200603071049.7309-1-Andreas.Geissler@duagon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [2001:a62:14ff:e901:99c1:aeed:d6c6:6a34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 685f7ade-d662-482e-36dc-08d87a544b39
x-ms-traffictypediagnostic: SN6PR04MB4398:
x-microsoft-antispam-prvs: <SN6PR04MB4398EF3A7CB18B4EE8A9B2399B160@SN6PR04MB4398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5RknmDp0EddrTkFQfcxtHGUXoD8uYmczfYXIRNfTB4NaOtJCMDmEK+5P3dLxAfJsqDZZA9Zf9IgjS8dbM3y+0gZcuTi8waEZ6IBQoNCYMikYu9s5S5p61GeInm5u1fpulPnwoU8q7AyJa6dtDYyG4iMwEgF7EZc3edq0G7BH9aHhJIMus84VtWIrHx3WF18etcmQhJ83+QPkCnUQdvEPXyiSxuvSm0ePT0NE0HRyQ5fGqf9dBo8qrh2rYnESB3ksCAOkouxyo59d5F69Uubc9NyTmxMxwqzmkLdDMQfFwz6x6v7+GNTJs2LXKXYv0X4aDnVzGcjQu6pTRmS1K6JVmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(76116006)(9686003)(66946007)(7696005)(86362001)(64756008)(53546011)(66446008)(91956017)(186003)(6506007)(71200400001)(33656002)(66476007)(5660300002)(55016002)(66556008)(478600001)(54906003)(2906002)(83380400001)(52536014)(4326008)(8936002)(8676002)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: luDJL0+8n+RH0BfFL+XhKRuQOLnKNwjxoECvkNP0tq4EtiE+lLU39gsFNplIcqDrfLMmpERhFmprDqsPfM8oTtPTqD1ou1IJaEJLb/AqY+pIz7bCZLOKgMGhaU4O4pvsWeujp/8qOzvwHxOoa2EJnlyuWhDj5CsAqE/HseF2PTvJA7aCDllvSg5+DA7TI2bxOUDXa+zSWmeN4kiazhaE7y0SU4BHvzr7XMf0Xu5kQpcqRyoSIAINSDeZs7JnSQxHbE1hneZIROvD+DX9hVQ0xTruYOCM6ZnnOXx8g+DZU48eKY4c1/qdATu28W5M553SAL/Nqb13G5Oytj9iq/XAWYCnye/uzcQrOOaXWIVW77j2BF6t+nXbeERqOr0NYvxTPLnbQ8XXw6vfeyQqpKpBWY4ADp30ySgqybCf3vjtHGNzGRKUDxWJ4Oo4ubnqIXiYXGReS9px/MlirfRHKSm+OKf7xXFxvZvh9oC2CF3ibEB4hM8Om5vHTXCk2eF+5oV5DcFPb0TekDWyDPAnur9oG6pJKu1zdglgMjjIj8EtPNjeYyrCMtJFe7NCEwl9z27JJWydl4asco0EweZi/i7kJO95HDQ/UPfpk+fBqpea+e364OmJlWIGHVm/vYKUoR78tEBF2z4zZcXA0n0cxBmbBygzvHFSlHLKz0FcrPHFuWbF7qnmLD/QynLmedKFEXKSNP2aoXP3qVQLofCBrd506Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f7ade-d662-482e-36dc-08d87a544b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 08:42:52.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Zf7waVc3JGwu2/rdj/BulePS9s9N5xlNhDzDKmJ7GMa0STGOhpJ/9eHr5/TG5Kz85AK3VUsunKq4BBvuM3gsiw//EjT4t7+gvuUcTKZbQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMvMDYvMjAyMCAwOToxMCwgQUdlaXNzbGVyIHdyb3RlOgo+IO+7v1tyZXNlbmQ7IGJlY2F1
c2Ugb2YgbWlzc2luZyBjY10KPiAKPiBSZW1vdmUgQW5kcmVhcyBXZXJuZXIgYXMgTWFpbnRhaW5l
ciBvZiB0aGUgRjIxIEJNQyBkcml2ZXIsIGFzIGhlIGlzIG5vCj4gbG9uZ2VyIHdpdGggdGhlIGNv
bXBhbnkgYW5kIGFkZCBBbmRyZWFzIEdlaXNzbGVyIGFzIGFkZGl0aW9uYWwKPiBNYWludGFpbmVy
IGZvciBhbGwgTUVOIEhhcmR3YXJlLgo+IAo+IEFja2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGp0aEBrZXJuZWwub3JnPgo+IEFja2VkLWJ5OiBBbmRyZWFzIFdlcm5lciA8Y3J1c3R5YXdAZ214
LmRlPgo+IFNpZ25lZC1vZmYtYnk6IEFHZWlzc2xlciA8QW5kcmVhcy5HZWlzc2xlckBkdWFnb24u
Y29tPgo+IC0tLQo+ICBNQUlOVEFJTkVSUyB8IDEyICsrKysrKysrKysrLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXggNjhjZDFiOTY2YjQ1Li5iM2I0NWQyZTlj
OGEgMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiArKysgYi9NQUlOVEFJTkVSUwo+IEBAIC0x
MTA0NCwxOSArMTEwNDQsMjEgQEAgRjoJaW5jbHVkZS91YXBpL210ZC8KPiAgCj4gIE1FTiBBMjEg
V0FUQ0hET0cgRFJJVkVSCj4gIE06CUpvaGFubmVzIFRodW1zaGlybiA8bW9yYmlkcnNhQGdtYWls
LmNvbT4KPiArTToJQW5kcmVhcyBHZWlzc2xlciA8YW5kcmVhcy5nZWlzc2xlckBkdWFnb24uY29t
Pgo+ICBMOglsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcKPiAgUzoJTWFpbnRhaW5lZAo+
ICBGOglkcml2ZXJzL3dhdGNoZG9nL21lbmEyMV93ZHQuYwo+ICAKPiAgTUVOIENIQU1FTEVPTiBC
VVMgKG1jYikKPiAgTToJSm9oYW5uZXMgVGh1bXNoaXJuIDxtb3JiaWRyc2FAZ21haWwuY29tPgo+
ICtNOglBbmRyZWFzIEdlaXNzbGVyIDxhbmRyZWFzLmdlaXNzbGVyQGR1YWdvbi5jb20+Cj4gIFM6
CU1haW50YWluZWQKPiAgRjoJRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL21lbi1jaGFtZWxlb24t
YnVzLnJzdAo+ICBGOglkcml2ZXJzL21jYi8KPiAgRjoJaW5jbHVkZS9saW51eC9tY2IuaAo+ICAK
PiAgTUVOIEYyMUJNQyAoQm9hcmQgTWFuYWdlbWVudCBDb250cm9sbGVyKQo+IC1NOglBbmRyZWFz
IFdlcm5lciA8YW5kcmVhcy53ZXJuZXJAbWVuLmRlPgo+ICtNOglBbmRyZWFzIEdlaXNzbGVyIDxh
bmRyZWFzLmdlaXNzbGVyQGR1YWdvbi5jb20+Cj4gIFM6CVN1cHBvcnRlZAo+ICBGOglEb2N1bWVu
dGF0aW9uL2h3bW9uL21lbmYyMWJtYy5yc3QKPiAgRjoJZHJpdmVycy9od21vbi9tZW5mMjFibWNf
aHdtb24uYwo+IEBAIC0xMTA2NiwxMCArMTEwNjgsMTggQEAgRjoJZHJpdmVycy93YXRjaGRvZy9t
ZW5mMjFibWNfd2R0LmMKPiAgCj4gIE1FTiBaMDY5IFdBVENIRE9HIERSSVZFUgo+ICBNOglKb2hh
bm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPgo+ICtNOglBbmRyZWFzIEdlaXNzbGVyIDxh
bmRyZWFzLmdlaXNzbGVyQGR1YWdvbi5jb20+Cj4gIEw6CWxpbnV4LXdhdGNoZG9nQHZnZXIua2Vy
bmVsLm9yZwo+ICBTOglNYWludGFpbmVkCj4gIEY6CWRyaXZlcnMvd2F0Y2hkb2cvbWVuejY5X3dk
dC5jCj4gIAo+ICtNRU4gWjEzNSBVQVJUIERSSVZFUgo+ICtNOglKb2hhbm5lcyBUaHVtc2hpcm4g
PGp0aEBrZXJuZWwub3JnPgo+ICtNOglBbmRyZWFzIEdlaXNzbGVyIDxhbmRyZWFzLmdlaXNzbGVy
QGR1YWdvbi5jb20+Cj4gK0w6CWxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcKPiArUzoJTWFp
bnRhaW5lZAo+ICtGOglkcml2ZXJzL3R0eS9zZXJpYWwvbWVuX3oxMzVfdWFydC5jCj4gKwo+ICBN
RVNPTiBBTyBDRUMgRFJJVkVSIEZPUiBBTUxPR0lDIFNPQ1MKPiAgTToJTmVpbCBBcm1zdHJvbmcg
PG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPgo+ICBMOglsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmcKPiAKPiBiYXNlLWNvbW1pdDogZDZmOTQ2OWEwM2Q4MzJkY2QxNzA0MWVkNjc3NzRmZmI1ZjNl
NzNiMwo+IAoKCkxvb2tzIGxpa2UgdGhpcyBuZXZlciBnb3QgYXBwbGllZC4gR3JlZyBjYW4geW91
IHBpY2sgaXQgdXA/Cg==
