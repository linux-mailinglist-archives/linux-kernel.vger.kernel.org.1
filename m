Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420CC2922F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgJSHZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:25:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727420AbgJSHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:25:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 590CA4BC37FAE14D9FAB;
        Mon, 19 Oct 2020 15:25:21 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 19 Oct 2020
 15:25:13 +0800
Subject: Re: [PATCH V2] mm: fix potential pte_unmap_unlock pte error
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <osalvador@suse.de>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>
References: <20201017021151.28104-1-luoshijie1@huawei.com>
 <20201019065912.GA27114@dhcp22.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <ed500ac7-0b67-cde1-57dc-ca7347fd8560@huawei.com>
Date:   Mon, 19 Oct 2020 15:25:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201019065912.GA27114@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/19 14:59, Michal Hocko wrote:
> On Fri 16-10-20 22:11:51, Shijie Luo wrote:
>> When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code breaks
>>   and passing origin pte - 1 to pte_unmap_unlock seems like not a good idea.
> This would really benefit from some improvements. It is preferable to
> provide a user visibile effect of the patch. I would propose this, feel
> free to reuse parts as you find fit.
> "
> queue_pages_pte_range can run in MPOL_MF_MOVE_ALL mode which doesn't
> migrate misplaced pages but returns with EIO when encountering such a
> page. Since a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
> MPOL_MF_STRICT is specified") and early break on the first pte in the
> range results in pte_unmap_unlock on an underflow pte. This can lead to
> lockups later on when somebody tries to lock the pte resp.
> page_table_lock again..
>
> Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
> MPOL_MF_STRICT is specified")
> "
I will take these in my patch description and send version 3, Thanks.

