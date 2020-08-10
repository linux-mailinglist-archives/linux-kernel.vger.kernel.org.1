Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2A240137
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHJDjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 23:39:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgHJDjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:39:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F32BCB6126B71AC1A4B4;
        Mon, 10 Aug 2020 11:39:50 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 10 Aug
 2020 11:39:43 +0800
Subject: Re: [PATCH] erofs: Convert to use the fallthrough macro
To:     linmiaohe <linmiaohe@huawei.com>, <xiang@kernel.org>,
        <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f8ff563e-3d20-fc44-37ca-7eb05407ddc8@huawei.com>
Date:   Mon, 10 Aug 2020 11:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/8 17:21, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Convert the uses of fallthrough comments to fallthrough macro.
> 
> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
