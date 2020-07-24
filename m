Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0C22C75A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:09:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgGXOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:09:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OE2bGH148746;
        Fri, 24 Jul 2020 10:08:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fact9dnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 10:08:54 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OE3hOd155756;
        Fri, 24 Jul 2020 10:08:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fact9dmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 10:08:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OE4RLf007803;
        Fri, 24 Jul 2020 14:08:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 32brq842dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 14:08:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OE8muY18022758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 14:08:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E014E42041;
        Fri, 24 Jul 2020 14:08:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069854203F;
        Fri, 24 Jul 2020 14:08:46 +0000 (GMT)
Received: from [9.85.127.153] (unknown [9.85.127.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 14:08:45 +0000 (GMT)
Subject: Re: [PATCH v4 06/12] ppc64/kexec_file: restrict memory usage of kdump
 kernel
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Nayna Jain <nayna@linux.ibm.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524954805.20855.1164928096364700614.stgit@hbathini.in.ibm.com>
 <875zad6ajx.fsf@morokweng.localdomain>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <77c606da-8eb2-d831-147b-a204b498c7d7@linux.ibm.com>
Date:   Fri, 24 Jul 2020 19:38:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875zad6ajx.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/20 5:36 am, Thiago Jung Bauermann wrote:
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> Kdump kernel, used for capturing the kernel core image, is supposed
>> to use only specific memory regions to avoid corrupting the image to
>> be captured. The regions are crashkernel range - the memory reserved
>> explicitly for kdump kernel, memory used for the tce-table, the OPAL
>> region and RTAS region as applicable. Restrict kdump kernel memory
>> to use only these regions by setting up usable-memory DT property.
>> Also, tell the kdump kernel to run at the loaded address by setting
>> the magic word at 0x5c.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> Tested-by: Pingfan Liu <piliu@redhat.com>
>> ---
>>
>> v3 -> v4:
>> * Updated get_node_path() to be an iterative function instead of a
>>   recursive one.
>> * Added comment explaining why low memory is added to kdump kernel's
>>   usable memory ranges though it doesn't fall in crashkernel region.
>> * For correctness, added fdt_add_mem_rsv() for the low memory being
>>   added to kdump kernel's usable memory ranges.
> 
> Good idea.
> 
>> * Fixed prop pointer update in add_usable_mem_property() and changed
>>   duple to tuple as suggested by Thiago.
> 
> <snip>
> 
>> +/**
>> + * get_node_pathlen - Get the full path length of the given node.
>> + * @dn:               Node.
>> + *
>> + * Also, counts '/' at the end of the path.
>> + * For example, /memory@0 will be "/memory@0/\0" => 11 bytes.
> 
> Wouldn't this function return 10 in the case of /memory@0?

Actually, it does return 11. +1 while returning is for counting %NUL.
On top of that we count an extra '/' for root node.. so, it ends up as 11.
('/'memory@0'/''\0'). Note the extra '/' before '\0'. Let me handle root node
separately. That should avoid the confusion.

>> + *
>> + * Returns the string length of the node's full path.
>> + */
> 
> Maybe it's me (by analogy with strlen()), but I would expect "string
> length" to not include the terminating \0. I suggest renaming the
> function to something like get_node_path_size() and do s/length/size/ in
> the comment above if it's supposed to count the terminating \0.

Sure, will update the function name.

Thanks
Hari
