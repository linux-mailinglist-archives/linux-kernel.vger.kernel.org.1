Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D8276CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgIXJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgIXJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so757472pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glvDYGNjTmcJYt9UHJ/EtDQnKtOXTLQW97MGgahDhHg=;
        b=Ootls2FApOIHImzS6dH9p9IhwyZvLjCjxdwOj2hKsGhXNx+tS1luncq8bSBjkYO8sS
         Xzx96XlWJtq9cG2ZG/u/ul+GKLRC15cAnRVjKEvCRJqnDltLa6faRhl1CFw1R5jKCL/R
         +s3R8ss6PILJ+BGihZgwcGN+P49JIfJ+8gFih2pzchew8daEhZ5s+hnmqRVfRVaJ/fri
         RfiAAYsIBOqoaClXN+YD9jDe5cTieuODhD3rje9KXfbuQ8nhCRmb+PHWEqZ6Bd+2Kd5M
         7X5+CWikSRmfruOdMKDQOBE/W7P9ZLVb2OyofVKPor3tl/Rtmwehyl2pJKNdPrI4vB5E
         DGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glvDYGNjTmcJYt9UHJ/EtDQnKtOXTLQW97MGgahDhHg=;
        b=Civ/tAOsnyTefq25Ac/VIAza67G5jCsZTb9RhQ+cuawLmIBTs6QY/l3gOK21NJTe8Z
         0wB2u7lYQwZJUqEaVWiWEzFn1FAxx/tDeQHi2T106//06bFfhJN2PkRqsCWiFXoVDa2x
         BdNc7TvRch9Gnrb9KSLe76T3ERaIkPwC7rHc5BCCN/L3PxIbJy87DphYFlzvLWEfb+2e
         I3fCC3/FdD5u/U6vb4pLhlCTk+1+g2t6OcxzcmriV8p+IoQ0f84QrmT1qzzgNY0wo5Rv
         MktYCyXvL2jAxVT3UJ7X4bzlieD1HBXw31AALFGjyeY7qLHzvoxT+XpwbLXto7z/uDLs
         kwhg==
X-Gm-Message-State: AOAM530gmu8ipuiE812PbrIVErkEdQdVNUakI/gF7N250QhvKuF/hpxU
        nl9FLxnmN40lkTp7tno4Qqs=
X-Google-Smtp-Source: ABdhPJzen2q3Ea9oLPyMwYiiNrZ8J8ZQ74BBxBdfvP1b/YXYBd4JkN1Dgg+GPW3wZbkaW+Y65yad6A==
X-Received: by 2002:a05:6a00:8b:b029:14f:be90:a83a with SMTP id c11-20020a056a00008bb029014fbe90a83amr3600406pfj.70.1600938416124;
        Thu, 24 Sep 2020 02:06:56 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i9sm2274413pgb.37.2020.09.24.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:55 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:06:53 +0900
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
Message-ID: <20200924090653.GC541@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200924061746.GF577@jagdpanzerIV.localdomain>
 <20200924085445.GK6442@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924085445.GK6442@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/24 10:54), Petr Mladek wrote:
> > Just a question:
> > 
> > Can dynamic_textbuf be a PER_CPU array of five textbuf[1024] buffers
> > (for normal printk, nmi, hard irq, soft irq and one extra buffer for
> > recursive printk calls)?
> 
> That would be my preferred fallback when the approach with
> vsprintf(NULL, ) is not acceptable for some reasons.

OK.

> But I still think that calling vsprintf(NULL, ) is the most trivial
> and good enough solution.

It's probably good enough.

> IMHO, the solution with per-CPU buffers is not that trivial, for
> example:
> 
>   What if recursive printk() is interrupted by NMI and it causes
>   yet another recursion?
> 
>   Is one level of recursion enough?

We might try the current approach - when we, for example, have
recursion in printk_safe() we just end up writing data to the
same per-CPU buffer. We need to limit the depth of recursion
one way or another. With per-CPU counter we will just bail out
of "deeply recursive printk" without attempting to store its
messages; with the buffers approach we will write the data to
a static buffer and see how badly it will be overlapped at the
end. Just a thought.

	-ss
