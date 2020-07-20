Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7346225EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgGTMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 08:38:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728200AbgGTMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:38:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47BB1A1FCCCF437FFB8A;
        Mon, 20 Jul 2020 20:38:19 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 20 Jul
 2020 20:38:14 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: Avoid memory leak on
 cc->cpages
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <6074306e-e909-e17f-900c-320245a8f869@web.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8be91065-7c85-9501-f1c2-3cf11aab85a5@huawei.com>
Date:   Mon, 20 Jul 2020 20:38:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6074306e-e909-e17f-900c-320245a8f869@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/20 19:31, Markus Elfring wrote:
>> Memory allocated for storing compressed pages' poitner should be
>> released after f2fs_write_compressed_pages(), otherwise it will
>> cause memory leak issue.
> 
> * Would an imperative wording be more appropriate (without a typo)
>    for the change description?
> 
> * Will the tag “Fixes” become helpful for the commit message?

It looks this is replied from patch-robot? since I found all comments
you replied are almost the same.

And what's funny is that the reply starts being caught by another patch-bot
from Greg...

https://lkml.org/lkml/2020/6/28/157

> 
> Regards,
> Markus
> .
> 
