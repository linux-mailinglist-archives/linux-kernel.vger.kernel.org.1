Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF61C2CE86F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgLDHKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:10:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8942 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgLDHKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:10:08 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CnP2P1WrBzhlvv;
        Fri,  4 Dec 2020 15:09:01 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 15:09:20 +0800
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com> <20201204003119.GA1957051@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d713f69b-af1b-4e4a-41ad-267a3b9026ac@huawei.com>
Date:   Fri, 4 Dec 2020 15:09:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204003119.GA1957051@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 8:31, Gao Xiang wrote:
> could make more sense), could you leave some CR numbers about these
> algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
> cluster size?

Just from a quick test with enwik9 on vm:

Original blocks:	244382

			lz4			lz4hc-9
compressed blocks	170647			163270
compress ratio		69.8%			66.8%
speed			16.4207 s, 60.9 MB/s	26.7299 s, 37.4 MB/s

compress ratio = after / before

Thanks,
