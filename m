Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2042AC2E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgKIRwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:52:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgKIRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:52:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Hjq2Y076313;
        Mon, 9 Nov 2020 17:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YvxrNDq4sUYMOLMW+ILwJqr+WkVxbMPyXAKBEteaKZo=;
 b=Qz2IBDDNnCWcrnkrlK/L/AuCT8Zm4y9KEhu+5UGSui5VZyYUKUDIIBQjEtlZLbDN1EZX
 /leCS7Ec/AM1HoCFjOMqXD9J6roC8wgVxFd2lIJWVL4ZgQMHbDF4qfVx13jlQitaiDIY
 7R9uRSb2A2EpefCMa/W3F/9AZbsQoz9dTunQ2yrDoCLsx0Qn0Iz8ICbiSJpGf5VuvGBn
 xUKt2wOaS/+yv9hRQc2FdOyziiHmmLOsxGEbYQvSptbklwYGtYCrnm6eladgkzIe33QS
 nZP8ekiB6q1CfmnoAObOhaAHPQ8Vhi97hu4B59Zpd9zVJyT0nQMRMvMziO7qxbkvhEGg rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72edh2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 17:52:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Himof056123;
        Mon, 9 Nov 2020 17:50:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5fy0f7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 17:50:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Hoajl017863;
        Mon, 9 Nov 2020 17:50:37 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 09:50:36 -0800
Subject: Re: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
 <20201109112319.264511-14-alexandre.chartre@oracle.com>
 <CALCETrX-cN8zcSNZnmEw=0dL+mkaqkWVMdE2FkGTfUFR+Si=Bg@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <6a1b1267-c5bf-a1ba-4707-8cec35b1295c@oracle.com>
Date:   Mon, 9 Nov 2020 18:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX-cN8zcSNZnmEw=0dL+mkaqkWVMdE2FkGTfUFR+Si=Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/20 6:28 PM, Andy Lutomirski wrote:
> On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> Extend PTI user mappings so that more kernel entry code can be executed
>> with the user page-table. To do so, we need to map syscall and interrupt
>> entry code,
> 
> Probably fine.
> 
>> per cpu offsets (__per_cpu_offset, which is used some in
>> entry code),
> 
> This likely already leaks due to vulnerable CPUs leaking address space
> layout info.

I forgot to update the comment, I am not mapping __per_cpu_offset anymore.

However, if we do map __per_cpu_offset then we don't need to enforce the
ordering in paranoid_entry to switch CR3 before GS.

> 
>> the stack canary,
> 
> That's going to be a very tough sell.
> 

I can get rid of this, but this will require to disable stack-protector for
any function that we can call while using the user page-table, like already
done in patch 21 (x86/entry: Disable stack-protector for IST entry C handlers).

alex.
