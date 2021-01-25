Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4B30308E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbhAYXw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:52:29 -0500
Received: from alln-iport-4.cisco.com ([173.37.142.91]:60291 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbhAYVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1574; q=dns/txt; s=iport;
  t=1611608790; x=1612818390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Tr9JtP5Au4UgfOy33osGTHQ1H+y+S1L6zTdqLkwu9E=;
  b=AVMYo5c75kPcYVBvFybuKvY38/LWAPBgiMH5+a/ib1YuxaqjahDvTO0C
   SD2UqhANihIT5I/gZ3mYl/87v4HWtj/5xjFumxwwG616rFrO2iZDuUwXC
   LxJd+1/6gvSzTx9H44rrvoDOpsfqvGvXBG3z1PEusnCQ3v4w3JTu0l51h
   o=;
X-IPAS-Result: =?us-ascii?q?A0CBAABHLw9gkIUNJK1iHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YFSKSiBWC8vCod+A4t2ghcDj3CJJ4EuFIERA1QLAQEBDQEBLQIEAQGDS38Cg?=
 =?us-ascii?q?XgCJTYHDgIDAQEBAwIDAQEBAQUBAQECAQYEFAEBAQEBAYY4DIVzAQEBAwE6B?=
 =?us-ascii?q?gEBNwEECwIBCBgeEBQeJwQOgyuCVgMOIAGnQgKKJXSBNIMFAQEGhSMYghIJF?=
 =?us-ascii?q?IEkAYJ2im0bgUE/hCo+hCQahXmCSIEaETJ2gTEpAppXnVAKgnebYDEPomm1d?=
 =?us-ascii?q?AICAgIEBQIOAQEGgV0BMIFZcBWDJFAXAg2OIQwOCYECAQmCQopYdDcCBgoBA?=
 =?us-ascii?q?QMJfIoIAYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AOpe7/h1y4fFl/4ChsmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxWGu6d9jVvIW5Wd4PVB2KLasKHlDGoH55vJ8HUPa4dFWB?=
 =?us-ascii?q?JNj8IK1xchD8iIBQyeTrbqYiU2Ed4EWApj+He2YlhUHMf4dxvZpXjhpTIXEw?=
 =?us-ascii?q?/0YAxyIOm9E4XOjsOxgua1/ZCbYwhBiDenJ71oKxDjpgTKvc5Qioxneas=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,374,1602547200"; 
   d="scan'208";a="634438447"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 25 Jan 2021 21:04:22 +0000
Received: from XCH-ALN-003.cisco.com (xch-aln-003.cisco.com [173.36.7.13])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 10PL4LVT006546
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 25 Jan 2021 21:04:21 GMT
Received: from xfe-rcd-002.cisco.com (173.37.227.250) by XCH-ALN-003.cisco.com
 (173.36.7.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 15:04:21 -0600
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xfe-rcd-002.cisco.com
 (173.37.227.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Mon, 25 Jan 2021
 15:04:21 -0600
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 25 Jan 2021 15:04:20 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZDm+t5WpIN+jv1lqBxoVJntZXpLhs/XWDxzuMj6NBgNSG8fW4Co5ydmEniAzNRpm6UVomLzcxqJrD5sKZ4PoY8z3ROv2VUc8Vkkhs+x+2RLSe7eNXTEC7p62oMhhuH2yBZL82iPyCMtVyCu4IWFcHrmuBtsahjcTfKyqwAnsfI/Zt/5PhuyeHzLCNjYrrpCrdVjMA3zg4hAOj+1tFlw4BryJRG44K1pTiN2KLETFdcEZlEZHayLF4t/pJnMt7+utrnc3/RN9DIYvIs4tjnt82W5kk06L66sw6kRVgqxO32dDRUAjeJeA1nP9Ea51uUMek4jh42dLfYvXkR1Y5SeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tr9JtP5Au4UgfOy33osGTHQ1H+y+S1L6zTdqLkwu9E=;
 b=YSwRBNL3ETzvgaChGeijW3/F7GOAr5fKMbLNhgKwcufDbFqwi/TBU/FJhPHwAtWyDCAC6pGIm4WO3EmvVImH47No+m26JlfFyBwKZFW1okbO6Bb5f3uMlTmSyaEDmttl70zhgtYX4i2ZA4b2mbUEwhRsAlYcUGyU0bMmykcXKpNDuo9RKiCOEEC9G9GBttb3YZskJpfRv7myxiQwbJfji3pylSSanIX4UnAHhMNGl3wEdTmQxKC92a6RLHwKM/3pW7XIumscV3V9kryv2VMb6oRDfyhOp+Vay1ToCI09usd2Exy4Uj3giV1rosr/CK95NUW5S+IZ9U4wLQ77MSz/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tr9JtP5Au4UgfOy33osGTHQ1H+y+S1L6zTdqLkwu9E=;
 b=rRGcr5zKewUajceLinfuhWCfPue7+C/rflMd+FfL56v4RQsdoltnoe7wMHNy+4nus9im9WiNfYpCCX0s6v7dfQcslxVPwZDoYfe8eAqvATkNS13p2scUiRl3xBmlLYwJRC9OIarI2gmPXhtCl8upWhMgi73AEqVDTpLvLZ/rTls=
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21)
 by BYAPR11MB2662.namprd11.prod.outlook.com (2603:10b6:a02:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Mon, 25 Jan
 2021 21:04:19 +0000
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c]) by SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c%7]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 21:04:19 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Mark Brown <broonie@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Thread-Topic: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Thread-Index: AQHW812lwVKiYqawu0ux3HJtZz9QMg==
Date:   Mon, 25 Jan 2021 21:04:19 +0000
Message-ID: <20210125210419.GU3710@zorba>
References: <20210121231237.30664-1-danielwa@cisco.com>
 <185100f4-67f1-140b-ad01-9997891e68da@xilinx.com>
 <20210122203240.GS3710@zorba>
 <849cc330-8545-f1cd-1715-5244e399897e@xilinx.com>
In-Reply-To: <849cc330-8545-f1cd-1715-5244e399897e@xilinx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [128.107.241.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 882c313e-6630-4121-93c4-08d8c174c861
x-ms-traffictypediagnostic: BYAPR11MB2662:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26622A904E5E80DD90AE0D87DDBD9@BYAPR11MB2662.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pqvk8mjayK0QL0HCfMZ+6BKucKzDasSIK7bE1tTMeeF3Q6BENV7RcVz+Rd1l7P517JMZXpCjtRzQfZgo390Wn5/z/0WA3CbwK1W8T9QM6+bT+N2vsrjgpC1s0MYYl9jvaaM/HdIJA7bHebxyb3yTl6o6ZIQ2bLo9oI7eNLAaQAw8LzIDVZjzVSjQrYpEb5lv2XBNCR82A4T5kOu6T3vG7FNCapxnMnqwY2LXbktvyWXTVbFPAhgPNbqksu6T5Y5CMxql4YlTzpq0bwitjPh10bS8nFK1TURPSu44kfC8bXFDj4UDvNjdGgaC6dX4hxgZKCxnSaAN9MlCneyixyxyU+lBIsOCublz7Bt2fHrqgQ4RDD+77YQAxkT9nHS/gCa8mL+BoVIcHRSOTD4lNlJeSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(8676002)(54906003)(71200400001)(6916009)(83380400001)(316002)(6506007)(1076003)(66446008)(33656002)(86362001)(6486002)(6512007)(186003)(4326008)(9686003)(66556008)(64756008)(66946007)(76116006)(26005)(8936002)(2906002)(5660300002)(33716001)(478600001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?veAtB+RSVxnPs7ekPg58YIqDU6c0Mzs0i+rjoswb9d1jWvh/IvxgGgddAHlD?=
 =?us-ascii?Q?247JvCjJDMoLZaQK9qEKeukqJ8qcfKbG/uLzeqgR5SQicabbkYHNjHdJqzYf?=
 =?us-ascii?Q?WZsnJ79VRqspPdY0J42EjQh94Oaaq44Ig0Ouq0a+1Kv0s/hwXUPRtiveVAHD?=
 =?us-ascii?Q?yITQ8JkbFc5MQWCq8U6r1OWDaxBAHweiBdo06wVpTnAFxGMGIOzTKxgK/lEN?=
 =?us-ascii?Q?TPNGsCYEOwxY3ap5YLu1eMZJFfVRCZAYGLlaP9le2HmyaNIlncCVv7AtcqU9?=
 =?us-ascii?Q?VRUhQ2Ysf2WlkU0Z5vRk05Te706CtpnAf7zXgyCo0EWK/DNyl84/ZVAgl8zA?=
 =?us-ascii?Q?y7+nrRc+Mkup1Za2+5tBZwdQefFNRWGI77uNDUbptcZi6yxYM2Q5Kbw50ZvC?=
 =?us-ascii?Q?N3ZKgLOmeuYmXoCJCm3QOFcO8WpwjsZQj8m6CWkpHkKmkSyTrmMYjwwnD/CL?=
 =?us-ascii?Q?YdNxT3+mm8eKW3mX46C8rBM4j9cvTt6II2wyk3E6jMYSW1d1loKyEQj90/Ch?=
 =?us-ascii?Q?vnfKA+SZsbHmcNqlA3qG+gb0fqPJVnnfbn4tWGRWvRsQurD4/TUnJA0fV5G3?=
 =?us-ascii?Q?sYtBE+ii8s/5IroRbI66esqQOsEOXB8axMUrKF3orzL68gwDSWLtPyuiEufo?=
 =?us-ascii?Q?JSVz8lAjIlYVymgovS+pkWmVk63Vh1Wrw5i4DoD7nKjZGqXKUBwhqxZXur7B?=
 =?us-ascii?Q?n5KWHgknMs+Mk1BVjiASm04tN5SLAgjHY1XoDrhUhnnXN76//CMqiqi5PoyX?=
 =?us-ascii?Q?yaYVZ5DQL03ogL/d1+mAOF9/TetPMzhmottEC6bdqqJX2z4Mfw3nY+cEQu6j?=
 =?us-ascii?Q?n7DWFoMb7zT9ylm3nR6Lrs0DfxYH34bKmb13IiwA6eCTbe75/C776uTye3Qo?=
 =?us-ascii?Q?CJp6L6tBuWX9lJ7ti9+JAt/GtLEzmNaC5mrWjxL1fq2tluD/UT8mKkswLz+c?=
 =?us-ascii?Q?gpxVl+0nerBVFXEU2YtNVuONj9s2bFFQdVpjyKbJGQ0fQtVZ0I8iNN0FNg7i?=
 =?us-ascii?Q?g6q0vUaPuGQDlWDhYGDbkh7NO5XdsD6rmYBZHoeHK56MhtaNGromwLfM9sMv?=
 =?us-ascii?Q?M0IqtaOiABsqB5fRsQiAICBoPw4mQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <625E3E2C9A602A4DBE26BB580B710191@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882c313e-6630-4121-93c4-08d8c174c861
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 21:04:19.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9A/N3+FGgNo1n9muJRnqLMYy3Xr073GzNNtxOkSeoesjUzADzot8qVNuj2InArux9EiZbydgRFG2UcuANf3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2662
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.13, xch-aln-003.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:52:01AM +0100, Michal Simek wrote:
> >=20
> >>
> >> Long time ago we said that we are not going to push any PL related
> >> configurations. It means all below can't be merged.
> >> And there are also coding style issues.
> >=20
> > You'll need to explain this more. It's likely this was added at the sug=
gestion of
> > Xilinx. If it can't be upstreamed what should we replace it with ?
>=20
> No idea who gave you this suggestion from Xilinx.
=20
Just an FYI , I didn't write this dts or work on it's original development =
so I
can't name names.

> I had similar thread with Michael Walle about supporting Ebang board.
> PL depends on your custom design and can change quite quickly that's
> there is no good/bad configuration. That's why all of them can be valid
> and kernel is not the right location to store thousands of
> configurations (likely in overlay form). That's why only fixed
> configurations for PS are added to kernel.
> And I prefer if there is any good reason behind why these platforms
> should be added.

I'm not sure what your talking about above .. Are you suggesting the change=
s in
my DTS will change quickly ? They have been the same for years , we don't p=
lan
to change them. This DTS is not a prototype it's a released Cisco product.

If I did delete this "PL configuration" where would you expect it to re-app=
ear ?
Typically things which aren't upstreamable are transformed into something e=
lse,
it's rare that something is just removed and has no transformation.

Daniel=
