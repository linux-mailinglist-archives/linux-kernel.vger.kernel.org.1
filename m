Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDE28B14D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgJLJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:19:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbgJLJTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:19:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9361749BE495EE3BFA0;
        Mon, 12 Oct 2020 17:19:40 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 12 Oct
 2020 17:19:39 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix writecount false positive in
 releasing compress blocks
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201012045947.3622888-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <44ebf328-7d67-8826-9000-5858e8c11db8@huawei.com>
Date:   Mon, 12 Oct 2020 17:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201012045947.3622888-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/12 12:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In current condition check, if it detects writecount, it return -EBUSY
> regardless of f_mode of the file. Fixed it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
