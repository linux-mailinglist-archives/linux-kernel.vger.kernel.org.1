Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739AC26C0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIPJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:36:32 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54707 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgIPJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600248984; x=1631784984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FgldDGaeYa0tYIh2F4rl+Za7Ta9yuiNoTF+KMVTSebY=;
  b=dzO+YFsMvJHtp372JdRUaK8L3OdriUVyp9lveoOPkF8BkgnIKD3XprSE
   /U4QBRxKmwxQ2llB0oqAvmVCuTyUgVvWVCW3JCff24iqyqcgMfMKQUJnI
   aYSZ8h6VfjIFDSaY76+mMDQJ5ndC3zDz3CNZ6izxczMplvRyU3PxPYOOG
   GSHMUYHYGBsgADFZy4rXj3NiZljNsvoLAE4jpMNcLIdtufXoCSPs1ng6N
   8nxNca5QnPXG/nsUJEtN9aRE/SFRj4yM7pR3/6xSAjsNJuS2z4yDG5jgO
   9A7030Q5gnBRek/VqV4jV8LjIBxAMDYpQmNIWy6vA0LDVFtShPifMoUUt
   Q==;
IronPort-SDR: 6EZflJUx3YdCQaoPL5zoSAHrxklQ7UFTHO8UUuqyuNxaAF6eTb6kC+YiJRiXue5pnxojDA/rMZ
 0E40DJCqKPeNZgHoTU0ji40YO4eXTxG20Kzn0CxlHLrasbd5vM57yZkB2G84srcYTuVyq0vtff
 njBupGywA3a36jBfP3Az0Qt7p6LapFeoef3T1UpxMnuia4k5dDrxUwLT++h9qlTP1sqvMdzlQP
 iBojGsmseGvjfWSdi/KGi5zME7O1YvquZX2bSjAEnrsswhhrje0SSJFUTrwtkpPvZZ8lJYLIXF
 RSg=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="26587040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 02:36:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 02:36:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 02:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhjTAIPFLlA9/ayJLd9fMRQOdg0C1gdTxMEOZyJcBT7SIMb+lHLbBzOSrTKbtE8BW8bX5k3VhCcLAs339w0SlJyEcnlFG2rMXRE4zg/XALQ0f23heu1xrRDE3AYqxRywO5k8Okq6NP9V7Wm4xvfulRzCi/B2ufszL0poP5DjrE7X2edMSFm4LCK2BJmWgL2FoN6ej1I/hTAYaqn7hBIQbZQvO1pgx/JvoOVh6+fZSa8+H1z7s7wrmZF0ONDkfh4IF8hHLdelOn1n7Li/LpTTuX9KSG0Tad8CFqTBCXUa74mXw1r3DynR7przoyXLwuBaBnzAIaoZoFw9Q14mFaViHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgldDGaeYa0tYIh2F4rl+Za7Ta9yuiNoTF+KMVTSebY=;
 b=RQ4ZaBxELiDSTKlIgaYFvH+AiaviwR27YriJ/SCGomZPhO+I/TZz8s/hvi3MINK7sx16GLdnUYCw5dS8P4IrWme/8e15JZjKSQnRifPw/hWwwNIDB+fKTl1v4Q1PAdBD9Zm1II78aLd0ISaBRBUilpsyXgYSWELXpGld9VZ2oePws3WlydCh283aSxyS0ZW20kKzI4KqP1uW2N6zPPoum8pKdCdYdbUeM+8ENZFsesBMqz5H6sJjQP283GTNyh+F1JjQlsVu4fPP8M7OywH4vhk0yYrG68oxxDjLilYqMZMTx29352+20A4kq+S3La62tE2uOmq3xuZIx+e17Kd/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgldDGaeYa0tYIh2F4rl+Za7Ta9yuiNoTF+KMVTSebY=;
 b=o32TrEK49rRq6q0GNopM4zJ14O8j/dMJPv38tPsF4z6Grb1gvTJ2+bAN8q5rM57l4Wxf/b2ZSaM8QP4eFFFsSehTK0EDgnds6gnUKrWYYkY9R6FIlwWY4Jtxo1MxHSo7NgCY5Q9/cZ6O/oscSDsd6HhZ16UvuqTDTSiN08G1XMw=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1257.namprd11.prod.outlook.com (2603:10b6:3:12::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 09:36:20 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.014; Wed, 16 Sep
 2020 09:36:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <m.felsch@pengutronix.de>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <sergei.shtylyov@cogentembedded.com>,
        <boris.brezillon@collabora.com>, <michael@walle.cc>,
        <j.neuschaefer@gmx.net>
CC:     <linux-mtd@lists.infradead.org>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: sst: fix write support for SST_WRITE
 marked devices
Thread-Topic: [PATCH 1/3] mtd: spi-nor: sst: fix write support for SST_WRITE
 marked devices
Thread-Index: AQHWjAzVSbw2cN8jH0Sx48szyJxchQ==
Date:   Wed, 16 Sep 2020 09:36:20 +0000
Message-ID: <7cee3de0-19ee-d9f7-fd04-7f0771f73da5@microchip.com>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
 <20200911144703.25409-2-m.felsch@pengutronix.de>
 <dc80d00a-27a3-6c75-5820-97ad2e297d8e@ti.com>
In-Reply-To: <dc80d00a-27a3-6c75-5820-97ad2e297d8e@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 796c6b88-7aa5-4bd7-e9e3-08d85a23f80a
x-ms-traffictypediagnostic: DM5PR11MB1257:
x-microsoft-antispam-prvs: <DM5PR11MB1257A4941A26D0FB3F8EC919F0210@DM5PR11MB1257.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjR1qvehKHBclAiNfd7Sv0T9wCqJ/PJCAMYzWkLGwWfjIOoqRTwoHLoZE2zA6cMGiKj1J1fe6BhDRv1BgevBCTsUbB3ZGfAiIVk9DVO3hT7vBuLJQ6QBgm1XHVap33QjM+zHEA5TDftb1h6re/5VWqWd7c3nEjeqZN7HnMYhLfKltP7EKWDWUPtQqln1l/l6nvLdavF6ZQCxR9BCg4zMUynivSN6b9J4Pjc+mXX1pnLsqsrLLc2/+U10AZg7QcwuKxig20YvVL6NBO67AnP9qT9oUE3hnP73kJVENLlE537F2pv9TzV87cWlVjpuPQDK6qqO4X0Dq/kqNvH+wUN2hhDogEV0fHyZzGTfEtQFcGhcuzsEbFbnHU0F3pZkwJqtA6/BD1H7NAj297ziODc7b+ot72++FiqPi+dk+NZEH4Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39850400004)(376002)(346002)(366004)(31696002)(8676002)(83380400001)(478600001)(6512007)(7416002)(2906002)(26005)(316002)(86362001)(186003)(31686004)(71200400001)(2616005)(64756008)(4326008)(66946007)(6506007)(6486002)(36756003)(91956017)(66446008)(54906003)(53546011)(66476007)(66556008)(76116006)(5660300002)(8936002)(110136005)(341764005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iDber/c6ZYg/BmvdcBw8RfcRwzkHH6fdE71KDa1ntWS6EMc+G4E68MKlQPj+3PfTMdy75xfRLMuVdOKxLyLsoJk9XQ6I8Ex4v2VM01HserEMXKQjYA5rbfG8IzB1+PRaeuS6mIyIeePL59Stf29FG2Llfhy6AL7auNy8rW8fYO2E7pVoOiZqrpW5pFTd4Ij/eNtYfbEfo7+aZNWx9NAgSGTc/gRJ2tronDYi+GqyXYEJEADh6eQWAH5CQfkpvP13vP2tRnVjuMxBA3QvW3ppfaJ7Ia3F5EjNbWLFvVrCg+k6OP6mCtC/6W3ff9YuHrWxuOM77JgD6P0WfeIbrvbM25a2qD8EM9laF5hyJx5X3PKVckvgy29Eo9Cu7napSD2HgOxYKmTAUdOqW3CfXQUkO6o3QV2eMQ5iUkQfCYZdYmwl16HQ4wDycrPYV12+ZkUiw8iiK4gReTtnGsJk+E/2ZCD1m/0qaqKmG8tPhyMojFeevItF1VukFYbSNuHTpYVh2hNppbiHmATQBUIC2ktf4ZW5tRybogME9AriUoOAfjM/YJGRJSReJCaViErh21N2zFXRDvg/b4JRyD0fXriH3NpzD9RQnbdGue6dMLaasCD1vlQT5Ma1hqjw1NUVRYsJarqNXQT7VpBtDI1XIUgqzw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C9805C0D0E8F84DA6D369ACAD48482D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796c6b88-7aa5-4bd7-e9e3-08d85a23f80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 09:36:20.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJx4F4RgBs9MDsQXIdCaax/kILUU2PxAPkSQLWLJF1h3d4JQ06Ya0nW10gSkPNQ8JCsNCzzVtr4wedbQKvoGx+uKbxw8NIjJ3jGIwc2nrKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNC8yMCAzOjAwIFBNLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDkvMTEvMjAgODoxNyBQTSwgTWFy
Y28gRmVsc2NoIHdyb3RlOg0KPj4gVGhlIHNzdCB3cml0ZSBzdXBwb3J0IGZvciBkZXZpY2VzIHVz
aW5nIHRoZSBzcGVjaWFsIFNTVF9XUklURSByb3V0aW5lDQo+PiBpcyBicm9rZW4gc2luY2UgY29t
bWl0IGNvbW1pdCBkZjVjMjEwMDJjZjQgKCJtdGQ6IHNwaS1ub3I6IHVzZSBzcGktbWVtDQo+PiBk
aXJtYXAgQVBJIikgYmVjYXVzZSB0aGUgc3BpX25vcl9jcmVhdGVfd3JpdGVfZGlybWFwKCkgZnVu
Y3Rpb24gY2hlY2tzDQo+PiBTUElOT1JfT1BfQUFJX1dQIGFuZCBzc3Rfd3JpdGVfc2Vjb25kLiBU
aGVzZSBjaGVja3MgYXJlIG5vdCB2YWxpZCBkdXJpbmcNCj4+IHByb2JlLiBUaGUgY2hlY2sgc2Vl
bXMgYWxzbyB0byBiZSBicm9rZW4gc2luY2UgdGhlICJvcC0+YWRkci5uYnl0ZXMgPSAwIg0KPj4g
Y2F1c2VzIHRoZSBkZXZtX3NwaV9tZW1fZGlybWFwX2NyZWF0ZSgpIGZ1bmN0aW9uIHRvIHJldHVy
bg0KPj4gUFRSX0VSUigtRUlOVkFMKSBhbmQgdGhlIHByb2JlKCkgZnVuY3Rpb24gd2lsbCBmYWls
Lg0KPj4NCj4+IEl0IHNlZW1zIHRoYXQgdGhlIGNvbW1pdCBvbmx5IGNvcHknbidwYXN0ZWQgdGhl
IGV4aXN0aW5nIGxvZ2ljLiBVc2UgdGhlDQo+PiBjb3JyZWN0IFNTVF9XUklURSBmbGFnIGFuZCBy
ZXR1cm4gMCB0byBmaXggYm90aCBpc3N1ZXMuDQo+Pg0KPj4gRml4ZXM6IGRmNWMyMTAwMmNmNCAo
Im10ZDogc3BpLW5vcjogdXNlIHNwaS1tZW0gZGlybWFwIEFQSSIpDQo+PiBTaWduZWQtb2ZmLWJ5
OiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPg0KPj4gLS0tDQo+PiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAxMiArKysrKysrKystLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
DQo+PiBpbmRleCA2NWVmZjRjZTZhYjEuLjMxODY5YWMyNDVhOCAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuYw0KPj4gQEAgLTMyODksMTUgKzMyODksMjEgQEAgc3RhdGljIGludCBzcGlfbm9yX2NyZWF0
ZV93cml0ZV9kaXJtYXAoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICAgICAgIH07DQo+PiAgICAg
ICBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AgPSAmaW5mby5vcF90bXBsOw0KPj4NCj4+ICsgICAgIC8q
DQo+PiArICAgICAgKiBNb3N0IFNTVCBTUEktTk9SJ3MgaGF2ZSBhIHNwZWNpYWwgd3JpdGUgcm91
dGluZS53aGljaCBzaG91bGQgc28NCj4gDQo+IHMvU1BJLU5PUi9TUEkgTk9SLg0KPiANCj4+ICsg
ICAgICAqIGRpcm1hcC53ZGVzYyBpcyBub3Qgc3VwcG9ydGVkIGZvciB0aGVzZS4NCj4gDQo+IE9y
IEhvdyBhYm91dCBtb3JlIHJlYWRhYmxlIHZlcnNpb246DQo+IA0KPiAiTW9zdCBTU1QgZmxhc2hl
cyBoYXZlIHNwZWNpYWwgc2VxdWVuY2UgZm9yIHdyaXRpbmcgZGF0YSB0byB0aGUgZmxhc2gNCj4g
YW5kIHRoZXJlZm9yZSBjYW5ub3Qgc3VwcG9ydCB3cml0ZXMgdGhyb3VnaCBkaXJlY3QgbWFwcGlu
ZyBBUElzLiINCj4gDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmIChub3ItPmluZm8tPmZsYWdz
ICYgU1NUX1dSSVRFKSB7DQo+PiArICAgICAgICAgICAgIG5vci0+ZGlybWFwLndkZXNjID0gTlVM
TDsNCj4gDQo+IG5vci0+ZGlybWFwLndkZXNjIGlzIGtub3duIHRvIGJlIE5VTEwgYXQgdGhpcyBw
b2ludC4gU28gbm8gbmVlZCB0byBzZXQNCj4gdG8gTlVMTCBhZ2Fpbi4NCj4gDQo+PiArICAgICAg
ICAgICAgIHJldHVybiAwOw0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gICAgICAgLyogZ2V0IHRyYW5z
ZmVyIHByb3RvY29scy4gKi8NCj4+ICAgICAgIG9wLT5jbWQuYnVzd2lkdGggPSBzcGlfbm9yX2dl
dF9wcm90b2NvbF9pbnN0X25iaXRzKG5vci0+d3JpdGVfcHJvdG8pOw0KPj4gICAgICAgb3AtPmFk
ZHIuYnVzd2lkdGggPSBzcGlfbm9yX2dldF9wcm90b2NvbF9hZGRyX25iaXRzKG5vci0+d3JpdGVf
cHJvdG8pOw0KPj4gICAgICAgb3AtPmR1bW15LmJ1c3dpZHRoID0gb3AtPmFkZHIuYnVzd2lkdGg7
DQo+PiAgICAgICBvcC0+ZGF0YS5idXN3aWR0aCA9IHNwaV9ub3JfZ2V0X3Byb3RvY29sX2RhdGFf
bmJpdHMobm9yLT53cml0ZV9wcm90byk7DQo+Pg0KPj4gLSAgICAgaWYgKG5vci0+cHJvZ3JhbV9v
cGNvZGUgPT0gU1BJTk9SX09QX0FBSV9XUCAmJiBub3ItPnNzdF93cml0ZV9zZWNvbmQpDQo+PiAt
ICAgICAgICAgICAgIG9wLT5hZGRyLm5ieXRlcyA9IDA7DQo+PiAtDQo+PiAgICAgICBub3ItPmRp
cm1hcC53ZGVzYyA9IGRldm1fc3BpX21lbV9kaXJtYXBfY3JlYXRlKG5vci0+ZGV2LCBub3ItPnNw
aW1lbSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmluZm8pOw0KPj4gICAgICAgcmV0dXJuIFBUUl9FUlJfT1JfWkVSTyhub3ItPmRpcm1h
cC53ZGVzYyk7DQo+Pg0KDQpXaXRoIFZpZ25lc2gncyBjb21tZW50cyBhZGRyZXNzZWQsIG9uZSBj
YW4gYWRkOg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9j
aGlwLmNvbT4NCg==
