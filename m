Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9758F2AB7C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgKIMH5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 07:07:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:3656 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgKIMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:07:57 -0500
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CV8rh1P7LzXl1h;
        Mon,  9 Nov 2020 20:07:48 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 20:07:53 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 9 Nov 2020 20:07:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REF PATCH] mm/swap: fix swapon failure
Thread-Topic: [REF PATCH] mm/swap: fix swapon failure
Thread-Index: Ada2j2TG6Hr9AvitT2imzesq0TetBw==
Date:   Mon, 9 Nov 2020 12:07:53 +0000
Message-ID: <9e184857ee9f4e5d8f176b5b511c0dc4@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
Alex Shi <alex.shi@linux.alibaba.com> wrote:
> One of my VM guest has a swapon issue:
> root #swapon -v -f /swap1
> swapon /swap1
> swapon: /swap1: found swap signature: version 1, page-size 4, same byte order
> swapon: /swap1: pagesize=4096, swapsize=1607467008, devsize=1607467008
> swapon: /swap1: swapon failed: Invalid argument
>
> and bisection report commit 822bca52ee7e "mm/swapfile.c: fix potential memory leak in sys_swapon" cause the trouble.
>
> Go through the context I found the exit_swap_address_space(p->type) shouldn't be used in good result path. So just move it to error path.
>

Many thanks for your patch. But I'am somehow confused as we only do the label free_swap_address_space stuff in error path. And the good result
path can't reach here as it just goto out before free_swap_address_space label. Could you please explain it for me more detailed?

Thanks again.

> Fixes: 822bca52ee7e ("mm/swapfile.c: fix potential memory leak in
> sys_swapon")
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
