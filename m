Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0252F27DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbhALF1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:27:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731814AbhALF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:27:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10C5CTX8009136;
        Tue, 12 Jan 2021 00:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=QuydjXo1EcdFzUAxxPb9MPnX+rR3blM/+PH80011SW0=;
 b=HgnaDnO9trNDcijXNQvY4pU+OGSgxIorvvP6J9fqlYlvLUwwn1smZsXWMdIxzPaocQXD
 GGhmABET/rG9wwvvAW6bvWF2QCvFCfgJdRCEVS+4n53vcrBHh9HHXerf78/cWNTTI/bo
 kYun9kcM474T2+w0ID7gPhfeg3OpJulWK0y6GuY5G6/egrN9w3H/NGfhbv2sYaCxzDn6
 8i77iF44xvXtgjsKxctrgIEkABmRSDZX80lUynuMgsrZ0WXQyEDjUZfNOE4sz8Z38g32
 UyajE0m5mAKjgy0tj/H4gwwIACiVDDTjC1l6Wz/SadsrNT1Ucjaxc6Wnf7yjo+Vs+6tT YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3615dx86yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 00:27:01 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10C5FnQF018684;
        Tue, 12 Jan 2021 00:27:01 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3615dx86y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 00:27:01 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10C5QwCK008065;
        Tue, 12 Jan 2021 05:26:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3604h98wky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 05:26:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10C5QuMa40304992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 05:26:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A29F4C044;
        Tue, 12 Jan 2021 05:26:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FC14C04A;
        Tue, 12 Jan 2021 05:26:54 +0000 (GMT)
Received: from [9.79.235.228] (unknown [9.79.235.228])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jan 2021 05:26:53 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH V4 0/6] Add the page size in the perf record (user tools)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20210105195752.43489-1-kan.liang@linux.intel.com>
Date:   Tue, 12 Jan 2021 10:54:43 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F170D59-1C3D-4719-BF51-9AC306DB862D@linux.vnet.ibm.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
To:     kan.liang@linux.intel.com
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_01:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-Jan-2021, at 1:27 AM, kan.liang@linux.intel.com wrote:
>=20
> From: Kan Liang <kan.liang@linux.intel.com>
>=20
> Changes since V3:
> - Rebase on top of acme's perf/core branch
>  commit c07b45a355ee ("perf record: Tweak "Lowering..." warning in =
record_opts__config_freq")
>=20
> Changes since V2:
> - Rebase on top of acme perf/core branch
>  commit eec7b53d5916 ("perf test: Make sample-parsing test aware of =
PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE")
> - Use unit_number__scnprintf() in get_page_size_name()
> - Emit warning about kernel not supporting the code page size =
sample_type bit
>=20
> Changes since V1:
> - Fix the compile warning with GCC 10
> - Add Acked-by from Namhyung Kim
>=20
> Current perf can report both virtual addresses and physical addresses,
> but not the page size. Without the page size information of the =
utilized
> page, users cannot decide whether to promote/demote large pages to
> optimize memory usage.
>=20
> The kernel patches have been merged into tip perf/core branch,
> commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 76a5433f95f3 ("perf/x86/intel: Support =
PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 4cb6a42e4c4b ("powerpc/perf: Support =
PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 995f088efebe ("perf/core: Add support for =
PERF_SAMPLE_CODE_PAGE_SIZE")
> commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned =
hugetlbfs")
>=20
> and Peter's perf/core branch
> commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
> commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
> commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
> commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
> commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() support")
>=20
> This patch set is to enable the page size support in user tools.

Hi Kan Liang,

I am trying to check this series on powerpc.=20

# perf mem --phys-data --data-page-size record <workload>

To my observation, some of the samples returned zero size and comes as =
=E2=80=99N/A=E2=80=99 in the perf report=20

# perf mem --phys-data --data-page-size report=20

For fetching the page size, though initially there was a weak function =
added ( as arch_perf_get_page_size ) here:=20

=
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf/core&id=3D51b646b2d9f84d6ff6300e3c1d09f2be4329a424

later I see it got removed here:=20

=
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf/core&id=3D8af26be062721e52eba1550caf50b712f774c5fd=20

I picked kernel changes from =
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git , or I am =
missing something ?

Thanks
Athira

>=20
> Kan Liang (3):
>  perf mem: Clean up output format
>  perf mem: Support data page size
>  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>=20
> Stephane Eranian (3):
>  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
>=20
> tools/perf/Documentation/perf-mem.txt     |   3 +
> tools/perf/Documentation/perf-record.txt  |   3 +
> tools/perf/Documentation/perf-report.txt  |   1 +
> tools/perf/Documentation/perf-script.txt  |   2 +-
> tools/perf/builtin-mem.c                  | 111 +++++++++++-----------
> tools/perf/builtin-record.c               |   2 +
> tools/perf/builtin-script.c               |  13 ++-
> tools/perf/tests/sample-parsing.c         |   4 +
> tools/perf/util/event.h                   |   1 +
> tools/perf/util/evsel.c                   |  18 +++-
> tools/perf/util/evsel.h                   |   1 +
> tools/perf/util/hist.c                    |   2 +
> tools/perf/util/hist.h                    |   1 +
> tools/perf/util/perf_event_attr_fprintf.c |   2 +-
> tools/perf/util/record.h                  |   1 +
> tools/perf/util/session.c                 |   3 +
> tools/perf/util/sort.c                    |  26 +++++
> tools/perf/util/sort.h                    |   2 +
> tools/perf/util/synthetic-events.c        |   8 ++
> 19 files changed, 144 insertions(+), 60 deletions(-)
>=20
> --=20
> 2.25.1
>=20
>=20
>=20

