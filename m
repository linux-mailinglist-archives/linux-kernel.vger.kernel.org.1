Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B350027FB5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgJAISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:18:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57161 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601540319; x=1633076319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IbW3mizmOSpRRBgEZthrzSQIsRF/rtPnEFy5zze2rVM=;
  b=XJpUbG3Z74gxvu8rL7+EdwCAYOB1G78sGiKLGr1x6EFouGJt4irwnQl3
   33L/hFvlVyum4VhogMMDjHVbqPfzIUVDMHFmJD3RvDCf3VHYp//CcQMZC
   6RowpGDA370gDd7xdBQTeUOd908hrl/WrBqF8i6OsghwajPYyQ0v1E117
   9udjqxGTmjfYd6K/2vxmynYHX+cNZQJjyNUmjgV0jMl2ULiKTkuPqwbY4
   KH+kNSgYVRzA0Uenbhncyj5T09Bu3W9u+vp+zUXHx/q4g4MoLOUz4CAgj
   2x2wUDZq9DcSHT20nzPusEEznzQwdP+yThlusqP20/hrfLcP1BpyZXM4l
   w==;
IronPort-SDR: gxp/N1DWh5L4NS1XGNyfUxoYFIFu2LBA3UJ1enFa2eCr5oSDz5HQKaMDeJaRwGXAj/zwYehYnG
 1ReqHNCFBvxAah8ygNWr9PCouKu8W9YksggqiFvDznRMN6RjgMk5ME2WZzRa9lTc/+StqlPC2R
 gQ4YBl1oMYNpIQLJYkxe6XNP1gm3e8PagPidQD+5OzVkO1m+sLYBwJbp7iikQQgI5rciGkvH69
 0RsyncOave2fl1ado1EXk4eiwXYQE9a7s8qEUXvzw3jNmNGpD1OgmmwsLkMuPky0nVQ/XXO6cd
 6d0=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="28343746"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:18:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:18:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+4z7kLVhM8S6aSMNsKjRUEF90pgZ9LbncJsx/hmztZc5zRuAzp246AKok031VTRjh8M2D/9lKSC1O1gY4504Hx7tq+ssX+L+0X0ucWnCXxeDa6eNhlABKyL8JLZPrUDONeOD8IofQPe2GO31BXSF3hr5NN4TbdqRJxgQO/KCemhUgzzzs5iCUlfpX4vN6BgM51AtD/xvMmdViAfyaJbvBYtbSxjT9J264sB8mO/map0VIRmxRPbNi0BkZU2/r+tl5MSICyyaGCH9cpG4NOFToyiNXuv0MaTz5dOkYp//r8wzyQzqLWi+yAEYUkE2EcQe81E4Kp8yJIkRaGzjO/q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbW3mizmOSpRRBgEZthrzSQIsRF/rtPnEFy5zze2rVM=;
 b=Nd70rZ2I9y1F9bJ4RNyAdkQo4PtzAyAEHBkECmSqQ1q6zyWOHTWDaDr/2+kAlpsP+RZ9YI83jzuZ10mVwyo2H8SK4HMthQn/rHH30MGb9vzn5LI7o/PUUVJEeCPeoY//5HwW3757CKhuo6GGhQQQYzz84tfmovUJuQoPmCTCRpY8+qbSS1O297B9gxlb7jj+1QzvuRIqKs59GbygL26PyZ8pDHHlwciLQyEjA/XCJuDSlOOAj5RU7vHkUTztBU7zbLdU2YDpPq3TPL7NRKqKDg6oqoetPHmct6suNxlt/Q84nqklm/YZUjgHkkZqytDujs2hUJzCfWlgaBYauPm3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbW3mizmOSpRRBgEZthrzSQIsRF/rtPnEFy5zze2rVM=;
 b=fKHeHjO5ZoNi4Jrbb1MP0PUFy80oH1o8d21a+9QDHcDIK4iS4Mq8WaZdgYNJzRGS6egudRTvSiSzSbuPOaejsH7S2CiW0wtdrlvxsYAeAnGMViQtSaK3je6tkubpcgi1p3G0YtC2yjck1KX1tFHlRcLeHkzZ6HVfTajTaKlAASs=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM6PR11MB4594.namprd11.prod.outlook.com (20.180.252.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Thu, 1 Oct 2020 08:18:30 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:18:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <p.yadav@ti.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Topic: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Index: AQHWl8Mq03c/QD6Sr0Oo7ADJT92UwQ==
Date:   Thu, 1 Oct 2020 08:18:29 +0000
Message-ID: <702a3b92-0df3-3c04-ae83-b8f432d92ff0@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-2-p.yadav@ti.com>
 <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
 <20201001073425.txsfdngrsugsy6uf@ti.com> <20201001095012.5c331bf8@xps13>
In-Reply-To: <20201001095012.5c331bf8@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26edebfc-2332-4092-2102-08d865e29477
x-ms-traffictypediagnostic: DM6PR11MB4594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4594994F752E91A7C9991089F0300@DM6PR11MB4594.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vB03m3QuPpyr7ZDRfe6f866DoiAabgYvZ+JRkFNKuGnb/s46S3vBGEkQSd/5w7MWoFxXCdia7CVTMAKXnMzV9DTzruc3lfXx4WE5duckUGBXnM7AJ3PZI78ZfKic27dEJ6yQINZqR+/Cu60IHgalqWBtWim52nKnpz3JfPBVxnf3rXN/cTxoEYUWLQeCVBRvyAyxhDv0WygFtCnxD7CmMGr//Fsknwc73BEBs141nyySPPzW+SZMCJDpnPfyNrZw5pQowT1ry0AN1u13cEzHsHl0EXW/+xM3Bvq/yebiRM8wkZWKsaFVTpQQjkCa9+89/kVvM2O880Bwhg2dgrR38Ohpmf7g1wrRlQdI4VeaXqhgos1PH42ceybnf9ec4Nd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(54906003)(71200400001)(186003)(4744005)(31686004)(76116006)(91956017)(5660300002)(66446008)(66556008)(66476007)(64756008)(6506007)(53546011)(26005)(6486002)(316002)(2906002)(66946007)(478600001)(4326008)(8676002)(107886003)(6512007)(36756003)(86362001)(83380400001)(2616005)(8936002)(110136005)(31696002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qjECYwO4/44FhUNXH1YJy4KecC2jk5OCgEZ/P0PA7iKZCqYnPTWFg8qnMnkdC2jz6wIg8lMmFovYLGIQ7hkbUIJlvm01rYMJRY6AuB+8MLCpJpbJhivE+bqKMbe1UzaBUu1V8CTY0ugamgfq/wXNbWgsliFVYhtg6rR1EdGKMnB3/bBTJp22y86P2fIvjQOggoLCPoo6EThZwbsRfx+ExKOupUFG93oP8ZLPmsoX5HewRW0pcojrKet7EGG/UDqnovOokXT7Dj48lThuP1sfvsBXcfiziDvU1li7fz/YB5833xF639GuQFK8qi7U/SWj6ZFJpJwlnZrf8E9LTp01AwHtdaICNsHRVfyhvdFe4O4Wik6LGBm3e0ux0KEUeuYgoW9akMZ0cJy8lTah6PKX6bc8EjgXpkbusZZ1SHyyuIv3U6H9lIaBdsPpOvlCiuX3+5F4IVcIJ/sXZIhPp4PsTiBeaAuXlsZD+iAn1PnL+RKjdm1vdKaB3t7kq9iXfv3CKI6cl/2eCJR/YCfCnz6DC+1g7anfOci0Psn5g73Jg1mF13CQVI8Lewd7X8GoEz4K724x4QAWPXfhk+RmJgGRNrXWYt0Z9/vLqPVdlHPZg/+z6Ou9xj1sBuUHwee3/CF9ZbcmE1bLT0djWC4s7x/E7A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D00CC8705BDAD46A66D5465BE38EFA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26edebfc-2332-4092-2102-08d865e29477
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:18:29.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YUU/3MBXbl5rII6MM2oL+606mYhFEpcFg38Shwx6dLm9t0aaH+HNK0q2lKtPNXZG5iglk8nyWV0uX6ERi6AYElmdTrxPJgC8m0zr0V0Kz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAxMDo1MCBBTSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IEl0IHNlZW1zIHRoYXQgeW91ciBtYWlsZXIvc2Vy
dmVyIGludHJvZHVjZWQgdGhhdCBsaW5lIGF1dG9tYXRpY2FsbHksDQo+IGNhbiB5b3UgZG8gc29t
ZXRoaW5nIHRvIGF2b2lkIGl0Pw0KPiANCg0KSSBkb24ndCBrbm93IGFueSBwbHVnaW4gdGhhdCBy
ZW1vdmVzIHRhZ3MgYXV0b21hdGljYWxseSwgSSBjYW4ndCBkbyBtdWNoLg0KTWF5YmUganVzdCB0
byBtYW51YWxseSByZW1vdmUgaXQgZXZlcnkgdGltZSwgeWFheS4gT3IgdG8gc3dpdGNoIHRvIGEN
CmRpZmZlcmVudCBlbWFpbCBhY2NvdW50LCB0aHVzIGRpZmZlcmVudCBlbWFpbCBzZXJ2ZXIsIGJ1
dCB3b3VsZG4ndCBiZSBmYWlyDQp0byBteSBlbXBsb3llci4NCg0KdGENCg==
