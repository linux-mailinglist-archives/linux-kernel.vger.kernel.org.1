Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F22D14F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgLGPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:42:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9CC0617B0;
        Mon,  7 Dec 2020 07:41:45 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607355704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tvO4PmPM4Ab6iPOra8TFrq2ZRXT3Xi2SqmN9MvXnt28=;
        b=pjeLAmKpGUur7O1GR8OWAhq53xC9AmW2OLRLKpWEl8cWoPgtzs5d4OGEYTee7WMNfic2D4
        XlJKxVIODQ1nZsAhI6iYhYxHh0gyoeuuUnRypM1lcTKOKlV7UdV2eNEYcY66vJ0Ka+VIJt
        lYE6xNPSojrIZJzle7Sn1obm+ruAWkJR8yn3oa7ieKToU0X1E7+YxU65GnEgTigxslQGj0
        J8ciuuV8dO6FOExQ5vaVn4CtpQTBnyCxbpjBRAGA/gXx3uzokt3bg3WEVvDjnKTOKKe10G
        DCAQ4MVz6obDaC1K4wHzMXzTrO5+xFwW55E5bN7yap2bf5jLYQcqIIJWnYWKFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607355704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tvO4PmPM4Ab6iPOra8TFrq2ZRXT3Xi2SqmN9MvXnt28=;
        b=leGJU6xVrEvuHYmiW1GAF6a4ze4XEuXc9geqMrEvhXnz89T2wA5Mj0jX9T1ehNAt0XBHTe
        jVIPZQ/kvGpItYAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201207154142.cwxhlv7cxor424rv@linutronix.de>
References: <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
 <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
 <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
 <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
 <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
 <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
 <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 16:21:20 [+0100], Vitaly Wool wrote:
> On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
> >
> > Unfortunately, that made zero difference.
> 
> Okay, I suggest that you submit the patch that changes read_lock() to
> write_lock() in __release_z3fold_page() and I'll ack it then.
> I would like to rewrite the code so that write_lock is not necessary
> there but I don't want to hold you back and it isn't likely that I'll
> complete this today.

Please with a

   Fixes: 4a3ac9311dac3 ("mm/z3fold.c: add inter-page compaction")

tag.

> Best regards,
>    Vitaly

Sebastian
