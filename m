Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C391E7210
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438235AbgE2B15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437482AbgE2B14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:27:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B68C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:27:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so567005ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9DDH+ka577yWN8I1lwER+N2nfRC2WU0Ckv2Lu1OmbU=;
        b=c3Co8BnhP/+fpOuPHGIDwU4Zp4Sa2cqOLC6C5vXoWp8xHdS4zCAeFxT3cnyP/W5jRQ
         9z0IlAP5Pfc8kc9hkuA28qt6ar69ruD08xLRWHn6gdeuFA6y10LClepdBIXBKdhQGHiP
         yAqpd4zJ1skPKdhgL9YZOnpw20LZMDWu0PnDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9DDH+ka577yWN8I1lwER+N2nfRC2WU0Ckv2Lu1OmbU=;
        b=Twr68fFmYkKY84Z40QPE0lXDDDIEe0pINwC4hSzCn+LK4OFaX0/p2xu9mIw4WHhFyf
         hIh04F/oO6fJzpOn5afWkN3z2A4+k3LmWiVpcx0+Fdoe80Hl0GysPmIT4fzqEEgi2hSP
         zEBqNWFnlGVfJLPQa18GoMQm5NY9jO77kGCeeQzuTYV4yp1eEeIEUikFLVXbFvJi8ptR
         a8gAgs1swNS7WkK6CbWIDwAo1+pYvVqL+dCAdLivdNBRhHPRYAB9t/cPzCye0SdXE8Me
         pMyIX/z86dICl5IgVl1GNLnP8csnOaVjMMv0Qh8A5n17BEbhp9WuwhFo4dWtQQNxQPdX
         gQOQ==
X-Gm-Message-State: AOAM531W7J6fMk5IsK69LuoDCbsDdCiadw+yImvay5pgN2WL10xYepM6
        4eB8s9B8Rx19MPk0dfDG7Lwmc3ZJ5w4=
X-Google-Smtp-Source: ABdhPJwBjdwm5zWF366QDT/cTTJI9WCduAlWnZUT872S4nAQqlORVe6GMOIsoHPmaNF5vNt9AIIhrw==
X-Received: by 2002:a2e:b004:: with SMTP id y4mr3049845ljk.273.1590715673925;
        Thu, 28 May 2020 18:27:53 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h26sm1996417lja.0.2020.05.28.18.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 18:27:52 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id r125so281766lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:27:52 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr3050072lfo.152.1590715672160;
 Thu, 28 May 2020 18:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 18:27:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
Message-ID: <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (*ppos >= i_size_read(inode))
>                 return 0;
>
> +       /* don't read past the lvb */
> +       if (count > i_size_read(inode) - *ppos)
> +               count = i_size_read(inode) - *ppos;

This isn't a new problem, since you effectively just moved this code,
but it's perhaps more obvious now..

"i_size_read()" is not necessarily stable - we do special things on
32-bit to make sure that we get _a_ stable value for it, but it's not
necessarily guaranteed to be the same value when called twice. Think
concurrent pread() with a write..

So the inode size could change in between those two accesses, and the
subtraction might end up underflowing despite the check just above.

This might not be an issue with ocfs2 (I didn't check locking), but ..

                  Linus
