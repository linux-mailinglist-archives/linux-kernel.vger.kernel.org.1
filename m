Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA02D6BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392209AbgLJXNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:13:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48468 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388690AbgLJXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:13:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAMxb9D145265;
        Thu, 10 Dec 2020 23:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6+1bUuHhVxs0QO9FbJk8Jaw0AYdPkH+lIF3guEdwRuY=;
 b=N81zZuNm3Zj45VeqZIMM+jxrqFmyoT4kNadHms4YZCt0WdLUl/B6VYqUd5LLIER8k+7T
 cQsFA7pxM8i1CYrQGRD0HVVemLE+sq9v0o+8ZGdrQ1ycKmFq/6JwRl3LkXkeiGqvln8w
 4nkkm5YLiKoMIi8bGB5DPgy5PD4bB4kyUzJJfpRFKcHD10X0toIvifiPfZZo5iANxDS7
 fHpMB7i9+LAGAj5HbrphHbUbDYtD8nw8G7J8HdC0nvqxvcMkr35QRiSXmL1L2iS8NW/5
 rCXbW7xaTeWVfLk+8g4YgGp8+TtyfncxolX6L354qvrGVGu2EZLKuV8UvEo7cFSc2SMj uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqc84x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 23:11:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAN0dMZ086108;
        Thu, 10 Dec 2020 23:09:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m42ekrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 23:09:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAN9lTu015847;
        Thu, 10 Dec 2020 23:09:47 GMT
Received: from [10.159.144.152] (/10.159.144.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 15:09:47 -0800
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
 <20201130013256.oryyz4wxd356n74o@gabell>
 <20201130222514.0949e3cc@oasis.local.home>
From:   Libo Chen <libo.chen@oracle.com>
Message-ID: <37123326-8e04-dce4-502a-410c3e979974@oracle.com>
Date:   Thu, 10 Dec 2020 15:09:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130222514.0949e3cc@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 7:25 PM, Steven Rostedt wrote:

> On Sun, 29 Nov 2020 20:32:56 -0500
> Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
>> On Fri, Nov 20, 2020 at 06:12:43PM -0800, Libo Chen wrote:
>>> This issue was first noticed when I was testing different kernels on
>>> Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
>>> kernel entry was added successfully and the index of that kernel entry was
>>> retrieved correctly, ktest still wouldn't reboot the system into
>>> user-specified kernel.
>>>
>>> The bug was spotted in subroutine reboot_to where the if-statement never
>>> checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
>>> set for the next boot.
>>>
>>> Add a check for "grub2bls" so that $grub_reboot $grub_number can
>>> be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
>>> the correct kernel.
>>>
>>> Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")
>>>
>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> Thank you for the fix!
>> I tested the patch with fedora33. It works well.
>>
>> Please feel free to add:
>>
>> 	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>
>>
> Thanks.
>
> I may push this upstream by the end of the week.
>
> -- Steve

(Mistakenly sent the last one privately so resend it now)

Hi Steven,


Just wanna check in and check on the status of it.


Thanks,

Libo

