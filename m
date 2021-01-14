Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2140D2F65FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbhANQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhANQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:30:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F201C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:29:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h205so8863387lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhivDocjQjO6hOpCGfibEH2/3UBbIKLAOQt6lfMtD7Q=;
        b=QX5mrJ484oA8dIkTLxc0SZYKsULVMwzfvpG0unk5iF6xOWcdm+oVkVQV2E1EQrByFd
         7ucMjpdm7yoe7DiPulTA+DXlO0g0pARxIvYt5KtOnbBe0h6YR6rNHYrpPLzptWcmP7PP
         FWpGnEZ7/FXtkVXj8Aj3OUTbCf0XQc/raR66w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhivDocjQjO6hOpCGfibEH2/3UBbIKLAOQt6lfMtD7Q=;
        b=l5/YbcOppIi0P3iDLPm9+OuRKrakGgdP5YZA+4sKPIfUwvmOCRHjfpthXvaPYFCVd1
         DRZBqZSqajdnOFSb/cHRI/JTACkJdsAbTxy+s6Yn0HaUB4xmdIGZQNutd964o4ROHM7U
         dKOL6LLkd7X9bGJkSeKaLqNrYdiw5zEmYR9l1bx0xhU1PmofeXKu6b/mFzaMkSF7bpmj
         UDchyCCe6rrhjg5kAmRt1PMWjKsqiXy/YYj4fcs9/7LwM7yLxyq7xAZdxB2VGlUkfODR
         TGvbn5MVi/+aWe9fU07W3tv8KXzwLF0oMZTFkiUwDYA6znMCxEAVRlyY/rv3OpDaRfTS
         V3HA==
X-Gm-Message-State: AOAM5309IFfZ6dXX2wX0Mxi5h41r1Ato7AIO4oGuTdsE5gg1lrSW31pX
        fT839NViv9+lmR5wqdHXIXDG1fWBAAsUdfayWPsdkgelRNHzhg==
X-Google-Smtp-Source: ABdhPJyBHPibmyKBFVkzIPGSXP/+pUyRb5YaXltlT62UUzX/ghjVT2Oyh1EYU3Opk9MeTOFBkBcF1JO7+eQJ1xAWxUI=
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr3451673lfq.585.1610641789060;
 Thu, 14 Jan 2021 08:29:49 -0800 (PST)
MIME-Version: 1.0
References: <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
 <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com> <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com> <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com> <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com> <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
 <20210114161850.zjcfhsgtmojjjqba@linutronix.de>
In-Reply-To: <20210114161850.zjcfhsgtmojjjqba@linutronix.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 14 Jan 2021 17:29:37 +0100
Message-ID: <CAM4kBBKcj+ZVEv8mkh+rWc0xbomKsyc60UNuuRem_iWPf9YxVA@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, 17:18 Sebastian Andrzej Siewior,
<bigeasy@linutronix.de> wrote:
>
> On 2020-12-23 19:25:02 [+0100], Vitaly Wool wrote:
> > > write the following patch according to your idea, what do you think ?
> >
> > Yep, that is basically what I was thinking of. Some nitpicks below:
>
> Did this go somewhere? The thread just ends here on my end.
> Mike, is this patch fixing / helping your case in anyway?

Please see
* https://marc.info/?l=linux-mm&m=160889419514019&w=2
* https://marc.info/?l=linux-mm&m=160889418114011&w=2
* https://marc.info/?l=linux-mm&m=160889448814057&w=2

Haven't had time to test these yet but seem to be alright.

Best regards,
   Vitaly
