Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44627B319
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1RZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:25:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58690 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1RZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601313939; x=1632849939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5iomrdu/SHS8JnOrFTM7ITiD6KVLfl0QY1on4lhYwYg=;
  b=oK/f+9k7xTM9eDjpYEupLDKjXZSl9PP213h+/55dRZJoJO05gTrEEPuE
   OpwuAnE+3I4gZ9UQdcVsqz4OHpGMD6oAKCW+3P1mtP7L9rlT5i4KHityQ
   HdKU+Pq7HIuJGbMck5GKZkUT7E0ssv5WKoTJCcyXEaqStCAv5nLjsK/rj
   R1NkfW58AdvlkV2RnEDzd/Bv5MdaPmyIvkq+wpHXx7T3zZ/m9yfN+2zup
   uJiCoR2tLmYQviOXFIr4A1HaAdMsrXTNFZYj4us4IUDF3RxFq0Sur16Ij
   O6Yp/OJFzPL2wv7Z17y1sNTEwHdnw1c4ZcDpaQRpSxVcLA71Gtt6W/nfO
   w==;
IronPort-SDR: 5CjHKrJ24A6Dynzpi+BXTUV9hBhRy+39NLD/3hdWW3wFEOoQZT21TnXb4FfJu0gSM39QdRzYmc
 eVQgotBuRC69J70u8YK4gaN2cYrmHN3XFtRXLMvnwJOXMK9ONwM8tZwmc/mTDkBtbZY4rPgB0M
 i3V4qxs9watCx05z02/Za/nyiyZF6wQiya81dxoK57UTEqsNthfTmfCjCt+/onRiwihZz/rV4Z
 jcLlQIPPfAxPPmO3l6d+cxC1OOv77FjPuzDJOCmssntavCMVquDGsmWDU76mulDMQ3bt42SaHV
 uw0=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; 
   d="scan'208";a="152829539"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 01:25:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfUuqBbD7QD8Al+3GPDpqgHgaGMCK8ywsiqZ8uuqdHfK+EIN0+u8XK7eJj9gD6ZZHNHhzCXK0iWTMYG8MakMmt6GD0S6hGd5SlQs3ePD3nm8mwdwccQuGlo2OmlIzOlRdqMYsPaoPzUUmyQKZ7cIun0Lap1L1q8S1+hcREnw6cDcXqcVjpOSwa7tZIygu6JRfE+859pTper4tP4ghMR+RFI6x16aRh0jillvEiXLiFKGO2Yidwd+PUDWZZpABruI0dQwOQ9df3C555fVEhcVFTFp1xERahTyvRBl83Ur7CwWd2ufAJAeqejVh+5YaSJZTD8U80fyccEDa1cp82mPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iomrdu/SHS8JnOrFTM7ITiD6KVLfl0QY1on4lhYwYg=;
 b=aNpXVGBWU2mfcqp0juFUluIpaYs9YqneK98ErIM7lF9rnl2NO0ukEDvABWtjUwMam6hWVwCuhft9Kc3K7/aUW8fL9nFqXR3j+qQ0JjIqfh20uLeBMDf5+sWyPSuLlaYOeKX9tC/8zbvmOgVSCb2AZ6cNh8VmZZslvxnKdHt7BdorF+iUbh+Gt3zz6T2rAzmXKKzEV1ac6ldXRmeOuzIpXvjMp1h1fNOtSbdtzg0A/ZBkFR97wrkOKxh0BCjO52mV0pDPS2dpSQUIhCdAhsHYXc4cASjCpErPBU5SYUlUYu9+hgl10J01DHwvK1F1DTSaYYC1NOXhSFuAIlAccZfhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iomrdu/SHS8JnOrFTM7ITiD6KVLfl0QY1on4lhYwYg=;
 b=EzF1QBAFjlbO0hfNxAX/gobROeD92EVyDigSRDzAU36r+PcsKuzBTOnKpG5rD9Ex0vlPbqqSWqt7vMMcW3HihVOymR8MleU1GJR02mJrzgSRS28l5SkdeUYSfWPLiYWoiJq/ZYlyMYgsAHQHYm/tykrRWDlmEP5+M84qUdpe+JI=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BYAPR04MB4088.namprd04.prod.outlook.com (2603:10b6:a02:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 17:25:36 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::f122:ad41:aebe:6785]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::f122:ad41:aebe:6785%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 17:25:36 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
Thread-Topic: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
Thread-Index: AQHWlaoBURfAeTX8ZECfjN5JwK97B6l+TWuA
Date:   Mon, 28 Sep 2020 17:25:36 +0000
Message-ID: <67278555f143564677878cc849155393a93c018a.camel@wdc.com>
References: <bug-209317-8243@https.bugzilla.kernel.org/>
         <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
         <20200928111341.7eaa98a8@oasis.local.home>
In-Reply-To: <20200928111341.7eaa98a8@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [98.248.240.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10b10069-1729-4490-d83c-08d863d38354
x-ms-traffictypediagnostic: BYAPR04MB4088:
x-microsoft-antispam-prvs: <BYAPR04MB4088A75D63D4A084FCFB8BF3FA350@BYAPR04MB4088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWD4lxiUZf0AqK08ZnwX180vZjmb5S1eEYWDiAWTewjRfYY21BDs+Gc9G6TZy+mq8+xL5yp3/SiQkFx4M9N4pGhLaFwnVpw5Ee8+O3gEqjpY8riyF/FsR1Mg5UKyOk6dytLlHEZlqE6p2yY/wduXBKIaYkyR3ZdfYBbK707sv2QVHBqTfnYhb7ZWpzNqBzn8MOplTrkh5XL8XA+0uBQ2gOl4MeIDSt37T+sDKpxOd3KSX2K6wcVw1/8KYzrDjQkhLa9Szu41G2PrGMIKpC0HFFQSOYtU7caYaDOKGJ8t+a46ieWetiyaAAhxDOT+giC9cw2US0A0p05arkEj3bD0bB5JlzJyM0lARot0FqWN22MiHsiE5SShaGm9TPIGebqGqrZW405EVBBXrj0dWIspcL/8kG+onG3si+LrDLSayHlXJrjrSNR8riC1lqWl6b7Qp+vrh/f7hVg/3VC7UJbxJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6486002)(478600001)(2906002)(8936002)(6506007)(6916009)(66946007)(36756003)(76116006)(8676002)(66476007)(86362001)(66556008)(66446008)(64756008)(83380400001)(966005)(186003)(5660300002)(2616005)(26005)(4326008)(54906003)(6512007)(4744005)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7jfuKH1emkWsM84tdAyp/WYoc4WJFqKXpiMDm/9BnQXvL0zc3HCfWIA0XUluk7WJuqWghAZHKwloSzXGvn421/WzWYtiiuZA6hYRBhnXGtuWvXUJnrOZQaURZDW8bUbBBtRnHGUE+9xE8hI7q+ZyonzxiWEm9Kvp32jWKTrGQYCQzcNsHt0qpBNE+wvWESLc7KPhJ6NUaQrbcImX1q1y3EzCyVXPIYQIxvvp7yyHUYw8f4/mz+rKOHUq23AgUUBe2PIYXN+R3KdM6VVJHwy8dOb39CV5DfejqRzGGSDDJnqPKNy4OTsyGZkW3xyG5u2JFF117BkOoCRJp5iUrWEvj9OYr4/a8tzY8hQN15dqz3VDVP+rQRl1Dged2KLivUFGAYJRkdjCghhJ/hkqQm37uKXx1H1DNnSF+zc9Wg+t4d9ZguDecTHlki2xaAJ7K4NtkJsh4+1QJ3JO3jU+i91ElxrXfPbTkrwWhQbCbMXMYCRPvp4dCTSgCwdCRR7ZOkiJHmR9jZIJ3l90UF3TfffInm9nfNkOwHuzJVsyyC+2+uXVG1zl8rv7ezfHDk4Gkh2NJk4Od7yEcMkBrpi9WZS5xSQczMq9r6/mYtkB8wJTiWlUw/ohWXEwog4ZIiEFISlnTAgPbZLQDmhWKB71nsBxzg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <19764D9744CBCF499EF422C1354464FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b10069-1729-4490-d83c-08d863d38354
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 17:25:36.4375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swvzNbPwmXcVCZI1bZYsRJ6EgCR3Ls+v1upa+FCNeDnr+ZypucLeBE7xa4Z8Bd9FJdSDiwZjlQ5i9EjNyVI1wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTI4IGF0IDExOjEzIC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gU2F0LCAyNiBTZXAgMjAyMCAyMjowMjozNSArMDAwMA0KPiBidWd6aWxsYS1kYWVtb25A
YnVnemlsbGEua2VybmVsLm9yZyB3cm90ZToNCj4gDQo+ID4gaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDkzMTcNCj4gPiANCj4gPiAtLS0gQ29tbWVudCAjNCBm
cm9tIENvbGluIElhbiBLaW5nIChjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20pIC0tLQ0KPiA+IElz
c3VlIHN0aWxsIGluIDUuOS1yYzYNCj4gPiANCj4gDQo+IEF0aXNoLA0KPiANCj4gQXMgdGhlIGlz
c3VlcyBiaXNlY3RzIGRvd24gdG8geW91ciBjb21taXQsIGNhcmUgdG8gdGFrZSBhIGxvb2sgYXQN
Cj4gdGhpcy4NCj4gKEFuZCB0YWtlIG93bmVyc2hpcCBvZiB0aGlzIGJ1ZykNCj4gDQoNClllcy4g
SSBhbSBhbHJlYWR5IGxvb2tpbmcgaW50byB0aGlzLiBDb2xpbiBpbmZvcm1lZCBtZSBhYm91dCB0
aGUgYnVnDQpvdmVyIHRoZSB3ZWVrZW5kLg0KDQpJIGNvdWxkbid0IGNoYW5nZSB0aGUgb3duZXJz
aGlwIGFzIEkgYW0gbm90IHBhcnQgb2YgdGhlIGVkaXRidWdzIGdyb3VwLg0KSSBoYXZlIHNlbnQg
YW4gZW1haWwgdG8gaGVscGRlc2tAa2VybmVsLm9yZyBmb3IgYWNjZXNzLg0KDQo+IC0tIFN0ZXZl
DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
