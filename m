Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3B1BEFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 07:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD3Fwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 01:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD3Fw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:52:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U5ViQ1014088;
        Thu, 30 Apr 2020 01:52:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mfhg8mt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 01:52:21 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03U5qFlN063752;
        Thu, 30 Apr 2020 01:52:21 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mfhg8msb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 01:52:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U5pNJo014810;
        Thu, 30 Apr 2020 05:52:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu71wvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 05:52:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U5qFog25821338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 05:52:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 800E1A4062;
        Thu, 30 Apr 2020 05:52:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5DF6A405F;
        Thu, 30 Apr 2020 05:52:10 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.199.54.187])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 05:52:10 +0000 (GMT)
Subject: Re: [RFC 1/3] powernv/cpuidle : Support for pre-entry and post exit
 of stop state in firmware
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Cc:     ego@linux.vnet.ibm.com, mikey@neuling.org, mpe@ellerman.id.au,
        oohall@gmail.com, psampat@linux.ibm.com, svaidy@linux.ibm.com,
        skiboot@lists.ozlabs.org
References: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
 <1588035100.usm3gb816q.astroid@bobo.none>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Message-ID: <66ce544a-c1bf-4e84-2a7c-7480bbc0e12c@linux.vnet.ibm.com>
Date:   Thu, 30 Apr 2020 11:22:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1588035100.usm3gb816q.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Have you posted out the kernel side of "opal v4" patchset?
I could only find the opal patchset.

Thanks,
Abhishek

On 04/28/2020 06:38 AM, Nicholas Piggin wrote:
> Thanks for picking this up and pushing it along. I do plan to come back
> and take another look at it all, but what we do need to do first is get
> a coherent approach to this proposed new calling convention and OS ops.
>
> It's fine to work on this in the meantime, but to start merging things
> my idea is:
>
> - OPAL must leave r13-r15 untouched for the OS.
> - OS ops are made available only for a "v4" OS that uses the new
>    calling convention, including kernel stack.
> - OS ops baseline (all OSes must provide) will be console / printk
>    facility, trap handling and crash/symbol decoding on behalf of OPAL,
>    and runtime virtual memory.
>
> Other OS ops features can be added in the versioned structure, including
> this.
>
> I'm trying to get back to cleaning these things up and start getting
> them merged now. Any comments or review on those would be helpful.
>
> Thanks,
> Nick
>

