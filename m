Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26673302C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbhAYUcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbhAYUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:32:09 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:31:27 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p13so16999662ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpdkiDUiJjTq8PYQ0mE03z4QPO39NKIUJykccdYPnZA=;
        b=P/J81xwDxdbJsrAqkXE0UocZqLdLlW6TRSIBDm+Rj1uhnfpUxdANylY0cJ1/VCyNG9
         67oNRCFZnK+QCvACVI37MTvMiHCnXvvg8Yt0ZAzEz16SNIvGDLmxT2M/KzFkDBYDQm3G
         gqS1m+tDXT+CXpw2w2sRAjbzmUxnsJspNELLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpdkiDUiJjTq8PYQ0mE03z4QPO39NKIUJykccdYPnZA=;
        b=GHAY+fFZz3cfYkJd9XUnpcVITFpLjqR3x7BRxA8ZzwmVvQPU2F72sU30CJALiTWAqP
         yQ/+LkdVACbumWa0DERX14Iu09CHLoPe/5T3TaexB7+TaSwnJpPvx57B7SYpdEhmKu7L
         HfriVfhOTVE4Nj03rB9KNnM15c6MlRtDBt9YeMJcX+Q3548L0gcbax3WnalgYyaTC45T
         z47kdgiuH5H85d3ogRcYzsaJr01hEEG2GG+2HhoeJDTANS37t4nbn6fRV40Ac9NhsiO0
         CZ8KuD8V1uFNwtET5fUNmtwOmljx/CkGWvqXKC+nLpO1mKkfRCVk+eqEUA75XAiLPlOr
         +ZLw==
X-Gm-Message-State: AOAM531QbaPpRtTkgyQdnTOI1ZrLiPDPvFKc3mf75S/8xV3KcaPkJPL7
        kF41bMvyVcU2S4msqzOBOPszXwdwp+eqlA==
X-Google-Smtp-Source: ABdhPJwMmHli6TSCHk4AYbCZK2P5mq5a3ocFsmT+3C1AiUTQMHmcqG7/oL8dj0E8hcHsFN6uFC2Urw==
X-Received: by 2002:a2e:2ac4:: with SMTP id q187mr1035146ljq.151.1611606686010;
        Mon, 25 Jan 2021 12:31:26 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j2sm2101595lfe.134.2021.01.25.12.31.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:31:24 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id b26so19687528lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:31:24 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr990527lfu.40.1611606684432;
 Mon, 25 Jan 2021 12:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com>
 <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
 <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com> <YA8hYxasFC9VarRq@kroah.com>
In-Reply-To: <YA8hYxasFC9VarRq@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 12:31:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=PWosa1VZQKBf9b2pMgVac_P+QPHp7TwLS7JVDHKUgA@mail.gmail.com>
Message-ID: <CAHk-=wi=PWosa1VZQKBf9b2pMgVac_P+QPHp7TwLS7JVDHKUgA@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I have nothing else that I know of, so yes, it is easier for you to take
> it directly, thanks!

It's top-of-tree right now, commit  9f12e37cae44.

And I just noticed I screwed up the formatting when editing the patch
- after pushing out.  I deleted the actual top line.

Darn.

            Linus
