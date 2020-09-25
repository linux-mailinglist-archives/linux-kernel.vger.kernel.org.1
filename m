Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECD27949A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgIYXRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgIYXRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:17:15 -0400
Received: from [192.168.0.108] (unknown [49.65.245.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D042074B;
        Fri, 25 Sep 2020 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601075834;
        bh=EbJfwvBeHXIYBXTTELse8un9TJ2c/bhePB4Xfufh4yI=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=sGBG9THcIeHUpPQzlCVRHKRzBldFa0OoegE5xBKJJDE09XngNv7EhKTWvzGyqXUJP
         SReJNDgIo2CBwnM1FFUKm9UpgaEZW/roKBqoHjNFHaB2AdddeTjFF6VPx0IbP0AgfT
         Trqfe2ACwHH/Wd3NfuSZIbJVEjuvWVL4XUac/Ki8=
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
 <20200925163819.GA3315208@gmail.com> <20200925164538.GB3315208@gmail.com>
Cc:     syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
        glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Chao Yu <chao@kernel.org>
Message-ID: <36d3ddc1-e8d1-6d0e-c1ea-aff198740182@kernel.org>
Date:   Sat, 26 Sep 2020 07:17:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200925164538.GB3315208@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-9-26 0:45, Eric Biggers wrote:
> On Fri, Sep 25, 2020 at 09:38:19AM -0700, Eric Biggers wrote:
>> On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
>>> Hi,
>>>
>>> I don't see any problem here, thanks for your report. :)
>>>
>>> Thanks,
>>
>> What about if max_depth == 0 in __f2fs_find_entry()?  Then __f2fs_find_entry()
>> would return NULL without initializing *res_page.
>
> ... and I now see Dan Carpenter already pointed this out.  I was a bit late!

Thanks for your check as well. :)

Thanks,

>
> - Eric
>
