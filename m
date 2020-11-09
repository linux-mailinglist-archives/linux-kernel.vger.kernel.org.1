Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789052AC578
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgKITvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:51:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48338 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKITvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:51:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Jnvpg124551;
        Mon, 9 Nov 2020 19:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vQL59eFferhmohEwf4bBAScf9qwvzs32dfLpyEY/s/g=;
 b=g8tM5hfnPP5me+JBqWNKa8AmoDgNM2nM9k724WR1etHZlg+/WIt6VoBCg5jpmKthN/cz
 OKLj7dcgIC7kVWTInOzbae4aFxKY302ydEUU89/6FV7tAewtsRjnqJ/y1aFT2oIgOf+v
 ml8e/QQyU91m2iTvIC4PrrjRM20ptcPBFpK6dwrS2F8JYamIUFerhQdMDFsUQ3CNiUBh
 GlOEL8xVxuhliaFGJZJGHvaz6GVTuUmTmHaE1ykjmjFReMndv1pMOtdm6zCsNRPWOxMt
 OZHsr1xDfwUBFBPbiuDqLTzbk/tyYaXL98kvkXfS7EY758E9ygn5cqHQhBfj4vVl/EuI KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3ar3rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 19:51:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Jo4T5084300;
        Mon, 9 Nov 2020 19:51:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gvq9rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 19:51:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Jp1km009024;
        Mon, 9 Nov 2020 19:51:01 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 11:51:01 -0800
Subject: Re: [RFC][PATCH 00/24] x86/pti: Defer CR3 switch to C code
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
 <8d9b6f38-5d98-dc91-cecc-36c7ab829c96@intel.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <d816313f-38f8-bcf0-3411-cdcbe0457d8b@oracle.com>
Date:   Mon, 9 Nov 2020 20:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8d9b6f38-5d98-dc91-cecc-36c7ab829c96@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/20 8:35 PM, Dave Hansen wrote:
> On 11/9/20 6:44 AM, Alexandre Chartre wrote:
>>   - map more syscall, interrupt and exception entry code into the user
>>     page-table (map all noinstr code);
> 
> This seems like the thing we'd want to tag explicitly rather than make
> it implicit with 'noinstr' code.  Worst-case, shouldn't this be:
> 
> #define __entry_func	noinstr
> 
> or something?

Yes. I use the easy solution to just use noinstr because noinstr is mostly
use for entry functions. But if we want to use the user page-table beyond
the entry functions then we will definitively need a dedicated tag.

> I'd also like to see a lot more discussion about what the rules are for
> the C code and the compiler.  We can't, for instance, do a normal
> printk() in this entry functions.  Should we stick them in a special
> section and have objtool look for suspect patterns or references?
> 
> I'm most worried about things like this:
> 
> 	if (something_weird)
> 		pr_warn("this will oops the kernel\n");

That would be similar to noinstr which uses the .noinstr.text section, and if
I remember correctly objtool detects if a noinstr function calls a non-noinst.
Similarly here, an entry function should not call a non-entry function.

alex.
