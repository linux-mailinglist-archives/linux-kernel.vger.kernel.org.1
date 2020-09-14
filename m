Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55376268797
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgINIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgINIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:51:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08E8WPap036016;
        Mon, 14 Sep 2020 04:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pLyhdJPyBNu1pv9ssiGleRiJI3PFTEZtqOCJCI/uhek=;
 b=VFkZodfcAlpIzHnmcR/z8CiPhmKg7cZJE//LlJ8d1vyiUUpLIvhH7B7pc3DTP8Ot6YBx
 2Px2ETguE/Px9sW0pMpOpVwJlELWwWGyVxJO4dmXAPVbMfwN4flBt+Wjj2eQgKM7ZGgN
 83YtwBsWD8LRxh/63u9osqF5x+67D0zatgZpBqZUtVGsyMsfdVzlkfEqsXyhyVG8f/uA
 gLjmD+u7ea5HqRvpSGrY4dIIn0TL0Sy8KUjL6EVRmazqDTZUj0dYgnH4CSE/KDtty3mR
 6fzWqxqbiQShHZRyXI/nuM9OvZ5tZwaUMPWAxzZZi0wwWLG8QAOJPUWyMewOJoa//eEN fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33j4sy90qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 04:51:13 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08E8WqZq038274;
        Mon, 14 Sep 2020 04:51:13 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33j4sy90pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 04:51:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E8n9d8026128;
        Mon, 14 Sep 2020 08:51:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 33gny81289-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 08:51:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08E8p8tT19530022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 08:51:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EED8711C052;
        Mon, 14 Sep 2020 08:51:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28EF811C04A;
        Mon, 14 Sep 2020 08:51:07 +0000 (GMT)
Received: from pomme.local (unknown [9.145.51.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 08:51:07 +0000 (GMT)
Subject: Re: [PATCH 1/3] mm: replace memmap_context by memplug_context
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
 <20200911134831.53258-2-ldufour@linux.ibm.com>
 <20200914084904.GA16999@dhcp22.suse.cz>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <d3843235-2e02-a4ad-494c-20222a7e3b45@linux.ibm.com>
Date:   Mon, 14 Sep 2020 10:51:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914084904.GA16999@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_09:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/09/2020 à 10:49, Michal Hocko a écrit :
> On Fri 11-09-20 15:48:29, Laurent Dufour wrote:
>> The memmap_context is used to detect whether a memory operation is due to a
>> hot-add operation or happening at boot time.
>>
>> Makes it general to the hotplug operation, renaming it at memplug_context
>> and move its define in the corresponding header.
>>
>> There is no functional change introduced by this patch
> 
> I do not want to nit picking on naming but we want to look at this from
> the initialization POV rather than hotplug. So....
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> [...]
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 375515803cd8..cd2bd21d3a4d 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -15,6 +15,15 @@ struct memory_block;
>>   struct resource;
>>   struct vmem_altmap;
>>   
>> +/*
>> + * Memory plugin context, use to differentiate memory added at boot time and
>> + * hot-plugged memory.
>> + */
>> +enum memplug_context {
>> +	MEMPLUG_EARLY,
>> +	MEMPLUG_HOTPLUG,
>> +};
> 
> /*
>   * Memory initialization context, use to differentiate memory added by
>   * the platform statically or via memory hotplug interface.
>   */
> enum meminit_context {
> 	MEMINIT_EARLY,
> 	MEMINIT_HOTPLUG
> }
> 

Sounds good too.
What about its definition's place, in include/mm/zone.h as David suggested ?
