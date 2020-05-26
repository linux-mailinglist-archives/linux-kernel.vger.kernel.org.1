Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9F1AB9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439202AbgDPH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:27:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439002AbgDPH11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:27:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 796BE80FCC6FEDB8FC34;
        Thu, 16 Apr 2020 15:27:25 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 16 Apr
 2020 15:27:24 +0800
Subject: Re: [PATCH] f2fs: Fix the accounting of dcc->undiscard_blks
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1587017861-6454-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ff0373a4-fe79-3de1-f535-06e168f86ffb@huawei.com>
Date:   Thu, 16 Apr 2020 15:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1587017861-6454-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/16 14:17, Sahitya Tummala wrote:
> When a discard_cmd needs to be split due to dpolicy->max_requests, then
> for the remaining length it will be either merged into another cmd or a
> new discard_cmd will be created. In this case, there is double
> accounting of dcc->undiscard_blks for the remaining len, due to which
> it shows incorrect value in stats.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
