Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90DA1CEA41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgELBug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 21:50:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgELBug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:50:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C2BACC829ABFA8EDCF1B;
        Tue, 12 May 2020 09:50:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 09:50:29 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: report delalloc reserve as non-free in
 statfs for project quota
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
References: <158917771894.228779.2521743301299120701.stgit@buzz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6818c82e-4df6-1dfb-90ef-61dc151e3061@huawei.com>
Date:   Tue, 12 May 2020 09:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <158917771894.228779.2521743301299120701.stgit@buzz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/11 14:15, Konstantin Khlebnikov wrote:
> This reserved space isn't committed yet but cannot be used for
> allocations. For userspace it has no difference from used space.
> 
> See the same fix in ext4 commit f06925c73942 ("ext4: report delalloc
> reserve as non-free in statfs for project quota").
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: ddc34e328d06 ("f2fs: introduce f2fs_statfs_project")

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
