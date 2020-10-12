Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED628C50D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390907AbgJLW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgJLW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:57:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B47C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:57:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so15108724pfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ho1l607OAVVmLnoWlMqhfwRhJkqSim+LddBz61r0Qos=;
        b=JJQ4S6hWNOQEK+Sy3Y+6MHvE6gOOcxmTo+VnXkRAr4YZg1jAzA2NjbHn3GiUPeK8gf
         0ipw1LXDfr3tEdWE6dRrL6M12460zyb+sjoMJRNxEoEbW1Tj6e5VYs12zu49n5jFE+ag
         LA//Dq0oC90jGuPSuhQwam8VrIDDiTx3NpK3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ho1l607OAVVmLnoWlMqhfwRhJkqSim+LddBz61r0Qos=;
        b=nkufcJg9JSMIz2XXwPTr8fomN09sMaEctc/1c3p7VUaOvt3g33CZQhgXNLzk66muRg
         ey5RU1Y0tFzk4SyvguVmMnMqhHwGCMsJSwmfMZd2uRYXUNvsd3epG6XEf5btoGn6xlFI
         //7cCCLFarpCWk/ZMvMsZUMwtw37ev4n8jk9aS9WEbvJ0Oq6b6s1JRv6G3ZU6xSJxOj1
         DhTX/xGz1TXJIQjYQ+M9hl3jfq2OYLlgn9SBPAhWmgE3Q1pfK2SPuNZo0dyspDZKCl+G
         yk7PFd958wWARynmlv0GxG5U/7lWIDpLXalWe5QGr+y/AJXgkQm+xKcRNRec5ir06oPp
         gnCQ==
X-Gm-Message-State: AOAM5322QL9Y1Voupz0i/WvhmWeTnNS5siXrreUYjUrE2SMxth5AQ9xX
        hoCMgpgmHg1Nxk7iblyRo84elQ==
X-Google-Smtp-Source: ABdhPJxRLYOMHo59Ns0oO1+b1TTIgg1tJPZTI/F+6kwXefZKFzuOW2ptOTYCFNOKi97y0iBzVBYADg==
X-Received: by 2002:a17:90a:a782:: with SMTP id f2mr2869911pjq.50.1602543458516;
        Mon, 12 Oct 2020 15:57:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm20479216pfi.129.2020.10.12.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:57:37 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:57:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202010121556.1110776B83@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook>
 <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 08:26:16AM -0500, YiFei Zhu wrote:
> On Fri, Oct 9, 2020 at 6:14 PM Kees Cook <keescook@chromium.org> wrote:
> > HAVE_ARCH_SECCOMP_CACHE isn't used any more. I think this was left over
> > from before.
> 
> Oh, I was meant to add this to the dependencies of
> SECCOMP_CACHE_DEBUG. Is this something that would make sense?

I think it's fine to just have this "dangle" with a help text update of
"if seccomp action caching is supported by the architecture, provide the
/proc/$pid ..."

-- 
Kees Cook
