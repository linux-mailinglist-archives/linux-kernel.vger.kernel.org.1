Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C732D3015C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhAWOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:22:52 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:59982
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbhAWOWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+N5YAhkBLOUTtk0i3Hr+s7BD7lOQEADEpxEDdbrbG0=;
 b=dQkWfxEOrJY2duhSItNrGX0MG7kLw02ElUjYbqwjxhLYN6GC24d73X4cqfynJaEpce6s2Q99cR4icsXb33lG/cPHMjWLTKQFMJWg2nBYb6Iiu5tbjf/7Sznrqt8SNPbO09thA3nUEHSYhcxXK1X/dI4VzG8K0XJFjTLpK8D4pws=
Received: from MR2P264CA0174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::13) by
 DB7PR08MB3913.eurprd08.prod.outlook.com (2603:10a6:10:7c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Sat, 23 Jan 2021 14:21:56 +0000
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::65) by MR2P264CA0174.outlook.office365.com
 (2603:10a6:501::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13 via Frontend
 Transport; Sat, 23 Jan 2021 14:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Sat, 23 Jan 2021 14:21:56 +0000
Received: ("Tessian outbound 8418c949a3fa:v71"); Sat, 23 Jan 2021 14:21:55 +0000
X-CR-MTA-TID: 64aa7808
Received: from c44abf9c58c4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A2C536A-16B4-4C12-B395-1C83F64A2A33.1;
        Sat, 23 Jan 2021 14:21:50 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c44abf9c58c4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 23 Jan 2021 14:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYvQRZQ22Zr8WztNU/0fNvQsmZC6FeND3LjIJMRCN7oFFbYhWzod3EqrtjTHtmbzD4Hit3rDHBo49wZLpEbrQAjoHttcQ84efpMPjtv30ggfF4abshagdXt3/zRD8Pm/mCqS+lOLoq03SRD5uBw+d+cSleJUqxaqWllOIfyQ91fL+bOEgbPuVJU4UyDq//iuIBjhihAZ+RQwyljJI695EYE3lks/TjpigogsfNMeDUvKvlL7FDJ4p0PzMrGOMMhedhNIc9IR9iJnoLL35FtxOHZmRrApOxgsayDWW8Aq3AqvlYbXi+q7ACwS3iUwDlcsBF+Fn6CqB/LFcYynW3ov7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+N5YAhkBLOUTtk0i3Hr+s7BD7lOQEADEpxEDdbrbG0=;
 b=KImXcxVQ8aDebsnS4laKHsMi1y3U/vxKTnVgEO9pEIUKda2ccOCxLOn/VP0n1g7tbgQoB3ytxSruR8ZPClvbPv88EV/+fHaywZjGv4VIwMoHB8S1HWWB3MtxVOPVPR0403CqRDOjRLV4QypQuaALvJ6DtiQnMke/6vzhSMwrnIKaefvu99F2UGjae2ccV+lAm51+TEKD3CUp7RSrjpWQ7EnYNjAoe2OpFrrJT0zzNs48A9SWhklueUtpT843ohkiO1VMOdhHizoJq6HwHRRUqYwPn15XbvqeNQRYDLkifxNgW6Fh4S5eTmRmRTw60EZMT8T5jMvhDTUoA0Mlp3ZuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+N5YAhkBLOUTtk0i3Hr+s7BD7lOQEADEpxEDdbrbG0=;
 b=dQkWfxEOrJY2duhSItNrGX0MG7kLw02ElUjYbqwjxhLYN6GC24d73X4cqfynJaEpce6s2Q99cR4icsXb33lG/cPHMjWLTKQFMJWg2nBYb6Iiu5tbjf/7Sznrqt8SNPbO09thA3nUEHSYhcxXK1X/dI4VzG8K0XJFjTLpK8D4pws=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AS8PR08MB6022.eurprd08.prod.outlook.com (2603:10a6:20b:295::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Sat, 23 Jan
 2021 14:21:48 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.014; Sat, 23 Jan 2021
 14:21:48 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: RE: [PATCH v2] tracing: precise log info for kretprobe addr err
Thread-Topic: [PATCH v2] tracing: precise log info for kretprobe addr err
Thread-Index: AQHW70TrW1DgGe3uT0qGSPuZ+YlVQKowsa4AgACqEoCAA+q/4A==
Date:   Sat, 23 Jan 2021 14:21:48 +0000
Message-ID: <AM6PR08MB3589CB4AB4EC3ADBBB45144C98BF0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210120155644.64721-1-Jianlin.Lv@arm.com>
        <20210120112004.4b9ff1df@gandalf.local.home>
 <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
In-Reply-To: <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 90D1C093136FB8499DD0AFFDD813CDEA.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97f86035-b744-4c14-d5a0-08d8bfaa3d0c
x-ms-traffictypediagnostic: AS8PR08MB6022:|DB7PR08MB3913:
X-Microsoft-Antispam-PRVS: <DB7PR08MB39136A3D5820F108F295BC2E98BF0@DB7PR08MB3913.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jpqrxx+QJTbkzkMvEKh2AKUh0LGHRGq368zvQgsYwEUNm4SxymxrkoNARVMRPFojCWUKn9UWHWm83Qx7xXoMsPyzNuosusd569ddRQlcumiowqF/UcWb7SA+RsQTX6IftSV3Q/L4IM6lgxtooO+uZ3VJNsYIRKxuyeQZfM31EXRERTbWG7s4WR2gFsjULM9XRoOEcBzG9I2sY7OVKMy3suQxxCsPQSD8obVZ5pxDGUDtzFkqJR9ciVClrardPNTV7jvinPXGNJtgNlYRbmUu+nNOa8+ki4AaQqKdxxjXZLqx5JTcVgIh1tyAP75b8awCd5rYltPDGWE8yWXV0DFg34iMZS6Jl4Ri5PFxid0kt5o4dgoeE++pievLnTfI0dO7sWi4c8s93ZGMwacq1/pSuB1rgnCELa3DTLhbwrkoFusr5zW88z+bS81D65v4IKHtq63HK39sk95TTFPuj4EQO/NmRMH1ARL06iLlCr6Z0FKwyAMs4dmmzjt9SikljXkDT9jJl8mC5l/nHiTztyoj48KXaJ+TUIPbjDfNCJoXOrGATlQ3NMmEeb3pe1WxCYeQ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(8676002)(478600001)(7696005)(4326008)(8936002)(33656002)(86362001)(54906003)(26005)(5660300002)(110136005)(186003)(83380400001)(66946007)(2906002)(66476007)(66556008)(64756008)(66446008)(316002)(71200400001)(76116006)(53546011)(6506007)(9686003)(52536014)(55016002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iGiHmAO3stFJtHke7gpsCqP75Jf9RDVVuZJql0/U5Kz+6tCjs9mn1R5d0atH?=
 =?us-ascii?Q?+FGa1oyyo/m9wDDkQG6YBZi1PGBxBGZJtGSqxGhYmzFRvGXh9horeSXKtAxt?=
 =?us-ascii?Q?bTMQqmomiZWGgY0LLFOMxy1xFVs7kDV1Y2J7qDuCIC/CGbEBtNebCnJCN684?=
 =?us-ascii?Q?aKY3hjSjRbUBpzAP1HF33FH1AtDjdlLz9oAUduI6jh/Ot7nJgOSJtPIMMyKs?=
 =?us-ascii?Q?xK3ne4NlWXpF+dYNvhWIB0Zb7zSYXLKLndeJ6tF+d+FUTWrBbjcsp6Qw6Hje?=
 =?us-ascii?Q?TQwmyk+4haiXUPMM4i/Z1h1U2xCOkFU1mlIQ2SUMvTiRQy+06z+OLYEZdENH?=
 =?us-ascii?Q?ixzOWy+vnSaZ5+55juBo5wji2GleNJW31XloNt+bcoQvoYvR57eGVmrgzsjn?=
 =?us-ascii?Q?qyh17dK4p7GttIixau9JMU9SqFNk/SiasYFppOZ5k0P7yVRUQa0Ggfh6KKPa?=
 =?us-ascii?Q?YNU7zAPTt/E9dL8iiwzPN7J56V6N9i/uxlf+XbZrmMZe9WH/HqSZeTNeKEe/?=
 =?us-ascii?Q?OI81RGqQb49ANf5NniMXfKTNLbebqXBqzK3vJoGVfkGyNSvVeUQjrew3b6px?=
 =?us-ascii?Q?B06NULcGA3S/DDKXbnus5Nm7T699+YyT0ZCllI3gxM09CohTTLwFWLUOaZKt?=
 =?us-ascii?Q?Zde0MKTONgpZ95awAP1oa+0PTOg3BOMG2+JcG2somH2BruH+2zD+oc3NwtZO?=
 =?us-ascii?Q?sol54QtIHS7XJhH96AQfA7Ho1BWtPKHLejjaJS2J0wZErTs2nN53RWdoJyWo?=
 =?us-ascii?Q?2w6MeTZ62ELISIAgg6cRgXW1A9huElBd5V1VEHk1ynjzmQySctCTErg1hdcy?=
 =?us-ascii?Q?yi3vWmIaYG4g+5TKpziwBgz92D8asLfJpC4q9ufaYHs6PMneyzgSSIJ2pGEX?=
 =?us-ascii?Q?hmaD5baM0nGdJP091Hmpx7OE1fPfDSICIe0RfUYkY8WZ3M01iXyY7fFoHcXW?=
 =?us-ascii?Q?E3FBNUyEu5QzWl/BU2+3hJ7T/CA/05aAFaqnAwQxl5eb1VHWC2zwMl1zzgro?=
 =?us-ascii?Q?hu7ZvnK7fbbGon5AQSR0Y/yE4D5/nlBSOq2FijYhoSwuHBVTF+XonhdFYTPE?=
 =?us-ascii?Q?SeT7zueB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6022
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3daf545d-91e7-4484-1568-08d8bfaa3854
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkfkX8Rgq53YcMnrmqZBQ3HlhciAMRAHLn1vs+IrRQQ+0RiQ2yuccUsUmo/Rd0jooq9hE8EsisEYqaFexKFlF7YFrDyId5umjeyyS32pWdbrjvHQqtwUvF+1RwoxY7jvO/+OeuQUtVjO/R9W0LQJBLlC9zORYKdPQUObC6BdVqfdIvF2E40pLXQTfbYqWU9ltfTb2iQGSx2lK8wtyxKa8mqE+y/2DoOuqIRCPtbL2KiN9mxX3VIdinhg36qFuk97qu7iGNoL1TqUFIm2C7Voptm09EdT67GJ9O+4RQW0MEjA6OBC+5xQgCSa2mWUdwLfi7X4OotRR78sco32ylk0CUw26dSxVP0tpiqtWWjvWGYneAOVVyNyiMHi3+GSWPRaSfsOaW3plPJ6nYRgJFPc6a5cOWiILbpQYAdmwwpczzmQjA0j9YJDWwsBzOP/gJqUk4CWKoEH4DtQ+l0OHwfsxzOiL9KhufPLodSZu5nG8Nc=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(396003)(346002)(46966006)(107886003)(5660300002)(8936002)(47076005)(186003)(70586007)(9686003)(55016002)(33656002)(70206006)(4326008)(7696005)(83380400001)(336012)(478600001)(316002)(8676002)(81166007)(26005)(86362001)(356005)(82310400003)(53546011)(110136005)(82740400003)(54906003)(6506007)(52536014)(2906002)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2021 14:21:56.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f86035-b744-4c14-d5a0-08d8bfaa3d0c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Thursday, January 21, 2021 10:29 AM
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jianlin Lv <Jianlin.Lv@arm.com>; mingo@redhat.com; linux-
> kernel@vger.kernel.org; Masami Hiramatsu <mhiramat@kernel.org>;
> oleg@redhat.com
> Subject: Re: [PATCH v2] tracing: precise log info for kretprobe addr err
>
> On Wed, 20 Jan 2021 11:20:04 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >
> > You forgot to include Masami on Cc again. Masami maintains kprobes.
> > Please include him on any updates, as he needs to review them, and
> > give his acknowledgment before acceptance.
> >
> > I need to update MAINTAINERS files to include trace_kprobe under
> KPROBES.
> > And I also don't see any UPROBES section there. That needs to be done
> > as well.

Regarding the UPROBES, I read the code of trace_uprobe_create() and  found =
a place for improvement.

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad3..8c81f04d7755 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -567,16 +567,18 @@ static int trace_uprobe_create(int argc, const char *=
*argv)
        if (!filename)
                return -ENOMEM;

+       trace_probe_log_init("trace_uprobe", argc, argv);
+       trace_probe_log_set_index(1);   /* filename is the 2nd argument */
+
        /* Find the last occurrence, in case the path contains ':' too. */
        arg =3D strrchr(filename, ':');
        if (!arg || !isdigit(arg[1])) {
+               trace_probe_log_err(arg + 1 - filename, BAD_UPROBE_OFFS);
                kfree(filename);
-               return -ECANCELED;
+               ret =3D -EINVAL;
+               goto out;
        }

-       trace_probe_log_init("trace_uprobe", argc, argv);
-       trace_probe_log_set_index(1);   /* filename is the 2nd argument */
-

Is there anything else that is missing?
Could you provide more detailed guidance?


>
> Uprobes is under kernel/events/, which seems to be handled by
> performance event subsystem. Maybe we should ask them too.
> Or, can I be a reviewer (R:) for tracing subsystem?
>
> >
> > On Wed, 20 Jan 2021 23:56:44 +0800
> > Jianlin Lv <Jianlin.Lv@arm.com> wrote:
> >
> > > When trying to create kretprobe with the wrong function symbol in
> > > tracefs; The error is triggered in the register_trace_kprobe() and
> > > recorded as FAIL_REG_PROBE issue,
> > >
> > > Example:
> > >   $ cd /sys/kernel/debug/tracing
> > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=3D%x0' >> kprobe_events
> > >     bash: echo: write error: Invalid argument
> > >   $ cat error_log
> > >     [142797.347877] trace_kprobe: error: Failed to register probe eve=
nt
> > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=3D%x0
> > >                        ^
> > >
> > > This error can be detected in the parameter parsing stage, the
> > > effect of applying this patch is as follows:
> > >
> > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=3D%x0' >> kprobe_events
> > >     bash: echo: write error: Invalid argument
> > >   $ cat error_log
> > >     [415.89]trace_kprobe: error: Retprobe address must be an function
> entry
> > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=3D%x0
> > >                        ^
> > >
> > > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > >
> > > v2:add !strchr(symbol, ':') to check really bad symbol or not.
> >
> > Also, the "changes since" section should be below the "---" so that
> > they don't get pulled into the commit.
>
> Except that, this looks good to me.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> Thank you,
>
> >
> > Thanks!
> >
> > -- Steve
> >
> >
> > > ---
> > >  kernel/trace/trace_kprobe.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace_kprobe.c
> > > b/kernel/trace/trace_kprobe.c index e6fba1798771..bce63d5ecaec
> > > 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const ch=
ar
> *argv[])
> > >  flags |=3D TPARG_FL_RETURN;
> > >  if (kprobe_on_func_entry(NULL, symbol, offset))
> > >  flags |=3D TPARG_FL_FENTRY;
> > > -if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > > +if (!strchr(symbol, ':') && is_return && !(flags &
> > > +TPARG_FL_FENTRY)) {
> > >  trace_probe_log_err(0, BAD_RETPROBE);
> > >  goto parse_error;
> > >  }
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
