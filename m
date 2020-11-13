Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B562B15F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgKMGvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:51:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7228 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgKMGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:51:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXTdc2hlFzkdFl;
        Fri, 13 Nov 2020 14:51:16 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 14:51:27 +0800
Subject: Re: [PATCH] panic: Avoid dump_stack() twice
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20201113054747.177919-1-wangkefeng.wang@huawei.com>
 <40b1b70f-16d9-01c4-c045-508cde14f4c2@ozlabs.ru>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <999ca679-6d56-97ee-8ae5-7526617ba137@huawei.com>
Date:   Fri, 13 Nov 2020 14:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <40b1b70f-16d9-01c4-c045-508cde14f4c2@ozlabs.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 14:39, Alexey Kardashevskiy wrote:
> Fixed already
>
> https://ozlabs.org/~akpm/mmots/broken-out/panic-dont-dump-stack-twice-on-warn.patch 
>
>
> Sorry for breaking this :(
>
OK.
