Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A427FB64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgJAIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:21:04 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:40962 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601540462; x=1633076462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NkP4xDEKRLPfbxw9D378wtTzrlfQkW4JRIBOiB/+OqY=;
  b=LYfpNK3SNe7YdkKzcBku+EzWgFAO8yd1XHAIBzVWKO25A4Dti0aJCvEJ
   Tw3IZ35xRbWB9RzRthydfKTLNp9tzBh2TUFuNuD0RhEUwDIDT2sP/uVtk
   GeIsLUXkw8MHeAsRvQ71DqDz1KZjKHbopFsww5XWc7oCXdqMpTBGqbHTT
   D8f18i6MCi5R0VwWDgQrPaIUGkReaYVsqdWQpvMpRJrGS7N7IMZ9F41li
   n7n2ksKuUnGvrTRT/7VRt9TO3MflGnU1rzBkC8XXE0VWk0Fgc5yx3LY2n
   05ohb8PiyU3bOz2lSF968q9utTQ7qLYn19KrjK85Yf70wVZ1eL/4L3qT5
   A==;
IronPort-SDR: yr1SZA/PTKFNrN6HI0yj+G9JIy8dBArT8p9frLzq4M/MV4mR4n6E22JTDbc/xt7GIdEj90cLiA
 A0PVFZFCVKvbyntgaTTq7gb5dgb6JdQDU1kxy0hBXlqz3N+NPGw6kdB7480t1Fr1DdoRJRsnUL
 tuKQlypiaIyH6DRQUzzBxBxmvp7FQsaF7V1PASQYzhY+F7171veUBshUcDP+h5aBKcoXikNXF5
 xDhIKkTxGea02dBgrfuvKhlLOkhNe9XjQPwbc2VTUVB/v+ayKM0Ak0P3euRgHQu+RnpUnJm0Jx
 PcM=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91054010"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:21:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:20:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EntYXOu0WGyI8gCa3MyhANXBQV5lKc/TqCuoRxQ8x4zd9RrGIHfUlT7/LUB8oKUjAgwsH/+0aeL7TFWaORbN6HZBSDD1/n/WnvhD/il/PH5GnSJkjAoNG8/tSZ/C2OoF0EyuuXdy4HKVnNbdZxO5RlGpkOrY9O3fVhZ7huxn//XKAdSq5IMuBtmFnJ92MicOsBV4GXIXjCE7eJ1GtLHeZ0akPc+0O+FZ6SHcqlmKq7H0Zit31GPSUGboANtHNETbvP2fl/SO49OjcmrB8OZgnJLkdWUQ/rrXz7dfCOa3ENi31PBHvc2CZ/DX7WSOGGxtBc4WbKJWl7p76OW+PW+f0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkP4xDEKRLPfbxw9D378wtTzrlfQkW4JRIBOiB/+OqY=;
 b=j2SGvE3oqNZEK/NIllT8DkiUr2V+evXpbbs0dXEDcjL1cz0/TkZupFJWybFAh5R48QPH6IGOqoyYblDRkGxsGZnVbDBKNsCaZnUOjrMiATxYtYNMyaZPsVIkeniidVXHukb71Xz0GaE4wBbTD3o9S9JzHsDM90/RDVFiwRhoggRQn1ABGIOsaP7eXQPCcTVFY4jbpCfcjRmy1xv2tYr32EKuo7AU4PZakK+oCfT/G7IgEcViVauVwsZeUiCpJholNmBYIsFOw9L5D9sW2wUotal3L3UnLbh8k8BEqFiPSRlM3yb7d+iUB/af/agWCvA+425uYdMuJguR4gEMURRaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkP4xDEKRLPfbxw9D378wtTzrlfQkW4JRIBOiB/+OqY=;
 b=GROccR/DmjluZWe0A04xK6I/OBVv24fC5n8c8ee0tf6AAQEcVdPxBvq+DZmYvPguZ1r2lq+IesGKwvpHBAQwkzUTcD6sKnhuve90lxNpeOHgSoFDHB39KB02ku0zlvi+kcLoqOchSzYTuZMRtwuM9hz4TO+LdkBiL4ho1SF1cZk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 08:20:54 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:20:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 10/15] mtd: spi-nor: Parse SFDP SCCR Map
Thread-Topic: [PATCH v14 10/15] mtd: spi-nor: Parse SFDP SCCR Map
Thread-Index: AQHWl8vHo8V9MvvnOkm2cl68dypCWQ==
Date:   Thu, 1 Oct 2020 08:20:54 +0000
Message-ID: <81fa2331-d808-fed6-232f-f8b67e7e9dac@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-11-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-11-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 3db79b75-8848-4bf2-876d-08d865e2eac7
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB194717C0E620DABFC67CCCE1F0300@DM5PR11MB1947.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMLvxSDUGiUvKkz75LiA/W/8JMAQqLvMLf+lxsBInX6QngnOeM8CTzIvb+i1iy86bzL3b34//JzpaW0i/S+FAsCa2fVwohyAdWap6i3onYPsBehGtNfeyc6SFEDbZkirg0KmDdfdwabo5S09Hbkz1ETxm08eUtqc+TB9tACRLNDpTojTLYmOrr93g2/5c32v7UdWJTle27u54x+KlbMeSigSRj18hFzzxeED1VLPxEKmyNNCACgQE/bfHLYAPHAFLh3bWi+gr14UNTGthkwXFD+kIx/qyldqwwMhOUMCmXhUXAjH0azRYumMHhDHoJLgEoeCynHQbCvuzu1FtjF6m0GBxWN0yy+zPymkEt2BwvHgEkIRYmJt0ZsT6DFH3j9E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(66946007)(478600001)(64756008)(66556008)(316002)(66476007)(71200400001)(91956017)(186003)(110136005)(2906002)(76116006)(86362001)(66446008)(36756003)(26005)(2616005)(6506007)(5660300002)(53546011)(31696002)(8936002)(31686004)(6512007)(6486002)(8676002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SLjFUTGp+k26gMvQvUfta4onl5PJPyrFeL6LwE2jcEQBJfas+oBryN2YNJMBCTKVHs5mTxsQpx5LuvjC7b68fh0XdZq3D3pWrwIsKKFDtaquDwAEixaFwtoqFAj+xYqUaE5l3MVWm9ezYI4eU0gJizjpYv/VME+ZVpkKoPl7Uw1fl6RdaUEMC4k+/DF6BDPIWsrgcSzsUpNRT3md91ULwtXQo0zSG/zkavK674GlP3lmLG7eOBxl8ChKd8vSbR1H7ySf4BLqtkFDi9yELZ+cJ3tbaimxxosw60PUhTqAFxRjv1WCbLT3qsO0UBKOLy6lcF3UR7aAijBYdYLLUyov+T5UUUCLUhekDxqCZjSRtx+VfqKfccCIU9Qs4ogqTBms4FbqKzoq/dJ2DBHnDAcfQS99G1G0nZMZAT2DhU5WvsAhr6038/E3sOTmk4IpuS2yos0OvJqL9IY6tnzBTGaG+fOCWiq+yPxnzW0Dj9rQ0vcek2yOvAQsTta1qgIvFXBz716yALXunC2NR1IwaoEAoGkrsuHCn1UG8pHeD8JKu1YPUlT3kXHKSbYRUsl6gvhEyE8HQebuRiGaJgzojQkyF6YK3FOfjAVs7v47r4SM9GtaU4Oa+0UGR9Bjjj4/mgBIySJc6PLjZv+cxt46Uwvj2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B74599DA3275F4429888C0958A85589F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db79b75-8848-4bf2-876d-08d865e2eac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:20:54.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APjNHfvpDhQQTxexgZQxg8hL5tDVPZ/ASIINmJTfbsrVCWn/6s9kI1aIAbogfLOVq8sYuLSG5wXGq28j3e1hJhMYqZG2cABIyCUmRXoPcf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBQYXJzZSBqdXN0IHRoZSAyMm5kIGR3b3JkIGFu
ZCBsb29rIGZvciB0aGUgJ0RUUiBPY3RhbCBNb2RlIEVuYWJsZQ0KPiBWb2xhdGlsZSBiaXQnLg0K
PiANCj4gU1BJX05PUl9JT19NT0RFX0VOX1ZPTEFUSUxFIHNob3VsZCBiZSBzZXQganVzdCBmb3Ig
dGhlIGZsYXNoZXMNCj4gdGhhdCBkb24ndCBkZWZpbmUgdGhlIG9wdGlvbmFsIFNGRFAgU0NDUiBN
YXAuIEZvciB0aGUgb3RoZXJzLA0KPiBsZXQgdGhlIFNGRFAgZG8gaXRzIGpvYiBhbmQgZmlsbCB0
aGUgU05PUl9GX0lPX01PREVfRU5fVk9MQVRJTEUNCj4gZmxhZy4gV2UgYXZvaWQgdGhpcyB3YXkg
cG9sbHV0aW5nIHRoZSBmbGFzaCBmbGFncyB3aGVuIGRlY2xhcmluZw0KPiBvbmUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyB8IDUyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9zZmRwLmMNCj4gaW5kZXggZWJjMTE4OGY3NTMzLi4wYjViOWVhNDRjZmMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+ICsrKyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IEBAIC0yMSw2ICsyMSwxMCBAQA0KPiAgI2RlZmluZSBTRkRQ
X1NFQ1RPUl9NQVBfSUQgICAgIDB4ZmY4MSAgLyogU2VjdG9yIE1hcCBUYWJsZSAqLw0KPiAgI2Rl
ZmluZSBTRkRQXzRCQUlUX0lEICAgICAgICAgIDB4ZmY4NCAgLyogNC1ieXRlIEFkZHJlc3MgSW5z
dHJ1Y3Rpb24gVGFibGUgKi8NCj4gICNkZWZpbmUgU0ZEUF9QUk9GSUxFMV9JRCAgICAgICAweGZm
MDUgIC8qIHhTUEkgUHJvZmlsZSAxLjAgdGFibGUuICovDQo+ICsjZGVmaW5lIFNGRFBfU0NDUl9N
QVBfSUQgICAgICAgMHhmZjg3ICAvKg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICogU3RhdHVzLCBDb250cm9sIGFuZCBDb25maWd1cmF0aW9uDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBSZWdpc3RlciBNYXAuDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gDQo+ICAjZGVmaW5lIFNG
RFBfU0lHTkFUVVJFICAgICAgICAgMHg1MDQ0NDY1M1UNCj4gDQo+IEBAIC0xMTk1LDYgKzExOTks
NTAgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX3Byb2ZpbGUxKHN0cnVjdCBzcGlfbm9yICpu
b3IsDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICsjZGVmaW5lIFNDQ1JfRFdP
UkQyMl9PQ1RBTF9EVFJfRU5fVk9MQVRJTEUgICAgICAgICAgICAgQklUKDMxKQ0KPiArDQo+ICsv
KioNCj4gKyAqIHNwaV9ub3JfcGFyc2Vfc2NjcigpIC0gUGFyc2UgdGhlIFN0YXR1cywgQ29udHJv
bCBhbmQgQ29uZmlndXJhdGlvbiBSZWdpc3Rlcg0KPiArICogICAgICAgICAgICAgICAgICAgICAg
ICBNYXAuDQo+ICsgKiBAbm9yOiAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNw
aV9ub3InDQo+ICsgKiBAc2Njcl9oZWFkZXI6ICAgICAgIHBvaW50ZXIgdG8gdGhlICdzdHJ1Y3Qg
c2ZkcF9wYXJhbWV0ZXJfaGVhZGVyJyBkZXNjcmliaW5nDQo+ICsgKiAgICAgICAgICAgICAgICAg
ICAgIHRoZSBTQ0NSIE1hcCB0YWJsZSBsZW5ndGggYW5kIHZlcnNpb24uDQo+ICsgKiBAcGFyYW1z
OiAgICAgICAgICAgIHBvaW50ZXIgdG8gdGhlICdzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0
ZXInIHRvIGJlLg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb3Ro
ZXJ3aXNlLg0KPiArICovDQo+ICtzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2Vfc2NjcihzdHJ1Y3Qg
c3BpX25vciAqbm9yLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3Qgc2ZkcF9wYXJhbWV0ZXJfaGVhZGVyICpzY2NyX2hlYWRlciwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyICpwYXJhbXMpDQo+
ICt7DQo+ICsgICAgICAgdTMyICpkd29yZHMsIGFkZHI7DQo+ICsgICAgICAgc2l6ZV90IGxlbjsN
Cj4gKyAgICAgICBpbnQgcmV0Ow0KPiArICAgICAgIHU4IGlvX21vZGVfZW5fdm9sYXRpbGU7DQoN
CndvdWxkIGEgYm9vbCB3b3JrIGhlcmU/DQoNCj4gKw0KPiArICAgICAgIGxlbiA9IHNjY3JfaGVh
ZGVyLT5sZW5ndGggKiBzaXplb2YoKmR3b3Jkcyk7DQo+ICsgICAgICAgZHdvcmRzID0ga21hbGxv
YyhsZW4sIEdGUF9LRVJORUwpOw0KPiArICAgICAgIGlmICghZHdvcmRzKQ0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKyAgICAgICBhZGRyID0gU0ZEUF9QQVJBTV9I
RUFERVJfUFRQKHNjY3JfaGVhZGVyKTsNCj4gKyAgICAgICByZXQgPSBzcGlfbm9yX3JlYWRfc2Zk
cChub3IsIGFkZHIsIGxlbiwgZHdvcmRzKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+ICsNCj4gKyAgICAgICBsZTMyX3RvX2NwdV9hcnJheShkd29y
ZHMsIHNjY3JfaGVhZGVyLT5sZW5ndGgpOw0KPiArDQo+ICsgICAgICAgaW9fbW9kZV9lbl92b2xh
dGlsZSA9IEZJRUxEX0dFVChTQ0NSX0RXT1JEMjJfT0NUQUxfRFRSX0VOX1ZPTEFUSUxFLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHdvcmRzWzIyXSk7DQo+ICsN
Cj4gKyAgICAgICBpZiAoaW9fbW9kZV9lbl92b2xhdGlsZSkNCj4gKyAgICAgICAgICAgICAgIG5v
ci0+ZmxhZ3MgfD0gU05PUl9GX0lPX01PREVfRU5fVk9MQVRJTEU7DQo+ICsNCj4gK291dDoNCj4g
KyAgICAgICBrZnJlZShkd29yZHMpOw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsN
Cj4gIC8qKg0KPiAgICogc3BpX25vcl9wYXJzZV9zZmRwKCkgLSBwYXJzZSB0aGUgU2VyaWFsIEZs
YXNoIERpc2NvdmVyYWJsZSBQYXJhbWV0ZXJzLg0KPiAgICogQG5vcjogICAgICAgICAgICAgICBw
b2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPiBAQCAtMTMwMCw2ICsxMzQ4LDEwIEBAIGlu
dCBzcGlfbm9yX3BhcnNlX3NmZHAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgZXJyID0gc3BpX25vcl9wYXJzZV9wcm9maWxlMShub3IsIHBhcmFtX2hlYWRl
ciwgcGFyYW1zKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KPiArICAg
ICAgICAgICAgICAgY2FzZSBTRkRQX1NDQ1JfTUFQX0lEOg0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBlcnIgPSBzcGlfbm9yX3BhcnNlX3NjY3Iobm9yLCBwYXJhbV9oZWFkZXIsIHBhcmFtcyk7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICAgICAgICAgICAgICAg
ICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAg
ICAgICAgIH0NCj4gLS0NCj4gMi4yOC4wDQo+IA0KDQo=
