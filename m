Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD572D269D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgLHIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:51:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9034 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLHIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:51:46 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cqv5h6TwtzhpPc;
        Tue,  8 Dec 2020 16:50:32 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 16:51:02 +0800
Subject: Re: [PATCH v2 2/3] erofs: insert to managed cache after adding to pcl
To:     Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <20201207012346.2713857-2-hsiangkao@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cfdb46b5-0c66-4560-9069-5a4c21ad9768@huawei.com>
Date:   Tue, 8 Dec 2020 16:51:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201207012346.2713857-2-hsiangkao@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/7 9:23, Gao Xiang wrote:
> Previously, it could be some concern to call add_to_page_cache_lru()
> with page->mapping == Z_EROFS_MAPPING_STAGING (!= NULL).
> 
> In contrast, page->private is used instead now, so partially revert
> commit 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
> with some adaption for simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
