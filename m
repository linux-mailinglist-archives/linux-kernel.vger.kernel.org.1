Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF8D2EA9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbhAELXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:23:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbhAELXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:23:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105B31ho057558;
        Tue, 5 Jan 2021 06:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=AaoZVRjEvDfeHu5zqKpYiVy0UI9RiHVouwgQbQ18bm0=;
 b=Jq3KyYz9Fott0ZqwgaCkEHbd20+1m5n/ZjYGZ7bYjRsb51hdq/bGo/5zxjsFswjCIf3M
 wTPcAoamRt01RY3iDjYOJi1mSQVppQB6COlhvbOYnl2sfQXswSQY4GijkoZiSNU6H8mb
 kS00y9m239Ck7++VLS4u4Jgh6zt4SScRBNPgq54qwlcvgKe3WkNVYGNOaOhXU9THU5T8
 F66JB7wD6V81lM5HalvA+chzkzOcrs4zqi269N6YHU5G2OolHKkXIQGqpPSGVrIQdBGA
 kpgmgCUnx1nRUVvjGpc1k40IJMr7jDGy7nD7ETaFu7QEw0g9+askBS86Rca2cRUmzFNH xA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35vnw3jcw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 06:21:52 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105BCfHD001134;
        Tue, 5 Jan 2021 11:21:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 35tg3hheyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 11:21:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105BLjNT30146992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 11:21:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698F6AE051;
        Tue,  5 Jan 2021 11:21:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99C93AE045;
        Tue,  5 Jan 2021 11:21:47 +0000 (GMT)
Received: from localhost (unknown [9.85.82.253])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 11:21:47 +0000 (GMT)
Date:   Tue, 05 Jan 2021 16:51:50 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Disable multiple_kprobes test on
 powerpc
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        shuah@kernel.org
References: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
        <20210105191518.fc5e602cb10fb22ef1a2303d@kernel.org>
In-Reply-To: <20210105191518.fc5e602cb10fb22ef1a2303d@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1609845480.pjhqgleg8n.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 5 Jan 2021 19:01:56 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>=20
>> On Tue,  5 Jan 2021 12:27:30 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>=20
>> > Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
>> > test until that is sorted, so that rest of ftrace and kprobe selftests
>> > can be run.
>>=20
>> This looks good to me, but could you try to find the functions
>> which should be blocked from kprobes?
>> (Usually, the function which are involved in the sw-breakpoint
>>  handling, including locks etc.)
>=20
> Ah, OK.=20
> I wonder why CONFIG_KPROBE_EVENTS_ON_NOTRACE=3Dn doesn't help, it
> was ignored if the arch doesn't support CONFIG_KPROBES_ON_FTRACE.

Good point, though we do support CONFIG_KPROBES_ON_FTRACE on powerpc so=20
the below patch is unlikely to help. However, since entry code is=20
unlikely to be the source of the issue due to=20
CONFIG_KPROBE_EVENTS_ON_NOTRACE, I will take another look to see where=20
the problem lies.

>=20
> Naveen, could you try to run this test case with following patch
> on powerpc?
>=20
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index b911e9f6d9f5..241a55313476 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -433,7 +433,7 @@ static int disable_trace_kprobe(struct trace_event_ca=
ll *call,
>         return 0;
>  }
>=20
> -#if defined(CONFIG_KPROBES_ON_FTRACE) && \
> +#if defined(CONFIG_FUNCTION_TRACER) && \
>         !defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
>  static bool __within_notrace_func(unsigned long addr)
>  {
>=20

This looks like a good change regardless, so if you intend to post this=20
separately:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen

