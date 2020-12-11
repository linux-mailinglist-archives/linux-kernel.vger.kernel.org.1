Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF532D7BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbgLKRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:02:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2250 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404134AbgLKRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:01:56 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsxmW0tS0z67Mtk;
        Sat, 12 Dec 2020 00:57:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Dec 2020 18:01:13 +0100
Received: from [10.47.11.239] (10.47.11.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 11 Dec
 2020 17:01:12 +0000
Subject: Re: [PATCH 3/3] blk-mq: fix msec comment from micro to milli seconds
To:     Minwoo Im <minwoo.im.dev@gmail.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
 <20201204152055.31605-4-minwoo.im.dev@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b74bc7af-fb69-fd6e-90d4-c765ed864202@huawei.com>
Date:   Fri, 11 Dec 2020 17:00:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201204152055.31605-4-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.239]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2020 15:20, Minwoo Im wrote:
> Delay to wait for queue running is milli second unit which is passed to
> delayed work via msecs_to_jiffies() which is to convert milliseconds to
> jiffies.
> 
> Signed-off-by: Minwoo Im<minwoo.im.dev@gmail.com>
> ---
Reviewed-by: John Garry <john.garry@huawei.com>
