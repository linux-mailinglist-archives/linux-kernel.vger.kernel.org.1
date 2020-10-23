Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4931296AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369880AbgJWH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:57:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896937AbgJWH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:57:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N7c1OX028360;
        Fri, 23 Oct 2020 03:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uaq+VlNOGuAN/hj0SDjgAd94+zuOdR736ZcpTgyYVcI=;
 b=Dpb4EAH+yCBFrh1lu9QKGLeY51f155CDEQf/gzEILcEnLL4NbZMmO9YOvxxElIcEj3Jp
 JgX1dEa8yCwgOJBsH7VpKLyiJTBxv/NAlY4UDbLfpgFI5+pmTXV9RHoJT9y2Dbwb1qPp
 05htiGr/8KTCmdKwgbXM9AjZJIKYB4fpN9qXda4s36O5T0tN1h5Xnr1JJO8yX3JIwr1b
 /hGktAEgWg1TJm2VAuQ1H/+siBQZv+79rJnjslZQtVBC1NGG/a+mLNgFOmzSsK2H4fJd
 pS/DMfHCQtK8yUuoCr+ObkEif5s92MkH4xZ17llnFMUzo3Cvr6REf5BU50i+XCtiD6vH hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34b73rnvrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 03:57:17 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09N7bbJb026897;
        Fri, 23 Oct 2020 03:57:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34b73rnvr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 03:57:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N7q5sD013257;
        Fri, 23 Oct 2020 07:57:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 347r8a2mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 07:57:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N7vF8T27066636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 07:57:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94892AE05F;
        Fri, 23 Oct 2020 07:57:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45517AE05C;
        Fri, 23 Oct 2020 07:57:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.49.224])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Oct 2020 07:57:10 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] perf jevents: Add test for arch std events
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, yao.jin@linux.intel.com,
        yeyunfeng@huawei.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
 <1603364547-197086-3-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <1f54b1c5-e788-57f1-b2d4-c0d33af85f00@linux.ibm.com>
Date:   Fri, 23 Oct 2020 13:27:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1603364547-197086-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_03:2020-10-20,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/20 4:32 PM, John Garry wrote:
> Recently there was an undetected breakage for std arch event support.
> 
> Add support in "PMU events" testcase to detect such breakages.
> 
> For this, the "test" arch needs has support added to process std arch
> events. And a test event is added for the test, ifself.
> 
> Also add a few code comments to help understand the code a bit better.

Patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  .../perf/pmu-events/arch/test/arch-std-events.json |  8 ++++++++
>  .../perf/pmu-events/arch/test/test_cpu/cache.json  |  5 +++++
>  tools/perf/pmu-events/jevents.c                    |  4 ++++
>  tools/perf/tests/pmu-events.c                      | 14 ++++++++++++++
>  4 files changed, 31 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
>  create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json
> 
> diff --git a/tools/perf/pmu-events/arch/test/arch-std-events.json b/tools/perf/pmu-events/arch/test/arch-std-events.json
> new file mode 100644
> index 000000000000..43f6f729d6ae
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/test/arch-std-events.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "PublicDescription": "Attributable Level 3 cache access, read",
> +        "EventCode": "0x40",
> +        "EventName": "L3_CACHE_RD",
> +        "BriefDescription": "L3 cache access, read"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/cache.json b/tools/perf/pmu-events/arch/test/test_cpu/cache.json
> new file mode 100644
> index 000000000000..036d0efdb2bb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/test/test_cpu/cache.json
> @@ -0,0 +1,5 @@
> +[
> +    {
> +	 "ArchStdEvent": "L3_CACHE_RD"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 7326c14c4623..72cfa3b5046d 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -1162,6 +1162,10 @@ int main(int argc, char *argv[])
>  
>  	sprintf(ldirname, "%s/test", start_dirname);
>  
> +	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
> +	if (rc)
> +		goto err_processing_std_arch_event_dir;
> +
>  	rc = nftw(ldirname, process_one_file, maxfds, 0);
>  	if (rc)
>  		goto err_processing_dir;
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d3517a74d95e..ad2b21591275 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -14,8 +14,10 @@
>  #include "util/parse-events.h"
>  
>  struct perf_pmu_test_event {
> +	/* used for matching against events from generated pmu-events.c */
>  	struct pmu_event event;
>  
> +	/* used for matching against event aliases */
>  	/* extra events for aliases */
>  	const char *alias_str;
>  
> @@ -78,6 +80,17 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>  		.alias_str = "umask=0,(null)=0x30d40,event=0x3a",
>  		.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>  	},
> +	{
> +		.event = {
> +			.name = "l3_cache_rd",
> +			.event = "event=0x40",
> +			.desc = "L3 cache access, read",
> +			.long_desc = "Attributable Level 3 cache access, read",
> +			.topic = "cache",
> +		},
> +		.alias_str = "event=0x40",
> +		.alias_long_desc = "Attributable Level 3 cache access, read",
> +	},
>  	{ /* sentinel */
>  		.event = {
>  			.name = NULL,
> @@ -357,6 +370,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>  }
>  
>  
> +/* Test that aliases generated are as expected */
>  static int test_aliases(void)
>  {
>  	struct perf_pmu *pmu = NULL;
> 
