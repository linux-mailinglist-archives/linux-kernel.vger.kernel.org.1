Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109C42D0AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLGHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:08:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9389 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLGHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:08:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CqDrY1NgPz79bf;
        Mon,  7 Dec 2020 15:06:53 +0800 (CST)
Received: from DESKTOP-8N3QUD5.china.huawei.com (10.67.101.227) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 15:07:17 +0800
From:   Guohua Zhong <zhongguohua1@huawei.com>
To:     <richard.weinberger@gmail.com>
CC:     <joern@lazybastard.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <nixiaoming@huawei.com>, <patrick@baymotion.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <wangle6@huawei.com>,
        <young.liuyang@huawei.com>, <zhongguohua1@huawei.com>
Subject: Re: Re: [PATCH v2] phram: Allow the user to set the erase page size.
Date:   Mon, 7 Dec 2020 15:07:15 +0800
Message-ID: <20201207070715.15016-1-zhongguohua1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAFLxGvxSycd=6WE4=XnrXxuF2Bc6A6ULA8GfkT8QvgcX=2Gk8g@mail.gmail.com>
References: <CAFLxGvxSycd=6WE4=XnrXxuF2Bc6A6ULA8GfkT8QvgcX=2Gk8g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 14:56 AM Guohua Zhong <zhongguohua1@huawei.com> wrote:
>
>> Permit the user to specify the erase page size as a parameter.
>> This solves two problems:
>
>> - phram can access images made by mkfs.jffs2.  mkfs.jffs2 won't
>> create images with erase sizes less than 8KiB; many architectures
>> define PAGE_SIZE as 4KiB.
>
>> - Allows more effective use of small capacity devices.  JFFS2
>> needs somewhere between 2 and 5 empty pages for garbage collection;
>> and for an NVRAM part with only 32KiB of space, a smaller erase page
>> allows much better utilization in applications where garbage collection
>> is important.
>
>> Signed-off-by: Patrick O'Grady <patrick@baymotion.com>
>> Reviewed-by: Joern Engel <joern@logfs.org>
>> Link: https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
>> [Guohua Zhong: fix token array index out of bounds and update patch for kernel master branch]
>> Signed-off-by: Guohua Zhong <zhongguohua1@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>
> Looks good to me, except the authorship.
> If I understand correctly, you took this old patch and resend it.
> Please make sure that the "From:"-Line contains the original author.
> You can fix this up using git commit --amend --author=.
> The git format-patch will create a correct patch.

Sorry, I am not clear this rule before. But I found the same issue independently. It looks good 
after changging the erase size for phram driver. Then when I try to send the patch, I found that 
Patrick O'Grady has already send a patch which has not been merged as the link below
https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/

So I resend a patch with some change and fix for mainline kernel with the old patch link of Patrick O'Grady.

If I need to change the authorship, I will resend this patch for V3 with authorship of Patrick O'Grady.

-- 
Thanks,
//guohua
