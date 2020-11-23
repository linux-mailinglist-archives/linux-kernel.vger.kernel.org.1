Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7377A2C035C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgKWKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:32:49 -0500
Received: from mail-eopbgr760053.outbound.protection.outlook.com ([40.107.76.53]:15842
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbgKWKcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:32:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz8G1RvioP2kw1MDCl9hwjLCfjK20fwHL5FdL8554oKz4xEcxZxVu3ShKWaWLUaVslnqB/21GDoaH/q0yCWCfJHwZNf9POJxUL4NyGQnan1r911zslm1jEuwzIycMxZHchJpQ7szuVRx2ean8fUY+9WIUtCujpNObG+YhuBCw2kKkoYariz/wwkOknD4z8Vw77OmJxfhFJUvu1PbyDyO4pNvT45kzFblzPasVbkjhn44iRC8GhqkJYJ3pXD9dl74lfi5cN9J3sWm6DQzlQpC7P7LWwLPuKOy0+0dQjQsWae9YSziYlc7+tENcdYVRHbs85yZtPBRj5NqpNdJohblgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v3RabOWkB62RDyacqMafWyOZB5vX0udc7dbs95u1DY=;
 b=ezx8u22/WtHwdKozsNXuejjtd8DVxmLrmXVVmUV4GNYBKOevAWtR/vAJuCRxS2pzXuV2TFoxBtSLDwM0qG5sh3Tjj2YuDv42ImuwTSbUyrINL1aKK1luGgHU5bj05ash3tHkqDVEptzO9RXIPQrQViVMr6rm0xptCRGvJMmeVySSNdJizH5Dsbi4KropvNTZioq5Fd232Wy8XFTeVwVBj2kWN7P/NyI++o19GOoglaGh49g2Ad4IMFRKjmAJgVNJq9v64kj2vWmCl7ElX1X14n+zQ/BFrngVzk07AgWPG0YdT9z0pzd/12I+w5cb2obbh7i53xm9TbegAZRapuCYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v3RabOWkB62RDyacqMafWyOZB5vX0udc7dbs95u1DY=;
 b=nPIHEHNB4IG7K4TNUgcRABjrlwuTBONKfZ6GxJja4nVXij6K4dZpDiVZnaCaaNf3b+5NYxcoSq2Lhiat1pcNinF84WcVssy+B74M7CutxlcGz9C7qWeroHnEXRLNGp+UiRPDIn5ymcTuxWfZ3kWs099OitnvGj9ooz3ziRI02oo=
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BY5PR13MB3394.namprd13.prod.outlook.com (2603:10b6:a03:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.18; Mon, 23 Nov
 2020 10:32:44 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae%7]) with mapi id 15.20.3611.020; Mon, 23 Nov 2020
 10:32:44 +0000
From:   Yash Shah <yash.shah@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        Sagar Kadam <sagar.kadam@openfive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "bp@suse.de" <bp@suse.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@openfive.com>
Subject: RE: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Thread-Topic: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Thread-Index: AQHWuNPXeVMTcgdvxUGkk0ItZFlleKnSmU6AgAL3WiA=
Date:   Mon, 23 Nov 2020 10:32:43 +0000
Message-ID: <BY5PR13MB445328314FB3521DE257C57782FC0@BY5PR13MB4453.namprd13.prod.outlook.com>
References: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
 <20201121125443.GA2076465@robh.at.kernel.org>
In-Reply-To: <20201121125443.GA2076465@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [103.109.13.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a068c750-338b-4660-95ed-08d88f9b1ce9
x-ms-traffictypediagnostic: BY5PR13MB3394:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR13MB33940F47281CCB671301EB4882FC0@BY5PR13MB3394.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSdNfK0z+PbgBPRGtF1dPyZWJKjU2ZwrD3pmiQhOXQUzDcm0adDGKmF6QId8jiyVusfr9AbX3iL5I9Z+bG0bWcYzUGRbTi4N+Zok/7gVo7MmsF6n+x6MmI8//EVuCdsQzQHRazFGkjkHeYjFn+cVnUeDyhyRi258eu+7La9ZcG34QaapVAngXsY2odV9X5OaCepAQ8zDBsnCGF5G+PHLColVjSKRM4YQ/9cbwdIeSDpCedzsPASrVes6kSvAokH+AM/TjWGjDZk41diHTy7nOdf/v43l+wVQqLn/e4Xh8J+uuJ4oe5CiSot98lTzqU63mG1boI/8L2KbPPD9VSC6UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(6916009)(86362001)(76116006)(15650500001)(83380400001)(2906002)(66946007)(8676002)(316002)(54906003)(186003)(53546011)(6506007)(44832011)(7416002)(71200400001)(33656002)(7696005)(5660300002)(55016002)(26005)(4326008)(52536014)(478600001)(107886003)(9686003)(64756008)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mHrDVxY/NtmgyGRYMQDn3RFNBFo27SBgHB576Bv8uS9bI5ERYc1tlKz6KfEl9edBc5V6wulCR1E5NC2yLl6I8Czg/QEShk33pybWN6UGYN47nCSqnDrKuYDFyRo+AoeVIOM7xEAFuuao2l4gT155gTwYcLiGVjK0iI2u33LV8ViC2tpJCC0ErYUcYm2F4tHZFIEAGcC/qyv/oh4rnDMD3liHL9lKkEk8htP+chYaCrf7NahtWp6LGHQVlBmJIOfk8nts4SnVwqbyAnoiEbVtJlgRE6tpVWgTFEjMiGVTqIZ19MP8OJc8LRNCLkZV9KlGbvh2+lJ5RmNlZmEMSYr3ukQ+9rPGcetsXFShKzA20j3LVUObGY2i17yb+kDjZTv/cPIrD7lQ+PA/Oz9zN4145e01wBS9TJbDeOcFanEbFyha28XXb9/ea6zmeOVPWLYcnYHLZXnUY4OEltpMJ0eUuY14rbqn+Nbh29mhdpGHAwEibswgkGwZ4WIYQYS10iQzyRZBodFDqmHtnnakN5km9TGHvxCPPJ5F/YyjHQ2KLtrMhna41EHzkW0zjddbl4u63zMqCO0oo4494TK7Nx9Eo2WyqUu8gjE6Kya7qx3huK2TWUq+Da9pUZTiTjzg7jxMYwuVApJ5qv+pcGUo2i/s9YL1zHGhVyb2i/o0Itj0HTqtg4xOJfUJaRBlYqHPmSX9PC6fNKjcLBbDnXUoINKuahlP9+l6kL5VmC/VpXHZCUPK5Iprh/Qj0GJEBrLpy/gfWnpeseBztKG/4kzgsd0r8JwXsrP+X2f3cQI7BxuFycen3d6tHY7l+Od9cOWzqmE/U1MkRxUCkG/H4iqhbvr721RMOLCMvAXB9QC6z/o+MmbkkDF20Mq+g7smAsOyUSjcJZ9PMVYsp9UCP7UxIapsmw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a068c750-338b-4660-95ed-08d88f9b1ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 10:32:43.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJnFEo+GU8ieWGz6zRm4L6Tu4cjHQsrxLrIg1jE16qn4mxqapzglP/HMN8acpUmamk5N32sv2QPAnt9mkzjWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3394
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 21 November 2020 18:25
> To: Yash Shah <yash.shah@openfive.com>
> Cc: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>;
> palmer@dabbelt.com; aou@eecs.berkeley.edu;
> Jonathan.Cameron@huawei.com; wsa@kernel.org; sam@ravnborg.org;
> Sagar Kadam <sagar.kadam@openfive.com>; anup@brainfault.org;
> bp@suse.de; devicetree@vger.kernel.org; linux-riscv@lists.infradead.org;
> linux-kernel@vger.kernel.org; Sachin Ghadi <sachin.ghadi@openfive.com>
> Subject: Re: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
> support for SiFive FU740
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Thu, Nov 12, 2020 at 02:41:13PM +0530, Yash Shah wrote:
> > The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> > compared to 3 in FU540. Update the DT documentation accordingly with
> > "compatible" and "interrupt" property changes.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 33
> > +++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > index efc0198..4873d5c 100644
> > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

<...>

> > @@ -51,12 +54,6 @@ properties:
> >
> >    cache-unified: true
> >
> > -  interrupts:
> > -    description: |
> > -      Must contain entries for DirError, DataError and DataFail signal=
s.
> > -    minItems: 3
> > -    maxItems: 3
>=20
> Keep this here and just change maxItems to 4. Really, what each interrupt=
 is
> should be listed out as an 'items' entry.
>=20

Sure will send a v2 with the above modifications.

<...>

>=20
> > +
> > +else:
> > +  properties:
> > +    interrupts:
> > +      description: |
> > +        Must contain entries for DirError, DirFail, DataError, DataFai=
l signals.
>=20
> DirFail should be last so you keep the same indices.

Actually, the interrupts have been numbered like that in FU740 SoCs and the=
 driver expects the interrupts to be in this order.
I will keep the same order for v2 as well. Let me know if you still disagre=
e.

Thanks for your review.

- Yash


