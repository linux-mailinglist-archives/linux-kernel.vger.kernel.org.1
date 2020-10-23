Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAEA296A96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375891AbgJWHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:49:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27520 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374807AbgJWHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:49:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N7Xu6e138770;
        Fri, 23 Oct 2020 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YIgPuULYzgYnifDJDYtPA0RbSOSIjx/ZcmFBBnC/DdU=;
 b=W3boak6QaMD/5A0xokRlQdVPhETZonfX9Gu2iKTfaL6pHjE9llL8ENUuAMibkBDtloUk
 XmFJJBGVEMXBR+wvWRVTmzN3pME5/Ziw1giYzIObOJFnAHaEWEahm2Qya3A0roiTBD/Z
 8f0a7Rk0HVqjOcw4hqf+OQBdteW9l163moIu1y+t0lT346K+9sVz3m/OexvuKYmSEa/G
 aW3aooHBc77mTLT6yJjD1uVo+nDsSYSixTwvDJNtmtjL6r/LXNNGYhe9bt01RkwRfIdf
 S7HUtGMkYUsUnYHc9A+yt5KN77/CecKAKwQnckkK+6r7EEt3E02ifTPhZ6reKA03hugw 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34bcaphn3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 03:49:35 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09N7ZfQ4143959;
        Fri, 23 Oct 2020 03:49:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34bcaphn3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 03:49:35 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N7nPLg001807;
        Fri, 23 Oct 2020 07:49:34 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 347r89emjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 07:49:34 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N7nYlx38142378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 07:49:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14363AE062;
        Fri, 23 Oct 2020 07:49:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C18CAE05C;
        Fri, 23 Oct 2020 07:49:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.49.224])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Oct 2020 07:49:28 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] perf jevents: Tidy error handling
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, yao.jin@linux.intel.com,
        yeyunfeng@huawei.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
 <1603364547-197086-2-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <58c219e5-78a9-be21-4942-b6ba9d21d467@linux.ibm.com>
Date:   Fri, 23 Oct 2020 13:19:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1603364547-197086-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_03:2020-10-20,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=2
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/20 4:32 PM, John Garry wrote:
> There is much duplication in the error handling for directory transvering
> for prcessing JSONs.
> 
> Factor out the common code to tidy a bit.
> 

Patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/jevents.c | 83 ++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index e47644cab3fa..7326c14c4623 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -1100,12 +1100,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>   */
>  int main(int argc, char *argv[])
>  {
> -	int rc, ret = 0;
> +	int rc, ret = 0, empty_map = 0;
>  	int maxfds;
>  	char ldirname[PATH_MAX];
>  	const char *arch;
>  	const char *output_file;
>  	const char *start_dirname;
> +	char *err_string_ext = "";
>  	struct stat stbuf;
>  
>  	prog = basename(argv[0]);
> @@ -1133,7 +1134,8 @@ int main(int argc, char *argv[])
>  	/* If architecture does not have any event lists, bail out */
>  	if (stat(ldirname, &stbuf) < 0) {
>  		pr_info("%s: Arch %s has no PMU event lists\n", prog, arch);
> -		goto empty_map;
> +		empty_map = 1;
> +		goto err_close_eventsfp;
>  	}
>  
>  	/* Include pmu-events.h first */
> @@ -1150,75 +1152,60 @@ int main(int argc, char *argv[])
>  	 */
>  
>  	maxfds = get_maxfds();
> -	mapfile = NULL;
>  	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
> -	if (rc && verbose) {
> -		pr_info("%s: Error preprocessing arch standard files %s\n",
> -			prog, ldirname);
> -		goto empty_map;
> -	} else if (rc < 0) {
> -		/* Make build fail */
> -		fclose(eventsfp);
> -		free_arch_std_events();
> -		return 1;
> -	} else if (rc) {
> -		goto empty_map;
> -	}
> +	if (rc)
> +		goto err_processing_std_arch_event_dir;
>  
>  	rc = nftw(ldirname, process_one_file, maxfds, 0);
> -	if (rc && verbose) {
> -		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
> -		goto empty_map;
> -	} else if (rc < 0) {
> -		/* Make build fail */
> -		fclose(eventsfp);
> -		free_arch_std_events();
> -		ret = 1;
> -		goto out_free_mapfile;
> -	} else if (rc) {
> -		goto empty_map;
> -	}
> +	if (rc)
> +		goto err_processing_dir;
>  
>  	sprintf(ldirname, "%s/test", start_dirname);
>  
>  	rc = nftw(ldirname, process_one_file, maxfds, 0);
> -	if (rc && verbose) {
> -		pr_info("%s: Error walking file tree %s rc=%d for test\n",
> -			prog, ldirname, rc);
> -		goto empty_map;
> -	} else if (rc < 0) {
> -		/* Make build fail */
> -		free_arch_std_events();
> -		ret = 1;
> -		goto out_free_mapfile;
> -	} else if (rc) {
> -		goto empty_map;
> -	}
> +	if (rc)
> +		goto err_processing_dir;
>  
>  	if (close_table)
>  		print_events_table_suffix(eventsfp);
>  
>  	if (!mapfile) {
>  		pr_info("%s: No CPU->JSON mapping?\n", prog);
> -		goto empty_map;
> +		empty_map = 1;
> +		goto err_close_eventsfp;
>  	}
>  
> -	if (process_mapfile(eventsfp, mapfile)) {
> +	rc = process_mapfile(eventsfp, mapfile);
> +	fclose(eventsfp);
> +	if (rc) {
>  		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
>  		/* Make build fail */
> -		fclose(eventsfp);
> -		free_arch_std_events();
>  		ret = 1;
> +		goto err_out;
>  	}
>  
> +	free_arch_std_events();
> +	free(mapfile);
> +	return 0;
>  
> -	goto out_free_mapfile;
> -
> -empty_map:
> +err_processing_std_arch_event_dir:
> +	err_string_ext = " for std arch event";
> +err_processing_dir:
> +	if (verbose) {
> +		pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
> +			err_string_ext);
> +		empty_map = 1;
> +	} else if (rc < 0) {
> +		ret = 1;
> +	} else {
> +		empty_map = 1;
> +	}
> +err_close_eventsfp:
>  	fclose(eventsfp);
> -	create_empty_mapping(output_file);
> +	if (empty_map)
> +		create_empty_mapping(output_file);
> +err_out:
>  	free_arch_std_events();
> -out_free_mapfile:
>  	free(mapfile);
>  	return ret;
>  }
> 
