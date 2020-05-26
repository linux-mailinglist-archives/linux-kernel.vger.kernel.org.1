Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8901C9FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 03:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHBGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 21:06:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3903 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgEHBGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:06:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6BF86FCECC25D483787D;
        Fri,  8 May 2020 09:06:13 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 09:06:09 +0800
Subject: Re: [PATCH -next] dm mpath: Remove unused variable ret
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <agk@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <1588854412-19301-1-git-send-email-zou_wei@huawei.com>
 <20200507142958.GA12032@redhat.com>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <d945a16d-5a9d-252f-2dec-1d654c4f7e77@huawei.com>
Date:   Fri, 8 May 2020 09:06:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507142958.GA12032@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

You are right.
I did not notice that the macro DMEMIT uses the sz variable.

Thanks.

On 2020/5/7 22:29, Mike Snitzer wrote:
> On Thu, May 07 2020 at  8:26am -0400,
> Samuel Zou <zou_wei@huawei.com> wrote:
> 
>> This patch fixes below warning reported by coccicheck:
>>
>> drivers/md/dm-historical-service-time.c:240:14-16: Unneeded variable: "sz". Return "0" on line 261
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> 
> Nack.
> 
> DMEMIT() uses the local sz variable.
> 
> 

