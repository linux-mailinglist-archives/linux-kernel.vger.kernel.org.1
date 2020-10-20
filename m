Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C733729368B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbgJTIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:15:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387546AbgJTIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:15:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K81qwV005935;
        Tue, 20 Oct 2020 04:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aCB9TXIhILyunqqd/Q2+KsybLjU1sdD+0hm6Re3a0x8=;
 b=LGSuxCNm8EjoJQ9W+HU+oe1EF1Ln9Ua/HnL6AMzUJ3kJrFFNxIjVGBqvleqT9Nu6/fQ8
 HVN/rRsThyn+qDAiidc55Tu4z0OHthoC1ozpzVaHZYKHbQi3+0ZWapTqb58r4c0uJm2L
 iUfC1ggJSoBGIj/suPsUza47ISLvwfqKUk+JmuyOPq6DZ1lusKRGVuiv/bCmd2OVe543
 uhxCmXTjOTGfxuBCcM4o5LIM9+nO9LhlQoM7/htJjRJ+VglMICb5x0trdeQgc8cnpuEX
 vIl3oSmO9VM6tBBQv/ix5XVbGG5+Eqi4p4DIaj+5q87yfjNsjwozcGATw9D5mOcOxib6 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349u4928an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 04:15:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09K82OaS008711;
        Tue, 20 Oct 2020 04:15:00 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349u49289h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 04:14:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09K8Cqtk014692;
        Tue, 20 Oct 2020 08:14:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 347r88x8mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 08:14:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09K8EvgP57082336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 08:14:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F82C6057;
        Tue, 20 Oct 2020 08:14:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0B43C6066;
        Tue, 20 Oct 2020 08:14:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.175])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Oct 2020 08:14:52 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf jevents: Tidy error handling
To:     Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Yao Jin <yao.jin@linux.intel.com>, yeyunfeng@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
 <1603121908-53543-2-git-send-email-john.garry@huawei.com>
 <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <eb3073cd-7184-58f3-f03f-b094abaff007@linux.ibm.com>
Date:   Tue, 20 Oct 2020 13:44:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_03:2020-10-16,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/20 11:13 AM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Oct 20, 2020 at 12:42 AM John Garry <john.garry@huawei.com> wrote:
>>
>> There is much duplication in the error handling for directory traversing
>> for processing JSONs.
>>
>> Factor out the common code to tidy a bit.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
> [SNIP]
>> -empty_map:
>> +err_processing_std_arch_event_dir:
>> +       err_string_ext = " for std arch event";
>> +err_processing_dir:
>> +       if (verbose || rc > 0) {
>> +               pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
>> +                       err_string_ext);
> 
> This was printed only if verbose is set but now changed.

Hi John,
   Yes I agree with Namhyung.
So, this is our original checks

if (rc && verbose) {
		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
		goto empty_map;
	} else if (rc < 0) {
		/* Make build fail */
		fclose(eventsfp);
		free_arch_std_events();
		ret = 1;
		goto out_free_mapfile;
	} else if (rc) {
		goto empty_map;
	}

May be we can use similar checks:

if( verbose)
  pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,err_string_ext);
if(rc > 0)
   empty_map = 1;
else
  ret = 1;

Thanks,
Kajol Jain
  
> 
> Thanks
> Namhyung
> 
> 
>> +               empty_map = 1;
>> +       } else {
>> +               ret = 1;
>> +       }
>> +err_close_eventsfp:
>>         fclose(eventsfp);
>> -       create_empty_mapping(output_file);
>> +       if (empty_map)
>> +               create_empty_mapping(output_file);
>> +err_out:
>>         free_arch_std_events();
>> -out_free_mapfile:
>>         free(mapfile);
>>         return ret;
>>  }
>> --
>> 2.26.2
>>
