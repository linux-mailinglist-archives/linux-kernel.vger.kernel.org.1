Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E2303D95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391927AbhAZMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:48:16 -0500
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:19713
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391691AbhAZKDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6WPeSg2e96w642FZIo6RFQnW4eNEjmmFTOsufpJ7Cg=;
 b=8FS4Pydzz7dP5cZ7kMwhrWhKzN/jrY/lSFL1EdnRxhJhthOVvrY2q/exWZmzc5RRipyBYjKS5Ky6x0h47eadaFbCRnznNHJ82dts9QGWp3E3n87GlDt7L+QLKdLh555I2z22Pr1UtRSOhC1x7ail9BYewY7NddCkyhsbnhZRBWs=
Received: from DB6P191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::18) by
 PA4PR08MB6255.eurprd08.prod.outlook.com (2603:10a6:102:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Tue, 26 Jan 2021 10:02:21 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::4) by DB6P191CA0008.outlook.office365.com
 (2603:10a6:6:28::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Tue, 26 Jan 2021 10:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 26 Jan 2021 10:02:21 +0000
Received: ("Tessian outbound e989e14f9207:v71"); Tue, 26 Jan 2021 10:02:21 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7a2e9a0929b0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9363C7A5-6D00-4647-827A-216B48F9F5FE.1;
        Tue, 26 Jan 2021 10:02:16 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7a2e9a0929b0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Jan 2021 10:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCIuMkTpj4ciOFnwlybEZOGeVuVFNo+vLMVEAyge3G3KHC3NJ0hYfOzNjgq5WYTBUVDCSTUQQLRHJVaPtLz06bl9hJsrio4eRM/Qjc3RDHMIZT5c1DDDpket3iSPRkqQVG4btxT1r24rHGdQcBJA7BkXuBWhHoEE2bcoUkEa6GZHVnnyuRQ2t7gMiZ99VUuftqNcmOt6ctNp8+PLrtPMMbD7Zpu5qWvjZXcqul0pf7YvpfzaC0qlMhDI9NBBdDHXgets4RABkReGctTzzgO7eRtR0tlCmrQZA5P0bI3VwYFpAZW66giRB4hzL/wc5vXxRKiYouR9IWcGcXd898IZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6WPeSg2e96w642FZIo6RFQnW4eNEjmmFTOsufpJ7Cg=;
 b=ZMUay7pSCv8t5FVHJ4bxoGOLXBaD3nAqQAjFVvNocHVCI6WbvQv+bb1sJw3JXsp6wE5EolP9iYVKiQ/D3JFodNCdfCNu+OdejpBdJiuaaSf/xzFHud+0AluSesPb/96NX2Wk2Jn4GCWPR43VOn5LpL4iE9C+6p3Fuzo3uoasCtcE61Nj66aCV1lC75ErngZNC9jDjmGfw4M0C3HVjqGJQXtucCBtGSbHDaxPUTqJUqGM237JXZ/3CCQFLT2s2rSNj6z/8NNeXbq14zp6dYsV9y3i7kNcaFXpueP9mLVSykN8sq3rmfRns9iFiMFtP9dlQlo2w0/8BBtSLV0NbFqTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6WPeSg2e96w642FZIo6RFQnW4eNEjmmFTOsufpJ7Cg=;
 b=8FS4Pydzz7dP5cZ7kMwhrWhKzN/jrY/lSFL1EdnRxhJhthOVvrY2q/exWZmzc5RRipyBYjKS5Ky6x0h47eadaFbCRnznNHJ82dts9QGWp3E3n87GlDt7L+QLKdLh555I2z22Pr1UtRSOhC1x7ail9BYewY7NddCkyhsbnhZRBWs=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AS8PR08MB6325.eurprd08.prod.outlook.com (2603:10a6:20b:332::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 10:02:15 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.019; Tue, 26 Jan 2021
 10:02:15 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>
Subject: RE: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Topic: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Index: AQHW8zNhQKRvGbxdckymzuUtTURLX6o4ptSAgAAFXgCAAKEyAIAAXTAQ
Date:   Tue, 26 Jan 2021 10:02:15 +0000
Message-ID: <AM6PR08MB35891B98A9A4A0A12E76F75D98BC0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
 <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
In-Reply-To: <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 6EC49C9AB0321B439542064C8C0E7019.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3614246-3961-40c3-cee5-08d8c1e17923
x-ms-traffictypediagnostic: AS8PR08MB6325:|PA4PR08MB6255:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PA4PR08MB62554693A91AE83FBD379FCB98BC0@PA4PR08MB6255.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ina12CjNBIJxM0c+lIqjsTpdoVheMTJ7bG6KU9lLdxzGA5b1hUSky1h1izTVBKvXdJi4xpkYmh06pZ+4d57r2TQEaaOrqT/dNZRffzwP0lK/px11Xv6mfGu3al6eKLpACrf7AP3mee1dicEeXh1jaff4fgYwuUbMuIKzX7irI4MO9YrESBN0wqfSHw+kKVetRw+4Ba4O8Axr3d5WjiP5MOrQPRm6jK+E7UKsJh3tVJ10Rz2KymRk84D4/OUWIX/QD84JHi5yEq8Rv/OXTFiIvVaSB9bsKD6zXvh2Kb3pPkxWqr0S/X5JrbojOqihEExbFFA8JSrZl4BQhxjli6P9zqNPef501V+69oH1fQNB4pEnkhAZ0WMV3A9Yvq9CRpwL+k7sMLvJTOzilcs5H2p7uiaZzY6hTXqnziiz8PeC2Ii7dLXmgMoDuNjACUIsZM2DQvZpQTgqD174gqO638k02bUlSXaJrBAGoCwNGCvZXF9ydVgwfcN2IiPiFC1OyGwjnmqFDass45C4KVdURwCJmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(136003)(366004)(346002)(396003)(52536014)(110136005)(186003)(7696005)(33656002)(8936002)(76116006)(6506007)(55016002)(5660300002)(9686003)(54906003)(478600001)(8676002)(53546011)(66476007)(86362001)(66946007)(64756008)(66556008)(2906002)(83380400001)(26005)(966005)(66446008)(316002)(4326008)(71200400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8CSN2LMuxzY4SO87rkPNuM+Qtw/Vb7zkFQ1idYAuCd/cdMz9BStUuRYT/q4f?=
 =?us-ascii?Q?1dMZh3Lwi4rB2AUPGWslgeV1o0JJ/YLuzPUk6Crnu2u8bTsSm7bZ8bqWIOIY?=
 =?us-ascii?Q?Cdx2HtPsQT3G2i0cQGTvotqlDDLnIPU/h++tC3UJ5LbWtML2LqZaswY9DFdW?=
 =?us-ascii?Q?t7SCGCZsUFzSMbeZafxo9AHxVR7kww2mJp+9woojh9fw8oNgv/t/JGLUfAV4?=
 =?us-ascii?Q?sltMgfD+92yZQLafWKTwJ6T54NzFYwu70G3z/yznvpewEctCNV4U/+2h63AZ?=
 =?us-ascii?Q?n6Ad9+XFeSpDpAK5m+G7E2msW2FRL/Gd1pSKpobnaeqG3M/4LLccZVmBrrgf?=
 =?us-ascii?Q?ExV8VhxBul81zHtBbmObZRqcEVH5guBEUkRhRKR0QkwTmeyRB0TlK4USycx9?=
 =?us-ascii?Q?awoL3C+pN3vYExu0r4S/eJMrh1joNVrj3TJ3e4fa6rBxu0APjMDemsYMByv5?=
 =?us-ascii?Q?MrK821uq5p9AfCK+X+UMs741+OVTIxQ1Z+5HuoSGg/MUR/INxIfqcRyh2tYF?=
 =?us-ascii?Q?zXkN2u6zeKBZi+VE7U/OL8tIDOn3oMEm8jopJbD+7vycyfsKVhKON+Z9y25W?=
 =?us-ascii?Q?7XHSI0MXRrd2zIeWk3+RYCNf5eg7a24lU+jQnorxmPE2h8WNhiRa464EtBAA?=
 =?us-ascii?Q?O5/0LuWUF0O9oR5OY4O700uT+Z+97E7j3vyAInQWWGCx1JryPAtVpFoq8ZAZ?=
 =?us-ascii?Q?EJCUf5fW9o6dGSvcmARD+RvnN8zXFugSSxElTLWGvkAeTOCfGoyD92KKfLGh?=
 =?us-ascii?Q?tG3GfWLsioN5sOm/wt9NM+YCYBQIQIwp37eQ5waglqLxQsT098Fte9PCyJ6+?=
 =?us-ascii?Q?G4jOstTL17clDmkUFJiKsiK6hrCjkNQqqX21tBhAiK4NcNmTPspJXuGWK1xX?=
 =?us-ascii?Q?6EBxQxaVXsKgMbzWOX7UpsB3ejE9HGX20Yc4zX17r/9DWqm0XfneqL3QG3lq?=
 =?us-ascii?Q?yG4nsVdBMwQeDctcOfs8Qwp9X4M/AjNZds3udmpLO0IurjqV9w47d7ugzLzY?=
 =?us-ascii?Q?jngzGQuRyVXS5FfjhOBZADjEz6QUb1EuWiq5a++oOaYDXaOvPH+gm8bGB6bM?=
 =?us-ascii?Q?nXRsM6Mr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6325
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6e7c269e-73d9-48ac-4c0b-08d8c1e175a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulYg09XG8UsEM1FHyDVdSin9kSeba+0+nsnuPpx7VjzJV6qD2kiJTgoGVpOWNqLaICh6rIjx2A9Ox9frwvPPJ7S46k5Uz++vWanxWJ9AFd6RQYSpVigmSZlC/sYLQXZJ64budaaU2IvlOzBdWy/TCDnUO7AQNXpGwFcKWSVPxtrqxjyqjDspYQ1G7kQJIyYrtdj3lM3HV4ZToLk+J0Toq7AnqTUnK43Kdzmn0XGXs3urdUjfMd8cyiJdjuVQF37TEdooa959xXwsSRJJJY5eAAhe/bhqk21UeUG2Bb5h7zn+DUxmNCOkrH8DOqzafluNnaj62+ySflDl2MCqD0S5HH9jD209Pf/WNmUpyX/37j5NNECTkK0N0C1I61b4Q++y4Kg4JU9uYfcaQ/snq/2emC3RSprZdVxh2fAvaKq7wJsRj0eiQuQMG7ODyzuIKJGe182HGHp6X+TM12HYIuCuWH8lZ7jW7DBg5VnASkPKt4Yo3+qH62tQvoybLFDxIKwogSLzAfO7vSU79FcU5Bugu6LrhtC0Zo8r4GYKPs7h8/macR1QiQhhHcBWlB9lCBUpdDb0m27Mp5LpXXzhCpwczE8x9oitXzfZT+wdptfUgxv2qUe6Mfroat1yAnYM9oWklv46Pes598K41bvWzIJpyG9lJ9v2MZAF3oAARhoNeu5sx1GDpsrpsLoiA+LsiU+Y
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(396003)(136003)(46966006)(70206006)(47076005)(70586007)(4326008)(52536014)(55016002)(83380400001)(966005)(9686003)(110136005)(7696005)(8676002)(356005)(478600001)(54906003)(336012)(81166007)(8936002)(186003)(316002)(33656002)(86362001)(6506007)(2906002)(26005)(53546011)(82310400003)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 10:02:21.7037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3614246-3961-40c3-cee5-08d8c1e17923
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Tuesday, January 26, 2021 12:16 PM
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>; Jianlin Lv <Jianlin.Lv@arm.com>;
> mingo@redhat.com; mhiramat@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
>
> On Mon, 25 Jan 2021 13:38:40 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 25 Jan 2021 19:19:27 +0100
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > On 01/26, Jianlin Lv wrote:
> > > >
> > > > When trying to create kretprobe with the wrong function symbol in
> > > > tracefs; The error is triggered in the register_trace_kprobe() and
> > > > recorded as FAIL_REG_PROBE issue,
> > > >
> > > > Example:
> > > >   $ cd /sys/kernel/debug/tracing
> > > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=3D%x0' >> kprobe_events
> > > >     bash: echo: write error: Invalid argument
> > > >   $ cat error_log
> > > >     [142797.347877] trace_kprobe: error: Failed to register probe e=
vent
> > > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=3D%x0
> > > >                        ^
> > > >
> > > > This error can be detected in the parameter parsing stage, the
> > > > effect of applying this patch is as follows:
> > > >
> > > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=3D%x0' >> kprobe_events
> > > >     bash: echo: write error: Invalid argument
> > > >   $ cat error_log
> > > >     [415.89]trace_kprobe: error: Retprobe address must be an functi=
on
> entry
> > > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=3D%x0
> > >
> > > IOW, the "offset !=3D 0" check removed by this patch is obviously wro=
ng,
> right?
> > >
>
> No, not wrong. Even offset !=3D 0, if the symbol exists in the kernel,
> kprobe_on_func_entry() will check it.
>
> > > Agreed, but...
> > >
> > > > --- a/kernel/trace/trace_kprobe.c
> > > > +++ b/kernel/trace/trace_kprobe.c
> > > > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const
> char *argv[])
> > > >  flags |=3D TPARG_FL_RETURN;
> > > >  if (kprobe_on_func_entry(NULL, symbol, offset))
> > > >  flags |=3D TPARG_FL_FENTRY;
> > > > -if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > > > +if (!strchr(symbol, ':') && is_return && !(flags &
> > > > +TPARG_FL_FENTRY)) {
> > >
> > > but why did you add the strchr(':') check instead?
> > >
> > > I was really puzzled until I found the this email from Masami:
> > >
> https://lore.kernel.org/lkml/20210120131406.5a992c1e434681750a0cd5d4
> > > @kernel.org/
> > >
> > > So I leave this to you and Masami, but perhaps you can document this
> > > check at least in the changelog?
> > >
> >
> > No, you are correct. That needs to be documented in the code.
>
> Agreed. There should be commented that is defered until the module is
> loaded.
>
> >
> > I was about to comment that the check requires a comment ;-)
> >
> > Jianlin,
> >
> > Care to send a v4 of the patch with a comment to why we are checking
> > the symbol for ':'.
>
> Thank you!
>
> >
> > Thanks!
> >
> > -- Steve
> >

Thanks for everyone's comments;  I will update this patch.
In addition, I have another question.

perf-probe can add a probe on a module which has not been loaded yet.
But I still get an error when I execute the following command:
# perf probe -m /lib/modules/5.11.0-rc2+/kernel/drivers/net/vxlan.ko
'vxlan_xmit%return $retval'
Failed to write event: Invalid argument
  Error: Failed to add events.

According to my investigation, __register_trace_kprobe will return -EINVAL,
because the vxlan module is not loaded;

__register_trace_kprobe
->register_kretprobe
->kprobe_on_func_entry
->return -EINVAL;

The following code snippet shows that the probe of the offline module can b=
e
registered successfully only when the ret value is -ENOENT.

ret =3D __register_trace_kprobe(tk);
if (ret =3D=3D -ENOENT && !trace_kprobe_module_exist(tk)) {
pr_warn("This probe might be able to register after target module is loaded=
. Continue.\n");
ret =3D 0;
}

kretprobe events not work with Offline Modules.
Is this a bug?

Jianlin

>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
