Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD32E2358
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 02:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgLXBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 20:15:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9921 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgLXBPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 20:15:15 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1XCH4kqdz7KN4;
        Thu, 24 Dec 2020 09:13:47 +0800 (CST)
Received: from [10.174.176.185] (10.174.176.185) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 09:14:21 +0800
Subject: Re: [PATCH v2] ubifs: Fix read out-of-bounds in
 ubifs_jnl_write_inode()
To:     Richard Weinberger <richard@nod.at>,
        Chengsong Ke <kechengsong@huawei.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wangfangpeng1 <wangfangpeng1@huawei.com>
References: <20201223121536.6244-1-kechengsong@huawei.com>
 <244303467.160590.1608764840819.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a45eb291-c3e5-23c6-239d-88347cf688e4@huawei.com>
Date:   Thu, 24 Dec 2020 09:14:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <244303467.160590.1608764840819.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/12/24 7:07, Richard Weinberger 写道:

>> Reproducer:
>> 0. config KASAN && apply print.patch
>> 1. mount ubifs on /root/temp
>> 2. run test.sh
> 
> What does test.sh do?
Go to Link: https://bugzilla.kernel.org/show_bug.cgi?id=210865.
test.sh creates a very long path file test_file, and then create a 
symbol link link_file for test_file, so ubifs inode for link_file will 
be assigned a big value for ui->data_len.
When we change atime for link_file, ubifs_jnl_write_inode will be 
executed by wb_writeback. By this way, write_len could be not aligned 
with 8 bytes.
> 
>> 3. cd /root/temp && ls // change atime for link_file
>> 4. wait 1~2 minutes
>>
>> In order to solve the read oob problem in ubifs_wbuf_write_nolock, just align
>> the write_len to
>> 8 bytes when alloc the memory. So that this patch will not affect the use of
>> write_len in other
>> functions, such as ubifs_jnl_write_inode->make_reservation and
>> ubifs_jnl_write_inode->ubifs_node_calc_hash.
> 
> I gave this a second thought and I'm not so sure anymore what exactly is going on.
> The problem is real, I fully agree with you but I need to dig deeper into
> the journal and wbuf code to double check that we really fix the right thing
> and not just paper other something.
> 
> Thanks,
> //richard
> .
> 

