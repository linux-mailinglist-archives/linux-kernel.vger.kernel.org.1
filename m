Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9E2F7E56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbhAOOeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbhAOOeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06050224F9;
        Fri, 15 Jan 2021 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610721219;
        bh=JlKooYtElvoBMZ5GgPDQkCOzjeZLLHw0zI1ErnpiMME=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n84OuihdpxPZSCEyu2+9PdEdvMGODoT7rfwGJKCJVQu+RWVvZv7kKTdyzVBwQHjER
         /KgPuCh4t/3RrSVuGEFnO+43KiugUEQ+1pxhLEnOjG+VoqPXRith5tGebZky3XctZ7
         9vr+OIFeQnvqJPT313tBjeqbN2pO1vMzzFVrgPd7G5/h/7GEARTEleX6E83tTcZX4s
         f9LhQFOfAALetyeqoqT7wmf/2P/sel/bHB16EPXoStanCObOLhU3kP3C9tXWux6noH
         zaIb/UlThPWSsDD5ji8nY7q/9pFPFO5YQXKqPfPQyHG3SJ7Exv3FapLkH54c1lrrKy
         S1MzyvnqxCn9Q==
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: introduce checkpoint=merge mount
 option
To:     Daeho Jeong <daeho43@gmail.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daehojeong@google.com>,
        Sungjong Seo <sj1557.seo@samsung.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210114062302.3809664-1-daeho43@gmail.com>
 <965dc435-c0a0-36ca-7e97-c3aaa3831bff@huawei.com>
 <CACOAw_x4R+rWZbi4TQym_sWuyqOGRR5w3iOs1A+e+g=ZT5k7FQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b64dc9dd-9f22-cb91-c633-d7bbc74abf72@kernel.org>
Date:   Fri, 15 Jan 2021 22:33:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_x4R+rWZbi4TQym_sWuyqOGRR5w3iOs1A+e+g=ZT5k7FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/15 22:00, Daeho Jeong wrote:
>> ktime_get() returns time based ns unit, in extreme scenario, average
>> time cp cost will overflow 32-bit variable, I doubt.
>>
> sum_diff is already turned into msec using ktime_ms_delta() above.

Yup, I missed ktime_ms_delta().


On 2021/1/15 22:23, Daeho Jeong wrote:
 >>> How about updating queued_ckpt and total_ckpt in batch, update atomic
 >>> variable one by one is low efficient.
 >>>
 >> You mean like using spin_lock()?
 >>
 > Ah, you mean like updating these values as much as the count of the
 > loop at once?

Correct. :)

Thanks,
