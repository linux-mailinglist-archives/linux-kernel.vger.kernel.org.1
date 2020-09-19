Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0D270B12
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISGUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:20:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgISGUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:20:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 379CF27431EFBF991AD9;
        Sat, 19 Sep 2020 14:20:15 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 19 Sep
 2020 14:20:13 +0800
Subject: Re: [PATCH 4/4] erofs: add REQ_RAHEAD flag to readahead requests
To:     Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
 <20200918135436.17689-4-hsiangkao@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <006c92b6-d10a-088a-9a3d-4736de5e17c6@huawei.com>
Date:   Sat, 19 Sep 2020 14:20:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200918135436.17689-4-hsiangkao@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/18 21:54, Gao Xiang wrote:
> Let's add REQ_RAHEAD flag so it'd be easier to identify
> readahead I/O requests in blktrace.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
