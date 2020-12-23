Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD592E1DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgLWP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:26:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbgLWP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:26:42 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BNFD6XG145489;
        Wed, 23 Dec 2020 10:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=BQoM7V/Ioibi44I4VpkdVsX5sQhSQZwAfazieUxQWZU=;
 b=aVRS2XrMdhoiux/IbYbZIHMKwAlhvL6QfQJZloQ/v+I3u9GixbUtb5bIZvaMsOne0uiy
 ZjkX7MBQ0w0cUnSabnPpO+rTSPIBZ0cV9MI74KN+g1qL8XrPYfaW1UZGKvj+6xNHymhK
 OPs9PRyIfAUfj3n/Tx9vY5oRCHCa/i0f1j3zrrNCVMHlAoI4OHeyJUlmTx7uHaklY8jq
 wPVqUmkJu7k5FYfTHkUF32ERN9U7b9hfoWHeip1oIoFdjR21Y4/+agNq5EIXSRyCZrXI
 zctLuxh46agR6Qv/ngbteuOlnDinlB1daCLkY834faPA5SO0TQVaZbmaqpTio1tZSWwI /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35m8b7r8pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 10:25:06 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BNFDA3x145706;
        Wed, 23 Dec 2020 10:25:05 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35m8b7r8pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 10:25:05 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BNFDBng020061;
        Wed, 23 Dec 2020 15:25:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 35k906sf2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 15:25:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BNFP0tG24314332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 15:25:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 955BAA404D;
        Wed, 23 Dec 2020 15:25:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06712A4057;
        Wed, 23 Dec 2020 15:25:01 +0000 (GMT)
Received: from localhost (unknown [9.85.92.32])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Dec 2020 15:25:00 +0000 (GMT)
Date:   Wed, 23 Dec 2020 20:54:59 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
        <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
        <20201218112659.GB325926@kernel.org> <20201218113209.GD325926@kernel.org>
        <1608301824.eljlhiafee.naveen@linux.ibm.com>
        <20201221234755.GC433286@kernel.org>
In-Reply-To: <20201221234755.GC433286@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1608737054.bq8cv7ll62.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_07:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 18, 2020 at 08:08:56PM +0530, Naveen N. Rao escreveu:
>> Hi Arnaldo,
>>=20
>> Arnaldo Carvalho de Melo wrote:
>> > Em Fri, Dec 18, 2020 at 08:26:59AM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>> > > Em Fri, Dec 18, 2020 at 03:59:23PM +0800, Tiezhu Yang escreveu:
>> > > > This silences the following tools/perf/ build warning:
>> > > > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/sysca=
lls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscal=
ls/syscall.tbl'
>> > >=20
>> > > Hi Ravi, Naveen,
>> > >=20
>> > > 	Can I get your Reviewed-by or Acked-by for this change and the
>> > > other that adds s390's syscall.tbl to check_headers.sh so that we ge=
t
>> >=20
>> > oops s/s390/powerpc/g :-)
>> >=20
>> > > notified when the copy drifts, so that we can see if it still contin=
ues
>> > > working and we can get new syscalls to be supported in things like '=
perf
>> > > trace'?
>>=20
>> Yes, this looks good to me:
>> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>=20
>> FWIW, I had posted a similar patch back in April, but glad to have this =
go
>> in ;)
>> http://lkml.kernel.org/r/20200220063740.785913-1-naveen.n.rao@linux.vnet=
.ibm.com
>=20
> My bad :-\

No worries, thanks for checking on this one.

- Naveen

