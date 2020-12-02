Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DF2CB282
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgLBBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:51:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8902 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgLBBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:51:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cm23v4Ql1z73g6;
        Wed,  2 Dec 2020 09:50:35 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 2 Dec 2020
 09:50:56 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Remove unnecessary unlikely()
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <tiny.windzz@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201201071739.13301-1-huangshuosheng@allwinnertech.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a79534af-b1c2-4b1d-bc09-b0727147623d@huawei.com>
Date:   Wed, 2 Dec 2020 09:50:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201201071739.13301-1-huangshuosheng@allwinnertech.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 15:17, Shuosheng Huang wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> WARN_ON() already contains an unlikely(), so it's not necessary
> to use unlikely.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
