Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1E71D6ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 04:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgERCZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 22:25:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727034AbgERCZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:25:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 766F4F215F752565CAFA;
        Mon, 18 May 2020 10:25:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 May
 2020 10:25:52 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint=disable:%u%%
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200516010416.116281-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <042c288f-3422-1529-4ce8-10b055b6a404@huawei.com>
Date:   Mon, 18 May 2020 10:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200516010416.116281-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/16 9:04, Jaegeuk Kim wrote:
> When parsing the mount option, we don't have sbi->user_block_count.
> Should do it after getting it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
