Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337B429E124
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgJ2Bxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:53:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:32994 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgJ1V5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603922244; x=1635458244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FzO3LfTGC0uIgiJSpK9cPhl0EM1NmOVohVWY9Y/ivHc=;
  b=RnDR8eBENKDynQMZv7h3hD2IDmNC4BwfAdOqMIjbmk1ELsihgnN4Z69U
   rfZVPN/Qk9hV/xBfFCtDcg+dqcU6/dKWvbiqfGTtSSZ8irhlL1e3TSqOG
   HSAwn0hTNsu0Po6KNyicyfh565povbtWXGJYBMx3jkjv1N8aSlkIK3cwY
   67XNpsBc7EQ9rlL6RSXbRpVeuePRlb2e4oySJd6LdyWdULdPa+IICw42q
   X3AW8tzRRapZjsFG2yvKlbhDtPzcSxp9BO0yDWP1mDpFN4mAYW3Vgq7Gn
   FfEPnwEAFqNrIf9/erY5cndB+WeDp+UE2b/l4HZo1JJIqtbhncRif2S4l
   Q==;
IronPort-SDR: 9AlDSvw2vTZJaL3WAXVFiTYuosjnsmYlVQ6M0GaTjeRcELiFkKCAAB38LFoKZfPMAtS8Hrg9mO
 sBQPM9GbVBolsZDEkcDQZDgiBpVa+sbr542WWAiKJlTr0q/AWEF+lFk2tzYvk64LyZ+vXSM1eR
 HF9IgJBj/I3MMw3/fteeDDfIEhzwrCbmswnrA369iEAi7+UFgp+PZDLYmuhuCo25H052R3NvOI
 OL7kybAHry1HfdNylXBuZXhfilJy2IohIT1Qhq0LJwaD20DGmBaHqrVu9p3w7q9rbJkc8JpUDo
 ik0=
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; 
   d="scan'208";a="31486630"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2020 00:53:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 00:53:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 28 Oct 2020 00:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avuYPMEL/57ICXmBrN5Z4o8XNLZovuxZU1GnaFDoFsacn4YYr6siTtv4LRpKsC6XG+epRtY78dejkyvZI39fm//0blT/v6PyAcuSTPvCxfyvXcVbOdtTBMpAc+BrW71zO3WzhUkw8uGTkb+h+yY5E1tNnsT5te7ZFVbNyS6eCDPBcAiPRCz3dptIkS9co9m2Gf3YPoA7LsHnFFOOT4HOsiCSdw8/a0+WMIz668Jvy/1skFkx9JHyEOF4NV1md7UBNDi0jQWWXOPNTH7CdXGbHuBGVSLgwltrVHd5v7lJzMFwK4wZZDsq7Y4a07oZwAXN4HI/VGRIMgViNE8qQJS0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzO3LfTGC0uIgiJSpK9cPhl0EM1NmOVohVWY9Y/ivHc=;
 b=bQo1fH9bZbxtXIv/308vGrRwCcTVVqHI//GRYUN+E14s2UY+RRtQIBSYVkDbNisyEM9oGTHFn6/Y2Rh7izmm0h/RKnlUkuvldavUTcwCZtYxdq710U1mDQGFwoZ0bV//4CdSCxyjEfGAPbX56+2aUvGiBB3ZZcL/7hUdjtYVcI/S0NYg3A9St9Ia2zAj5EGP1sfCWARL+w2hgM9a4HpfRAQIK1LJ+3B1THg4SeuDf6VRrku0lpxwRnOghvCECXu6/cf5n8otMUducJREnfZci/AWFxs0Q1HQmtVaT0nikfL4cuA0GR6uP5gFqTKlea1qTF8qQAw7QrILGo0Zv/koBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzO3LfTGC0uIgiJSpK9cPhl0EM1NmOVohVWY9Y/ivHc=;
 b=NpuNzjWlk5IlxD9ECeoMMEVqeBbIIMOvPc18hWr/Hzt3lgGT+PQ7LkrrxvFeQ7ltHFE1KlWycMc+Qo81j2S2mlm1da8F4rj6TGGu160qxGpMMIUWXZTVtRGs0PRNX8ez4cmmkEJF6ESJuH9H2wC/XbtN9UfnOEFC10x+A2g67yM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2736.namprd11.prod.outlook.com (2603:10b6:805:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 28 Oct
 2020 07:53:40 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 07:53:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWrP9znYtyl4SgskmwPX4NHXsKvg==
Date:   Wed, 28 Oct 2020 07:53:40 +0000
Message-ID: <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
In-Reply-To: <20201005153138.6437-1-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62e9f024-c0ae-4e31-9e8b-08d87b1695e2
x-ms-traffictypediagnostic: SN6PR11MB2736:
x-microsoft-antispam-prvs: <SN6PR11MB2736ACA7D36F1CF92D809A5EF0170@SN6PR11MB2736.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04FkmKCWwSUwVRkHcFXg75R9oYab9MMxlil0iHaEeSCt/RIfuJ/ebUHXfXat3VocBVXeNWeSmXGidL1Hqq+CgkYzkVPisHxyWmvPo7OOJ373Egw/Lap3KkwIF/3KqfxCKKeUDkQ3Cw/HuRq1M7ypFrcNqGQ7oh4E+CafZzfKaaCbORkR8SEKdNE3GrHhwBBWfRysPUw3WwJUS/YJuqk/OtpSN1GNE+umo8tkxDFbcJmTZe5uX5plZqQHPLjgqWiuXj33LZjTRlfgW6eCeTJDqSjmfR1taU2N7LdmG6tufoJAZZ+PU7kZd+Sry2Wwfndlwp881Dbxje4MZyAHx4/ZMvf8ZUot1bBNdoFo+nuXBgQETcs0/UOvLRlc2DLcoYmMnLe89iygi9COVGd+6Clmmgv4/fNSdwpDHonwULBpmUBllwsfCt3OkyoHhdUMnp7RemQ5NOx8u9fEo+CzzYEEQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39860400002)(366004)(8676002)(2616005)(76116006)(8936002)(66946007)(4326008)(6506007)(53546011)(26005)(71200400001)(66476007)(66556008)(64756008)(6486002)(66446008)(31686004)(31696002)(4744005)(6512007)(186003)(86362001)(5660300002)(36756003)(110136005)(54906003)(316002)(2906002)(478600001)(966005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4WfRXQDG57Io+YduLVZYbDTII7vwA17DskX4kNkrjYgp0yatmJfBfnHSrONGkjbOv7hWHYt2ujjya/uuVeE16OW8YTE8hBDSYUC1PdgpDbFzbY1MByFq2HiVtN93Z7hgBuJq3m8c5JFo1ZPOvsudFartekJTzoqcb5BpusEehsTOytWR0jxVJMlpw7i245rs7+QE36JhPM5Fzb4P4mJMc2bO0sYiqh6RBI1MWeJfE4JVU/0pXTU7A41256quq5ILUuwAPM3AaCy1GILaQzVTijhfUyOxil2wZYL5XPmv/YkEkctmVlNzBlEQoYcNeWHp/RNJTqxqxQMmG24n0HQQffZ7IHHxBT7bQF4fxLLD9uY9FoA1VJzYRh0ZEIjUiZkfnQKt7v8siw4QzsERap1ETEcXoTjB6lk8tc16HHihwGUH3p3zh81ryWlhe0/sy3naUVhRaDE+7mghdgcUmNCt9UE07BkN1TicQA2jHrH3QqyXGrKLutHGabiPEwU1kdBC9y0jviW0ncyneP3WG+Cm59X+6BvXcATl0EXiPmCdG0cz6/d2bg1Cm6XyxgtZTW9ao+ecjTRgAV2VB3c0UwfDX4kHpeKTihz18VVayd/ymeCRm05ZgFRDs7gNbKk9KhfRhMjD4kP4r39uqSxLmTU2rg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DBBE59EBC3ED743A274D976A5FCE311@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e9f024-c0ae-4e31-9e8b-08d87b1695e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:53:40.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm4IZjSzygOhlFdXiRCFdST1ElbGmhWD0RO+wxOfwvyoSToKdBgMqU9WXKwtnXyWo2YEtoodsyrEnjY5nELxUXVXeCjLan/WeiZqJc80Z3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2736
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFByYXR5dXNoLA0KDQpPbiAxMC81LzIwIDY6MzEgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3Rl
Og0KPiBUZXN0ZWQgb24gTWljcm9uIE1UMzVYIGFuZCBTMjhIUyBmbGFzaGVzIGZvciBPY3RhbCBE
VFIuIA0KDQpEbyB0aGVzZSBmbGFzaGVzIGRlZmluZSB0aGUgIkNvbW1hbmQgU2VxdWVuY2VzIHRv
IENoYW5nZSB0bw0KT2N0YWwgRERSICg4RC04RC04RCkgbW9kZSIgdGFibGU/IENhbid0IHdlIHVz
ZSB0aGF0IHRhYmxlDQppbnN0ZWFkIG9mIGRlZmluaW5nIG91ciBvd24gb2N0YWwgZHRyIGVuYWJs
ZSBmdW5jdGlvbnM/DQoNCkkgc2VlIHRoYXQgTWFzb24gdXNlZCB0aGlzIHRhYmxlIGZvciBhIG1h
Y3Jvbml4IGZsYXNoOg0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4
LW10ZC9wYXRjaC8xNTkwNzM3Nzc1LTQ3OTgtNC1naXQtc2VuZC1lbWFpbC1tYXNvbmNjeWFuZ0Bt
eGljLmNvbS50dy8NCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1t
dGQvcGF0Y2gvMTU5MDczNzc3NS00Nzk4LTgtZ2l0LXNlbmQtZW1haWwtbWFzb25jY3lhbmdAbXhp
Yy5jb20udHcvDQoNCkNoZWVycywNCnRhDQo=
