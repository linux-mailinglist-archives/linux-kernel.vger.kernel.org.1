Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0349D28745B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgJHMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgJHMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:37:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F0C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 05:37:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so2697319pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cb4YJZnoQoGqK1LKwtvMQqiOZjH7yJF3J75UsweUkfA=;
        b=s8FL/Z1r05oYpewIbdP8y8xWKTvAKkCc6sH2RBuhJA77e69NOeK20VP6Yn9lyrrraJ
         MAiqLLLC8Ah/OMRqUDnesEVprGx3fhVZJBb9ahzenz6S1bQP36Aj8zfS09B/6HB5eokA
         CMjjtKRJcftJspsKP7yKfbLCxEuvfruo0gpmsdtOUyoFEbfVAPpoBSTPYh5LIIIsBdhx
         J3PHdwsSFjBz+M0rUmUs8YF7IS3nn43I1zC0bWOfW7CVGPci/6eBcvINYKVDQu/JraEq
         vLnZn26Zmgkq8P0s/IO8n3p0lSA+y9c/7LyAweB26wGu3zq5JcwvYIfClQLyCzqL9+7v
         IiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cb4YJZnoQoGqK1LKwtvMQqiOZjH7yJF3J75UsweUkfA=;
        b=h5gCTYALq4js1KOMbuM5g6gV0BQ0giQhdLr1a+gN8GDZmQioPbtXOYCBPIjjBiHC7U
         NpLlsNZZhHkHIYEBIqn816IsMvDA89IzOmm/XPkChortZ01ig8Qukp9sLsitWdLbujKT
         FXnsV+17cCnT5q9trvSHj82QpxkzTdwdk1wjiBKL9TB9G3sJ7FjJKVrTEWrMYL2p4J6H
         nutIzl1uU0gKgU1JD8P6L6cD2NF7l9BcuiW9DzhK0uontkDa8DBsEMBHRXLW0x9OmCoX
         AtHGe9Bi7q1aAB1Wry4wBvFI/v1boHIFC2AHf6Drrt2sTG7FAvNu6wbfWdNeQHHEZyaK
         3Gmw==
X-Gm-Message-State: AOAM5339L26ncLPBTiNynmEENspDbIJLJ4rM+nZgp5NNpj0kM45AqZxX
        ir2LLhziGkxBHcrfTcP8lzQ=
X-Google-Smtp-Source: ABdhPJyeSDaJSVcX3ZPz7sgS9WChONcWMQRI8Hr06YA0Cr03xrGtCT0LLA786WePUkTc5YgaJX6DCw==
X-Received: by 2002:a17:902:67:b029:d2:564a:e842 with SMTP id 94-20020a1709020067b02900d2564ae842mr7554414pla.4.1602160669104;
        Thu, 08 Oct 2020 05:37:49 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m11sm6821896pfk.57.2020.10.08.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 05:37:47 -0700 (PDT)
Date:   Thu, 8 Oct 2020 21:37:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008123745.GC127397@jagdpanzerIV.localdomain>
References: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <20201008085008.GA16837@alley>
 <20201008122042.GB127397@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122042.GB127397@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/08 21:20), Sergey Senozhatsky wrote:
[..]
> > > Let me dump my findings so far. I still don't understand what exactly
> > > crashes the laptop (blank screen is not very helpful).
> > > 
> > > So, things start with the "preferred_console = -1". In console_setup()
> > > we call __add_preferred_console(). Since we have no consoles, the
> > > name matching loop is not executed, and console selection counter remains
> > > at 0. After the loop, despite the fact that we don't have the console
> > > (`name' is empty), we still set `preferred_console', to 0.
> > 
> > Heh, we actually add the console.
> 
> To the console drovers list?

Oh, sorry, I realized that you were talking about __add_preferred_console(),
not about console drivers list and console registration.

Well, yeah, that's funny. We sort of add preferred console. But since
it has empty name it's not recognized by printk as legit console. So
essentially it sort of does not exist, yet the preferred selector tells
printk that console does exist.

	-ss
