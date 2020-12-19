Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0802DECD6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgLSDTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:19:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42192 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgLSDTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:19:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ3GT2a004791;
        Sat, 19 Dec 2020 03:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=v6q6IbegRXRbGCELj5Zvab6ivdH8CTWiLtARp7czLwE=;
 b=p1KdMGHt6c12R61yXtFiDyB+J6kaBzzMB1jPHJQfq4pfJ9NXbnF9RtzXAaX8UnbzINDV
 1nSaYjgw//u8xepQXXw46DNm/9s7GK8ly+eniTuQQZCu39yv3b+vAukXKDuFtBSxqztt
 BMTLGwNQLfZnL+MFZ9R+GLbKNfEHb1SIaY0z2obzOF0Ii81wlT/AsjnxMuzTfGYMaS2V
 VvQeCU1UXKlauy75ok6GKJnDP6wlRlZUzil/Y3PhvuTvXFmjY7tG7EvGGWI4C0xunQ55
 qcdQAS3HR+ZVKdQI6ZGlFyIvh5d0c06ts0XZZRXrFCiNmYhj7mhUmgqtJY254hPCnKEH NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35h8xqr1c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Dec 2020 03:18:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ3GL6r178625;
        Sat, 19 Dec 2020 03:18:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 35h6mrkvqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 03:18:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BJ3InUJ022223;
        Sat, 19 Dec 2020 03:18:50 GMT
Received: from [10.191.10.149] (/10.191.10.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 19:18:49 -0800
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218105153.GX32193@dhcp22.suse.cz>
 <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
 <20201218142717.GA32193@dhcp22.suse.cz>
 <63e8a821-a3f6-47a6-f438-b27c32f4a05f@oracle.com>
 <X91Vg1Mg1nPk/Bsx@chrisdown.name>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <fc257fe6-f2e4-bc53-1943-533661378fc5@oracle.com>
Date:   Sat, 19 Dec 2020 11:18:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X91Vg1Mg1nPk/Bsx@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=866 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=878 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/19/20 9:21 AM, Chris Down wrote:
> Jacob Wen writes:
>> set_task_reclaim_state() is a function with 3 lines of code of which 
>> 2 lines contain WARN_ON_ONCE.
>>
>> I am not comfortable with the current repetition.
>
> Ok, but could you please go into _why_ others should feel that way 
> too? There are equally also reasons to err on the side of leaving code 
> as-is -- since we know it already works, and this code generally has 
> pretty high inertia -- and avoid mutation of code without concrete 
> description of the benefits.

I don't get your point. The patch doesn't change code of 
set_task_reclaim_state(), so I am fine with the repeated WARN_ON_ONCE.

I mean I prefer removing duplicate code to avoid going down the rabbit 
hole of set_task_reclaim_state().

It's a fundamental principle to me to move the code into its own 
function. I'd like to hear the others' opinions.



