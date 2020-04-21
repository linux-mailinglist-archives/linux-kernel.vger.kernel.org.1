Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6674D1B252E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgDULf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 07:35:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgDULf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:35:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5100D55BC0460382B078;
        Tue, 21 Apr 2020 19:35:53 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 21 Apr
 2020 19:35:49 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant assignment to variable
 err
To:     Colin King <colin.king@canonical.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200420220057.98796-1-colin.king@canonical.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <881187e9-68c0-6766-d462-881371973974@huawei.com>
Date:   Tue, 21 Apr 2020 19:35:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200420220057.98796-1-colin.king@canonical.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/21 6:00, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being assigned with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
