Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9672922C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgJSHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:02:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbgJSHCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:02:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7EE5CA68E2D7D2CD371;
        Mon, 19 Oct 2020 15:02:38 +0800 (CST)
Received: from [10.67.103.212] (10.67.103.212) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 15:02:29 +0800
Subject: Re: [PATCH v3 0/2] uacce: fix some coding styles
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <f3c3371f-40aa-9a64-4238-d7e8d4f91713@huawei.com>
Date:   Mon, 19 Oct 2020 15:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hartman

Could you help to take this patch?
Thanks.


On 2020/9/23 18:09, Kai Ye wrote:
> 1. delete some redundant code.
> 2. modify the module author information. "Hisilicon"
> spelling is error.
>
> Changes v2 -> v3:
> 	Two things, splited to two patches.
> Changes v1 -> v2:
> 	deleted extra NULL pointer check in uacce_fops.
>
> Kai Ye (2):
>    uacce: fix some coding styles
>    uacce: modify the module author information.
>
>   drivers/misc/uacce/uacce.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>

