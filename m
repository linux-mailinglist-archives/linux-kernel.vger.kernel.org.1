Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD41B2FDEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbhAUBXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733092AbhAUBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:19:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:18:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v24so232245lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JP+7QleKuLgHptYHf4LCuBKk6rR02rSADT8oXjn/4HU=;
        b=PI/7Zop4+ozSbs1tdpArYaakSyWMjc+O7EK7/ZhAY9MH8s5LdF+DHqs5Dfh/iw1wnm
         qJCgFB0/f/DWWbnpB7EsisnsFOgfLNPrqY/0AzopwsNYC0vTcT75GzwptIsROHaaANmb
         CY7spS48ia+6h0SMEpgswOQaldRvls1y1oDFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JP+7QleKuLgHptYHf4LCuBKk6rR02rSADT8oXjn/4HU=;
        b=OQiBp3KMJpGt310sN9UEwUmszBsoNnltY+dkvDEh3mwuZqF2ZSr0bFQg/7nm208EiX
         OKO+U5pBjLz2TEFNNnakQ91TpndpcFaLpSKO0CniQdP9kauxOYuCLmtOvqChdB1ygjbR
         6KIpGthO3Fmuhqgfz9f5NZq3p7uif0+cP+7dKr95UP9a8/qh0TOgyRdv38bBFK1BSPet
         DmGL4FbxZvFQbEeRMo/yTExmPLTtJhz+zgu1ib51imrq7sqLpoY/vThEEQvSMctWdTHR
         Bxy9NDvfi9jofjgWE0EI3jpWBtvWXoZojPylSupmVEpM6ma3MxxKN5Ffre2fY7hMQWI+
         ZkLg==
X-Gm-Message-State: AOAM53344VOyRjNmskIjUGDuU2fo4BZaOToHxLRD9SV5zR0f48E1osy7
        zCAE6NOZEdTmmDsbEQsE4gVPMw0HKFMl9A==
X-Google-Smtp-Source: ABdhPJwOnXJUrruSYMv/SrmJJCHTEA6fHQ2g4d4QXSOOgp+/LJAch5lmKYxTgcwSFy7OMTeg6YgYFw==
X-Received: by 2002:ac2:44a6:: with SMTP id c6mr5584682lfm.102.1611191934585;
        Wed, 20 Jan 2021 17:18:54 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 29sm348262lfr.304.2021.01.20.17.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 17:18:53 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id o13so254818lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:18:53 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr5229454lfc.421.1611191932745;
 Wed, 20 Jan 2021 17:18:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc> <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
In-Reply-To: <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 17:18:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
Message-ID: <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
Subject: tty splice branch (was "Re: Splicing to/from a tty")
To:     Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 8:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll come back to this tomorrow and do the line-buffered icanon case
> too (unless pull requests pile up), and then I'll be happy with the
> tty changes, and I think I can submit this series for real to Greg.

Greg, I don't know how you want to handle this.

I have a branch with my tty splice patches at

    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git tty-splice

and that now includes doing that "cookie continuation" thing even for
the N_TTY icanon modes.

It passes my local tests, and I did try a few rather odd things. And
Oliver tested an ealier version without that final commit on his load.
But...

That tty splice thing is clearly a regression, but it's not like we
have seen a lot of reports of it, so it's clearly a very special
thing.

End result: I'm leaving it to you to decide how you want to handle it.
You can tell me to just merge it myself as a regression fix, despite
it being fairly late in the 5.11 series.  Or you can pull it into your
tty tree for linux-next and 5.12. And we can just plan to backport it
(for 5.10 and 5.11) later when it has had more wide testing.

Another alternative is to do just that first patch immediately (the
"tty: implement write_iter" one), because that one should be the
simple case that gets sendfile() and splice() working when the
_destination_ is a tty. The "source is a tty" is the much more complex
case that the other patches deal with.

         Linus
