Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A249A290FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436955AbgJQGCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436907AbgJQGBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BAC05BD18
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:49:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id az3so2389815pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jax4atoPJwkdfJLEu7w0obe+ESpSyuWLwfdsf3Y/MXI=;
        b=EyNFtokkMOa7ze2Kbr5RF4vu56zkybgxN1S+XqwEuGm/93rAdYcsk5GVZrOQwne0Gu
         uamOGa2VlAv5ps8EotoVIXq0pWWgr9NqBa597VliymjdSANE2AB0vq82ErtnsEBKOe7S
         7ZLvcEmQu9YYEu2QMarKqvs6phZOpdh7IIN1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jax4atoPJwkdfJLEu7w0obe+ESpSyuWLwfdsf3Y/MXI=;
        b=nNT4F1J97dAoIBQlpGQdRkvLaJUITCL7wH86alTa8LAd176xWzu+bo4QX0bSCsyR4y
         2icGq6kmGO3b455y0Pv9F8DVGf4JXx+qpjWMt+omtFwcEzCDuYJny1BkIkMVxe4Y4X7u
         MbDtdMV2DAQAWPzvQ3oMWhc/mS3T6sE+SrLJYHuzkqLAvYE2lHcssprPVlhVGJXpigjj
         61dJjBh2D1meUKoE9KWWhMWw7RQpDNTjJmoePc6X3LH0WvVvxi+e4Lhp2XvihT7ikpsB
         GnOfg8Ngth9WHgdVkbX0HT/jQaSnSi4rRyPgSfD8wPZRHjT587worZSwcOY+8OHxnAqJ
         3CdA==
X-Gm-Message-State: AOAM532196C4knLWlpAc8J8X7zNu/6XQcqbNx2UUHIF3TwPzvC31m4kQ
        myt1iu4NuRtaiUlDzJ+8do545g==
X-Google-Smtp-Source: ABdhPJy3c4n93YNge6bCvLa5SNe3k/VWD6dF7uIpzuTvy8Uq0axiuYe+VCgXWMxO8UG8MTQ3YwVQsw==
X-Received: by 2002:a17:902:bcc6:b029:d4:db82:4439 with SMTP id o6-20020a170902bcc6b02900d4db824439mr7210581pls.63.1602906581160;
        Fri, 16 Oct 2020 20:49:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w74sm4510226pff.200.2020.10.16.20.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 20:49:39 -0700 (PDT)
Date:   Fri, 16 Oct 2020 20:49:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     herbert@gondor.apana.org.au
Cc:     syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-hardening@vger.kernel.org,
        Elena Petrova <lenaptr@google.com>
Subject: Re: UBSAN: array-index-out-of-bounds in alg_bind
Message-ID: <202010162042.7C51549A16@keescook>
References: <00000000000014370305b1c55370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000014370305b1c55370@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:12:24AM -0700, syzbot wrote:
> dashboard link: https://syzkaller.appspot.com/bug?extid=92ead4eb8e26a26d465e
> [...]
> Reported-by: syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com
> [...]
> UBSAN: array-index-out-of-bounds in crypto/af_alg.c:166:2
> index 91 is out of range for type '__u8 [64]'

This seems to be an "as intended", if very odd. false positive (the actual
memory area is backed by the on-stack _K_SS_MAXSIZE-sized sockaddr_storage
"address" variable in __sys_bind. But yes, af_alg's salg_name member
size here doesn't make sense. The origin appears to be that 3f69cc60768b
("crypto: af_alg - Allow arbitrarily long algorithm names") intentionally
didn't extend the kernel structure (which is actually just using the UAPI
structure). I don't see a reason the UAPI couldn't have been extended:
it's a sockaddr implementation, so the size is always passed in as part
of the existing API.

At the very least the kernel needs to switch to using a correctly-sized
structure: I expected UBSAN_BOUNDS to be enabled globally by default at
some point in the future (with the minimal runtime -- the
instrumentation is tiny and catches real issues).

Reproduction:

struct sockaddr_alg sa = {
    .salg_family = AF_ALG,
    .salg_type = "skcipher",
    .salg_name = "cbc(aes)"
};
fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
bind(fd, (void *)&sa, sizeof(sa));

Replace "sizeof(sa)" with x where 64<x<=128.

-- 
Kees Cook
