Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4227CEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgI2NNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:13:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38423 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgI2NNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:13:19 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 09:13:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601385198; x=1632921198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WlK/2+GPKSvMcfe/7qJAzWkTg9/8RPkmElDCuJXePrc=;
  b=apMOAMU1YJVeky1sRPD9YTF+YbU/jnUUxndF6iag0R66Dn+HjvOhttlb
   ZO1dLcxkCCiYBF2HnFtCLu5llKNnWrcdmKEaarVvHrjw1ntkm/OUUJ09G
   ln6T6R5T/KSllmyjEiFqRZ1Pl5gnPQxQ1K14V1TaZwMq4fg7CrH+dz1Ld
   fq5Ix0aDPqSYtT8295ujeLcxZ/QpDUYxkHw04KfyQT5jS+1YVzt5fKZ5I
   8fRe56pDKCsh4fhL44VT8LAjhhHGd/InOhYuVqbNzthM68FyD5LFUnUFM
   WgAsEoAJXuPn34WkZhZMTBR3+Xupx00lZEWOZDJFHK5UNkTsA/C538pva
   A==;
IronPort-SDR: xhxtxwT45RlkqwzT4nmdNU/U4FwuZ08mpoYFD7DSk/fewFNpG7Na2zElRUottmDsIUnQKnJDUA
 fBdOxdGFG6Nq7ogzHX5kt8GPWpsfvCVwP36IsfoqbyjO0EhzUzkn0NxGATy2RTkvC/8ZHxTLPj
 7YNRdNJaboAHrzmEm20rIxtnhTGd6nPnjtTBqlXMTcVpyEE3zBREugbj5uF4b/Y2ReCSo36Fkj
 pkIcN9hILAMwdH7GsDD1SIfor79SiuDfUtxmGWLVZCTiTPIUSpEYgUXAPpWolqHHtCB/FPM9GY
 uys=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="97579282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 06:05:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 06:05:06 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 06:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBabwzarqNrTpTL0YcBPWfeUOcwSCEBAqBBGR05uUrnrAk3QHvI5xY8DQg/i1asFhs5l/rXlb2uIX1etnx0kEMxOi2PFph9HUge72yjVR9T7t1O7hibwlxAiIzS/3lyuNNPb3ES31zVIsjHrkx8QZNiatkL/+LN0D+eOQrPryE9MwK303hDiAJ+Z4ILxrtjz+IrFii1tDGU5yT/md0ywBX+95SoCie96kJW+NNv1FBnCfhE4cZp1f3XisH3zi5Yc6Jdhddn04Xuk+0XdlZm7SZ/abpYwAOSsKgrZUuGN7fdNQoCNuvvbNCM5NkJJOapBBEMEmrtYtYmaDeVKkDYf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlK/2+GPKSvMcfe/7qJAzWkTg9/8RPkmElDCuJXePrc=;
 b=VkfNlAdJsUXrVAz6T3X1sO/qgqJTLqP5lEWUOSYF2HShw3jMIbRim2CRRjX866wlDMTBzW/f7kXmZE7ZNzZIZhkG8e+FmMjKQ+c5SWo/sf+xvLGXDWZnDb6gz9ULdFmJ9rFGrNzqdQ/gXpNNc5bwpXeHYZsGBho/LjYI0qClvEISWR7TLVPFQbSkfsNTEr/gOowbFh7xoM2cezStMs0V8OKSmJk20RY++prEQNRvxiaPvw1PQjIcbugemqVCeqXRAi9V09AR6DL11PplqbdAq2Ip4pYk8hfALT8NztlQivKUB6jTJXDeayuMmhE3P2ENBQTajEPcf1iexGD8kdfJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlK/2+GPKSvMcfe/7qJAzWkTg9/8RPkmElDCuJXePrc=;
 b=cyeqYXeOJy0JWtHwZBd5EB+tu287A00t2V2A45kMcpUwyi38uyO7YdkCH/xHoY3yaa35T4YlXyWEXTdPth27X+MRIeGUVXFag3a2gmBnB25CtW/m2PCMtlyatMxywz7lcfm4del1aJBCsuZIWB4NC9fMtYSrJ+4og8pe+4DXINA=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4396.namprd11.prod.outlook.com (2603:10b6:5:203::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.23; Tue, 29 Sep
 2020 13:05:14 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 13:05:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Topic: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Index: AQHWllNcSEOJ06dulUeHo292BYv/qQ==
Date:   Tue, 29 Sep 2020 13:05:14 +0000
Message-ID: <dc0fd8d2-f639-0752-2a4e-8adaaeec5c7a@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-10-p.yadav@ti.com>
 <feb046fd-a9ea-9ea3-55f7-bf823ed1e61f@microchip.com>
 <20200929125131.fmztz4rr2iuj6uof@ti.com>
In-Reply-To: <20200929125131.fmztz4rr2iuj6uof@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b40686bd-be19-4ba7-2a06-08d864784e4d
x-ms-traffictypediagnostic: DM6PR11MB4396:
x-microsoft-antispam-prvs: <DM6PR11MB43969FE0E80D7C8B199A47B4F0320@DM6PR11MB4396.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vdw8ah9TnjWjy32L+3zZP4Oh/YT435tHKZpmwkMRt/9ydixwIdu5wEhHoMtDUplCh7+XwpmBJakwuh7cy+YE6nstzoffbflUBYLOdnYxHGH/ElP+UQgvnNKnW6YtsemOlJXVkP60Nvkj5Juq+PalzKVBaxvW7QHz+BaDFGjlg/qYScx91dGDZV2dgQ9FBhr2kZE4FYRcIEHZ0VQ9YQ2bHzLuVAdPvl4nV/lnpVgRM6OMzYA2HPZHY0NWjMkctBlZdnsklhhyLCnY4wBEVXXunLJ3v2hnWDAIqPv4QquLqH5eBFW2+l9NrH8OIvw/MDtPhXJe20asQXjSSVWTj6fRmHAWUDyyFKRyJIf8GnphBrqFPmLUvAoo7qINlw/Cy3cJ+bMTNn8eYhvMVP4d8PG+3OPrafeqVAfPYj7Rr55a41sXu9QqFg4nAKopXaM6JRtL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(36756003)(53546011)(6506007)(186003)(8936002)(6512007)(8676002)(26005)(31696002)(86362001)(4326008)(2616005)(2906002)(54906003)(498600001)(31686004)(6916009)(76116006)(6486002)(66446008)(64756008)(66476007)(66946007)(91956017)(66556008)(5660300002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5Mv3+6OYWGOjpQI7xmypMOnvP5dEGuZ9UVsmG6gkHCZ3ZXjExaISOZT0zVUXFndhmVwaZI2NBbPsEViNoDKIzJ340kqcLseph6+odzvknSBfc08DFQS8inUHzFjV5EnPa8KWU8tTAzFqPe5uMpV/Bto696EGK1tbJvtl/ZMsUuhkLeIXv/kryEuqbBo/sHpeJiDJByCLPgQwj/mDpS0tHcFMNo6jOEBLP8K4zBW5P9m+qKqM01J7p4wHTB37jOXxUHs8H5CAT8giRbJJbCScPO07FkVfEuK4HBnQzdPuEV7KDo8D5Kb6sciMrR0V5x8TEc9Emlb8W8RfKi73JBlwAvV3FgOCz3U31Kb/YWLYHMibfh4591UBbwiBNrzsZRhEYGvZk9KKZs8HLXrBnIFXftEfldPsEl5GkkJ3LSKDRQE+tE4FeJZFHdvA48GT2f+Vos1vhQ9OYcy/PtzcQpUCWhMtKE87HXiXbmTLGo9Ifo4Slo0KIzKBssUvM8AtnPs6ZCqpx0gvpZN4GsELQqKu6rxJM+DrZqsKxTRRF+ssdUQhU05kwRTlywLkWvcQ5A5u+0xWaw7nm4RtZIdcNBTna7cXJy11uaqhbag+YbDwmGZMiwdrvViP1cDN6Vtm9sLzuKf6ZzVHsX1h4K6Huean/Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <161DCC45109BBC4589D8EE26101C78CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40686bd-be19-4ba7-2a06-08d864784e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:05:14.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPmAi0X2OzxoaifksquDtTptRzcneU+8uxDrMiRXitVLlsY6NCLz5rmRyNA7j6WBiTU3ClDFWW6RxVFzkIRG0crKuCzoIAHFxBDFYn0yGXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4396
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yOS8yMCAzOjUxIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyOS8wOS8yMCAxMToyNkFNLCBUdWRvci5B
bWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiA5LzE2LzIwIDM6
NDQgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+DQo+Pj4gQWxsb3cgZmxhc2hlcyB0byBzcGVjaWZ5IGEgaG9vayB0byBl
bmFibGUgb2N0YWwgRFRSIG1vZGUuIFVzZSB0aGlzIGhvb2sNCj4+PiB3aGVuZXZlciBwb3NzaWJs
ZSB0byBnZXQgb3B0aW1hbCB0cmFuc2ZlciBzcGVlZHMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAgMiArKw0KPj4+ICAyIGZpbGVz
IGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4gaW5k
ZXggODdjNTY4ZGViZjE0Li42ZWU5MzU0NGQ3MmYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMNCj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0K
Pj4+IEBAIC0zMDY5LDYgKzMwNjksMzUgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1z
KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+Pj4gICAgICAgICByZXR1cm4gMDsNCj4+PiAgfQ0KPj4+
DQo+Pj4gKy8qKiBzcGlfbm9yX29jdGFsX2R0cl9lbmFibGUoKSAtIGVuYWJsZSBPY3RhbCBEVFIg
SS9PIGlmIG5lZWRlZA0KPj4+ICsgKiBAbm9yOiAgICAgICAgICAgICAgICAgcG9pbnRlciB0byBh
ICdzdHJ1Y3Qgc3BpX25vcicNCj4+PiArICogQGVuYWJsZTogICAgICAgICAgICAgIHdoZXRoZXIg
dG8gZW5hYmxlIG9yIGRpc2FibGUgT2N0YWwgRFRSDQo+Pj4gKyAqDQo+Pj4gKyAqIFJldHVybjog
MCBvbiBzdWNjZXNzLCAtZXJybm8gb3RoZXJ3aXNlLg0KPj4+ICsgKi8NCj4+PiArc3RhdGljIGlu
dCBzcGlfbm9yX29jdGFsX2R0cl9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFi
bGUpDQo+Pj4gK3sNCj4+PiArICAgICAgIGludCByZXQ7DQo+Pj4gKw0KPj4+ICsgICAgICAgaWYg
KCFub3ItPnBhcmFtcy0+b2N0YWxfZHRyX2VuYWJsZSkNCj4+PiArICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQo+Pj4gKw0KPj4+ICsgICAgICAgaWYgKCEobm9yLT5yZWFkX3Byb3RvID09IFNOT1Jf
UFJPVE9fOF84XzhfRFRSICYmDQo+Pj4gKyAgICAgICAgICAgICBub3ItPndyaXRlX3Byb3RvID09
IFNOT1JfUFJPVE9fOF84XzhfRFRSKSkNCj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
Pj4gKw0KPj4+ICsgICAgICAgcmV0ID0gbm9yLT5wYXJhbXMtPm9jdGFsX2R0cl9lbmFibGUobm9y
LCBlbmFibGUpOw0KPj4+ICsgICAgICAgaWYgKHJldCkNCj4+PiArICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4+PiArDQo+Pj4gKyAgICAgICBpZiAoZW5hYmxlKQ0KPj4+ICsgICAgICAgICAg
ICAgICBub3ItPnJlZ19wcm90byA9IFNOT1JfUFJPVE9fOF84XzhfRFRSOw0KPj4+ICsgICAgICAg
ZWxzZQ0KPj4+ICsgICAgICAgICAgICAgICBub3ItPnJlZ19wcm90byA9IFNOT1JfUFJPVE9fMV8x
XzE7DQo+Pj4gKw0KPj4+ICsgICAgICAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4gIC8q
Kg0KPj4+ICAgKiBzcGlfbm9yX3F1YWRfZW5hYmxlKCkgLSBlbmFibGUvZGlzYWJsZSBRdWFkIEkv
TyBpZiBuZWVkZWQuDQo+Pj4gICAqIEBub3I6ICAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSAn
c3RydWN0IHNwaV9ub3InDQo+Pj4gQEAgLTMxMDksNiArMzEzOCwxMiBAQCBzdGF0aWMgaW50IHNw
aV9ub3JfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4+ICB7DQo+Pj4gICAgICAgICBpbnQg
ZXJyOw0KPj4+DQo+Pj4gKyAgICAgICBlcnIgPSBzcGlfbm9yX29jdGFsX2R0cl9lbmFibGUobm9y
LCB0cnVlKTsNCj4+PiArICAgICAgIGlmIChlcnIpIHsNCj4+PiArICAgICAgICAgICAgICAgZGV2
X2RiZyhub3ItPmRldiwgIm9jdGFsIG1vZGUgbm90IHN1cHBvcnRlZFxuIik7DQo+Pj4gKyAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7DQo+Pj4gKyAgICAgICB9DQo+Pj4gKw0KPj4+ICAgICAgICAg
ZXJyID0gc3BpX25vcl9xdWFkX2VuYWJsZShub3IsIHRydWUpOw0KPj4NCj4+IElzIGl0IHBvc3Np
YmxlIHRvIGVuYWJsZSBvY3RhbCBkdHIgYW5kIHF1YWQgYXQgdGhlIHNhbWUgdGltZT8NCj4+IE1h
eWJlIGFuICdpZi9lbHNlIGlmJyBoZXJlIGRlcGVuZGluZyBvbiB0aGUgdmFsdWVzIG9mIG5vci0+
cmVhZF9wcm90byBhbmQNCj4+IG5vci0+d3JpdGVfcHJvdG8NCj4gDQo+IE5vIGl0IGlzIG5vdC4g
SWYgeW91IGxvb2sgaW5zaWRlIHNwaV9ub3Jfb2N0YWxfZHRyX2VuYWJsZSgpIGFuZA0KPiBzcGlf
bm9yX3F1YWRfZW5hYmxlKCksIHRoZXkgYm90aCBhcmUgYSBuby1vcCBpZiB0aGUgcHJvdG9jb2wg
ZG9lcyBub3QNCj4gbWF0Y2guIHNwaV9ub3JfcXVhZF9lbmFibGUoKSB3YXMgYWxyZWFkeSBkb2lu
ZyBpdCB0aGlzIHdheSBzbyBJIG1hZGUNCj4gc3BpX25vcl9vY3RhbF9kdHJfZW5hYmxlKCkgZm9s
bG93IHN1aXQuIFNvIHRoaXMgaXMgZWZmZWN0aXZlbHkgYW4NCj4gaWYtZWxzZSBvbiB0aGUgdmFs
dWUgb2Ygbm9yLT5yZWFkX3Byb3RvLiBJIGRvbid0IHRoaW5rIGFuIGV4cGxpY2l0IG9uZQ0KPiBp
cyBuZWVkZWQuDQoNCnlvdSdyZSByaWdodCEgdGhhbmtzDQoNCg==
