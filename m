Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB42F65A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhANQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhANQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:19:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD39C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:18:52 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:18:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610641131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CU79fA3lQLU/0BgP+JVmOi9jW4RAszez+BU2b1uN+Ec=;
        b=0VUiS79Kr7Is4ga1h97stZ/TktYHG9GYuiftNyrdufmYVgr836jkryW1o6O/wTWQLd4QHN
        sa9AUDMaeA2JdwtgZSdHseHwoi8e6VZw6/nu7MsRKagT+McL7f5LfcEZwOz4bJQjF3YIpz
        P1r7wD4a+CF3Ih1+CzrCkKfFDvpY6KWMMEkAc6SQp7RjS6jdgelUxY7vp+Pys+OkbKIdmq
        gGDm0o6bNkZ73iTIOtez2jNo6nrRbqvXKXzH/5FETZNTh1A/qZQRlCUBH2vXTVsBNqWGEv
        b832ICCjrqUJLtWXO3PRQ2adHt32uSYxO9X9tAEUYR+rATzhqXIQ7Oo7mZk1wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610641131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CU79fA3lQLU/0BgP+JVmOi9jW4RAszez+BU2b1uN+Ec=;
        b=6sOM9PYjpHws9X17B3qPBB41OsMNIhLDKK2GdRYI5E/7iZ0xJ/UuHDnfLf6W+lFOhm8AMg
        ykTOJSe7TktJNsAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <20210114161850.zjcfhsgtmojjjqba@linutronix.de>
References: <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
 <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com>
 <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
 <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
 <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com>
 <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-23 19:25:02 [+0100], Vitaly Wool wrote:
> > write the following patch according to your idea, what do you think ?
> 
> Yep, that is basically what I was thinking of. Some nitpicks below:

Did this go somewhere? The thread just ends here on my end.
Mike, is this patch fixing / helping your case in anyway?

> Best regards,
>    Vitaly

Sebastian
