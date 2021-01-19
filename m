Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14702FB85C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbhASMXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:23:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392570AbhASMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:17:11 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10JC1tOi185260;
        Tue, 19 Jan 2021 07:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=lhyYMLBH8WMYu1Adh0A4CMlwl59TXMf82mJZpTLFbcA=;
 b=Vh+zx5i5A6x1BCwfdVuT/G8/qn6oGSBqsnucyVzTFfnUTdOLWPJm544wB8bbV34MzvR9
 h9a4qQ1HaNBqbP3JB81/3F4YtUjD1L3S0JjxXH5LaAsiWmiWJpFqJY/NQxaQKkONNIzF
 krjYhpqB4/1zVlOzSmZ7AmuP9FHTAEgt6G0/mW3I6auGpq7KzIe/sBYw+c6LQ9BHMCMy
 mxYCmk9jRO6IxsNlNl6JWQRbTxN3bEJ6WFTeOMCipZ37I1Dheml+yJUcVK3Rl0s7oRWC
 Js9oq4HUKxVAERSYxs4YuzitkQH1dKUzxnqskt/YJWE/1Nak9ZxwWkZUcHhwYtT6T+72 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365xwq8ph8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 07:16:16 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10JCGFAb058199;
        Tue, 19 Jan 2021 07:16:15 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365xwq8pgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 07:16:15 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10JC2hCV009141;
        Tue, 19 Jan 2021 12:16:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 363qs8b1n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 12:16:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10JCGAcg7668076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 12:16:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C52C6AE053;
        Tue, 19 Jan 2021 12:16:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31D8BAE055;
        Tue, 19 Jan 2021 12:16:07 +0000 (GMT)
Received: from [9.79.225.157] (unknown [9.79.225.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jan 2021 12:16:06 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH V4 0/6] Add the page size in the perf record (user tools)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1f45cebf-1f89-2c4c-f2b3-dbdb623576ae@linux.intel.com>
Date:   Tue, 19 Jan 2021 17:46:04 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au, Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D84F9EA2-7BA9-41F2-9827-7C8AB64360F6@linux.vnet.ibm.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
 <0F170D59-1C3D-4719-BF51-9AC306DB862D@linux.vnet.ibm.com>
 <1f45cebf-1f89-2c4c-f2b3-dbdb623576ae@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_02:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13-Jan-2021, at 12:43 AM, Liang, Kan <kan.liang@linux.intel.com> =
wrote:
>=20
>=20
>=20
> On 1/12/2021 12:24 AM, Athira Rajeev wrote:
>>> On 06-Jan-2021, at 1:27 AM, kan.liang@linux.intel.com wrote:
>>>=20
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>=20
>>> Changes since V3:
>>> - Rebase on top of acme's perf/core branch
>>>  commit c07b45a355ee ("perf record: Tweak "Lowering..." warning in =
record_opts__config_freq")
>>>=20
>>> Changes since V2:
>>> - Rebase on top of acme perf/core branch
>>>  commit eec7b53d5916 ("perf test: Make sample-parsing test aware of =
PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE")
>>> - Use unit_number__scnprintf() in get_page_size_name()
>>> - Emit warning about kernel not supporting the code page size =
sample_type bit
>>>=20
>>> Changes since V1:
>>> - Fix the compile warning with GCC 10
>>> - Add Acked-by from Namhyung Kim
>>>=20
>>> Current perf can report both virtual addresses and physical =
addresses,
>>> but not the page size. Without the page size information of the =
utilized
>>> page, users cannot decide whether to promote/demote large pages to
>>> optimize memory usage.
>>>=20
>>> The kernel patches have been merged into tip perf/core branch,
>>> commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
>>> commit 76a5433f95f3 ("perf/x86/intel: Support =
PERF_SAMPLE_DATA_PAGE_SIZE")
>>> commit 4cb6a42e4c4b ("powerpc/perf: Support =
PERF_SAMPLE_DATA_PAGE_SIZE")
>>> commit 995f088efebe ("perf/core: Add support for =
PERF_SAMPLE_CODE_PAGE_SIZE")
>>> commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned =
hugetlbfs")
>>>=20
>>> and Peter's perf/core branch
>>> commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
>>> commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
>>> commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
>>> commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
>>> commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() =
support")
>>>=20
>>> This patch set is to enable the page size support in user tools.
>> Hi Kan Liang,
>> I am trying to check this series on powerpc.
>> # perf mem --phys-data --data-page-size record <workload>
>> To my observation, some of the samples returned zero size and comes =
as =E2=80=99N/A=E2=80=99 in the perf report
>> # perf mem --phys-data --data-page-size report
>> For fetching the page size, though initially there was a weak =
function added ( as arch_perf_get_page_size ) here:
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf/core&id=3D51b646b2d9f84d6ff6300e3c1d09f2be4329a424
>> later I see it got removed here:
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf/core&id=3D8af26be062721e52eba1550caf50b712f774c5fd
>> I picked kernel changes from =
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git , or I am =
missing something ?
>=20
> I believe all the kernel changes have been merged.
>=20
> According to the commit message of the recent changes, only Power/8xxx =
is supported for power for now. I guess that may be the reason of some =
'N/A's.
> https://lore.kernel.org/patchwork/cover/1345521/

Thanks for clarifying.=20
For tools side changes, other than =E2=80=99N/A=E2=80=99 in the perf =
report which I got, I verified the --data-page-size option for perf mem =
record and mem report.

For tools-side changes,
Tested-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>

Thanks
Athira
>=20
> Thanks,
> Kan
>=20
>=20
>> Thanks
>> Athira
>>>=20
>>> Kan Liang (3):
>>>  perf mem: Clean up output format
>>>  perf mem: Support data page size
>>>  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>>=20
>>> Stephane Eranian (3):
>>>  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>>  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>>  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
>>>=20
>>> tools/perf/Documentation/perf-mem.txt     |   3 +
>>> tools/perf/Documentation/perf-record.txt  |   3 +
>>> tools/perf/Documentation/perf-report.txt  |   1 +
>>> tools/perf/Documentation/perf-script.txt  |   2 +-
>>> tools/perf/builtin-mem.c                  | 111 =
+++++++++++-----------
>>> tools/perf/builtin-record.c               |   2 +
>>> tools/perf/builtin-script.c               |  13 ++-
>>> tools/perf/tests/sample-parsing.c         |   4 +
>>> tools/perf/util/event.h                   |   1 +
>>> tools/perf/util/evsel.c                   |  18 +++-
>>> tools/perf/util/evsel.h                   |   1 +
>>> tools/perf/util/hist.c                    |   2 +
>>> tools/perf/util/hist.h                    |   1 +
>>> tools/perf/util/perf_event_attr_fprintf.c |   2 +-
>>> tools/perf/util/record.h                  |   1 +
>>> tools/perf/util/session.c                 |   3 +
>>> tools/perf/util/sort.c                    |  26 +++++
>>> tools/perf/util/sort.h                    |   2 +
>>> tools/perf/util/synthetic-events.c        |   8 ++
>>> 19 files changed, 144 insertions(+), 60 deletions(-)
>>>=20
>>> --=20
>>> 2.25.1

