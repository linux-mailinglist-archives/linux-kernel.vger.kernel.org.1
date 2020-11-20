Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51212BA230
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKTGRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:17:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8006 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKTGRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:17:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcmYN1Ys2zhdD3;
        Fri, 20 Nov 2020 14:17:28 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 20 Nov
 2020 14:17:38 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove writeback_inodes_sb in
 f2fs_remount
To:     Liu Song <fishland@aliyun.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <liu.song11@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201118140104.5825-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <862998f9-aac8-83e1-b11e-d70df3714e19@huawei.com>
Date:   Fri, 20 Nov 2020 14:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201118140104.5825-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/18 22:01, Liu Song via Linux-f2fs-devel wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Since sync_inodes_sb has been used, there is no need to
> use writeback_inodes_sb, so remove it.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
