Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE501A2DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 05:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDID0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 23:26:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgDID0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:26:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 088CEFE00E213CFD3A77;
        Thu,  9 Apr 2020 11:26:41 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 11:26:32 +0800
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     <ebiederm@xmission.com>, <oleg@redhat.com>, <tj@kernel.org>,
        <akpm@linux-foundation.org>, <guro@fb.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
 <20200330084845.o5jdrg44pm3uiydh@wittgenstein>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <bb0dae48-0183-019b-b4ba-47ac6347fcc5@huawei.com>
Date:   Thu, 9 Apr 2020 11:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200330084845.o5jdrg44pm3uiydh@wittgenstein>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 2020/3/30 16:48, Christian Brauner wrote:
> On Mon, Mar 30, 2020 at 10:44:43AM +0800, Zhiqiang Liu wrote:
>>
>> signal.c provides kill_proc_info, we can use it instead of kill_pid_info
>> in kill_something_info func gracefully.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> Thanks! I'll shorten the commit message header a little when picking
> this up otherwise:
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> .
> 

