Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86B027FE99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbgJALqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:46:18 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:22657 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgJALqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601552777; x=1633088777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vuhW1T8BI282lrdBdSKqVCRAZo60FYufMZYNNw0qqrE=;
  b=QfzmzoJWLllGGuhTzTVpmJdCAlVUcJ/GFK+ypoAD28bMttwpWs/IrdkU
   NDcfR5ahIazBVrmCAMrTOWNGObh+tK4aUK2teOARuDuTOALhoxUjyplUo
   sFCxeiktIx5on1gK9lb30MjThJF/hpCjHFV5jL/tMG6OnZQM8MXoMSjTQ
   8h5u6iCvBOssTZNvkPsWM4WiZCcQ1lGPlAEuZFuTXP0iPRKjtcbfyqsQ6
   tZ1TE0uLDd3o16Zt1Z31wMEcm75cH9IodRaMoRjzcBIAXgdi8JEfm2w+O
   NXyc+WddrHtEhKtDXso2n0qoio1A7pbin2uWETNigVusADFu7SU9i1Ist
   A==;
IronPort-SDR: YNabKgx0I9hfnl5R0tUr4pLWayZP7oNA09GyEXTnTj1IC3DFMASp44FrCyOt/P/XCitpqJBga3
 mr9VGj7SfUDFNQLzmPsSND9xhwLu2JfHa3v7ZTsdZdnWGORZLrI0YzNQLe/bNXXXyTLREH47FT
 3zksA2N05/N0HaT0Mqx+upZUJPDfPGHEIZJr5Y5ibh2qwvEi+v9EJORgkLLGVDZ56lkV50Gda9
 mtg4qH7otPsk3L5hh9jwj4iuVDhlTk0aRJhzWc13GHoBkhUETeunTovEsmssUK9wznrGoJiGqq
 gG8=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="93871901"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 04:46:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 04:46:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 04:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPjKPhqeNy5AlCCKI6NY1SYdTPddUmHI72QufATT/lAxYCQwZrLwJZyoGpoG3Nb9ZBxKRfk3BqcN6Mu5gVxVONpAHMlIHZANAeMlzVx8ScEtk1yfhgk36GvvPCnPJZ0jgZnLeXHlol0QCCj5lROJIXx4etcQXh5b0ebcVPt790d6UKKFQ9FvVEm4mOZtLu5KXTvIfPPncIfHgobJbrVi4nu+VXZ3K145s6kq9dlCNW/swBDWG0AUxqAT0RwieHFTotEGGhiH9++MgcXxd7XIKbzipXNUOddRkEFTQ+99cTYr+7GUOpK8dPGgJuF0MtIUBtjUx5wu0Wk8+Cz79Xle9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuhW1T8BI282lrdBdSKqVCRAZo60FYufMZYNNw0qqrE=;
 b=WuNQHUUHYIwUYvMFhVu9sObLpiFtZg/GUTLZGuqARh+TK6NOnc7/o4td7GMblTA3YLGQVqTiT6YBvrpaIJgahXoEsQjynSCRP/EsYR0HjkmJXz3brCabuL5i7TOUVlNvpW2mZUUAocwXLHzFda2jp3Sczds/YHU+7DIX2nZns8nwWfn5spdWXiik3FIYTjs+9NM5YP/aF0DIcuAZ6PiuUTu5uhDPu9C3up97WD8+W8jt+wjVo1z6sgmlGNnTNeGtDDowFmBH9JLMZnbvENJr9L2CNkTsy3GazB4wgc+eX7zOtMKpnVBar86IeOY20dzWpL3y85O6yqleQwHhSsm2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuhW1T8BI282lrdBdSKqVCRAZo60FYufMZYNNw0qqrE=;
 b=mLgYsmcZo2yGifn2Jc+b7i9vaXd4F0eh4mChjNDFg7CkGJZj5trHbngCkjjcm6RQq+vuTrfNrAoA1QPg5zpWffuvH+bbglOEwJbxnpkTn0oG1Y/UhSs0V/fGzGvI/lEnZef7hFTb4nDGvFRlZuGGtDtu0hzgao1kgI1FpWsPGvk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 11:46:14 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 11:46:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHWlzICH6PibhncD0qfQu8hdLJMbA==
Date:   Thu, 1 Oct 2020 11:46:14 +0000
Message-ID: <2df08e26-b773-9fa5-fd69-6575d3e50f67@microchip.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
 <a82d1ce203383af149ed77c5fd6c8985@walle.cc>
 <bec5b899-fbd2-1c29-611c-654f17e63dbf@microchip.com>
 <8cbaef6c7565deed1109fe958291d9e0@walle.cc>
In-Reply-To: <8cbaef6c7565deed1109fe958291d9e0@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e08909c-a43f-4e31-710c-08d865ff99e0
x-ms-traffictypediagnostic: DM6PR11MB4705:
x-microsoft-antispam-prvs: <DM6PR11MB47055B5A762E767B97E7D1DFF0300@DM6PR11MB4705.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kvjN36YL3MUxa70D3FJzKws/yYrDN26G6ykQ+TIs7em7TflLHq6drDToDMrl5AxmynPNgychy9zWNadt0imWizXQlJWM3ejfteC3SUgrhb24J3YG3EdQguG9BJiDcerF7n2r9Wh7ZCQKQTfTLW182NiMba/igX+zwmPIMB/n/HXspKOAaSwc0I/Rht5DIPMdYJncv1D1ASH2zSYQG/RCcXwySrl90ytOrDa+/XsFvKImer8itn9Lj+/rRQglIuT31XBo0D6bRBOgGi1GAseiqfP/pM2EQW/ZciCsLcegQvUfJHLOnLfNUpTwONbeLdUaTZY18xxdNJDgz70QUVcdOULIYM5X/t4a3wQJ31j5FpzFNQ5ehXeL3SDVeuahtXh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(6916009)(316002)(66946007)(71200400001)(76116006)(64756008)(2906002)(91956017)(66556008)(66476007)(66446008)(6512007)(54906003)(86362001)(8676002)(2616005)(4326008)(31686004)(5660300002)(8936002)(36756003)(31696002)(26005)(186003)(83380400001)(478600001)(6506007)(53546011)(6486002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G5EsC3sBgkPQ+h4VPfiitT6E89ExBqJss3C74TNtmE4xpHS9I7ZwxYHjdsbQHzLLDmM+4YDvDehl1DO6hj7CUMzo9feT69oBiXw6XFcRyTIByXvCn8joVHPCO4zQX6HFYQ1f7MbYGm2ybR+qpvA6moro1+ezZvOkr/WspjqK3Izq76aFEAzSn8UNXzwlRIJgQBiGGizpCtor0Heboy/RDwcbZTf1mtZxUSFq+pFpUgkWCzvn4U/GzbRV31PA9a+W2PgYo+FYISu5NE6VpLdIC+w+ym6wL7qdjvYPmw3HNaoT5RfDsltkSyqpZfqPEomO3B6Ta+IbZztsmkxNbNJxCgn5GZ8LfhPf4FaB571T7Vbjvj058PUz/PNvNhetsb0n5kHlMM+jCVShwNJCncKfOBO8UhajAKyeaU9C7tuijYtNZpY9agKNiXKUq618jRS3n6vTZGHLR58l4snwyigbmXqTBONTc5fkCk/xhXj1c36F66oxG2TzDyqMBTxYIJdG5Sh2fb9Neam57zGhrmdFNaE5ybxBG15aRFLursXAyxQIo9mVWlyybIpZl3g7iYqdMR97MSD/NQ3co7JQzkHHfIEHzegCuHbHXqYhSwzOWxDC/IVS1HY8IACB3mueJZwDL4Hk/AMlQeoUkev2PuBWcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <72C40BD1A9F83A448BF15FB53048DEF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e08909c-a43f-4e31-710c-08d865ff99e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 11:46:14.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkeJUIF/65LOCmnpvRwewsyR+9A+40TkXtT86DggDQshrV5NbXagu8fs+OW9LCnvpbpFIA9oGYw0bVqVakd+aImNJGnOpJx/DJpQeVnMevE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAxMDozOCBBTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCg0KSGksIE1pY2hhZWwsDQoN
Cj4gDQo+IEFtIDIwMjAtMTAtMDEgMDk6MDcsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tOg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+Pj4+IGluZGV4IGNjNjhlYTg0MzE4ZS4uZmQx
YzM2ZDcwYTEzIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMN
Cj4+Pj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4+PiBAQCAtMjkxNiwy
MCArMjkxNiwzOCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcXVhZF9lbmFibGUoc3RydWN0DQo+Pj4+
PiBzcGlfbm9yDQo+Pj4+PiAqbm9yKQ0KPj4+Pj4gwqB9DQo+Pj4+Pg0KPj4+Pj4gwqAvKioNCj4+
Pj4+IC0gKiBzcGlfbm9yX3VubG9ja19hbGwoKSAtIFVubG9ja3MgdGhlIGVudGlyZSBmbGFzaCBt
ZW1vcnkgYXJyYXkuDQo+Pj4+PiArICogc3BpX25vcl9nbG9iYWxfdW5wcm90ZWN0KCkgLSBQZXJm
b3JtIGEgZ2xvYmFsIHVucHJvdGVjdCBvZiB0aGUNCj4+Pj4+IG1lbW9yeSBhcmVhLg0KPj4+Pj4g
wqAgKiBAbm9yOsKgwqDCoCBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJy4NCj4+Pj4+IMKg
ICoNCj4+Pj4+IMKgICogU29tZSBTUEkgTk9SIGZsYXNoZXMgYXJlIHdyaXRlIHByb3RlY3RlZCBi
eSBkZWZhdWx0IGFmdGVyIGENCj4+Pj4+IHBvd2VyLW9uIHJlc2V0DQo+Pj4+PiDCoCAqIGN5Y2xl
LCBpbiBvcmRlciB0byBhdm9pZCBpbmFkdmVydGVudCB3cml0ZXMgZHVyaW5nIHBvd2VyLXVwLg0K
Pj4+Pj4gQmFja3dhcmQNCj4+Pj4+IMKgICogY29tcGF0aWJpbGl0eSBpbXBvc2VzIHRvIHVubG9j
ayB0aGUgZW50aXJlIGZsYXNoIG1lbW9yeSBhcnJheSBhdA0KPj4+Pj4gcG93ZXItdXANCj4+Pj4+
IC0gKiBieSBkZWZhdWx0Lg0KPj4+Pj4gKyAqIGJ5IGRlZmF1bHQuIERvIGl0IG9ubHkgZm9yIGZs
YXNoZXMgd2hlcmUgdGhlIGJsb2NrIHByb3RlY3Rpb24NCj4+Pj4+IGJpdHMNCj4+Pj4+ICsgKiBh
cmUgdm9sYXRpbGUsIHRoaXMgaXMgaW5kaWNhdGVkIGJ5IFNOT1JfRl9ORUVEX1VOUFJPVEVDVC4N
Cj4+Pj4+ICsgKg0KPj4+Pj4gKyAqIFdlIGNhbm5vdCB1c2Ugc3BpX25vcl91bmxvY2sobm9yLT5w
YXJhbXMuc2l6ZSkgaGVyZSBiZWNhdXNlDQo+Pj4+PiB0aGVyZQ0KPj4+Pj4gYXJlDQo+Pj4+PiAr
ICogbGVnYWN5IGRldmljZXMgKGVnLiBBVDI1REYwNDFBKSB3aGljaCBuZWVkIGEgImdsb2JhbCB1
bnByb3RlY3QiDQo+Pj4+PiBjb21tYW5kLg0KPj4+Pj4gKyAqIFRoaXMgaXMgZG9uZSBieSB3cml0
aW5nIDBiMHgwMDAweHggdG8gdGhlIHN0YXR1cyByZWdpc3Rlci4gVGhpcw0KPj4+Pj4gd2lsbCBh
bHNvDQo+Pj4+PiArICogd29yayBmb3IgYWxsIG90aGVyIGZsYXNoZXMgd2hpY2ggaGF2ZSB0aGVz
ZSBiaXRzIG1hcHBlZCB0byBCUDANCj4+Pj4+IHRvDQo+Pj4+PiBCUDMuDQo+Pj4+PiArICogVGhl
IHRvcCBtb3N0IGJpdCBpcyB1c3VzYWxseSBzb21lIGtpbmQgb2YgbG9jayBiaXQgZm9yIHRoZSBi
bG9jaw0KPj4+Pj4gKyAqIHByb3RlY3Rpb24gYml0cy4NCj4+Pj4+IMKgICovDQo+Pj4+PiAtc3Rh
dGljIGludCBzcGlfbm9yX3VubG9ja19hbGwoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+Pj4+ICtz
dGF0aWMgaW50IHNwaV9ub3JfZ2xvYmFsX3VucHJvdGVjdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0K
Pj4+Pj4gwqB7DQo+Pj4+PiAtwqDCoMKgIGlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19MT0NL
KQ0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNwaV9ub3JfdW5sb2NrKCZu
b3ItPm10ZCwgMCwgbm9yLT5wYXJhbXMtPnNpemUpOw0KPj4+Pj4gK8KgwqDCoCBpbnQgcmV0Ow0K
Pj4+Pj4NCj4+Pj4+IC3CoMKgwqAgcmV0dXJuIDA7DQo+Pj4+PiArwqDCoMKgIGRldl9kYmcobm9y
LT5kZXYsICJ1bnByb3RlY3RpbmcgZW50aXJlIGZsYXNoXG4iKTsNCj4+Pj4+ICvCoMKgwqAgcmV0
ID0gc3BpX25vcl9yZWFkX3NyKG5vciwgbm9yLT5ib3VuY2VidWYpOw0KPj4+Pj4gK8KgwqDCoCBp
ZiAocmV0KQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+Pj4+
ICsNCj4+Pj4+ICvCoMKgwqAgbm9yLT5ib3VuY2VidWZbMF0gJj0gflNSX0dMT0JBTF9VTlBST1RF
Q1RfTUFTSzsNCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4+ICvCoMKgwqDCoCAqIERv
bid0IHVzZSBzcGlfbm9yX3dyaXRlX3NyMV9hbmRfY2hlY2soKSBiZWNhdXNlIHdyaXRpbmcgdGhl
DQo+Pj4+PiBzdGF0dXMNCj4+Pj4+ICvCoMKgwqDCoCAqIHJlZ2lzdGVyIG1pZ2h0IGZhaWwgaWYg
dGhlIGZsYXNoIGlzIGhhcmR3YXJlIHdyaXRlDQo+Pj4+PiBwcm90ZWN0ZWQuDQo+Pj4+PiArwqDC
oMKgwqAgKi8NCj4+Pj4+ICvCoMKgwqAgcmV0dXJuIHNwaV9ub3Jfd3JpdGVfc3Iobm9yLCBub3It
PmJvdW5jZWJ1ZiwgMSk7DQo+Pj4+PiDCoH0NCj4+Pj4NCj4+Pj4gVGhpcyB3b24ndCB3b3JrIGZv
ciBhbGwgdGhlIGZsYXNoZXMuIFlvdSB1c2UgYSBHRU5NQVNLKDUsIDIpIHRvIGNsZWFyDQo+Pj4+
IHRoZSBTdGF0dXMgUmVnaXN0ZXIgZXZlbiBmb3IgQlAwLTIgZmxhc2hlcyBhbmQgeW91IGVuZCB1
cCBjbGVhcmluZw0KPj4+PiBCSVQoNSkNCj4+Pj4gd2hpY2ggY2FuIGxlYWQgdG8gc2lkZSBlZmZl
Y3RzLg0KPj4+Pg0KPj4+PiBXZSBzaG91bGQgaW5zdGVhZCBpbnRyb2R1Y2UgYQ0KPj4+PiBub3It
PnBhcmFtcy0+bG9ja2luZ19vcHMtPmdsb2JhbF91bmxvY2soKQ0KPj4+PiBob29rDQo+Pj4+IGZv
ciB0aGUgZmxhc2hlcyB0aGF0IGhhdmUgc3BlY2lhbCBvcGNvZGVzIHRoYXQgdW5sb2NrIGFsbCB0
aGUgZmxhc2gNCj4+Pj4gYmxvY2tzLA0KPj4+PiBvciBmb3IgdGhlIGZsYXNoZXMgdGhhdCBkZXZp
YXRlIGZyb20gdGhlICJjbGVhciBqdXN0IHlvdXIgQlAgYml0cyINCj4+Pj4gcnVsZS4NCj4+Pg0K
Pj4+IFdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBqdXN0IHNldCBwYXJhbXMtPmxvY2tp
bmdfb3BzIGZvciB0aGVzZQ0KPj4+IGZsYXNoZXMNCj4+PiB0byBkaWZmZXJlbnQgZnVuY3Rpb25z
PyBvciBldmVuIHByb3ZpZGUgYSBzcGlfbm9yX2dsb2JhbF91bnByb3RlY3Rfb3BzDQo+Pj4gaW4N
Cj4+PiBjb3JlLmMgYW5kIHRoZXNlIGZsYXNoZXMgd2lsbCBqdXN0IHNldCB0aGVtLiB0aGVyZSBp
cyBubyBpbmRpdmlkdWFsDQo+Pj4gc2VjdG9yDQo+Pj4gcmFuZ2UgbG9jayBmb3IgdGhlc2UgY2hp
cHMuIGp1c3QgYSBsb2NrIGFsbCBvciBub3RoaW5nLg0KPj4NCj4+IEkgbGlrZSB0aGUgaWRlYSBv
ZiBoYXZpbmcgYWxsIGxvY2tpbmcgcmVsYXRlZCBmdW5jdGlvbnMgcGxhY2VkIGluIGENCj4+IHNp
bmdsZQ0KPj4gcGxhY2UsIHRodXMgdGhlIGdsb2JhbF91bmxvY2soKSBzaG91bGQgYmUgaW5zaWRl
IGxvY2tpbmdfb3BzIHN0cnVjdC4NCj4gDQo+IE15IHBvaW50IHdhcyB0aGF0IHRoaXMgZ2xvYmFs
IHVubG9jayBzaG91bGRuJ3QgYmUgYSBzcGVjaWFsIGNhc2UgZm9yIHRoZQ0KPiBjdXJyZW50IHNw
aV9ub3JfdW5sb2NrKCkgYnV0IGp1c3QgYW5vdGhlciAiaG93IHRvIHVubG9jayB0aGUgZmxhc2gi
DQo+IGZ1bmN0aW9uDQo+IGFuZCB0aHVzIHNob3VsZCByZXBsYWNlIHRoZSBvcmlnaW5hbCB1bmxv
Y2sgb3AuIEZvciBleGFtcGxlLCBpdCBpcyBhbHNvDQo+IGxpa2VseQ0KPiB0aGF0IHlvdSBuZWVk
IGEgc3BlY2lhbCBnbG9iYWwgbG9jayAoaS5lLiB3cml0ZSBhbGwgMSdzKS4NCj4gDQo+IHN0YXRp
YyBpbnQgc3BpX25vcl9nbG9iYWxfdW5sb2NrKCkNCj4gew0KPiDCoCB3cml0ZV9zcigwKTsgLyog
YWN0dWFsbHkgaXQgd2lsbCBiZSBhIHJlYWQtbW9kaWZ5IHdyaXRlICovDQo+IH0NCj4gDQo+IHN0
YXRpYyBpbnQgc3BpX25vcl9nbG9iYWxfbG9jaygpDQo+IHsNCj4gwqAgd3JpdGVfc3IoMHgxYyk7
DQo+IH0NCj4gDQo+IHN0YXRpYyBpbnQgc3BpX25vcl9pc19nbG9iYWxfbG9ja2VkKCkNCj4gew0K
PiDCoCByZXR1cm4gcmVhZF9zcigpICYgMHgxYzsNCj4gfQ0KPiANCj4gY29uc3Qgc3RydWN0IHNw
aV9ub3JfbG9ja2luZ19vcHMgc3BpX25vcl9zcl9sb2NraW5nX29wcyA9IHsNCj4gwqDCoMKgwqDC
oMKgwqAgLmxvY2sgPSBzcGlfbm9yX2dsb2JhbF91bmxvY2ssDQo+IMKgwqDCoMKgwqDCoMKgIC51
bmxvY2sgPSBzcGlfbm9yX2dsb2JhbF9sb2NrLA0KPiDCoMKgwqDCoMKgwqDCoCAuaXNfbG9ja2Vk
ID0gc3BpX25vcl9pc19nbG9iYWxfbG9ja2VkLA0KPiB9Ow0KDQpNZWgsIHRoaXMgd291bGQgYmUg
dmFsaWQgb25seSBpZiB0aGUgZmxhc2ggc3VwcG9ydHMgX2p1c3RfIGdsb2JhbCAodW4pbG9jaywN
CndpdGhvdXQgc3VwcG9ydGluZyBsb2NraW5nIG9uIGEgc21hbGxlciBncmFudWxhcml0eS4gT3Ro
ZXJ3aXNlLCBwZW9wbGUgd2lsbA0KZ2V0IGxhenkgYW5kIGp1c3QgYWRkIHN1cHBvcnQgZm9yIGds
b2JhbCAodW5sb2NrKSB3aXRob3V0IGludHJvZHVjaW5nDQpzb2Z0d2FyZSBmb3Igc21hbGxlciBn
cmFudWxhcml0eSBsb2NraW5nLCB3aGljaCB3b3VsZCBiZSBhIHBpdHkuDQoNCklmIHRoZXJlJ3Mg
c3VjaCBhIGNhc2UsIHRob3NlIGZ1bmN0aW9ucyBzaG91bGQgYmUgbWFudWZhY3R1cmVyL2ZsYXNo
IHNwZWNpZmljLg0KDQo+IA0KPiBIYXZpbmcgdGhlIHNwaV9ub3JfdW5sb2NrIGRlY2lkZSB3aGF0
IG9wIHRvIGNob29zZSBpbnRyb2R1Y2VzIGp1c3QNCj4gYW5vdGhlciBpbmRpcmVjdGlvbi4gRXNw
LiBpZiB5b3UgdGhpbmsgYWJvdXQgaGF2aW5nIHN1cHBvcnQgZm9yDQo+IGluZGl2aWR1YWwgc2Vj
dG9yIHByb3RlY3Rpb24gd2hpY2ggYWxzbyBuZWVkcyBuZXcgb3BzLiBCdHcuIHRvIG1lDQo+IGl0
IHNlZW1zIHRoYXQgImdsb2JhbCAodW4pbG9jayIgaXMgYWxtb3N0IGFsd2F5cyB1c2VkIGZvciB0
aGUNCj4gaW5kaXZpZHVhbCBzZWN0b3IgcHJvdGVjdGlvbiBzY2hlbWUsIGkuZS4gbGlrZSBhIHNo
b3J0Y3V0IHRvIGFsbG93IGFsbA0KPiBzZWN0b3JzIGJlIHVubG9ja2VkIGF0IG9uY2UuDQo+IA0K
DQpQcm9iYWJseSB5ZXMsIHRoZSBnbG9iYWwgdW5sb2NrIGNvbW1hbmQgaXMgdGllZCB0byBpbmRp
dmlkdWFsIGJsb2NrIGxvY2tpbmcsDQp3aWxsIGhhdmUgdG8gY2hlY2suIEFuZCB5ZXMsIGEgZ2xv
YmFsIHVubG9jayBjb21tYW5kIHNob3VsZCBvZmZlciBhIHNpbmdsZQ0KY29tbWFuZCBjeWNsZSB0
aGF0IHVubG9ja3MgdGhlIGVudGlyZSBtZW1vcnkgYXJyYXkuIEl0IHNob3VsZCBiZSBwcmVmZXJy
ZWQNCndoZW4gb25lIHdhbnRzIHRvIHVubG9jayB0aGUgZW50aXJlIGZsYXNoLg0KDQpDaGVlcnMs
DQp0YQ0K
