Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D445F2E8B47
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhACHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:48:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbhACHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:48:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1037WeQ7117493;
        Sun, 3 Jan 2021 02:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1TZF1yrMdKF0cI6gv6RLrazxFj21gnJjIEytObv3dA4=;
 b=SFtyyEZ8vxIMgRVs4r7FfggyoHDBqkgB/qiebpa/IYkpivc5UH36t7hHSPSRTzVNDaXX
 1jYVifpMqX6CetxWxM+5YrV4k359AYiofW1HRgv6mQa13/W+fHDBGaMUdOelQRiA0h+2
 qziWyW83zT7j3qkommGkSlragOxOGaZC+MDxn+YBE09nm7/0p6E2S7MMC+UODYmWQVEZ
 RIBXgSk4bkyirnMrLQcaH91Ef+J372F+8iRCrSKlx9KdfBi/C4cJSshxRpyXd+UdIeUB
 alnRShLMIeBcBfFeGqWgtHWG+EbQDWSO0/tIwYOjY47xH64i3msDS9lZ6363v0+cx7eh +w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35u817sfcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jan 2021 02:47:58 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1037S3iP022420;
        Sun, 3 Jan 2021 07:47:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 35tgf7rdqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jan 2021 07:47:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1037lsgF41681252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Jan 2021 07:47:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F320AE045;
        Sun,  3 Jan 2021 07:47:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 264D4AE057;
        Sun,  3 Jan 2021 07:47:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  3 Jan 2021 07:47:54 +0000 (GMT)
Received: from [9.206.161.160] (unknown [9.206.161.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CF1CD609AF;
        Sun,  3 Jan 2021 18:47:52 +1100 (AEDT)
Subject: Re: [ANNOUNCE] [CFP] Call for Sessions - linux.conf.au Online 2021
 Kernel Miniconf
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
References: <f43afd8c-5ce6-c505-3f4c-bd8f130ff904@linux.ibm.com>
Message-ID: <626b30c1-0546-2abd-90eb-6681fbc3e25c@linux.ibm.com>
Date:   Sun, 3 Jan 2021 18:47:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f43afd8c-5ce6-c505-3f4c-bd8f130ff904@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-02_13:2020-12-31,2021-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 1:45 pm, Andrew Donnellan wrote:
> LCA2021 Kernel Miniconf - Online - 2021-01-23
> ---------------------------------------------
> 
> LCA Kernel Miniconf submissions now open! (Ever wanted to present at 
> LCA, but couldn't justify flying to Australia? Well, 2021 is your chance 
> - we're going online-only for reasons you're probably aware of.)
> 
> Submissions close: 2020-12-18, 23:59 AoE/UTC-12
> Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
> More info: https://lca-kernel.ozlabs.org/2021-cfs.html

The deadline has been extended until January 7 - we're looking for talks 
on a broad range of kernel topics, so please feel free to submit a 
proposal about anything kernel-related!

> 
> ***************************************************************************
> 
> linux.conf.au 2021 will be held at the Australian National University, 
> Canberra^W^W^W^W^W^Win the comfort of your own homes, by the magic of 
> the internet, from 23-25 January 2021.
> 
> The Kernel Miniconf is a single-day miniconf track, held on Saturday 23 
> January, about everything related to the kernel and low-level systems 
> programming.
> 
> The Kernel Miniconf will focus on a variety of kernel-related topics - 
> technical presentations on up-and-coming kernel developments, the future 
> direction of the kernel, and kernel development community and process 
> matters. Past Kernel Miniconfs have included technical talks on topics 
> such as memory management, RCU, scheduling and filesystems, as well as 
> talks on Linux kernel community topics such as licensing and Linux 
> kernel development process.
> 
> We invite submissions on anything related to kernel and low-level 
> systems programming. We welcome submissions from developers of all 
> levels of experience in the kernel community, covering a broad range of 
> topics. The focus of the miniconf will primarily be on Linux, however 
> non-Linux talks of sufficient interest to a primarily Linux audience 
> will be considered.
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
