Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F41B1958
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgDTWYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 18:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDTWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:24:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:24:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b8so5643927pfp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DV6jlkNA0aYuGGTHJFqAlVIWbRQ6V/i9e8cl7YrriE0=;
        b=ubLDLsXEcS+gRy7NCuBS0U8hRfvDH8rbExG4hDMZ/UPB3Z0OlbN5956SCN9w+6vt4s
         i83qKMAoJ8s6PECVYrrc48ILh1tnEurqEwv6c7qI9bHt4RPg/ZBGxoaZyy/j42XiO4dZ
         szcTBlYZ8evRbhYds+7lmWbRUWuouJm359n2RL7FTpFj1Nv1nKihW9WTUcwiDozzD5WY
         y79OD8sZ5VE5Gw8TQs24EtaXvjyqhd4U03u/RPmN+nWebpW7jIQxR6i14XX2UtNodQmJ
         G8FQ1K1xAaTx89lJDQ/zwRRShkgammuw55ZrtUzq7jvDzTQEV7jKgg9hy2uo610Rayz4
         c41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DV6jlkNA0aYuGGTHJFqAlVIWbRQ6V/i9e8cl7YrriE0=;
        b=DvUrR2pCX8hYZwgqNN365p1hK8HnKgDduvly40Xl2ZfFAhNJJehpX7n8iwP2sto7Xh
         AEPRZTwb1bzZ+S5G8NYHQvmRdAshBKXYqAeeN4ei9HuybeoSAel7cK6bQDiZ8+Uw3Ufr
         85BPebC3lpXsMU7xZHdZb3pqMdqfKJPOlhPUAQl3QwmvgyUG1obWLC9e1MzqNUBx1/By
         fu7mSyVQ64slv3Z/sg2haVKoC0d+cHuNgBGBEYkvr5cd/0qFzRHvr7+JvPJNdmjS5bWV
         d/nkpnNFx+/xh+CC6lsagKFdZrRPC4ZrX2hfv6C1k3B6neBXDARIPkl8uWQP0BlUaCGA
         +L5Q==
X-Gm-Message-State: AGi0PuYHMv4b4Nja89ylenJktcQS5jd9HLxY3scN/c5MdeYekNGsZdfs
        gxdR5ZJPTqbXUAIFttm5fdLQ5A==
X-Google-Smtp-Source: APiQypK3lXJJ8OnZ7ClIxD0BeYEB6XEfm/pjTCKJqF60XnIqxkjWXsIItatZa73ZW9cYSXO2hPmHIw==
X-Received: by 2002:a63:df0a:: with SMTP id u10mr18587666pgg.79.1587421475507;
        Mon, 20 Apr 2020 15:24:35 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id w126sm490730pfb.117.2020.04.20.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:24:34 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:24:28 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/12] scs: add support for stack usage debugging
Message-ID: <20200420222428.GB77284@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-4-samitolvanen@google.com>
 <20200420171741.GC24386@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420171741.GC24386@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:17:42PM +0100, Will Deacon wrote:
> > +#ifdef CONFIG_DEBUG_STACK_USAGE
> > +static inline unsigned long scs_used(struct task_struct *tsk)
> > +{
> > +	unsigned long *p = __scs_base(tsk);
> > +	unsigned long *end = scs_magic(p);
> > +	unsigned long s = (unsigned long)p;
> > +
> > +	while (p < end && READ_ONCE_NOCHECK(*p))
> > +		p++;
> 
> I think the expectation is that the caller has already checked that the
> stack is not corrupted, so I'd probably throw a couple of underscores
> in front of the function name, along with a comment.

Correct. I'll do that.

> Also, is tsk ever != current?

This is only called from scs_release(), so tsk is never current.

> > +static void scs_check_usage(struct task_struct *tsk)
> > +{
> > +	static DEFINE_SPINLOCK(lock);
> > +	static unsigned long highest;
> > +	unsigned long used = scs_used(tsk);
> > +
> > +	if (used <= highest)
> > +		return;
> > +
> > +	spin_lock(&lock);
> > +
> > +	if (used > highest) {
> > +		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
> > +			tsk->comm, task_pid_nr(tsk), used);
> > +		highest = used;
> > +	}
> > +
> > +	spin_unlock(&lock);
> 
> Do you really need this lock? I'd have thought you could cmpxchg()
> highest instead.

This is similar to check_stack_usage in kernel/exit.c, but yes, I can
change this to a cmpxchg() loop instead.

Sami
