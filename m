Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2F2F1021
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbhAKKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:32:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10954 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbhAKKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:32:38 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DDqk44DKGzj4xl;
        Mon, 11 Jan 2021 18:31:08 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 11 Jan
 2021 18:31:54 +0800
Subject: Re: [PATCH v3 1/5] f2fs: compress: add compress_inode to cache
 compressed blocks
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210107093126.116958-1-yuchao0@huawei.com>
 <X/we0NoUqAwuW82+@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6b0060b9-460a-617a-3778-e67f35d551f0@huawei.com>
Date:   Mon, 11 Jan 2021 18:31:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X/we0NoUqAwuW82+@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/11 17:48, Jaegeuk Kim wrote:
> Hi Chao,
> 
> After quick test of fsstress w/ fault injection, it gave wrong block address
> errors. Could you please run the test a bit?

Jaegeuk,

Oh, I've covered with fstest cases and there is no such error message, let me
try fault injection + SPO case soon.

Thanks,

