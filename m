Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143192D2466
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLHHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:34:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38608 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgLHHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:34:51 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 33173C0432;
        Tue,  8 Dec 2020 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1607412830; bh=AwgDUeeC57gKeN03bzsRHL31DMBypP6Gp6h0LWy4KTU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Tls9pr4F8xP+bKsRLufR7frTriMkeYiX0GSlYxmpscKuV1Ody3DSIF2nFx6X/K5pT
         sdEFPagwJ1AsXeDYH3CE82+f0l6sJuyl10sDE4K2zWdmGHKPkeCWvy4JIr+QTd2get
         w/L61vkUxNrZgwCkijLOpfnaWrzip+s486fLBbk1I0n0LkjA+3U9C+2GfroVVWlABJ
         e+WkR3wo3MNxow8yR6YwWEn/xpbkQWXIjtBHduMwMx07CP505e3HqbF8Wso4esz8lD
         SeKUMYzqQ4FfO0z/p8MAuz0QQjxRVKIA2xAJOndD1wsmRQFhgpnQnoXDWYV2+hpqJj
         wy8T27mjDC9oQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A4E1AA007F;
        Tue,  8 Dec 2020 07:33:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5830E400D5;
        Tue,  8 Dec 2020 07:33:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="is2Jn3t2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQPKevTJcsdKV5lModT/i1QfT4GpzoRPNlyn3EOjwTRswg0aIZ7/3o7ttoLoxIh8j4zCdLRFvnQdZmh5CQobdplaLvUP82o4OOs/iLwPfuJZJYd+A1W6wxlSaJ7LAtgb5q/0Nbx1aPEpLyY4PM8e+UXJjAfzPO4X6J+Byt1odwo3OYe4aYKoFz5XI8Y9QhZKai2ZCzp9zru3sgWqfC+N+rdA/gDrHqf1lfBNYz7MbrSW5YFcRK3YP+DeY6jyVPgDhcYc4W3uOFQSoqnOuNH7rkdpjLsIDxgewAZaSxdFzvDzgMkOM4Q0Rhj21SVW1eSAEj3ZMrozcsf+VJqR6eJh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwgDUeeC57gKeN03bzsRHL31DMBypP6Gp6h0LWy4KTU=;
 b=VQuIq4HtR3OtAwzGtT1b5XdRt95W9TamiS2ijeCE59j7nvLB7Z2gdm2sV5nWreTZsFsR8hdhfLj4Ta51jT4mfrrNT8EYlpG0ur00ydQjC1XJv6N+3f9i1kj09EXhxUTlnp/KjLPAYWdKlmOVgVhJMwomnFlsqGNE5daM8pKXodR5VcNoNx8lmeKWtub6HvltGxOOV43GdB999D9esVFi2XnN2SETqDT52Nt4LHfcLvvVstFX9Bn7nhjdlymsFjr9us8ty43Suc7oj9wW0PWYktUlaCNqTb4ivPz4L9Yw0S0UzM9fyoyMHNWq3ssWkCp2AB1HYNIHpXGaG/wnqeDPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwgDUeeC57gKeN03bzsRHL31DMBypP6Gp6h0LWy4KTU=;
 b=is2Jn3t2scFcFDncXvpAQhtW2FHDblVuq8PO9vQEQctE7R1rc6msZkrDw0sxowEStJmGQN93GQKjWZkX4D244E2rTIzTj2ae91DnIfFqDQDQBXChBIaP+l5OaQpCwH1yxxP7epDX8uCJo4FBVE/7fzxY+Ufk4r0/Vag+n6IHeIE=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Tue, 8 Dec
 2020 07:33:36 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 07:33:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Thread-Topic: [PATCH] usb: dwc2: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Thread-Index: AQHWyhij/SlUeTWuQU6OpaiFwXt8Hans04wAgAABIoA=
Date:   Tue, 8 Dec 2020 07:33:35 +0000
Message-ID: <d5e5d31a-84d0-7521-5a4c-5520797a2744@synopsys.com>
References: <20201204083644.2704-1-vulab@iscas.ac.cn>
 <2a1cdaa8-0582-6651-49e6-ee459e6a5f33@synopsys.com>
In-Reply-To: <2a1cdaa8-0582-6651-49e6-ee459e6a5f33@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.92.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cb4b32e-a0e9-40ba-74b9-08d89b4b92fb
x-ms-traffictypediagnostic: BY5PR12MB4853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4853B23DDA080C1607839C6EA7CD0@BY5PR12MB4853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:199;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UDm0MGR6qwQae5R2Cppi/JJ1laoTZ/WyTJ2aC3AUTyEXjClJokMOXPLksNglxUEx0G5+9fx+jJd3QRVtKm/9j0fM9lvpuUC8NUHPPsVSSXi9MdrW5Ssx/EAGQlbeC/g6pXycv4N6FdrnPqI5lNebsbA0aAPu0vqUOzyLshsXNAntdW8gONxRYOfP4ftmibHYJzGG4+L2042Ey4l2VhxILpZssFS9wk7Oq04yST5Job4UU2taOADZU2QoL+oMgWIr16Jy0OKTvwvYrrcgclAW+OUM+NWBKAgookNP1gLQjGlXkQ1xZ5uGZdoqoTv670ijdSet7Ec/sZzDM+zLERQY/+MKnJJfE6fidDwWMwSCEnSVl3Q9ePPVlJkIjm58ZX/0YhHhn1MMOkntH5b6XPWmo89Q9f4UrG30jcK2lclTDM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(2616005)(91956017)(31696002)(76116006)(86362001)(53546011)(71200400001)(6486002)(2906002)(478600001)(6506007)(66476007)(66556008)(316002)(8676002)(54906003)(66446008)(8936002)(36756003)(66946007)(31686004)(4326008)(64756008)(110136005)(186003)(6512007)(4744005)(26005)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YnpsRjdld1g0dXJBTmFvR2hQbVhSNW5DMnlUTDBRT3Zzb1UwN3RMUEx5WVRy?=
 =?utf-8?B?TVlrVjgxbmV5R3B2RVFBSVpSK1Y1R3ZGTjYvY3FlM0cwVzdVNmJTM3FmdVoy?=
 =?utf-8?B?ZTdVa3RqOUlZMk4zQ2I3WjdTSVl3dFN4UCtUNXVHTWtpRnJ2dExGK3NEU2lQ?=
 =?utf-8?B?UEN6SjZCTkxpbTRLRnkxSjd3T255R1hRUHFFbmNkTFJIR2V1UzhKdTFqdUQw?=
 =?utf-8?B?RkdGbTlGTWVIcUtPODZVZ1lYbithSFlBWkhhdWpmRzRjaUpYREorRWJGTTFJ?=
 =?utf-8?B?UXZtTWFJbXJlS3h2bVhDZ0d6SXpmTDhGdmRvZWpjTG1CNmlaMUJaT0xXWTk1?=
 =?utf-8?B?S0YrZlV4UDhCZkJjbE1YWGJDZjhMSCtmQmNMWnNEcUo5UzJOM1o0MUd2TVcw?=
 =?utf-8?B?Z082a3FFYXcyUWpPdXo3ejZpLzZRQ21wVDlqMVNnQkFIaC9OSW5aTU1vRGRG?=
 =?utf-8?B?OG12dmkxbTNCOFpJU3BwOEN5aEYyc3dTRXl3OUkxNjNJYjBGbjZjMHhJdGhy?=
 =?utf-8?B?U2RLdkpHMGRISzY1QkF3N3BxS1c4VllSNkI2ZU9lTXloUkZmc29lOWNPbGlO?=
 =?utf-8?B?bDRSSHRpRG5NSnhhTk1WeTZUeEtienpCSmlmRmZjLzRRMHhldjJIT3FKOFJZ?=
 =?utf-8?B?bGdla2M0R2ZjeU9RdnpuWHF4SmV5Q1VMTXZIWEdabXp4VlZHTW9yNm1NU1M5?=
 =?utf-8?B?Z25rUFFhdUJLOUwzbjYzZFFFMDFjQkVQM3BueXlpOHRGUFJJR1U4K3Q5b093?=
 =?utf-8?B?ZGc4OGE0UjhEVUJPV0xKT3NmbWZhc3IzRGcza1lKWFcvQzIzOU0rWE96bVFQ?=
 =?utf-8?B?VUF0ZnlhbEtnU053QTlERHVFTTJNVStmV1kvTWdIdTRNbWdGcDhudTgyT2Zv?=
 =?utf-8?B?OWg4OXRObFRGczNyU05xY1ZoWnlYQjR4aUFXMXJKUUNObFltc3VkU1RnN0xH?=
 =?utf-8?B?SEk5ckRoQSt5bkkxVGt2Vi9tVGxOaWhUcHovTW5Wc3lHWXRhUVZKaGNpeWl0?=
 =?utf-8?B?b3JKU0tVY2ozR0F6SFlRdE1xcE9WWE1sZG9rUlFlZkE0cGZJK1paQWdUSXFI?=
 =?utf-8?B?RENIMHN2Z2ZLK24vY0xOc1U3QkJpT0JURDlFdm5FK2tjdWF1TG1henlQcGJt?=
 =?utf-8?B?ZzZ5UlJHVXFUdlAvL3RVMVIrK0ZPUm5VeDY3SExSRzBVbUcwREtJSUFXUWI4?=
 =?utf-8?B?SThJa0h6aHR1eWM4ak8xYllhMkZYWHRDdWhja2pZUWxSK3ZsS21wbXBlMDdx?=
 =?utf-8?B?Nm96U3g5VGpTUkdFN1JrN3plRm05SHppeWVjUlFwbkk4WGt0bnBwS3FZejBZ?=
 =?utf-8?Q?u8WJhwNs+Ur7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4BE868F37A0E4C9F4A2ACD1347B9BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb4b32e-a0e9-40ba-74b9-08d89b4b92fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:33:35.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWFK9ggrFs8uOIReFgWfY49XQu2zUWuRJ8FWPNz7zdIuPZFpQWmUJMrU7/cayRbe/8t2bAAOUEhvrP8uDb8MDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvOC8yMDIwIDExOjI5IEFNLCBBcnR1ciBQZXRyb3N5YW4gd3JvdGU6DQo+IE9uIDEyLzQv
MjAyMCAxMjozNiwgWHUgV2FuZyB3cm90ZToNCj4+IEJlY2F1c2UgY2xrX3ByZXBhcmVfZW5hYmxl
KCkgYW5kIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpIGFscmVhZHkgY2hlY2tlZA0KPj4gTlVMTCBj
bG9jayBwYXJhbWV0ZXIsIHNvIHRoZSBhZGRpdGlvbmFsIGNoZWNrcyBhcmUgdW5uZWNlc3Nhcnks
IGp1c3QNCj4+IHJlbW92ZSB0aGVtLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFh1IFdhbmcgPHZ1
bGFiQGlzY2FzLmFjLmNuPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0
aHVyLlBldHJvc3lhbkBzeW5vcHN5cy5jb20+DQo+IA0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5
dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0K
