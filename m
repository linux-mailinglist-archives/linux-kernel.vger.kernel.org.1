Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E12C7A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgK2Sdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Sdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:33:36 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:32:50 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so16120460lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9s52aALWnPzkuuwJbAFgf0zi/HKjwgBAX44SpRB1JFw=;
        b=RcB2/95Di1lzpzMOKzm+KHy3EssZStCPQ/w6GktN7zwpkpRfMSIlp6hsjgrvWZmQyD
         u05S9OIZaPdrTSVGTM+x7lvGgnDWpRDeu8fIZn2msYHRAxObnaPCIcrBlp1BA+eOxe5S
         OwQzpanMzHIjh4Rm1+hszbV5iHRjDf5snV5bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9s52aALWnPzkuuwJbAFgf0zi/HKjwgBAX44SpRB1JFw=;
        b=DB2Zrh2iSCbLrO+f6mNBic1Sye8wSBmw0y26RO9ZPZSSQ8lh/h7hLQV7nTkSOmM58A
         iWYA6hWeRPmZ/kihvlCEwa+YtQzWtLMflDcvBmiMWDKX75W7E1T6Em7klxKZV+FpXtve
         6QN2kakASYfWBile69a4yAzWQW+hASf68GooiPB8YYjpCqfSScTcx4sPU1XlFff7a/Ci
         hg55/rEjoji6+OtnRQgMLyoBBLRKTRc83lhGl5KBRlD6Jr9Prko/5R/1lamA8OlIgwCL
         N2HUMljFc/aLFXEqaHOEPXMRlrUUQNj6dhZ0xzRGOB1ubqRu/zDhtywqofuvRaawtr51
         qdtg==
X-Gm-Message-State: AOAM5326g00WldVOgxGi1ki01gpOdP0E3a0DcwoELnVKrioTce6bj/1v
        28gjvUPQ9WzlcP3a2lIeZ5MGpgcW2vffyg==
X-Google-Smtp-Source: ABdhPJyP98MLYoSiU7HFGFffugdKNEPRDuTpUyKn3ql0NIYYjiU7z/1eAdFvqsB5aBK8UXjsoCrkHw==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr7321076lfh.137.1606674768832;
        Sun, 29 Nov 2020 10:32:48 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a15sm1748764lfg.215.2020.11.29.10.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 10:32:47 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id i17so13371013ljd.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:32:47 -0800 (PST)
X-Received: by 2002:a2e:50c:: with SMTP id 12mr7470342ljf.371.1606674767070;
 Sun, 29 Nov 2020 10:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20201129104209.GB12056@zn.tnic>
In-Reply-To: <20201129104209.GB12056@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Nov 2020 10:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaj3E-UWvwQVuBYzy+=T8MmTyqzFJ34u5sY+Yt9Vnj2g@mail.gmail.com>
Message-ID: <CAHk-=wiaj3E-UWvwQVuBYzy+=T8MmTyqzFJ34u5sY+Yt9Vnj2g@mail.gmail.com>
Subject: Re: [GIT PULL] efi/urgent for v5.10-rc6
To:     Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 2:42 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull more forwarded EFI urgent fixes.

Ard seems to be using almost random signing of his tags. Last time it
was signed with subkey 9CD2A0DA, this time it's subkey FBD9627C.

I see that it's all the same primary key, and I'm pretty sure it's
simply because the 9CD2A0DA subkey is about to expire, but these
things take me by surprise when I suddenly see a new key like that.

It would be good to get a heads-up, because otherwise I end up
spending time looking at why I suddenly see a new key...

This is not a problem, it's just a note for people to try to avoid
surprising me..

          Linus
