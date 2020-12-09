Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F42D4043
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgLIKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgLIKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:46:57 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3F5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:46:17 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so745583pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13Rn7jh3b3TjSNdG/NRwwmrqyqpxZcBccJA2fkW9O6Q=;
        b=JMKpByMlVjcEJj9bv08rD0dOIJ/kIYPvIrrdUzhle4cH0cx6SU2BNTJ1LoH+2CeXwQ
         M+TDc3W+rAovxErKzyMcPUI8RcoyqPR/5KXdvrEe7L2d69j+5E9Ccrqra6/f8SA8lpfV
         SBAB6r5j56Voq52JfrI+5G/BAhd7jkqXPhLzKtHmB4KIf5g8/l6otdBx0sPnpgrQFv6L
         DHjFCpgTMTHbtbxzM8Cp+bfec8n9PTw8zO9fnYvZhSXQ+2pvow3i1gKHWYW46UcqZk9r
         /3flwNk+xboF8niYe21SpQxTU+f2vV6QJkPRwy3Agrd8dfISpPo1ZYASb1fOlfB2/iNs
         LGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13Rn7jh3b3TjSNdG/NRwwmrqyqpxZcBccJA2fkW9O6Q=;
        b=JX1wTY9ZBeRpN0uMyDwKm007PIT+xBKhw3ARlzR9hCbb6kWV266pDNZOWpYpqjeelP
         zEeIPLfX4KGdK7dobzfRQujCPjLohyXMgS34dkCmsQwDvhIbA3dCtw6UIe5gzCV5w1zh
         sYdTqvYuc1i1m6dZ9huKhvc6UCVzf8ZLNeCPs79MmdDmHNpvMGAaiS2qZIbCq46KebJc
         ebHXIwCgQZqa/lxZIk1Zm7yhD2lToRmsW8V34V2dYJIKL7jTJK73mOseLeSj/fvx+Z49
         ukBYD12Tj9p7y9s6cirSGg2mCbrKlJkBR9u344+mpWfF/8zIuUN5h/PejxLSa/S66u0Z
         c+9A==
X-Gm-Message-State: AOAM531bhBI5tuKnJHxnqYYIty1K/cIXuOaXAbhSHL5kjdB4EpMyLHlX
        76wNMesqk1eQuMMuRr6msI5SuGz8uHx6rQ==
X-Google-Smtp-Source: ABdhPJz0Nuw0n2FzUX5G5rCbfjmHOibelJ45uwdQ/mRHGbVhGPxtL7nfz0Lzbkw5S3cHdNQ1LbO+dQ==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr1395763pgi.261.1607510777231;
        Wed, 09 Dec 2020 02:46:17 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o62sm1847186pjo.17.2020.12.09.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 02:46:16 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:46:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <X9Cq9SMaCy3lGhXJ@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
 <20201209081623.GI2414@hirez.programming.kicks-ass.net>
 <20201209092204.GD1667627@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209092204.GD1667627@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/09 18:22), Sergey Senozhatsky wrote:
> > 
> > Please put on your eye cancer gear and inspect the atomic implementation
> > of PA-RISC, Sparc32, feh, I forgot who else.
> > 
> > Those SMP capable architectures are gifted with just one XCHG like
> > atomic instruction :/ Anyway, as said in the other email, they also
> > don't have NMIs so it mostly works.

PeterZ, thanks for the pointers!


> Hmm, wow. OK, I definitely want to look further.
> 
> When some CONFIG_DEBUG_FOO_BAR code wants to pr_err from prb->atomic_op
> on those archs then we deadlock in printk once again?

E.g. arch/sparc/lib/atomic32.c

	spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
	atomic_foo()
	{
		spin_lock_irqsave(ATOMIC_HASH(v), flags)
		...
		spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
	}

So another potential re-entry path is

	atomic_foo()
	 spin_lock_irqsave(ATOMIC_HASH(v), flags)
	  printk()
	   prb()
	    atomic_foo()
	     spin_lock_irqsave(ATOMIC_HASH(v), flags)

which can deadlock, in theory, if both atomics HASH to the same
key (same spin_lock).

I wonder what else am I missing.

	-ss
