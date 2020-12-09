Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F22D3812
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLIBEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLIBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:04:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F03C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 17:04:06 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y10so43124plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 17:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tt5NYYW3eD0CdG20YGbejb4+Hp9N0V37FHt2G4ZFsdk=;
        b=oyVudvZzPBxsLchBZ1RZ/5QowY9BdvvIe7OLQf2UDsbBXc7aYgEddgLgwUcOeUYl0J
         ZWfeTd/a9TEv5XYDG9XNXnry0r+TOeCEXSOumRtCXHkFyp68Uq/W5HYXRQaPdAMbQm+r
         Jkq4EPXkHa+gG0+KaUCAJjydTChXQnaDG8aorcaRXejDdzsb1NvrP25eF9zHvp3+RPqL
         F/BJZ9UHbgl5dA88CJlvXKIL4E+2KpPjttxAjshgJvmB+n8ElMInplyTp68ocr4kQ0MJ
         4y3fbaSl3aStgBCYVWXnovLQ4ikUaRAXdBudH+LrlIkaxsNs+SZVGqazNclxMxjuP0CY
         x/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tt5NYYW3eD0CdG20YGbejb4+Hp9N0V37FHt2G4ZFsdk=;
        b=KCXRE4P4ErUpZlQiKkUD5x7CvGVWpvvVZssUm17KRC1pJGiV066VcyZPDNx34RDIYv
         KlY1s641PEuyaqNY7bx5QShaAQz7CvrxiGXgJGlwUtW7tvNlGciMbA/ydSqiiWbTo9Pn
         q/e+Ioh6hl0WRinWUZX+IEgC0lBHpUDwXyTWJVMN5grpNv5Z4cDgsB3hCFysl9ELtfYH
         Do23w0JZ2MXuJHhib9QIHb+chZXibFHIbxDOoDER4SfHPJbzFVrbdszFFjN8JJZ3v6QB
         mVp5MWT4Q4X8QIx5bL2idaRKxJOmLtggCMzJPj5BQjuT/IYkeNmjFoFoqfT459UFtASh
         mJyw==
X-Gm-Message-State: AOAM530gh9XBQ5qQNX9MGVxaSDfChjl+G6Lp+oflhRUkn60GmcygiC5c
        bUbZaP/ZEu0n2PLF7VePVLo=
X-Google-Smtp-Source: ABdhPJy0+zbewDlJmiKqfyXzKu3doGknUn+AKerzZRVTMbOnpCaVnO9XNvo8QY5yr7VH+hCUIginAg==
X-Received: by 2002:a17:902:848e:b029:d6:d2c9:1d4c with SMTP id c14-20020a170902848eb02900d6d2c91d4cmr172237plo.40.1607475846101;
        Tue, 08 Dec 2020 17:04:06 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id y24sm9467pfn.176.2020.12.08.17.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 17:04:05 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:04:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201209010403.GC1667627@google.com>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5c9bhn.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/08 23:36), John Ogness wrote:
> On 2020-12-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> Sigh, atomic64_read() uses a spin lock in the generic implementation
> >> that is used on some architectures.
> >
> > Oh... So on those archs prb is not lockless in fact, it actually
> > takes the spin_lock each time we read the descriptor state?
> >
> > 	desc_read()
> > 	  atomic_long_read(state_var)
> > 	    atomic64_read()
> > 	      raw_spin_lock_irqsave(lock, flags)
> > 	        << NMI panic >>
> >
> > Am I missing something?
> 
> For the state variable we chose atomic_long_t instead of atomic64_t for
> this reason. atomic_long_t operations are available atomically on all
> architectures.

Right. Looking more at Kconfigs, it seems that when atomic_long_t is
atomic64 (64BIT) then GENERIC_ATOMIC64 is not selected. Those archs
that select GENERIC_ATOMIC64 unconditionally all seem to be 32-bit.

Thanks.

	-ss
