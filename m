Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC2571ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHaCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:49:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbgHaCtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:49:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C392904D3B68F91D429;
        Mon, 31 Aug 2020 10:48:59 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 31 Aug
 2020 10:48:53 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change compr_blocks of superblock info
 to 64bit
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200831020949.3218854-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <77e4d1c5-daad-5337-f71d-6975df89d796@huawei.com>
Date:   Mon, 31 Aug 2020 10:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200831020949.3218854-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/31 10:09, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Current compr_blocks of superblock info is not 64bit value. We are
> accumulating each i_compr_blocks count of inodes to this value and
> those are 64bit values. So, need to change this to 64bit value.

It's not a big deal, as f2fs use 32bits to index block device's address space,
so there is at most 1 << 32 blocks in f2fs, we can not save more blocks than
the number...

If it overflows 32bits variable's space, it must be a bug.

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
