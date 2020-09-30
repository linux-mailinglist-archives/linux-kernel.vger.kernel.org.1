Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC527E48B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgI3JMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:12:22 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:39028 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3JMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601457140; x=1632993140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oV8lFBButuiS0JMIb6X/7vRp9AyRntZh6d0dE+Umksc=;
  b=KrZYAHzc09k2lkJ/Ky4agMs+rQIg1ENgBKbzRERK7jjDkYY51oigl8K0
   v5AjEIAuxffkLa88/93LY6HKqNiryUil4T86AVU4EoExQd4XSVnMalUQd
   dMGwV8vJw977opbtVzZ7V2+PC+gBYg0dUuWLaumG7E9sn/236UhsA1yc5
   hAn5c+snvOtgWQrJ3AZ3Qo3BCBPdzQGbysQhuvcuKkf32M74OqomcPIZQ
   gvSg8pfChXERmIjeOO/om8mnZPLK1/BDZ7EvZaWthTksvMnqb2F/4pIup
   uqX7SXIXy1Ho3XdI1axJklDj5H4hv3nN9I+jkx0mCr0iGX7k0p43i20Mk
   w==;
IronPort-SDR: gjgi/kExCIy/bncSlln1+aAVO/UsSBC/veJ/BQdDS44AzZJ4W8ZGmOsfRUWXQPgyvRuoctnBXM
 1jF59/6RdGona7//q6r6vdBCxTOXvga7AWgzBz7CB9glelIyr5mvhYZArSqIrrfhhUL6dJiQlo
 vNZ7gKZwvD3KESI+4+x5bDG8mkEdJ8S4ZA7aC2PeNzAiEzGxH3AAdgpENe93HuKE4Ako7BWWWK
 O0TzPWe6rUZ/NI/QQNm/49XMkPjDIiq6C3Za4pja8Ld9BtM24YRjY8v2dsqgl4GxugtENZJOlW
 Ydc=
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="28201720"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 02:12:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 02:12:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Sep 2020 02:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X46+/M5pCypNSR2wPADHcLG836ypkLsV21bBAOt+rvfrMu7+A731xkpEG2VISdgInZBR75M3jklXKKbj2NnG8bEUyWpebLbmJM/g5EjmPDDInOh3czHbtFWwhcY2nwsEKpPpaxweq4iBKR/X2Q33IdwK+rMDGzbahZlAISDMshk7gCmhifxWU0v5YqPQEDUBIwf2k2GxogtKNAOGPXKXQ9sXkOjnF3sSRI+ptpISj6DdRElQf98q142Q8ICk3dNy0bPTPzLqVwCBnt6gsyrcuKlO07+1ntgTZuWDaKN7ZvuQYvsyAvEraWLvO0GslYHWgv3Pl4IKy8HOOhj0XWdQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV8lFBButuiS0JMIb6X/7vRp9AyRntZh6d0dE+Umksc=;
 b=B1Zbjd/ukKSMOJbKDOz4R9VMH8IBONTB6RSgXqrqqaM1DbZPpSK6YjHrzjhMwbCtiz5g67A0QZn4/vzIvmUNQGvaFnqLjMbRSKiD26r/Xw2Hiu14WkxgjjoQlHyLIxyabdS+4vFZIUgBrXuJ3f2Em4lbIk+51GzargWFKtheuQiknbzw1/Rrk8b7PDP9Cs5fV1fmFSrDiQ3YPsOGKo2oPUHubddgg/j3LUjmsB/pelviHxF4UERnHLtibdV9khJyb5S7DRA3z5GKTDApQNECyLmvaBP846Nd3dKgxB47HXFd5t7r8kL4zZOE5NcfHtceHOMMAw3s4hBd4fQ6JvInQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV8lFBButuiS0JMIb6X/7vRp9AyRntZh6d0dE+Umksc=;
 b=RqNuxeXLoj7J+eVKBJ0Ej1X+/A0nehgMc0aS4H4PXUhm3VjfGWG8Uq9MCPpPyrNy3PBxq4r4OjEjz6dVoi3wr6T3SGOvtbNboDrPf12Uva4a505ncgcFViLQ7mR+LE0Wt8pi3BYqfTiTKSHMfuJcyedKbHui7JkUaZ85WR+f2bs=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM5PR11MB1338.namprd11.prod.outlook.com (10.168.103.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23; Wed, 30 Sep 2020 09:12:17 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 09:12:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 15/15] mtd: spi-nor: micron-st: allow using
 MT35XU512ABA in Octal DTR mode
Thread-Topic: [PATCH v13 15/15] mtd: spi-nor: micron-st: allow using
 MT35XU512ABA in Octal DTR mode
Thread-Index: AQHWlwnK3bG2I0cC4UaUmPIuOZHDFg==
Date:   Wed, 30 Sep 2020 09:12:17 +0000
Message-ID: <62ad761a-3fcf-07c2-0b3d-0a27d877dcde@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-16-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-16-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a160f19-fff7-49a5-66ed-08d86520edbf
x-ms-traffictypediagnostic: DM5PR11MB1338:
x-microsoft-antispam-prvs: <DM5PR11MB13382C2B35D580F0738E5085F0330@DM5PR11MB1338.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: daiT/GFinROE4ocFW4c2UKwLJYTDA1TcKfSTECd3cRhLiOyzaxP2rLA7hmIHIWm6v5/xqLf9ljPOsfwegdv0qLdhaBPd8u0GwolFBwrIBCY5XtugZ+hGHc+2Ws0RQd9FvIeM0YPJTzJZMUiSu0at/d4/Mhwjc4NcbhJhYmUJTtvxCKNpqZEuH8M2nWintIVE+MOco6cZhjDV1C3YGPj9EFwfMXaDDnZFhhi5ai/9qjOITc6a0FzXgvPval2iDLphlH7PsAL5YBcz5Eu7kyyvdJwY/deMJUEjjvJVl7y4ZWf6B7oQUY/2uhje9QNLxxXDvcUeozFIHTG0m9jev9W6sviFi/na0zn2L6PyEnSAmME85FzpwhFSHaEr91IpdeDv85ZRTzI/ASO7QXMXWisYc0ZzkZfpaBUrDot3NgrJJHVMJmf42tSKp1s6Q1huA1gS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(36756003)(6512007)(8676002)(8936002)(86362001)(76116006)(91956017)(478600001)(71200400001)(66946007)(31696002)(110136005)(5660300002)(26005)(54906003)(316002)(186003)(4326008)(6486002)(83380400001)(66446008)(2616005)(66476007)(6506007)(53546011)(64756008)(31686004)(66556008)(2906002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: x60I7AAZBoIbJ52COQfyWwT/YfqmfuzLg5bXucY3ZoR6qWCIN+orM3zJnehqPeHDtL4dLabwxsj0pwGkGHm+58wYKtEGefBMm4fiJrBdojcBI7aLu67erfPUJG1zcj1SC9S6Nn7amjfETcJgYhFnOeqJijMkqxsPjnfeQiQgu8wqw5LpV5Syqc+L+nBF5EM273u+koEh3IAB9NafAApuq0XnmlSbwLl6d3LoI981+IbElGw1tgqzMd2ru4CU/gUXSLjtND6+Sdqg3c4Oj/t/+PNkEEu7Lu25p755aui0OlAlVa9rNeweETVT5TGruZogjOakigzcpIX6S3PRbwdtosluKN9zLCmqcOukN6pSx19sYhVplv9ROg+60PJazJ1gKG1pSI5lluvAUNut7ZDMYgIbhaPsyTfKxjFvOLtYaJNiK9rUnhF7or5jWsh4a6Qv9h0IR++UOaZvojjZUXk8dP3Qz0D96/9HzjkOJVbm6R5I0OhoXbdQ43c0/tqE+Cpo+pD20bo/rJdrcLeDJEy2rEC1Xmp/0EXgClUecoFOs8wXPmcpPHO8L4Dx94rpGPCX1tFUs2H3wMaFToMjS9ji8e1uFarMIlhHuAgmyQrUzIvWfh2dTpH7B71en9UZtqu40oQIB6r9c1AJ0AwaZXJhog==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4F3D63CA72B143BBB373C771C5D66B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a160f19-fff7-49a5-66ed-08d86520edbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 09:12:17.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLKbgviNMZpFnG+gw8mVvHjSrTUjcdggK2BCr21n38ZfP9pnfUCbG+tZbNSKSN5KmQ8y4VMjGJfvz46O+M0QOCaGBnRQkpfRRP8R+3bQbhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTaW5jZSB0aGlzIGZsYXNoIGRvZXNuJ3QgaGF2
ZSBhIFByb2ZpbGUgMS4wIHRhYmxlLCB0aGUgT2N0YWwgRFRSDQo+IGNhcGFiaWxpdGllcyBhcmUg
ZW5hYmxlZCBpbiB0aGUgcG9zdCBTRkRQIGZpeHVwLCBhbG9uZyB3aXRoIHRoZSA4RC04RC04RA0K
PiBmYXN0IHJlYWQgc2V0dGluZ3MuDQo+IA0KPiBFbmFibGUgT2N0YWwgRFRSIG1vZGUgd2l0aCAy
MCBkdW1teSBjeWNsZXMgdG8gYWxsb3cgcnVubmluZyBhdCB0aGUNCj4gbWF4aW11bSBzdXBwb3J0
ZWQgZnJlcXVlbmN5IG9mIDIwME1oei4NCj4gDQo+IFRoZSBmbGFzaCBzdXBwb3J0cyB0aGUgc29m
dCByZXNldCBzZXF1ZW5jZS4gU28sIGFkZCB0aGUgZmxhZyBpbiB0aGUNCj4gZmxhc2gncyBpbmZv
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgfCAxMDIgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1u
b3IvbWljcm9uLXN0LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+IGluZGV4
IGVmMzY5NTA4MDcxMC4uY2MwMmMxNDE4ZDFkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL21pY3Jvbi1zdC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0
LmMNCj4gQEAgLTgsMTAgKzgsMTEwIEBADQoNCnNpbWlsYXIgY29tbWVudHMgdG8gdGhvc2UgaW4g
MTQvMTUgYXBwbHkgaGVyZSBhcyB3ZWxsLg0KTG9va3MgZ29vZC4gSSBjb3VsZG4ndCBmaW5kIGRh
dGFzaGVldHMgZm9yIG5laXRoZXIgb2YgZmxhc2hlcyB0aG91Z2guDQoNCkNoZWVycywNCnRhDQo=
