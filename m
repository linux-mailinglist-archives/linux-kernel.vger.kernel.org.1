Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5555E27A553
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1CHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgI1CHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 22:07:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06508C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 19:07:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so6925158pgo.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 19:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGsX21ljFjqhDy91LfP82RiAAmGC1fdjtYTx0gxvs+A=;
        b=e4rQ4W8Xhp4Bg5H+P02CiNhfbWk5y8lTrzPWk0fLFHJyVc72jIPJd9j85HH6Jah0Mk
         Kdr+hboZHB0cadXcHKD6/funWe4NWsG/EHgvLrxcPYf1LVLA2N5bQuPdDotpIy9fE6wR
         3xbV4r5aYRh33EcMjb8ao7zVxsnQsyIzbmkK9/319Vx3ZaUUw5NJoGAqOtT876JQgdF7
         E56fcK1sh6ehbTyXfKVPvDL3OCZHAgZ29+HCIdXngRwvZgiOrOg5SVN44Z7dSJwqchhm
         vSLPZpO2CQK6i6gEJwVYDzQ4lMe6bc7gSi22bxx1DIC6B+96Tu+C+0DxDQo1m5YEetO4
         3Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGsX21ljFjqhDy91LfP82RiAAmGC1fdjtYTx0gxvs+A=;
        b=pWCLwts3mtpWili0AhP8VJ7jxTc54MMtZYl1UpCdrnlFJam6uBJqPD4JXPeziwRpaR
         I2QXWz+av/+nGII3ETGPMh7hhQDXEorbQKts6fWCUBGI2WpFCU4O6TTzuUEX7Yk6Ckou
         QNLFokE3ClnGZGOEnc1q39mFRXgFRNDCkQuqMNokT0dIEDKIJ2QVeTZsWx/6fq3A2pNn
         KDmRIjNx3mNGt8s3UB8KLRN+/JIGE9PkgqTx1yYkhv/8K3z1c6LuTmGjPuAJs2hgW2fE
         KP5IzDqGZXZ0OjVtfcmejTKxQ5jfqwM6Pujzblxzx7Rett2n/v1ygwlhu909odXTqkz3
         wnPg==
X-Gm-Message-State: AOAM532/OsSH1eegt606qr9yvVHv+Fnx5cJenoZM784ys58a1e+b94+M
        81NOjNleDO+qA54z5phBeDA=
X-Google-Smtp-Source: ABdhPJxzPDfKZ1m2ihcznouH4FTWNhaF2WKONPTJBe0rw/ArjZAkRoOfdB5sg+TInHOYrsGoiiox6Q==
X-Received: by 2002:a17:902:8d86:b029:d1:9237:6dfd with SMTP id v6-20020a1709028d86b02900d192376dfdmr9333630plo.22.1601258874421;
        Sun, 27 Sep 2020 19:07:54 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e17sm9451626pff.6.2020.09.27.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 19:07:53 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:07:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: KASAN: global-out-of-bounds in console_unlock
Message-ID: <20200928020752.GA871730@jagdpanzerIV.localdomain>
References: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing John and Steven

On (20/09/27 11:12), Dmitry Vyukov wrote:
> Hi printk maintainers,
> 
> I've got the following out-of-bounds in printk code.
> This is on next-20200925. Config is attached.
> This is just on pr_cont("\n"). Something overreads the string.
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in memchr+0x65/0x80 lib/string.c:1058
> Read of size 1 at addr ffffffff8c68c860 by task swapper/0/0

Thanks for the report. I think this should be fixed by
https://lore.kernel.org/lkml/20200926015526.8921-1-john.ogness@linutronix.de/

	-ss
