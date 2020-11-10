Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D182ACA89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgKJBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:37:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42579 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:37:09 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kcIao-0000r0-Lm
        for linux-kernel@vger.kernel.org; Tue, 10 Nov 2020 01:37:07 +0000
Received: by mail-lf1-f72.google.com with SMTP id s10so1830993lfi.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xygyfviZhrqldJoh55lqm86ZBffK6xSKZWicSP9XRLw=;
        b=bHM/eUUO0a6xmRyFT40LXR9j/MmaR+WP45DmJBl31Tkwcue9uxwiOXnOkoqoL+MZdd
         Nq6k1XgB6H2zlzqJLIrnrsCG8zuHrtive57WoMXmu/YwPGz8LgAZ0CsRuZNme88xamI5
         BFfDfXIz1PLlAsP5P2Mt3YV9XV8cfjjL6E+2LtR5qwMy8pUiDmyo4p6Rwg1DDOvmXdH1
         sKMhXMzV9uhTMN1hbAH8l+bHtbhXNPE/4YypkgA3XbfZg4FfsTFT6/qUsfFwPtNQ7fdP
         Di1fqURb/uzsBuTeRxE8SnYi2XT27Gj5hcoJvv4x5MGN3qivP4YZe7mPABgngVF5MSa3
         YCpg==
X-Gm-Message-State: AOAM530Jytm8yq38IfOny0kE8+BMR3SbNWpXk56yyIyUIhn/lPD8yfiS
        ecZ1ZzFAs3g+/ZaeeUbFCgNmmreqhBbAS8kJnyT/yah7tVrT/N3g4syyBk4EUJw0DliAV8PIWi4
        /TY+fZK5PtaY+FKBAlDk/d8rCYOThMrFiW3Aw6l/NrJd+c9iewSAWJMzk
X-Received: by 2002:a2e:8346:: with SMTP id l6mr6581917ljh.132.1604972225989;
        Mon, 09 Nov 2020 17:37:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwD7ul4nbZVQiVfaxChsuU9NpBuXQIKlLhwaoMNAWMub6P1uHlGOMMx0ima4z8Y3LMt9V7R+6TVWgDs82IrhIo=
X-Received: by 2002:a2e:8346:: with SMTP id l6mr6581908ljh.132.1604972225691;
 Mon, 09 Nov 2020 17:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20201105105051.64258-1-po-hsu.lin@canonical.com>
 <20201105105051.64258-3-po-hsu.lin@canonical.com> <20201107150200.509523e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMy_GT-Hsj7GmHKBb9Ztvsisrujud1C=E+sKE1TfHDsszwpMXA@mail.gmail.com> <20201109100911.28afc390@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201109100911.28afc390@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 10 Nov 2020 09:36:54 +0800
Message-ID: <CAMy_GT_FQrXObfebdzipkhzSuAGE7VbGiRuE3e87uH9YcjBrAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: pmtu.sh: improve the test result processing
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:09 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 9 Nov 2020 11:42:33 +0800 Po-Hsu Lin wrote:
> > On Sun, Nov 8, 2020 at 7:02 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Thu,  5 Nov 2020 18:50:51 +0800 Po-Hsu Lin wrote:
> > > > This test will treat all non-zero return codes as failures, it will
> > > > make the pmtu.sh test script being marked as FAILED when some
> > > > sub-test got skipped.
> > > >
> > > > Improve the result processing by
> > > >   * Only mark the whole test script as SKIP when all of the
> > > >     sub-tests were skipped
> > > >   * If the sub-tests were either passed or skipped, the overall
> > > >     result will be PASS
> > > >   * If any of them has failed, the overall result will be FAIL
> > > >   * Treat other return codes (e.g. 127 for command not found) as FAIL
> > > >
> > > > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > >
> > > Patch 1 looks like a cleanup while patch 2 is more of a fix, can we
> > > separate the two and apply the former to -next and latter to 5.10?
> > > They shouldn't conflict, right?
> > >
> >
> > Hello Jakub,
> >
> > Yes the first patch is just changing return code to $ksft_skip, the
> > real fix is the second one. However the second patch was based on the
> > first one, if we want to apply them separately we might need to change
> > this $ksft_skip handling part in the second patch.
>
> Ah, I misread the situation, ksft_skip is 4, not 2, so the patch is
> more than just refactoring.
>
> > What should I do to deal with this?
> > Resend the former for -next and rebase + resend the latter (plus the
> > fix to remove case 1) for 5.10 without the former patch?
>
> Let's apply both of the patches to net-next if that's fine with you.
> Indeed detangling them is may be more effort that it's worth.

That would be great, but allow me to resend V2 to get rid of case 1 first.
Thanks!
