Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193BB2F6765
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbhANRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbhANRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:19:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:18:57 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:18:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610644735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI5rqRnH3DCVyrdpP47Z8eWUhdxkk1qxR9tqMltfpqo=;
        b=HrnGJ0ppZoIgnbL5tUjMaeKjd3R7QOpSesNLWzhETK5vNb4IbQwexAENRXrEGG9xQtjluD
        KYZuguLbWwc3dew6EIVyUZPnWTCng+Bkmu4SZygmK6wzagLQBnYmzYsyspO0zyLoOpDaem
        BeX0adNqYSPVWIO0vZAdOHCatFDHZZ8PRXBmvStHtzNiJMSmJMdbJ3wuA/PTg1rRahOYqO
        QXfmZrcmJ/fsk1WRUo8ghsKTMHwptqS4nkrYzbNxd5iRTUUB3cnHccjWeJo1UeZ8ygZIFd
        nKVTDurwWY8QJL9NYPpWDJSPJkzyLkOW+zS7PRP6uxu0TlPoxORaRPMsTHmTLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610644735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI5rqRnH3DCVyrdpP47Z8eWUhdxkk1qxR9tqMltfpqo=;
        b=RzpQVmEx4C6cdB7OhXzZogS28Iox4XqOwFruHtuajjmy48uqB1yELmiYCKIoZD0nHNeVTC
        m1fqA/dizTA3amDQ==
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
Message-ID: <20210114171855.lzzxwpucpkjyhrch@linutronix.de>
References: <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
 <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
 <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com>
 <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
 <20210114161850.zjcfhsgtmojjjqba@linutronix.de>
 <CAM4kBBKcj+ZVEv8mkh+rWc0xbomKsyc60UNuuRem_iWPf9YxVA@mail.gmail.com>
 <20210114165645.czqpsk3lacmiyiik@linutronix.de>
 <CAM4kBBLqgh=ymq4pg6URB3OhjhRSH3O=4AEMRBuaC3Z0-hZ4Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4kBBLqgh=ymq4pg6URB3OhjhRSH3O=4AEMRBuaC3Z0-hZ4Lg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14 18:15:08 [+0100], Vitaly Wool wrote:
> 
> Basically, yes. Minchan was very clear that he didn't want to remove
> that inter-function locking, so be it.
> I wouldn't really advise to use zsmalloc with zswap because zsmalloc
> has no support for reclaim, nevertheless I wouldn't like this
> configuration to stop working for those who are already using it.
> 
> Would you or Mike be up for testing Tian Taos's patchset?

I will try to reproduce Mike's original report and the fix early next
week.

> Best regards,
>    Vitaly

Sebastian
