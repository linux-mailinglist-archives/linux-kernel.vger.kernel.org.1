Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83F42C76A4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 00:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgK1Xv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 18:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgK1Xv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 18:51:28 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C1C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:50:47 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so10764256lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhGfKp1ror+eW5JfNJNNFe/r27e3BZBI9puKXitJ1lY=;
        b=V0qHLJ8uhAyJx9CIF3e/s3/kXArtYxqNZpITmPP5zX1Rj5TqY3704MIo0lpw0mqbN3
         y5HT0is/rK4CnJ5J0CefgEaGMm6Hvxrl6qwtqqE2KZCnl0WZcWYcl9kPd5TISa74Btm8
         D2vgpFBMISfKb/Rh1KjAHgwgZStapGoTo8oAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhGfKp1ror+eW5JfNJNNFe/r27e3BZBI9puKXitJ1lY=;
        b=nJ/hmKccJ2dVt9MSUhtdaCCgAwnmUHNF3UsebO4viNNbRcF5ZDOLFck1D9UfqtbsaV
         69e0XhwRTV/Ss8f2XPGN2Jm556Uk61ItPBKnUoZY2tIW/zShW1PpfQSslqkdn9+No7hL
         kubserIQ7o/glAxSsdz3Jgr2KkUVaPpMj6k67+VZHMdmf1luZ201ec6m38TXpd7UPmb1
         BE0w9W2FXF3YchEAcaZBGg7hfuWaTfBFXTHH4o7ppqr2iahtkcY2q+GDCZ5x7rtMpHcB
         PnyeqILntr2RxnqG8Y08BBO7EuTBReEqg+SUQqiiAK33ZQg/qv3xUk8I0i22OHl8MO3J
         tsJw==
X-Gm-Message-State: AOAM530o7IPA3b5pS0m9uyOPHO0VeQ2wJXHQyvMm+iPZVHFbWMAss1uQ
        BlZdgrS7rNNXxw+i4slbD8znjCDawnsgig==
X-Google-Smtp-Source: ABdhPJwPyeqsD84dYpuxTV5ffqd4k8lSbC5FgK/TfGy2h/wwuVLpHj2/CfNNoWgaogfa/E36g0UmOw==
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr6404917ljp.333.1606607445793;
        Sat, 28 Nov 2020 15:50:45 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q13sm1231337lfp.2.2020.11.28.15.50.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 15:50:44 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id j10so10764174lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:50:44 -0800 (PST)
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr6648171ljd.70.1606607443948;
 Sat, 28 Nov 2020 15:50:43 -0800 (PST)
MIME-Version: 1.0
References: <X8JBIBWUEgxr1lSY@kroah.com> <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
 <39c8838b-b321-b91e-d29d-92cf43a09c16@infradead.org>
In-Reply-To: <39c8838b-b321-b91e-d29d-92cf43a09c16@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Nov 2020 15:50:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghm==vakvd81ezNpz58wnKTA07f81Q8sEv7KWOza3TdQ@mail.gmail.com>
Message-ID: <CAHk-=wghm==vakvd81ezNpz58wnKTA07f81Q8sEv7KWOza3TdQ@mail.gmail.com>
Subject: Re: [GIT PULL] USB/PHY driver fixes for 5.10-rc6
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 2:07 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Could it just be a vger issue?  vger has been acting ill today...

Possible. pr-tracker-bot obviously is back, it just had a very long delay.

And yes, the delay might have been due to it not seeing the original
pull requests due to vger slowness. I didn't think to check if the
pull requests were visible on lore.kernel.org when I was wondering
where the pr-tracker-bot was.

           Linus
