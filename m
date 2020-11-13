Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB42B1784
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKMIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:48:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:48:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8XTTI178842;
        Fri, 13 Nov 2020 03:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=36cbtDi4un8/lEh3q2ASAd6pMgDUdwExHeVKQP5zaTg=;
 b=ERgPGb/jQbM1hYojMW6q/Bl9E6vjV7b9yQsOTKBErYIFacqXM8NvVfuoDrqXw4GT8Hxj
 BBiF57As8tS6X2FGyWEiMhiFNQyKIWnvghKGFVlF+htnK/1H+pDA+OOQt+FO6PmLY2PM
 tUzRUNnoQs+APoboZqolfpzmUeEWA/rCssv98mcJk9OSI/eeyApQe+Z+/9/zV+uaaVJ3
 POPDxfZ4PmO8gS5eLLHgx69QRJk8qRiwLGSqbBKQNSi+P71Vyhel3JXsU83kIkuYSMfQ
 z2nnyaZiIFgG30WTqjbcL/b/IofNLEOp/HzhvIUJqrLncpD5QyXVsVovaa5rsNGinzCx Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sm064d27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 03:48:32 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AD8dtsn005658;
        Fri, 13 Nov 2020 03:48:31 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sm064d1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 03:48:31 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8mImk030589;
        Fri, 13 Nov 2020 08:48:30 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 34nk7b5n3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 08:48:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AD8mTEJ53477702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 08:48:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D567805F;
        Fri, 13 Nov 2020 08:48:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC7F378064;
        Fri, 13 Nov 2020 08:48:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.102.143])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 13 Nov 2020 08:48:21 +0000 (GMT)
Subject: Re: [PATCH RFC v5 01/13] perf jevents: Add support for an extra
 directory level
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        will@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        irogers@google.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qiangqing.zhang@nxp.com,
        zhangshaokun@hisilicon.com, linux-imx@nxp.com
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
 <1604666153-4187-2-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <61c23ae8-73d4-4616-38f5-f81dafbf5851@linux.ibm.com>
Date:   Fri, 13 Nov 2020 14:18:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1604666153-4187-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_05:2020-11-12,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/20 6:05 PM, John Garry wrote:
> Currently only upto a level 2 directory is supported, in form
> vendor/platform.

Hi John,
    Just want to check in case of sub directories,
Will it be good add on/feasible to be able to include events of particular sub-directory for a
platform? Otherwise with this patch in the end all event will be part of
same pmu_event structure. So what is the purpose of sub directories? Let me know if I am missing something.

Thanks,
Kajol Jain
> 
> Add support for a further level, to support vendor/platform
> sub-directories in future.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/jevents.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 72cfa3b5046d..9022216b1253 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -978,15 +978,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>  	int level   = ftwbuf->level;
>  	int err = 0;
>  
> -	if (level == 2 && is_dir) {
> +	if (level >= 2 && is_dir) {
> +		int count = 0;
>  		/*
>  		 * For level 2 directory, bname will include parent name,
>  		 * like vendor/platform. So search back from platform dir
>  		 * to find this.
> +		 * Something similar for level 3 directory, but we're a PMU
> +		 * category folder, like vendor/platform/cpu.
>  		 */
>  		bname = (char *) fpath + ftwbuf->base - 2;
>  		for (;;) {
>  			if (*bname == '/')
> +				count++;
> +			if (count == level - 1)
>  				break;
>  			bname--;
>  		}
> @@ -999,13 +1004,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>  		 level, sb->st_size, bname, fpath);
>  
>  	/* base dir or too deep */
> -	if (level == 0 || level > 3)
> +	if (level == 0 || level > 4)
>  		return 0;
>  
>  
>  	/* model directory, reset topic */
>  	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
> -	    (level == 2 && is_dir)) {
> +	    (level >= 2 && is_dir && is_leaf_dir(fpath))) {
>  		if (close_table)
>  			print_events_table_suffix(eventsfp);
>  
> 
