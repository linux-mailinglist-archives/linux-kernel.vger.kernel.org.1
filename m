Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C8A2A5B05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgKDA3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKDA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:29:40 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F7C061A4B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 16:29:40 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so9408518pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F06dNnLo5pVFz2CmGuB3AtlTt9h+PO3FFpFt/YqI8Cg=;
        b=H5API/cU2kCLm/rlmuWDHVdK/0fMqgPkW2hN+G7SbD2sk7CpKG1mpmYyfaYlF/fKt7
         wFOtq7PtHhIJM/OthEAdxoACuFnD193rR3n0aUSNCkpr6WyyGgMbqvIVCI2RbqO/ZU+S
         u/ysWEXSnty3nhLrLjTspLlf7adjMgKSny6Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F06dNnLo5pVFz2CmGuB3AtlTt9h+PO3FFpFt/YqI8Cg=;
        b=rCACWvKPQkKrL4n5+tTkP0hhPzW9IWEYFdfF9eWfleiaBJqcjWtf9T82xgogMqdIlg
         tcViEYNn88mJ6z82d6lZi8KIKf2A/qk3V49rHiyaOUEHBsmoAS9jPI1rzKyweYwlsIz0
         sceAH39enBc9ChRzmiVsAfxOU5zjPQKjq6j8fHDNBHFiCv8UxvbuwYBY3KUB+LarusAL
         7kR1cmS0GQhdvIc6sOw49hRNESVAI2MreMLIKFl1i1YoBUS1JTi0ouiC2c+rtRKU6d+E
         HfM9GYQClDsHgaIm2gcLng2yra6A7Vt9tVhQz1p7EbS/owQzPMNQr0nPAY26/XeqSaln
         aA9A==
X-Gm-Message-State: AOAM532Ufkr3mrEk5ol0LW6hlAkmZjVz87zrIn5sgnbmsGvOE1ridlr/
        amOkYS0gklNUGbyExqVu5rKqAA==
X-Google-Smtp-Source: ABdhPJx8PYXz0HMlsmRPwbUvWUVC3l2Awz7GVLjlBRUJvcJR3PRRG641cCj38glJarsx77xPHhgOPg==
X-Received: by 2002:a17:902:bd83:b029:d6:c53f:a771 with SMTP id q3-20020a170902bd83b02900d6c53fa771mr13437431pls.23.1604449780276;
        Tue, 03 Nov 2020 16:29:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w63sm271309pfc.120.2020.11.03.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 16:29:39 -0800 (PST)
Date:   Tue, 3 Nov 2020 16:29:38 -0800
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
Message-ID: <202011031612.6AA505157@keescook>
References: <202010091613.B671C86@keescook>
 <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook>
 <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook>
 <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
 <202010231945.90FA4A4AA@keescook>
 <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
 <CABqSeATiV0sQvqpvCuqkOXNbjetY=1=6ry_SciMVmo63W9A88A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeATiV0sQvqpvCuqkOXNbjetY=1=6ry_SciMVmo63W9A88A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:00:22AM -0600, YiFei Zhu wrote:
> My peers pointed out that in my previous benchmark there are still a
> few mitigations left on, and suggested to use "noibrs noibpb nopti
> nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable
> no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off".
> Results with "Mitigations Off" updated:
> 
>                         Mitigations On            Mitigations Off
>                 With Cache      Without Cache   With Cache      Without Cache
> Native          18:17.38        18:13.78        17:43.42        17:47.68
> D. no seccomp   18:15.54        18:17.71        17:34.59        17:37.54
> D. + seccomp    20:42.47        20:45.04        17:35.70        17:37.16
> 
> Whether seccomp is on or off seems not to make much of a difference
> for this benchmark. Bitmap being enabled does seem to decrease the
> overall compilation time but it also affects where seccomp is off, so
> the speedup is probably from other factors. We are thinking about
> using more syscall-intensive workloads, such as httpd.

Yeah, this is very interesting. That there is anything measurably _slower_
with the cache is surprising. Though with only 4 runs, I wonder if it's
still noisy? What happens at 10 runs -- more importantly what is the
standard deviation?

> Thugh, this does make me wonder, where does the 3-minute overhead with
> seccomp with mitigations come from? Is it data cache misses? If that
> is the case, can we somehow preload the seccomp bitmap cache maybe? I
> mean, mitigations only cause around half a minute slowdown without
> seccomp but seccomp somehow amplify the slowdown with an additional
> 2.5 minutes, so something must be off here.

I assume this is from Indirect Branch Prediction Barrier (IBPB) and
Single Threaded Indirect Branch Prediction (STIBP) (which get enabled
for threads under seccomp by default).

Try booting with "spectre_v2_user=prctl"

https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/spectre.html#spectre-mitigation-control-command-line

-- 
Kees Cook
