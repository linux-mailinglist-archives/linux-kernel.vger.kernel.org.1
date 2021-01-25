Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FC302C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbhAYUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbhAYUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:35:15 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E27C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:34:34 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l12so14433428ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AxiDuSt25u1RaO3NUM+BxxFxLF/kpj+MWWkTfuZLr0=;
        b=bPPjD5I6C7PQOWEiMCW//tix9F23TDzFrqg0SQs0foKM4EQTynibuBvR7MszfSQoQr
         K3/Lu8bd7TzRYtGVneRXrIEaDs2uebECG0dI2yO4Pu+ZgiDDSIPfBJai9SraaeSpAojc
         TyKCZyyymIrdS6Ih7Yi/ByYCy4fiIrIpAdaw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AxiDuSt25u1RaO3NUM+BxxFxLF/kpj+MWWkTfuZLr0=;
        b=J3LgTUSj1cn5NyS+ousaa2qlzbR5Oau+sSEwjo5F8KEAcpKnEro6HAaW9YXxEx8nRM
         VQLc9ZSkAjql5/gfYL5ph5xNTxbpt1u+WIckhkKwU+krwi/9/AYqCdyrbjK+vwTsWgOR
         Ra2MXA/tnbkN0TJ3uhLhKTFsMpWADXtPksISRjKdu5ajfeLLzvTH07T7EvWMcDu78zbo
         HeQxIJqfoEhB2vfa75kk0Jhd+6x5iPE3RfpkQBeOQpFlungFBSqqEcPQQkCTjJFdrqK8
         OslxmLMILzHs+YU+UovjCXUwmTrt6SZwocKQF9Irg6LjstqbRN4WlQ99GiB3QEed/ycN
         CXIQ==
X-Gm-Message-State: AOAM53198xkvaBM8XSlF15pOgXIAm+LpuEpwrlbBAJWzIg8u7PLhHmiM
        uekYkRhy2E0eGz0jBLyO78BNJTbi33106Q==
X-Google-Smtp-Source: ABdhPJywX5m8MAijnJ4lgaR1i33Qp1/NB4jPWJ/eMRMvNroiw37sO5qUP+qENVM55OWN2AA39QhgtQ==
X-Received: by 2002:a2e:888c:: with SMTP id k12mr1031543lji.365.1611606872778;
        Mon, 25 Jan 2021 12:34:32 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b4sm2346193ljp.53.2021.01.25.12.34.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:34:32 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id p13so17009546ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:34:31 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr1004295lji.251.1611606871397;
 Mon, 25 Jan 2021 12:34:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210125101615.efceefcaeae0.Ibe2d56dfaa49d7a366c835b5ae0f0a5c2d643ede@changeid>
In-Reply-To: <20210125101615.efceefcaeae0.Ibe2d56dfaa49d7a366c835b5ae0f0a5c2d643ede@changeid>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 12:34:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+oPAvdy-Mehtxs69K0xu=WuPMxKhaafxPLTi8=5vf2g@mail.gmail.com>
Message-ID: <CAHk-=wh+oPAvdy-Mehtxs69K0xu=WuPMxKhaafxPLTi8=5vf2g@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: allow sendfile() to pipe again
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 1:16 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Mostly for the record, since it looks like we'll have a proper
> fix without another intermediate pipe. However, this fixes the
> regression for now.

I've applied this anyway.

We'll see how big Al's proper fix ends up being, and depending on that
this one-liner might just be the right thing for stable anyway.

And if Al's patch ends up being small, simple and clean, this
one-liner won't matter, but it's not like there's any real downside to
it.

           Linus
