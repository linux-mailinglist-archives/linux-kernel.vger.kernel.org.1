Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5A276AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgIXHiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIXHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:38:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so1155629pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/ZWotEmwV2wYeMAbWubNYS0mAS1AJsi/PuMFNxSA0Y=;
        b=HnTNwGP8FohbDh7X+PypMX569OCpgnEdElmZ7hXNOGxNjGMFfEkxcg1my+0mklYktz
         UQxlLsrFts2bnq6rFWsLPHHuEQQ628XuCnd8XqRUUnUlvMTs3I66PIrsb0ARIcdPpkgp
         owqNp2wrBCqIff3j2oqFxAiN74eNqrGdyR6xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/ZWotEmwV2wYeMAbWubNYS0mAS1AJsi/PuMFNxSA0Y=;
        b=TwM1PIRtayQx0sV5qcB7MXmX6Q998tDsR4Zcr2Qw41lUmgmehiLEcMojJpLSFUQzPp
         wW296LCSAs39iqgjlNUnOjkJmWNjFE0QcptfGyobPU+8szIbuSt/XH9Alb0t/ju6odi2
         aUCY0Ab8vKAwvfAsdqCp9faxWbLn3JVXd/kAu6E7ZhxdaNITELsCMZZFogxNgxoHtoLM
         ELMWbzUCrH4gN4Sn6eF/hUbG+IKnVa6RHTFEwThraOtwMvZQhLhoc5i7pQg/kDbjc40p
         rkqk9bU6deZZYdhrP1ADYj25oY7WnBDH/PdXD2r09d8jPZL8xQxXRlmkgMam3VH6HDAs
         UFbQ==
X-Gm-Message-State: AOAM533+FuOWghiVxBlDVNajneXItYwMFMX1sGDNNaerMKGn0xJK1wfC
        EV7wEMRNvLw1ToaBjBFVS/qSKQ==
X-Google-Smtp-Source: ABdhPJwgnuX9NNL+oLb/kmNEL0CZL8XPv33AWyRHruVO1Vk1X5iwGSW6FVUhC/l7K0WYG62SFNLf2g==
X-Received: by 2002:a17:90a:ee16:: with SMTP id e22mr2551329pjy.81.1600933101134;
        Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm1607476pjs.18.2020.09.24.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:38:20 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:38:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
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
        bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
Message-ID: <202009240037.21A9E3CE@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org>
 <DM6PR11MB271492D0565E91475D949F5DEF390@DM6PR11MB2714.namprd11.prod.outlook.com>
 <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:36:47PM -0500, YiFei Zhu wrote:
> On Wed, Sep 23, 2020 at 6:29 PM Kees Cook <keescook@chromium.org> wrote:
> > In order to optimize these cases from O(n) to O(1), seccomp can
> > use bitmaps to immediately determine the desired action. A critical
> > observation in the prior paragraph bears repeating: the common case for
> > syscall tests do not check arguments. For any given filter, there is a
> > constant mapping from the combination of architecture and syscall to the
> > seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
> > there is a single architecture.). As such, it is possible to construct
> > a mapping of arch/syscall to action, which can be updated as new filters
> > are attached to a process.
> 
> Would you mind educating me how this patch plan one handling MIPS? For
> one kernel they seem to have up to three arch numbers per build,
> AUDIT_ARCH_MIPS{,64,64N32}. Though ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> does not seem to be defined for MIPS so I'm assuming the syscall
> numbers are the same, but I think it is possible some client uses that
> arch number to pose different constraints for different processes, so
> it would better not accelerate them rather than break them.

I'll take a look, but I'm hoping it won't be too hard to fit into what
I've got designed so for to deal with x86_x32. (Will MIPS want this
optimization at all?)

-- 
Kees Cook
