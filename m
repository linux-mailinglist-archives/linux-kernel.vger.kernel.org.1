Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8607E2FF9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAVA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:57:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11122 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAVA4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:56:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DMLQC1T2Fz15x8C;
        Fri, 22 Jan 2021 08:54:59 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 22 Jan
 2021 08:56:02 +0800
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: add ckpt_thread_ioprio sysfs node
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20210121134529.1201249-1-daeho43@gmail.com>
 <20210121134529.1201249-2-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2e97b330-3e8d-d876-e060-e44123f27f2c@huawei.com>
Date:   Fri, 22 Jan 2021 08:56:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210121134529.1201249-2-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/21 21:45, Daeho Jeong wrote:
> From: Daeho Jeong<daehojeong@google.com>
> 
> Added "ckpt_thread_ioprio" sysfs node to give a way to change checkpoint
> merge daemon's io priority. Its default value is "be,3", which means
> "BE" I/O class and I/O priority "3". We can select the class between "rt"
> and "be", and set the I/O priority within valid range of it.
> "," delimiter is necessary in between I/O class and priority number.
> 
> Signed-off-by: Daeho Jeong<daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
