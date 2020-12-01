Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB12C9CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbgLAJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:00:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8542 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbgLAJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:00:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClbdT3v1SzhlNJ;
        Tue,  1 Dec 2020 16:59:41 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 1 Dec 2020
 17:00:02 +0800
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: use new conversion functions between
 blks and bytes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
CC:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
 <20201126022416.3068426-2-jaegeuk@kernel.org>
 <20201201040944.GD3858797@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <57ca6cbd-6378-6ede-dc4a-47e0dfc0f13a@huawei.com>
Date:   Tue, 1 Dec 2020 17:00:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201201040944.GD3858797@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 12:09, Jaegeuk Kim wrote:
> On 11/25, Jaegeuk Kim wrote:
>> This patch cleans up blks and bytes conversions.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
