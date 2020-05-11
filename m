Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897EF1CCF08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 03:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEKBMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 21:12:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbgEKBMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:12:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A16BD23D88B576970A90;
        Mon, 11 May 2020 09:12:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 May
 2020 09:12:05 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Fix wrong stub helper
 update_sit_info
To:     YueHaibing <yuehaibing@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <hridya@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200509112135.51960-1-yuehaibing@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <684636ce-5bcc-328f-b7dc-dfdee06f41cf@huawei.com>
Date:   Mon, 11 May 2020 09:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200509112135.51960-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/9 19:21, YueHaibing wrote:
> update_sit_info should be f2fs_update_sit_info,
> otherwise build fails while no CONFIG_F2FS_STAT_FS.
> 
> Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
