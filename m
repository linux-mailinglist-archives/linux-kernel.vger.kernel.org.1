Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9F29E1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgJ1Vsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:48:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbgJ1Vhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S9Wgu7144314;
        Wed, 28 Oct 2020 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : references : in-reply-to : mime-version : message-id : content-type :
 content-transfer-encoding; s=pp1;
 bh=psd+OHOYF3+Ht8DKGiCudqcblb2fJY5VAJYYFPUhkHQ=;
 b=mFpdcx3ziyU5ny6V/yGm0RZYgbXV2bPVwYzmmCSyRN/aWTIQhmWNg8C7A/uDQnPbTbnb
 E3KMuZpkpkLw4nvXIy3jaMG0xQe2iswZi0BtZB4FcZ5ThemBNQWsSvFuCh2qPtpp4Sxh
 5FGsoUvi8NNbFOqZXrEKXgIUcHz0tE/LpRYXjYSXbKw0h3b2TI0WFl/sFg8W4J4VAb8d
 I9GhWGVt0rntE+NJfSqhxKDzXdBRlBS7z3xEhgNgYY5AwjnnSkqnB2+khi6V3azYZk78
 sQOCDDwCqC5rbpA0MdQ50ddk+p8yb2G0dbJVU7kA/dzmnzQvDYD++TX00LY3ZPxM1lSE 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34endjnpv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 05:35:10 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09S9XDcj149347;
        Wed, 28 Oct 2020 05:35:09 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34endjnptv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 05:35:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09S9XCKb022906;
        Wed, 28 Oct 2020 09:35:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 34cbhh4a87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 09:35:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09S9Z5qG22151652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 09:35:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F225AE051;
        Wed, 28 Oct 2020 09:35:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD520AE055;
        Wed, 28 Oct 2020 09:35:04 +0000 (GMT)
Received: from localhost (unknown [9.102.2.144])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 09:35:04 +0000 (GMT)
Date:   Wed, 28 Oct 2020 15:05:03 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 8/9] perf mem: Return NULL for event 'ldst' on PowerPC
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <Al.Grant@arm.com>,
        =?iso-8859-1?b?QW5kcuk=?= Przywara <andre.przywara@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20201028063813.8562-1-leo.yan@linaro.org>
        <20201028063813.8562-9-leo.yan@linaro.org>
In-Reply-To: <20201028063813.8562-9-leo.yan@linaro.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1603877629.hjro28ddup.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_04:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Maddy]

Leo Yan wrote:
> If user specifies event type "ldst", PowerPC's perf_mem_events__name()
> will wrongly return the store event name "cpu/mem-stores/".
>=20
> This patch changes to return NULL for the event "ldst" on PowerPC.
>=20
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/powerpc/util/mem-events.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/=
powerpc/util/mem-events.c
> index 07fb5e049488..90c5a0760685 100644
> --- a/tools/perf/arch/powerpc/util/mem-events.c
> +++ b/tools/perf/arch/powerpc/util/mem-events.c
> @@ -7,6 +7,8 @@ char *perf_mem_events__name(int i)
>  {
>  	if (i =3D=3D PERF_MEM_EVENTS__LOAD)
>  		return (char *) "cpu/mem-loads/";
> -
> -	return (char *) "cpu/mem-stores/";
> +	else if (i =3D=3D PERF_MEM_EVENTS__STORE)
> +		return (char *) "cpu/mem-stores/";
> +	else
> +		return NULL;
>  }
> --=20
> 2.17.1
>=20
>=20
