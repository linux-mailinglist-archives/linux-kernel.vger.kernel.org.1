Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5582F7499
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbhAOIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:51:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11392 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbhAOIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:51:54 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DHFHj5GNyz7VkL;
        Fri, 15 Jan 2021 16:50:09 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 15 Jan
 2021 16:51:08 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: deprecate f2fs_trace_io
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20210114220521.3578185-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a95b9c6c-d9c0-e536-4ae6-21c9e3ea0c77@huawei.com>
Date:   Fri, 15 Jan 2021 16:51:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210114220521.3578185-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/15 6:05, Jaegeuk Kim wrote:
> This patch deprecates f2fs_trace_io, since f2fs uses page->private more broadly,
> resulting in more buggy cases.

Agreed.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
