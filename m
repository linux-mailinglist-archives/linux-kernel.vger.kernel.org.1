Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563AD218389
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGHJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 05:27:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbgGHJ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:27:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EFDBAB1C5CF60D313BD1;
        Wed,  8 Jul 2020 17:27:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 8 Jul 2020
 17:27:46 +0800
Subject: Re: [PATCH 0/3] clean up some functions in mm/swap_slots.c
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200430061143.450-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b5c00915-6735-3519-5623-0837c129a177@huawei.com>
Date:   Wed, 8 Jul 2020 17:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200430061143.450-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all:
  Are these patches acceptable？
  All these three patches are "Acked-by: Tim Chen <tim.c.chen@linux.intel.com>" two months ago.

On 2020/4/30 14:11, Zhen Lei wrote:
> When I studied the code of mm/swap_slots.c, I found some places can be improved.
> 
> Zhen Lei (3):
>   mm/swap: simplify alloc_swap_slot_cache()
>   mm/swap: simplify enable_swap_slots_cache()
>   mm/swap: remove redundant check for swap_slot_cache_initialized
> 
>  mm/swap_slots.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 

