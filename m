Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598401A613F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 02:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgDMAer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDMAeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 20:34:46 -0400
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5FC0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 17:34:47 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0234DAA1B2BB9BF8950A;
        Mon, 13 Apr 2020 08:34:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 13 Apr
 2020 08:34:40 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid page count leak
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>
References: <c50f4bff-1c14-931d-ee07-a2f5dc336785@web.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d228c74b-0d33-e22c-56c8-f2bfd691c985@huawei.com>
Date:   Mon, 13 Apr 2020 08:34:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c50f4bff-1c14-931d-ee07-a2f5dc336785@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/11 3:19, Markus Elfring wrote:
>> In below error path, we missed to release reference count of pages
>> in compressed cluster, fix it.
>> - f2fs_mpage_readpages()
>>  - f2fs_read_multi_pages()
> 
> I suggest to improve the commit message.
> 
> Would you like to add the tag “Fixes” to the change description?

Sure, will update in v2, thanks.

Thanks,

> 
> Regards,
> Markus
> .
> 
