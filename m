Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55F42C7CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgK3CqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:46:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgK3CqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:46:23 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU2WWMf115906;
        Sun, 29 Nov 2020 21:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=IQicQyiS9kogl4wxS9cqGAmZBbWu2ejNITYBJrwsKDs=;
 b=TsATXlnyqqr0JMYoXyPBgqiv+0RWFwgjLUFSuDWjLF9GxqV3E+Q/KdTpayHXnFwiSskP
 hLY4jJdXT2fBXMHVi7VOlOBPuw5nbxnJCEndgFIILfpackbuk6oDUANsv0uv8k/kstqj
 ZEE6miwdo4h/QxdDqVDg5wTv3ZGNpA9evNQFT0pG0accsZBHGYV01pOAIg7f2MmawOjF
 rSepcQ2oLvHwfWjsXor1zMvd+kIVQEWi+kgmhdTVFDwZx5rtVpeOD7XTx19iHTjRgGWC
 iiTHIvF5iKG/yUul7pl/yYBkh1boBupOSnSMtprzjhpyexGbZ/hvXYD2qgyb1KGppec7 Qw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 354nrrtm4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 21:45:42 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU2fnR2004781;
        Mon, 30 Nov 2020 02:45:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpd8ac2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 02:45:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU2jbgd63766922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 02:45:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA07A405C;
        Mon, 30 Nov 2020 02:45:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CE3AA4060;
        Mon, 30 Nov 2020 02:45:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Nov 2020 02:45:37 +0000 (GMT)
Received: from [9.102.59.125] (unknown [9.102.59.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2CAC160A10;
        Mon, 30 Nov 2020 13:45:36 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
Subject: [ANNOUNCE] [CFP] Call for Sessions - linux.conf.au Online 2021 Kernel
 Miniconf
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
Message-ID: <f43afd8c-5ce6-c505-3f4c-bd8f130ff904@linux.ibm.com>
Date:   Mon, 30 Nov 2020 13:45:35 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_12:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=962 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300010
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LCA2021 Kernel Miniconf - Online - 2021-01-23
---------------------------------------------

LCA Kernel Miniconf submissions now open! (Ever wanted to present at 
LCA, but couldn't justify flying to Australia? Well, 2021 is your chance 
- we're going online-only for reasons you're probably aware of.)

Submissions close: 2020-12-18, 23:59 AoE/UTC-12
Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
More info: https://lca-kernel.ozlabs.org/2021-cfs.html

***************************************************************************

linux.conf.au 2021 will be held at the Australian National University, 
Canberra^W^W^W^W^W^Win the comfort of your own homes, by the magic of 
the internet, from 23-25 January 2021.

The Kernel Miniconf is a single-day miniconf track, held on Saturday 23 
January, about everything related to the kernel and low-level systems 
programming.

The Kernel Miniconf will focus on a variety of kernel-related topics - 
technical presentations on up-and-coming kernel developments, the future 
direction of the kernel, and kernel development community and process 
matters. Past Kernel Miniconfs have included technical talks on topics 
such as memory management, RCU, scheduling and filesystems, as well as 
talks on Linux kernel community topics such as licensing and Linux 
kernel development process.

We invite submissions on anything related to kernel and low-level 
systems programming. We welcome submissions from developers of all 
levels of experience in the kernel community, covering a broad range of 
topics. The focus of the miniconf will primarily be on Linux, however 
non-Linux talks of sufficient interest to a primarily Linux audience 
will be considered.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
