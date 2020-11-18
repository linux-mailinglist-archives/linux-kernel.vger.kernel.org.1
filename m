Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2971A2B756C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKREjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:39:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgKREjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:39:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AI4Vjkf169891;
        Tue, 17 Nov 2020 23:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mMN/I+ULrLZLhfR9hdqq7ovhu7Y8pk43iPxX5Uo59jI=;
 b=XEaBE3Gq3ZY2c3X0uhgaNizMMBLwXWl1FkmOk0udmCjoqeEQwSV9Y4FXXStSkpKJ1cH/
 IGTsdh+cWabDtM27IzSXZMqLQMR+eCmOnRgoFiTQaulJE3gjxIEawX74QdHgercJEWQX
 ApdONh+EG1Vn6qMwG4mcA20DscHMpZcq1oCjhvNhSxF4Rf6q6UmC0oxoqlXK4vEauoAp
 l2y/femdlQT1067uPhycSyhCMNXNo6m+wZs7qUYSn5qAiReQnJymSO8dpx0aNPPVKTsP
 U/4SuGtBLJbtl+AM9rPV/JXKao5S2z8mk+RpSfE47jZj/oQbsysLExjRS2oWzQte8z1i ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34vevtrc5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 23:38:42 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AI4WqJY176208;
        Tue, 17 Nov 2020 23:38:41 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34vevtrc4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 23:38:41 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AI4WfOE005455;
        Wed, 18 Nov 2020 04:38:40 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 34uttrf5ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 04:38:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AI4cch660162546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 04:38:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B68A36E056;
        Wed, 18 Nov 2020 04:38:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2207C6E050;
        Wed, 18 Nov 2020 04:38:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.39.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Nov 2020 04:38:32 +0000 (GMT)
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
 <61c23ae8-73d4-4616-38f5-f81dafbf5851@linux.ibm.com>
 <3ca35e0f-e5e6-8616-0435-0f8e553df1f9@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <03f4d625-1430-8b2e-7798-8de657b4141c@linux.ibm.com>
Date:   Wed, 18 Nov 2020 10:08:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3ca35e0f-e5e6-8616-0435-0f8e553df1f9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_01:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180026
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/20 2:54 PM, John Garry wrote:
> On 13/11/2020 08:48, kajoljain wrote:
>>
>> On 11/6/20 6:05 PM, John Garry wrote:
>>> Currently only upto a level 2 directory is supported, in form
>>> vendor/platform.
>> Hi John,
>>      Just want to check in case of sub directories,
>> Will it be good add on/feasible to be able to include events of particular sub-directory for a
>> platform? Otherwise with this patch in the end all event will be part of
>> same pmu_event structure. So what is the purpose of sub directories? Let me know if I am missing something.
> 
> Hi Kajol Jain,
> 
> So currently we support both of the following structure:
> arch/platform
> arch/vendor/platform/
> 
> arch/vendor/platform/ is for an arch like arm, where the arch provider may not be the vendor.
> 
> I want to go one step further, to support also:
> arch/vendor/platform/cpu
> arch/vendor/platform/sys
> 
> Here we have separate folders for cpu and sys events. CPU events in "cpu" folder are added to pmu_events_map[], as before. And events in "sys" folder are added from patch 2/13 to new table pmu_sys_events_table[].
> 
> I hope it's clearer now.

Hi John,
    Thanks for explaining. This patch looks good to me then.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Thanks,
> John
> 
>>
>> Thanks,
>> Kajol Jain
>>> Add support for a further level, to support vendor/platform
>>> sub-directories in future.
> 
