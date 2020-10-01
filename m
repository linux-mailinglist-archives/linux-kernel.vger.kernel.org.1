Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF627FB73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgJAI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:26:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31697 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601540793; x=1633076793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dKhm5Jq3RjfBobsY9x8yph06SCWNGKiKuD9sEJFSc/U=;
  b=bSWjwMstJPfq9iAnEyGr1FClMwUTu7FP4BoqO5r+gUY4iWkSQiIhaFBC
   NBKWT5tPS67lmElY7du/XYSjGy8Jrrh7hEzFhw7qdDFgla8tAzRU9DdSB
   nRC0DXPVEoiWOaUtChM5vP+31COzio8Qc5E4bpZaSSCqXcAdjZ1Zv0ccl
   mP05YAeZujd+laXkkCzKqdPEQBEpXjSzcdJcMtKvBsICI7oUc1LdzGeKb
   sOnwMf53KXcZ+uslEerWgUiJly3JkcD6ZbZmFqdb/CyZg0KS4kYSpD0jw
   nfwMSIXsFkpPoJi4xI9CocVmnvPjQZmylD6fsJElC5NCG79zPQDJz1f6z
   g==;
IronPort-SDR: sxQxMN/EgScWb5fTl8NAZQqjvOUFzos+DGRcUErUnzkVUbFhLFY7ck0N6mBjC38RA9toOk1llH
 ttGTG5OBMfIXvwc623Bl52t8qd955wNQ9kiu+iWfeKxDJEMi/ZOAq4gc7N7E0YhHmB6baM8s0L
 gVxI0Dz/RpnZCEmYM9MeYHxJ7u1YzestUh24/NqIs1HexAgViI2ur0ZSyor78Kt6irt2Ii5GDt
 QgyNkQk9ca/fD1ybxnpKdm5etXQ6UXUifkhR5Q6IGfffKx4qEYn4+7pq0BFtAjL3ZRbRiglzjN
 TPk=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="97881143"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:26:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:26:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/WnlIF/+af10rZISmfti5aswktv1MJjXliD7dKcKVfd1wews541SkX1hQa/UQhaxdZpleeLr+a18ieY2m+GQbafm4QscSZp6g3Ts4PeulgOXI5bhmZQBEvF9oPmC/USn93oTg/2MFgeXJNFzGBauvntnxM15yBGPkVEscHGsyq5NEeP/eLddbl7UN0okPZQjRiSaa9ZuAHuudB4x+RBgYWwoIc5JPeV5UWMcE1ADO2l9f9wXFWcK2U9zynAqB4+vKmVYkaP+uikwFJGzWGXZLXlTlPt0STXRF8BkWpzXWmmbJPBREbLIDzYwIzkU3jobdWVvKjOsdUbrT1y6DTFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKhm5Jq3RjfBobsY9x8yph06SCWNGKiKuD9sEJFSc/U=;
 b=f1Wx3Rt2LJ5+MF3TICTnZ5vSVCNQx1bW/zwv4000pRpN9YF5+rIm6BgzW0/Sx6eLj4ycDMfy1OmXz8gkKYVvlP1jkEj7d3E76bG7xMM5FnEuxjSoTQ1wCjUcju5bwmZS6A/GDJV5fKOP+P66iDBZ1fSuNsYYnAWR6DN+GFATCem0VNSse6n3vQrl2x5ul/hnm9JBXTZFBVLL9fUEjVNpnR6F2F0Ff4FNO2wqFHsnQ7NBbqjkPdpbNNFEvu8ghSJjY2Wbb/rjCWlbwUXcUfWpEjs9JyOrIQ2SomtdmDbr1lCV8w6V+GZbqHQ3meBj/ozC3zZP8ssUaPHlwuro3l5+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKhm5Jq3RjfBobsY9x8yph06SCWNGKiKuD9sEJFSc/U=;
 b=LvOGKbQOkCF8+KAYzZ4tL+15OqWuc8CAn8T0iFg71JAHmH+jnzI+5XYsJqzT+EmrelMlmnFPGCJJXraPjc6zGWV+MYWOKrVnxSx8jwlQakqVzWBUGm1s49God54CqIZT6jvr/BuHwjuI0UetKVAAA6aJW2TLfSR62TBUvRZcRy0=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 08:26:30 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:26:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 13/15] mtd: spi-nor: core: disable Octal DTR mode on
 suspend.
Thread-Topic: [PATCH v14 13/15] mtd: spi-nor: core: disable Octal DTR mode on
 suspend.
Thread-Index: AQHWl8yPvqdpa5efVkG93RkAcVFpGw==
Date:   Thu, 1 Oct 2020 08:26:30 +0000
Message-ID: <cd70d1bb-b2c6-0645-7534-b54ddade9117@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-14-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-14-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 792f83dd-4ba0-49ff-a493-08d865e3b2d6
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB194719E60A1F6934D5441462F0300@DM5PR11MB1947.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HL7lpUM5vRogI8koHFX9MVbZ6lEztRw7gOKm8wEKDZ/g9QQpYWyhoSrTp+tZqddfTrvyjS2BmcvncPXw6RH92sI6sWfcBYMuKjEGA3jZML7AEw5Jwi4j1Dad2J1O2GHrRT63kaasE1O5qtafL0EzYNZI3zJ89NC1foOxeHJt7dCXElLwQ4P5+aecf8B1supSyuJ4HSGCyIBqmci/J5iUZzznwXyjhriGLwLKVqZT4Pf1qqbftHPHnvpWWXNLaxgFpdTyCbhX5MZqFr/alQXlGk0KNzWI69KXhrjPAXzkzGK9LVU+6S5AhoXwzBmX5qFTBZfpZp7xW4ZJGkVZRq3+cacq0lSDZi+cnlXA03bfCFLWqtU+i4Y5FGwMll9mf/BF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(66946007)(478600001)(64756008)(66556008)(316002)(66476007)(71200400001)(91956017)(186003)(110136005)(2906002)(76116006)(86362001)(66446008)(36756003)(26005)(2616005)(6506007)(15650500001)(5660300002)(53546011)(31696002)(8936002)(31686004)(83380400001)(6512007)(6486002)(8676002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8H6OsnVMuTNqu1H7EiauuZNR8rUPalaRWl28lUWLmezy3zKKnZYehcuYwxI3gmLyaP8Z2TdnKb4nhlwwdfWfRZ0qYztOqa1fa0g9Q8hH9o+ScK/mFgS+xXxWxphg4ItQKhTvwmelu0s1sDjELKH5lAPy86rIDk74dCFASrcCPzHGGBxvg2SPzPGB0/LLq/l0JyH82SrgVRkrTR5Xi6agGseETDxMSWXF81WoMrldrfQnueJD1038MLHJjv/xJEtNgnV2C6qufqQICFPHicHWkXBeAExGv7mLcsq0ouuxpa+aAUMmBkqPnARzvHsjAQHn0vUjrz4Y88QYg62EerKVu74wVXtHN4A8eljxN5QKzv6MJBjUvdFSP2PlLp0hBC7fJmnsKg8y341h37tSP+t4XPIfH+nT+6sPi6uH6c/DO1L9TxEt6uBmkB4vhkEhOC+Dy41iGmVUg0Yj0i1nVQpPlsWQpEP7qgR5XZUm5wihyIRk27ZO3Mf2FQP92jn1KT1wHF358iLOEUjukKbuczwAxj8mYE8CVF6I6NzemDeQj/CNgJtT4y9OYmG7GWvOtWjU+Z2yQHcJag8EkjBWyWk26cNPJapfU4gY8RrLsF3gDFK2V9PCb8srvU5Wu1fMWgUMCGcOm+U5g1uF/vMVJY7Eog==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FDB0FA3BB6D7E469E7AD6E858AE1B1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f83dd-4ba0-49ff-a493-08d865e3b2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:26:30.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNGW1yGLSNjF7XfSPYhQADsue3OQnwEd5Fuy8/dt4uY7FnDYOmXbVR/slC4atrTHyiHvwEmDFGSl6wUI/FBviFX6o2n8if6u4PMDup+l8HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiByZXN1bWUsIHRoZSBpbml0IHByb2NlZHVy
ZSB3aWxsIGJlIHJ1biB0aGF0IHdpbGwgcmUtZW5hYmxlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA5ZGU4MTFi
MzMxMjUuLjE3YjZmODMzZTkyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTMyMTcsNiAr
MzIxNywyMCBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX3NvZnRfcmVzZXQoc3RydWN0IHNwaV9ub3Ig
Km5vcikNCj4gICAgICAgICB1c2xlZXBfcmFuZ2UoU1BJX05PUl9TUlNUX1NMRUVQX01JTiwgU1BJ
X05PUl9TUlNUX1NMRUVQX01BWCk7DQo+ICB9DQo+IA0KPiArLyogbXRkIHN1c3BlbmQgaGFuZGxl
ciAqLw0KPiArc3RhdGljIGludCBzcGlfbm9yX3N1c3BlbmQoc3RydWN0IG10ZF9pbmZvICptdGQp
DQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHNwaV9ub3IgKm5vciA9IG10ZF90b19zcGlfbm9yKG10
ZCk7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAgIC8qIERpc2FibGUgb2N0YWwg
RFRSIG1vZGUgaWYgd2UgZW5hYmxlZCBpdC4gKi8NCj4gKyAgICAgICByZXQgPSBzcGlfbm9yX29j
dGFsX2R0cl9lbmFibGUobm9yLCBmYWxzZSk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIobm9yLT5kZXYsICJzdXNwZW5kKCkgZmFpbGVkXG4iKTsNCj4gKw0K
PiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIC8qIG10ZCByZXN1bWUgaGFuZGxl
ciAqLw0KPiAgc3RhdGljIHZvaWQgc3BpX25vcl9yZXN1bWUoc3RydWN0IG10ZF9pbmZvICptdGQp
DQo+ICB7DQo+IEBAIC0zNDIwLDYgKzM0MzQsNyBAQCBpbnQgc3BpX25vcl9zY2FuKHN0cnVjdCBz
cGlfbm9yICpub3IsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgICAgbXRkLT5zaXplID0gbm9y
LT5wYXJhbXMtPnNpemU7DQo+ICAgICAgICAgbXRkLT5fZXJhc2UgPSBzcGlfbm9yX2VyYXNlOw0K
PiAgICAgICAgIG10ZC0+X3JlYWQgPSBzcGlfbm9yX3JlYWQ7DQo+ICsgICAgICAgbXRkLT5fc3Vz
cGVuZCA9IHNwaV9ub3Jfc3VzcGVuZDsNCj4gICAgICAgICBtdGQtPl9yZXN1bWUgPSBzcGlfbm9y
X3Jlc3VtZTsNCj4gDQo+ICAgICAgICAgaWYgKG5vci0+cGFyYW1zLT5sb2NraW5nX29wcykgew0K
PiAtLQ0KPiAyLjI4LjANCj4gDQoNCg==
