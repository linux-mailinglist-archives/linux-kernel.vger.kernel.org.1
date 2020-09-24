Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43899276A36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgIXHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgIXHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:12:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A151FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:12:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so1317908pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPyfajfaHq+r5oQ4+KHWAZ8VwhlnanG+Cg9XmXwcpuM=;
        b=U7RM1C8nWHiMvrUrOKOxP2OLNnkhNzx+5Xb+ZMQxUQlQ/k1EejiqZf9v+kTIPp+x+y
         CfUd2Msra+Iq6+48aOR+1uozXy3KUCJ65MrxIuN9LacgwDvrl040rvwOdje3uhosgFR8
         PHfcR07iK0OejM+M/srngdXt8hwsnJWfraF04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPyfajfaHq+r5oQ4+KHWAZ8VwhlnanG+Cg9XmXwcpuM=;
        b=npn05f97XzNIhdeKYuXQep3QvWWpabwDp86idvcLLWo9X/ImLhAMiqbmFTnTslvEc+
         sQz4IpG1Vx2OrIT7Sx2IDThoXQXo9Wpg5dyMG1K/yAhShYH8ntRmk52x9yc2+3ZNINmj
         bqbnHgpSMpOMoXBmk1QseLlPbJOM/5yet4qaTZycHiR+v+djCqE6Eyu3YXBONikp3T9o
         b7B5KpsQwn+tJRfq7KR0iskLm0unyWZe1yeRLmuFOuzvFklY6xQx32RMRlqtv+0NMk5+
         ldpcEZf3a/9l25oMvKlPIZZL15Kn2jlNGBBULbqrl8QYvIlt9yULCFHwPjCwSBFTcOdD
         smIQ==
X-Gm-Message-State: AOAM533f7ysgW6dehO7eCRATGw4eKp3+DcZurO3zbInKpqbOlFAtC2o/
        hJDo/qDQM/i6K7wl76eKW70nKg==
X-Google-Smtp-Source: ABdhPJwKQNB8FoBf+r4HIrsajmVau41WjZYMbzcPpPcitAZ+Zh9hRnUXNOc1+32wdpHjUyTITaPkuQ==
X-Received: by 2002:a63:c20b:: with SMTP id b11mr2902014pgd.421.1600931541212;
        Thu, 24 Sep 2020 00:12:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm1783640pgi.2.2020.09.24.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:12:20 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:12:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] x86: Enable seccomp architecture tracking
Message-ID: <202009240011.A56710DC@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-3-keescook@chromium.org>
 <CAG48ez1BXWdWA5zPzOD21bQ4RsHQ6bSDWR8soTkkNphJ=zdHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1BXWdWA5zPzOD21bQ4RsHQ6bSDWR8soTkkNphJ=zdHWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:45:45AM +0200, Jann Horn wrote:
> On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > Provide seccomp internals with the details to calculate which syscall
> > table the running kernel is expecting to deal with. This allows for
> > efficient architecture pinning and paves the way for constant-action
> > bitmaps.
> [...]
> > diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> [...]
> > +#ifdef CONFIG_X86_64
> [...]
> > +#else /* !CONFIG_X86_64 */
> > +# define SECCOMP_ARCH                                  AUDIT_ARCH_I386
> > +#endif
> 
> If we are on a 32-bit kernel, performing architecture number checks in
> the kernel is completely pointless, because we know that there is only
> a single architecture identifier under which syscalls can happen.
> 
> While this patch is useful for enabling the bitmap logic in the
> following patches, I think it adds unnecessary overhead in the context
> of the previous patch.

That's what the RFC was trying to do (avoid the logic if there is only a
single arch known to the kernel). I will rework this a bit harder. :)

-- 
Kees Cook
