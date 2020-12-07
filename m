Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F02D0B58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLGHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:52:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9106 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLGHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:52:16 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqFqL3bwNzM1Yf;
        Mon,  7 Dec 2020 15:50:54 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 7 Dec 2020
 15:51:28 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't allow any writes on readonly
 mount
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20201203205522.891082-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <48d45bbd-baaf-e29e-8351-df375ee5a8b0@huawei.com>
Date:   Mon, 7 Dec 2020 15:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201203205522.891082-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 4:55, Jaegeuk Kim wrote:
> generic_make_request: Trying to write to read-only block-device dm-5 (partno 0)
> WARNING: CPU: 7 PID: 546 at block/blk-core.c:2190 generic_make_request_checks+0x664/0x690
> pc : generic_make_request_checks+0x664/0x690
> lr : generic_make_request_checks+0x664/0x690
> Call trace:
>   generic_make_request_checks+0x664/0x690
>   generic_make_request+0xf0/0x3a4
>   submit_bio+0x80/0x250
>   __submit_merged_bio+0x368/0x4e0
>   __submit_merged_write_cond.llvm.12294350193007536502+0xe0/0x3e8
>   f2fs_wait_on_page_writeback+0x84/0x128
>   f2fs_convert_inline_page+0x35c/0x6f8
>   f2fs_convert_inline_inode+0xe0/0x2e0
>   f2fs_file_mmap+0x48/0x9c
>   mmap_region+0x41c/0x74c
>   do_mmap+0x40c/0x4fc
>   vm_mmap_pgoff+0xb8/0x114
>   vm_mmap+0x34/0x48
>   elf_map+0x68/0x108
>   load_elf_binary+0x538/0xb70
>   search_binary_handler+0xac/0x1dc
>   exec_binprm+0x50/0x15c
>   __do_execve_file+0x620/0x740
>   __arm64_sys_execve+0x54/0x68
>   el0_svc_common+0x9c/0x168
>   el0_svc_handler+0x60/0x6c
>   el0_svc+0x8/0xc
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
