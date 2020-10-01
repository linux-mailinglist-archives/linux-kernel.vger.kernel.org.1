Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706D527FFC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgJANIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJANIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:08:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5EC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:08:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so5122015qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DsXN/R7iGt42hx1lRS3IS/+IybE+fmPcIsKzKlGfRFo=;
        b=mkxWK5c9k0IydjRjqVsPf+titEIZ62Vyl37BRCPxDoJulw9RvZoa3yeAhpWKvsy1Ul
         sL4LufUVQXh/+b7hDMY78bdwR6nS+SoNvNMW10JSRiq/Mjm1BYTgKaEQvNcyIFPpkTTk
         IYkevRvh4wd1o28CBzaFZadl2jjDAF4JttKCFOYt0DQE1E3nBCI7jy5uvkI2M4H+dcMF
         P/k8MPPG9R4/1mpZe0FhWovLawnXtb/tWCnV/PlGemE9Ra72SJMPJGHqe+M5T9YGbIFK
         c0cNVXNl0Qur4WJHcKT63gPvELXh+6U4BkX16kg7AtH9BRTZ3RPCHRS3XYlsYqICVXht
         yYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DsXN/R7iGt42hx1lRS3IS/+IybE+fmPcIsKzKlGfRFo=;
        b=nALa6GLlCGi1bJBHjRqSWhLqgeG590o7yZBCan0LsXB4SVfMeBEGqujDnxFcCilFR+
         r7H2n+hwKx4TYrZBhXC5KP9p2BjhU9bGxoLI/muYSNZXSrTQ2qvegfOAludqj6GTSl7y
         dlplsvcrONUfUashcIwLnBkRdaJnNDtnWLo0ew8CeMFS6O0lvIGcHshTC4keBoduPwlp
         pka8KItQNs5mzg5qO6r4uBFDX/vDiW2+AuK8TzVQ/PHDRqXFiVASpORwILneD+Y9Cmqh
         YSm83cwDpEOSsdi9Bl2q3MSluD/8Eae/vwFmtiPR5txPU2EWKXqy+2s8jmiLaBYsWkue
         rU3w==
X-Gm-Message-State: AOAM532/jvnuxkcGzpuKrlbea8Dpg5tKfxX5gcnL5rG2MIBYx6eynluc
        zf1WvIH+speTogt81v9sSfrV6TplfCkyyque3jZusw==
X-Google-Smtp-Source: ABdhPJw+J1F//83UjvXGAyy08k4UKO+RiqB7CjflJduTVjjwLG9Yu/igzKLbPRlyAm4cqzNSZp+EmSjkMVPiqVsJzhY=
X-Received: by 2002:a37:a4c5:: with SMTP id n188mr7692334qke.8.1601557725617;
 Thu, 01 Oct 2020 06:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fe79005afbf52ea@google.com> <20200930165756.GQ6756@twin.jikos.cz>
 <20200930180522.GR6756@twin.jikos.cz> <CACT4Y+b6ctH447Hy9JuP1hF5MSV368WAB2tXz8xfi-5ZM-=tOg@mail.gmail.com>
In-Reply-To: <CACT4Y+b6ctH447Hy9JuP1hF5MSV368WAB2tXz8xfi-5ZM-=tOg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 1 Oct 2020 15:08:34 +0200
Message-ID: <CACT4Y+bQdT_eOcE-jOJQQFR_xi14YwBQUosuUTNq1t-k5JSFJQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
To:     dsterba@suse.cz,
        syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 3:05 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Sep 30, 2020 at 8:06 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Sep 30, 2020 at 06:57:56PM +0200, David Sterba wrote:
> > > On Sun, Sep 20, 2020 at 07:12:14AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel=
.org/pu..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10a0a8b=
b900000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dffe85b1=
97a57c180
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D582e66e5e=
df36a22c7b0
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> > >
> > > #syz fix: btrfs: fix overflow when copying corrupt csums for a messag=
e
> >
> > Johannes spotted that this is not the right fix for this report, I don'=
t
> > know how to tell syzbot to revert the 'fix:' command, there isn't
> > 'unfix' (like there's 'undup').
>
> Hi David,
>
> I've added "unfix" command:
> https://github.com/google/syzkaller/pull/2156
>
> Let's give it a try:
> #syz unfix
>
> Thanks

Voil=C3=A0! Unfixed:
https://syzkaller.appspot.com/bug?extid=3D582e66e5edf36a22c7b0
