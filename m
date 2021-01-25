Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265843020B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbhAYDQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:16:13 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:40160
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbhAYDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC38Q1+Iizw5k6V9SS16GoM3efQu6ZcgTZjX6Hu5gpo=;
 b=EXEqxBtcMhQlLg0JH8AyN8bwGoee0DeulhkE4UlWt26HOGCR+3NlrLIj7qi3w3eJ4S7j+2sDoMt4wsLfa291NKJ1yBdbzMAg1nfmi0Vblsjr9MwzmpWnbM5/qGNU2ikImFqXZVyRcyXKB10FM6nwtBIiQP2fuV2w7Z3yv3HDMJI=
Received: from AM6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::17) by VI1PR08MB4000.eurprd08.prod.outlook.com
 (2603:10a6:803:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 03:14:12 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::b7) by AM6PR01CA0040.outlook.office365.com
 (2603:10a6:20b:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Mon, 25 Jan 2021 03:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 03:14:12 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Mon, 25 Jan 2021 03:14:11 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7d50e64b2368.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B002A7D2-0FD2-4648-9D9D-C926E0022C32.1;
        Mon, 25 Jan 2021 03:14:06 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7d50e64b2368.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 25 Jan 2021 03:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fovcPKGGJ87olzEF15PceJqhp6EowmAB1pywHMQGt9sKDf/lcRuKRwA4YrEH0XIPXSUItqCW+IvjIMx7rQNWkzOlK3ERk+F3VJXsg+S4RguzBSATC08qX68XIVHBKMxw08tF/Z/X5kcE/17/RC8D7hSb1GM01AA7/8/NliegQPQUHh/rnXRmJOlxXuL2BsRfSYJYv3eGVy1oBPmOtbb3y9aKzMHIu+oFEKU+1pIHJOLM8XDvoJ9cgb/NvgyBliokujSSDEAsiVnXAPYdKMeEjNlAaT8ONRmILtxQ89Qn3+zLgCFigfJMaU+BhqAwuxYXboys9GgUAle3S1nIrjrM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC38Q1+Iizw5k6V9SS16GoM3efQu6ZcgTZjX6Hu5gpo=;
 b=lA8VpOaMb1TN1cK5aBB7VQ/fNiVeqe/9BwY87oA1ptP5jT11eMp8tpP76blFL351DTKZJmzsWezxyNQf8GRYxWI1DPQdIliJUHfmmlI4WY9AKg7qFBCy0ZwWeTv99nwcLrExzJW2X6KLYX14YtzQkd9bCWEcktSm6YEORw91BgOGaXbn0hnUpMc0q1ozWwN582gVnV+2clRYqcz1TIp3XftgmAFeQQP10LTdxFnS1RDdga0ouhKmmgbvRi18EAVF6RAmYeLe3Hw3TI3sOamnXFiPHAZSrXy24jXa3rlDwJcUaJQKvzd3XEjs6i0VFWJ84YPHafZ2fSUNCdt7I5X62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC38Q1+Iizw5k6V9SS16GoM3efQu6ZcgTZjX6Hu5gpo=;
 b=EXEqxBtcMhQlLg0JH8AyN8bwGoee0DeulhkE4UlWt26HOGCR+3NlrLIj7qi3w3eJ4S7j+2sDoMt4wsLfa291NKJ1yBdbzMAg1nfmi0Vblsjr9MwzmpWnbM5/qGNU2ikImFqXZVyRcyXKB10FM6nwtBIiQP2fuV2w7Z3yv3HDMJI=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM6PR08MB3477.eurprd08.prod.outlook.com (2603:10a6:20b:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 03:14:03 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.019; Mon, 25 Jan 2021
 03:14:03 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>
Subject: RE: [PATCH v2] tracing: precise log info for kretprobe addr err
Thread-Topic: [PATCH v2] tracing: precise log info for kretprobe addr err
Thread-Index: AQHW70TrW1DgGe3uT0qGSPuZ+YlVQKowsa4AgACqEoCAA+q/4IABN3eAgAEzScA=
Date:   Mon, 25 Jan 2021 03:14:03 +0000
Message-ID: <AM6PR08MB358928403BA18D3C1C75215E98BD0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210120155644.64721-1-Jianlin.Lv@arm.com>
        <20210120112004.4b9ff1df@gandalf.local.home>
        <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
        <AM6PR08MB3589CB4AB4EC3ADBBB45144C98BF0@AM6PR08MB3589.eurprd08.prod.outlook.com>
 <20210124175231.fed85eccade5dbe0240b5c3b@kernel.org>
In-Reply-To: <20210124175231.fed85eccade5dbe0240b5c3b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9DAA4AED0AA5224ABBC0B2BAFF9CF6BB.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5afd862-eb81-4398-b7d4-08d8c0df4a03
x-ms-traffictypediagnostic: AM6PR08MB3477:|VI1PR08MB4000:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4000D02E00F741EB7A67B2B598BD0@VI1PR08MB4000.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W+sfkaoYXNSzLC2vz4xSUt70DPNLhOKZ59sXLADIIDoHcZsOsL8Iw6KW/VIrTlpGCLRGv+x7FGV3XR25zJ5+/BOQ6WHGo6oeMShQHtCo2So5WJZj5dMjxKfQxH267s9xyKf61wn6LtJf5kqxNS9Qure7WDBcjX1eCi0YAoalK3kJ9M6B50sv9vNozt+qsS4pgP37CI7KCXjK9x7lX5SHlScnBevMtMThIORwkMiOkVj/QjVWpBowiUpANVT/GjFSw7LurUC2NS7ynoXkLWmX5atrrhaz50gnPSrmkjIp2udDKxKYfTn9Li9224ybA9LA7maZpLs//hUBo972QsasNyVWBWbbZp5lG182VMRpHtNwS9vCu2gpDr5+/afE86lhB8oPUyWRJYS/YKadS0evVQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39850400004)(186003)(26005)(53546011)(71200400001)(316002)(6506007)(76116006)(55016002)(66946007)(8936002)(9686003)(5660300002)(52536014)(86362001)(8676002)(110136005)(66446008)(54906003)(66556008)(64756008)(66476007)(478600001)(2906002)(33656002)(7696005)(83380400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gY+CY2r/kIKLRXvEDMLoamevfPkPFyAybMj8klrRsL670O04iY7rLR8u9yxc?=
 =?us-ascii?Q?h9hU88RZv/V403MtVQzCHlbJLKML3ylUyvseD18UanvmDavJREKm5a8m8pt9?=
 =?us-ascii?Q?zJxrwRrIfHMG7tLzuVNbMBXLPcH6mmhPfk0ydlvHyQve27joBKuIY3aTzRql?=
 =?us-ascii?Q?D0kT0dcJWbQheVa/4HDgbrb3Zav4A2sLZS7tfPqNNNjc2Wygd5seqICZ6FaW?=
 =?us-ascii?Q?WAdKoKxsRufUuEyagubxvakar1rquUmJIEJ7T1Qcg9tddiw6CG0YEeiBnQwn?=
 =?us-ascii?Q?5FpuV/9P/Abi32xcDZkV+HPEiSaxghNGZBujoRBL0IDEGQRXTs3spLIqAwWo?=
 =?us-ascii?Q?6buwAuKSn4xtcMHqLE2G/bfR9BRnRJbVdY7TqwOZ3OdcmoPKpV84AP8RdMeP?=
 =?us-ascii?Q?7DOyiG8lgMAwZZU41Wf8geT4FmnB/ISxGZU7HjYN0d7Y+52dpGw2g3ii3xMR?=
 =?us-ascii?Q?24dP5mDi25VYJvr/3RhjpjTPT6Kcsr0q334kZKfsC8+JYevfVMT9jvz4ihHU?=
 =?us-ascii?Q?4IwbvIbdHQSK6K7Cgfa7GvLuqEFjtdKjsdsac9ELqwdZmUTzPxKaL6yKVqoc?=
 =?us-ascii?Q?kGkkTFMUQ+hULdJoMiJvhwlIAeZyVhXkKV0fFI8d2CVmb8jUHOX3xV+bfNqH?=
 =?us-ascii?Q?v1rSuc+RY+pJt+fnX2iQ6Q+NCc/8SV7IXxwjxDUJFvkBMLfKwR2rqHnzClr2?=
 =?us-ascii?Q?GY5EXgVL7SdpMdEUTN0ZdwqTWzWn0fTwsRFCps1d65/tSLd5pbGE9u+XzTlD?=
 =?us-ascii?Q?rD7rJfRZ1gl8EwulB+5pAiTU7JvI9Kq99qndhTps4hj53rXoFS0myzemO8Nz?=
 =?us-ascii?Q?ECmZNqBwNWQCrSy6tryTgTZyqMcPVlvoYgCoo4iyulpUx8qkWZreXZsnDgYS?=
 =?us-ascii?Q?ORTn40iihxHpTytLIVMKK7Cutyt2l0faqy0oM9Usy8IZX6fWq59LK8jF2QqB?=
 =?us-ascii?Q?rZ1DphzZ63pqqFKiqpnWKryhu9zbacJ9M+yo1BqGYcLpiaW5M2YQYAKugttg?=
 =?us-ascii?Q?k/RVxic6hwkt+xA3WIh1738nQN0wyIlAAVG2ggNXyHqgFgRNPJyMPhfIMwnb?=
 =?us-ascii?Q?ckY/3DfA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3477
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 51f1be96-2e3b-4c4c-0721-08d8c0df44e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVFFzZtkVR8zVCRdceGeijVnjTm5cC6Gl9quDgU3vdhN8AzrFvcwnoZrg1JoZ42y6qOXNem29k5+Yh0AmDJEeOw0EP4kdYRHMIa97da+xA/gTpYpBB92I3D2kEqKVCNBF09WhrQ8FAnoQ3YxsyHLWOB3FWfO1ZyThp5nx7S4SwbauMSbIZrRfTzra7IfsFZQSLg0/R4eaft9CdOYf0m20bv1ZJ6XnQuGYeCK1jg1Vtfab0iESY0M7lpiQlKgqAgWhwdXM+05dHVT7zBTEIlFfNI1UZGJ6F1xm1b7XxKGCRxR6Q/yA7b83SYtUX8tzMsmQs5CxXzeSLHqVNnXwAwgx7lbUKwOB77GJM48X8OW+sjdX9Q6gT/vw1TMqlSdkYYkWDdJoyB4OkP3YnP7MENrazeWPNgmnqp59PcctCYR6O3VGdTpL5qLDccDQfpn3juoWsIiibZx5Cj0klQ2p+f6ow==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(46966006)(55016002)(33656002)(6506007)(8676002)(82740400003)(9686003)(53546011)(316002)(2906002)(54906003)(26005)(7696005)(82310400003)(47076005)(478600001)(5660300002)(110136005)(86362001)(52536014)(336012)(70206006)(186003)(4326008)(356005)(81166007)(8936002)(83380400001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 03:14:12.3582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5afd862-eb81-4398-b7d4-08d8c0df4a03
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,
Thanks for your comments, it is very helpful to me.


Hi Steven,
Could you give me more detailed suggestions about the UPROBES section? I la=
ck the knowledge of this part.
Can't fully understand your previous comments;


Thanks all for your patience.

Jianlin

> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Sunday, January 24, 2021 4:53 PM
> To: Jianlin Lv <Jianlin.Lv@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; mingo@redhat.com; linux-
> kernel@vger.kernel.org; oleg@redhat.com
> Subject: Re: [PATCH v2] tracing: precise log info for kretprobe addr err
>
> Hi Jianlin,
>
> On Sat, 23 Jan 2021 14:21:48 +0000
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
>
> > Regarding the UPROBES, I read the code of trace_uprobe_create() and
> found a place for improvement.
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 3cf7128e1ad3..8c81f04d7755 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -567,16 +567,18 @@ static int trace_uprobe_create(int argc, const
> char **argv)
> >         if (!filename)
> >                 return -ENOMEM;
> >
> > +       trace_probe_log_init("trace_uprobe", argc, argv);
> > +       trace_probe_log_set_index(1);   /* filename is the 2nd argument=
 */
> > +
> >         /* Find the last occurrence, in case the path contains ':' too.=
 */
> >         arg =3D strrchr(filename, ':');
> >         if (!arg || !isdigit(arg[1])) {
> > +               trace_probe_log_err(arg + 1 - filename,
> > + BAD_UPROBE_OFFS);
> >                 kfree(filename);
> > -               return -ECANCELED;
> > +               ret =3D -EINVAL;
> > +               goto out;
>
> Sorry, it's not a bug, but an expected behavior, because this is checking
> routine which identify the passed command is mine (uprobe event definitio=
n)
> or others (e.g. kprobe event definition).
>
> Note that the dyn_event_operations::create operator will be used from
> dyn_event, which passes the command string from
> TRACEFS/dynamic_events to each create operator and check the return is -
> ECANCELED.
> The -ECANCELED is not an error, it means "it is not mine, but maybe other=
s."
> See create_dyn_event(int argc, char **argv) in kernel/trace/trace_dyneven=
t.c.
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
