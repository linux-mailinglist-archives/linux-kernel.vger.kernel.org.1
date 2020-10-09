Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE92887CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbgJIL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:27:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731442AbgJIL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:27:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099B3c1k119694;
        Fri, 9 Oct 2020 07:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+gUJK0zH62vROwFwAyGDCYUlInBCWB3latI7AND8UaQ=;
 b=aAR/ZhWeOWqp8jy2QgwxXRc613eFG67mo9TYmSmLfLsZkFBwrcJ1Vy7cpKkCWLoBlgRJ
 iA748WNAK6ey+C7rwZUSlOOjEshFG46lq85djKhLvNYwIIsqPiaZsqFZ0Qn4tb7Ym/bD
 yHXfPCQf8Rjzt3FwVuDpIGx6GZeOIBr3u0Q3ix4C3zg/LQGiS2F/QXXwIUeDJwF6aPcx
 d1VSAa3sM8tY1EI7wZOE7T9lDUeYCdPEXKk+daG2+Xzg3ENR8UOgHA+IUYbWanqtjhST
 JqOnNrBMAR2LJq/aHpmzfencEaiCfYjZKs153MM/GBfDzBn4oui63bzNOShkjN4LPzUP xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342pjbgt4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 07:26:55 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099BG8aw006340;
        Fri, 9 Oct 2020 07:26:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342pjbgt46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 07:26:54 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099BBZlV016772;
        Fri, 9 Oct 2020 11:26:53 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3429hq61ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 11:26:53 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099BQqwZ15205128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 11:26:52 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B40AE063;
        Fri,  9 Oct 2020 11:26:52 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221F9AE05C;
        Fri,  9 Oct 2020 11:26:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.32.205])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 11:26:46 +0000 (GMT)
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, yao.jin@linux.intel.com,
        yeyunfeng@huawei.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        =linux-arm-kernel@lists.infradead.org
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <a7cbb1f7-1f7f-6bf9-6acf-fd5455aadd82@linux.ibm.com>
Date:   Fri, 9 Oct 2020 16:56:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=2 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/20 8:49 PM, John Garry wrote:
> The event code for events referencing std arch events is incorrectly
> evaluated in json_events().
> 
> The issue is that je.event is evaluated properly from try_fixup(), but
> later NULLified from the real_event() call, as "event" may be NULL.
> 
> Fix by setting "event" same je.event in try_fixup().
> 
> Also remove support for overwriting event code for events using std arch
> events, as it is not used.

Patch looks good to me. Not sure if any adding any example with this issue
is helpful.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 99df41a9543d..e47644cab3fa 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
>  }
>  
>  static int
> -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> -	  struct json_event *je)
> +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
>  {
>  	/* try to find matching event from arch standard values */
>  	struct event_struct *es;
>  
>  	list_for_each_entry(es, &arch_std_events, list) {
>  		if (!strcmp(arch_std, es->name)) {
> -			if (!eventcode && es->event) {
> -				/* allow EventCode to be overridden */
> -				free(je->event);
> -				je->event = NULL;
> -			}
>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> +			*event = je->event;
>  			return 0;
>  		}
>  	}
> @@ -678,7 +673,7 @@ static int json_events(const char *fn,
>  			 * An arch standard event is referenced, so try to
>  			 * fixup any unassigned values.
>  			 */
> -			err = try_fixup(fn, arch_std, eventcode, &je);
> +			err = try_fixup(fn, arch_std, &je, &event);
>  			if (err)
>  				goto free_strings;
>  		}
> 
