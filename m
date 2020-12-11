Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370EE2D6E65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405112AbgLKDOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:14:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48614 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395034AbgLKDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:13:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BB39WlL059885;
        Fri, 11 Dec 2020 03:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HRb984SQuzZAL6sFmQ/JEAwKN5b9oAgH5R6M9KaqRdY=;
 b=IEOIHaCiClQhDHwnI79DMwSBthhhMlevs2kozDL8RXaZ3E82QNuJcXM4voXxVl1OPKoU
 En8D612sgCvWLJb67b0zYoD5rlFD4kwX75FBrXzNlBxwKhDI6SVC5a6jGmrQyeSXXn7T
 +4OGDRmkJhfd4RiWazkAPNUH3mGYSwRrQLMDCelA7Mt7mfJSrdXjBKMp+dENjQIqhVQm
 7QJxd+0xSO4NMr8YtjoXoiYWxOeqVwKRzTC/wRhM9EPDFwWRhyoeZUF7SYcmhyxNTqpZ
 XtnDuLpr1mhJvudPUQr2OU/R5ndcbqw/IbZJOZMBlE7h7QYgkmZWq/lxy5XNdVTkcVS2 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 357yqc8kqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 03:12:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BB3AmFQ128600;
        Fri, 11 Dec 2020 03:12:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kyxbt1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 03:12:19 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BB3CI7X015797;
        Fri, 11 Dec 2020 03:12:18 GMT
Received: from [10.159.144.152] (/10.159.144.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 19:12:17 -0800
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
 <20201130013256.oryyz4wxd356n74o@gabell>
 <20201130222514.0949e3cc@oasis.local.home>
 <37123326-8e04-dce4-502a-410c3e979974@oracle.com>
 <20201210194504.3d9fb132@oasis.local.home>
From:   Libo Chen <libo.chen@oracle.com>
Message-ID: <53632126-7902-6f51-efc2-f6e3604bb706@oracle.com>
Date:   Thu, 10 Dec 2020 19:12:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210194504.3d9fb132@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 4:45 PM, Steven Rostedt wrote:

> On Thu, 10 Dec 2020 15:09:46 -0800
> Libo Chen <libo.chen@oracle.com> wrote:
>
>
>> Hi Steven,
>>
>>
>> Just wanna check in and check on the status of it.
> I have it applied in my local repo (even in my for-next, which I forgot
> to push :-p)
>
> I've been testing it on all my build machines along with my own patches.
>
> Anyway, it's in my queue (with two of my own patches) that I was
> thinking of pushing to Linus during the next merge window. But I can
> send your patch now, and see if he's willing to take it.
>
> Thanks for pinging me.
>
> -- Steve

Thanks Steven! It looks like Linus has taken it.


Libo

