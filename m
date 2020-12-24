Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE12E23CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLXCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:53:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10356 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLXCxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:53:48 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1ZP20f55z7JrS;
        Thu, 24 Dec 2020 10:52:22 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 24 Dec
 2020 10:52:57 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Replace expression with offsetof()
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20201222133415.19915-1-zhengyongjun3@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <36c3cca5-8bd0-19e3-9298-9a67403c5ca4@huawei.com>
Date:   Thu, 24 Dec 2020 10:52:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201222133415.19915-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/22 21:34, Zheng Yongjun wrote:
> Use the existing offsetof() macro instead of duplicating code.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
