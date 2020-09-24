Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F00276C78
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgIXIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIXIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:53:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:53:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so3996296pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZz8GBFni4/MW//4LD+yLWvprptZbx5M3RuYhabnC/w=;
        b=s8hYmtvmKN7Twq+TkzgLKlDHHN2z/Gd+c5hbEk52p4aYGKBDCiITV/PrHIQ+lWRHQq
         LuM+JZWa60XTcraNNuze1pcyZMxUlOO/hWSZ/9do/w2IOOjcJVCpPT2R+rK31fVTB8e+
         b8JqQ1JiUJ9+CNyn1c9Ty7n4IFDjTUoVUtnws675mias/ogv4utu2Bmj4qcWHCxaUX8f
         d1b+ew+W8IRP7O9mZ5Uru0zTiRhMr2G+NdDnMH/0UkI3AK2a7KkvGXCYTvbMzgXP6blQ
         69fQzz0+XQtioG/jjCD43F/75oFAhqvSC0Nxh2nJCqpcJi/Mn76iuLFKvSHiF5MDSejz
         wl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZz8GBFni4/MW//4LD+yLWvprptZbx5M3RuYhabnC/w=;
        b=DId/0PY7Aitbp+iB2nIdxddvwRu1W3UFB3z+090nOsyWgT6pP9VK/RrvEatTpp7Dml
         yNKomScDlyUrOaR9yLL5NpbP71pcazkLkz3PJPqhp/Yus80WuV0SdkiT9iFpkj5+Q3ZU
         2Vpo+s2d0TWHL9W3elIyFsTj4Du8jsmmCFrYYe8ul8CIxv9rmXSqnnn6gTWTU3sYdtLc
         Xn6wVog9If+N59wjs6oKIZT7cpi60VIbaDKgcUbqfGyuJ5dk2gr5kboiY+4O+uZ6o/FR
         ee4iakIpZ/EiStwVpm4C4+oFfsP2Y1rFTMzb6s3aL1qZYfS4krjuFFVlAO5aFrjSz5xL
         y4BA==
X-Gm-Message-State: AOAM532Vq+X5wKVrydl8dWIR1kPRwB+TtRqSsoAOLpKjIMDjdNpvH/sg
        MDAnzhCsAY6bhsEv5msFad8=
X-Google-Smtp-Source: ABdhPJwWFY24zSGxrR6h1O4i8XEPsgKyxiiSZOeLuPBER2PTwa0BAnUaL723g1FXAsPxFo+wBQNG/g==
X-Received: by 2002:a17:90b:1741:: with SMTP id jf1mr2981275pjb.164.1600937626380;
        Thu, 24 Sep 2020 01:53:46 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x20sm2100236pfr.190.2020.09.24.01.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:53:45 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:53:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924085343.GB541@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <20200924054058.GE577@jagdpanzerIV.localdomain>
 <20200924084555.GJ6442@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924084555.GJ6442@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/24 10:45), Petr Mladek wrote:
> On Thu 2020-09-24 14:40:58, Sergey Senozhatsky wrote:
> > On (20/09/23 17:11), Petr Mladek wrote:
> > >
> > > AFAIK, there is one catch. We need to use va_copy() around
> > > the 1st call because va_format can be proceed only once.
> > >
> > 
> > Current printk() should be good enough for reporting, say, "Kernel
> > stack overflow" errors. Is extra pressure that va_copy() adds something
> > that we need to consider?
> 
> The thing is that vsprintf() traverses the arguments using va_arg().
> It modifies internal values so that the next va_arg() will read
> the next value.

Yes, I understand the purpose of va_copy(). I'm asking if we are
always on the safe side doing va_copy for every printk (+ potential
recursive va_copy-s).

> If we want to call vsprintf() twice then we need to reset the internal
> va_list states. My understanding is that va_copy() is the only legal
> way when we are already nested inside va_start()/va_end().

Yes, it is. My question is a bit different.

	-ss
