Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DF284ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:19:18 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:24104 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601983157; x=1633519157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qDO6QsgBBrX8X0ieRJSfI/lYwRFllVrmISE7wQEE9E4=;
  b=k6nwzy6Z7bWazMlYuougsA4QjhElM1sr5NcXId+INye8rC1ATQD6kv6/
   iHMX+h2CspT/qPw7mXZcM661Bzi/bsd5gGLIRmjHcpV+zGrl3HrnwfeJQ
   8sm8eW/anj0xQ90rH+IBvHFWFZTMV/P6Qa6/5PC75nryhrmGRYe9vGBEs
   /pjzbxGBcWYttU0kg/4ttz8mczRWktaQt9Tmi1knBJtAzwVZUbFn9T+vY
   QCSznR8vJi/SGsm4FkZD1QetLrhNqFbO3BIys20tQ1HnFLsDEhQ6khgHb
   j4zgwfuXpHvtv4VH8a/CKkOtQrFIqQkoKsuX11xIIeEiU+oEbKISrGwBm
   A==;
IronPort-SDR: J6Z+O2UglRzleZloLZkensHpyBD+LorBMacsYTcrIQztUN3nx9t16NPuz9Ucy9pe/8yUYzqJmE
 4HIWqgVLISM30M47Av6gSFgVwGAavw15aBKEDqRp7n4qlQKSnBsU59TVGt5poH8c+T8uPj8IzC
 bgziMwbiJAHT91E5Z9tvBz+fhPYNww2L9hfH2Tthv0pQU5L/M7qpxRbKafmfq8I5XuEB4esLJk
 E5xnNB8gUl6RpZVLywlHe/3VClGjyebXRgfM/26IcXQZxVDf0vSM+e7XWpYWT5yFpJlf9Ev6Mm
 uPg=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="89256694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 04:19:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 04:19:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 6 Oct 2020 04:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0RSdN6MeJxDhzVFbM+lxmtg5PuhjzLuIXr+DKcaYmn5VNm+naHxGQH9sURfPiOdMWao18rxqOohIi7ZpZmh2fX/22aGXvCPeYc7nT06GBOmP20eXTkTmDoWZadbelUOfv5W1wGjlW7+8yvEvMcp2wGGRah0HOXkMj4PVCql+NnM6cZbbpCr3SWMNwowHT71xAzLe0WawK+8mATcxGquaniy1e2vaqogvfSYsO+jHJfsyuiaG55dlgHEmsd5dQ4qjuDK0UwhucmBsJwn3hVPM7nFEwSuHSjTaHm9Mz9d4l2FlR0OnYgD3FOFLLmEwBGf5J6ReYJYnnuI2p4OhThfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDO6QsgBBrX8X0ieRJSfI/lYwRFllVrmISE7wQEE9E4=;
 b=PAncvknDxopKQIbAdwgE5oGPt/lUFTbN16JxFDj5HXDTVEJF8inXa7Yx8AtHfHfmbetuz9gmK/ve3V7mv2F/QJoL+I1RK+JzmNfzMYGfDbA9rGeCBJMfJXH17uzbcvRiyv2X/qfItBCjgfNbUdLLF4VGJGTvcsxZs7zX7TrdAxQn/ctiyB2q2pioUEJKldDqVfjmshEvaWc+SxJpl2jMk95iSy2ztUDYXbDhP1/CKdXB2ITV8aNKxz8hm+YtTsKqaglXk0B7ScQ5xznEwjALmelAEG3AbBSmF14rOeGcvccnVOczOnCC6yGLPe1UY3+cE6j3kRWaBh+aOicS4PlRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDO6QsgBBrX8X0ieRJSfI/lYwRFllVrmISE7wQEE9E4=;
 b=WhPeddRpLMQ5kp24ZWmfACNJGTAYThZeV0R1jyDUZ/cxpOz8bkWrigFrUpsZabtQI8lS0ZXbtItnc9qVnJQ+TxtVMWNE9QplxhKjbbRhVf1KSJtRVomUZi202BRl5Flsyljqho0AQvz2gfUB4EOy03bGKzZorB+t4e/ncRVqsmk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 11:19:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3455.021; Tue, 6 Oct 2020
 11:19:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <bert@biot.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Topic: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Index: AQHWm9BKX2rNJEczUkGjcv47/rFXb6mKbWmA
Date:   Tue, 6 Oct 2020 11:19:14 +0000
Message-ID: <73a258f3-45dd-1354-d5fd-904d5e372d2c@microchip.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <ed7e13a5-db3e-79ad-0cdc-d2875cef2d22@microchip.com>
In-Reply-To: <ed7e13a5-db3e-79ad-0cdc-d2875cef2d22@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb0c8cd-ed7a-4dba-36e9-08d869e9a863
x-ms-traffictypediagnostic: SN6PR11MB2575:
x-microsoft-antispam-prvs: <SN6PR11MB257544BB9348C69892466F7BF00D0@SN6PR11MB2575.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldZEHHLFIm88UU9YqXQoBPiGOWWu2q7c0i+0xvvEW51Fy62TVJnR8IyPettUYoMkqmy9f0V/HxXLvqfhpaGD6moGUx+U2Z9hmV++Qhs7Enk/OZsmy+qjv6VGpZVutqK1KywEk+q7aD9mEETQexf5whFCn8iSzPDkzx3dJUINcfh+xL4CBBoKZc19YhGrGqZY17Qj6WxhyI/H5mve6rUJZvDRAFE5nluTA146JKkqnJ9H1FhU9XVNxfEomGtmM1BFJOKT/yzP67h2EcW8AhIqDG8+0BIMo/Y02AxjG+VxH6dBKzwwErDChf63sEYU4wmCjcbSJ+GEKKR2rIFWLzZGD0AmYDitzZ53DIrgK/xGpSiOtGlBti8+8qKcV87yXIFP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(8936002)(2616005)(316002)(4744005)(110136005)(8676002)(66556008)(64756008)(66476007)(36756003)(66446008)(53546011)(478600001)(6512007)(54906003)(26005)(4326008)(5660300002)(186003)(6486002)(66946007)(76116006)(86362001)(71200400001)(83380400001)(31696002)(6506007)(31686004)(2906002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QcsI1XPnVSETUiP0dkXNNIUB5e2N0cIlrk0+8c4WsOLD8Bchlmg16YE263gEQsNnnRouA3/p9gO69EWViSKUu0as9/hlqGDLA6H0tpZTWqy7wCrmH2B6TvQPNm4d4gujsdau9tc82u+UXhI3aSnFCxJHys9wM+D2OFIedbrcDus/9WAKNGausKxo4b5n+fxqHTuNjS2U+hSSl3Z5H+9GU1nc25I1G9igMqi0VbxO6ozPrPYtVT3s/CojVaTans5UoZC7YWnKUTG2nPPvR/Iuak2prQNeIl1LZeTLERqByHFwGQ93HLovWXqLTfaqfYjYgStcyVzYKeTsW0FsenmGAA1iq0V5S/5wwgzFuosQcAsYNM1B5BbGXSTffjAcGwa4wIRxORq+xpn1erN6yxuZRjyRrsoJrBD/BppU6WRfwo7mpB/elReL0xMlLUGm5DXgluqWxcVpARiXDZlZJGDH/9SyODkblqAka9/Ea8ATUZZfYje3lBR0CPJ2HuMuPtjl5/dlHdopqVVDnHtYDOfGg9pmdhlx2zI6/RTsqebvSmYEJaIYIwM4WpQB7V2Z+E95nj14EwPzXw8My4nu0wdrcxdXmQbJjDE4aIOC09xNMfkRh8/7vBHzZtoI6gX1IsABRsm3ZEbK65mUtbdC5rLvlg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CCAD0398B229D40A5A7F17334733353@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0c8cd-ed7a-4dba-36e9-08d869e9a863
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 11:19:14.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wW4k6vXUo5kDtoB3cueuFGpjJjWGU/xOABj0b1Sf5qz7sZv/jKnDMBT1xL12sPZJQjHDs8MYYAQZG6pPBFv9I5KIyPF8LPAet1PMSbNFon8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2575
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNi8yMCAyOjAzIFBNLCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0IHdyb3RlOg0KPiBPbiAx
MC8xLzIwIDk6MzQgQU0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4gU28gdXNpbmcgYW4gYWRk
cmVzcyB3aWR0aCBvZiA0IGhlcmUgaXMgbm90IG5lY2Vzc2FyaWx5IHRoZSByaWdodCB0aGluZw0K
Pj4gdG8gZG8uIFRoaXMgY2hhbmdlIHdvdWxkIGJyZWFrIFNNUFQgcGFyc2luZyBmb3IgYWxsIGZs
YXNoZXMgdGhhdCB1c2UNCj4+IDMtYnl0ZSBhZGRyZXNzaW5nIGJ5IGRlZmF1bHQgYmVjYXVzZSBT
TVBUIHBhcnNpbmcgY2FuIGludm9sdmUgcmVnaXN0ZXINCj4+IHJlYWRzL3dyaXRlcy4gT25lIHN1
Y2ggZGV2aWNlIGlzIHRoZSBDeXByZXNzIFMyOEhTIGZsYXNoLiBJbiBmYWN0LCB0aGlzDQo+PiB3
YXMgd2hhdCBwcm9tcHRlZCBtZSB0byB3cml0ZSB0aGUgcGF0Y2ggWzBdLg0KPiANCj4gRG8geW91
IHJlZmVyIHRvIHNwaV9ub3JfZ2V0X21hcF9pbl91c2UoKT8NCg0Kb2gsIEkgc2VlLiBJZiBhZGRy
IHdpZHRoIGlzIHNldCB2aWEgdGhlIFNNUFRfQ01EX0FERFJFU1NfTEVOX1VTRV9DVVJSRU5ULA0K
Y2FzZSwgYW5kIGlmIHRoZSBmbGFzaCBjb21lcyBpbiA0IGJ5dGUgYWRkcmVzcyBtb2RlIGZyb20g
YSBib290bG9hZGVyLA0KdGhlbiBzZXR0aW5nIGFkZHJfd2lkdGggdG8gMyBpbiBjYXNlIEJGUFRf
RFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80LA0Kd2lsbCBicmVhayB0aGUgcmVhZGluZyBvZiB0
aGUgbWFwLg0KDQpJZiB0aGUgQWRkcmVzcyBNb2RlIGJpdCBpcyB2b2xhdGlsZSwgbWF5YmUgd2Ug
Y2FuIHJlc2V0IHRoZSBmbGFzaCB0bw0KaXRzIHBvd2VyIG9uIHN0YXRlIGltbWVkaWF0ZWx5IGFm
dGVyIGlkZW50aWZpY2F0aW9uLiBGb3IgdGhlIE5WIGJpdHMsDQp3ZSBoYXZlIHRoZSBzYW1lIHJl
Y3VycmluZyBwcm9ibGVtLg0K
