Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB671F1179
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 04:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgFHCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 22:47:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbgFHCr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:47:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48C06372CBBA9DB0582E;
        Mon,  8 Jun 2020 10:47:26 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:47:22 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use kfree() to free super in
 read_raw_super_block()
To:     Denis Efremov <efremov@linux.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200605181533.73113-1-efremov@linux.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aec30a6c-ce45-18b7-7d6c-2a156c595f45@huawei.com>
Date:   Mon, 8 Jun 2020 10:47:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200605181533.73113-1-efremov@linux.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/6 2:15, Denis Efremov wrote:
> Use kfree() instead of kvfree() to free super in
> read_raw_super_block() because the memory is allocated with
> kzalloc() in the function.
> 
> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
