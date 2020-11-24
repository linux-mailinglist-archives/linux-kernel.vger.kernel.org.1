Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA42C1BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgKXDMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:12:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7970 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgKXDMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:12:21 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cg8Fd4zNjzhdMV;
        Tue, 24 Nov 2020 11:12:05 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Nov
 2020 11:12:14 +0800
Subject: Re: [PATCH] f2fs: change to use rwsem for cp_mutex
To:     David Laight <David.Laight@ACULAB.COM>,
        'Sahitya Tummala' <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
 <7f5213fb9b334d1290f019ab8ed6ee71@AcuMS.aculab.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a1b9a134-97a8-6fb7-2fdc-d4de91dff849@huawei.com>
Date:   Tue, 24 Nov 2020 11:12:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7f5213fb9b334d1290f019ab8ed6ee71@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/24 1:05, David Laight wrote:
> From: Sahitya Tummala
>> Sent: 23 November 2020 05:29
>>
>> Use rwsem to ensure serialization of the callers and to avoid
>> starvation of high priority tasks, when the system is under
>> heavy IO workload.
> 
> I can't see any read lock requests.
> 
> So why the change?

Hi David,

You can check the context of this patch in below link:

https://lore.kernel.org/linux-f2fs-devel/8e094021b958f9fe01df1183a2677882@codeaurora.org/T/#t

BTW, the root cause here is that mutex lock won't serialize callers, so there
could be potential starvation problem when this lock is always grabbed by high
priority tasks.

Thanks,
