Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568A129DF82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgJ2BB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:01:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6569 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgJ1WRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLfXp16fvzhcmf;
        Wed, 28 Oct 2020 14:58:02 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 28 Oct
 2020 14:57:56 +0800
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
To:     Robin Hsu <robinhsu@google.com>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201026094000.1500425-1-robinhsu@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <299c9027-e137-83ff-b2ba-8af07144a488@huawei.com>
Date:   Wed, 28 Oct 2020 14:57:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201026094000.1500425-1-robinhsu@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/26 17:40, Robin Hsu via Linux-f2fs-devel wrote:
> 'ret' should not have been used here: otherwise, it would be wrongly used
> as the error code and then be returned from main().
> 
> Signed-off-by: Robin Hsu <robinhsu@google.com>

BTW, how about changing 'ret = EXIT_ERR_CODE' to
'ret = FSCK_ERRORS_LEFT_UNCORRECTED', it's not critical though.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
