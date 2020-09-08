Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5752622A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 00:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIHWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIHWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:32:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 15:32:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so1106083iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vxLgXb6vL5kj6dYd9RuDEdt2qHv+p3bKsh1PxXIHTu8=;
        b=RU5Ds98tnYCCF2BftQjKNrxq6J6LAYqx8D/xDiaURHvnqB7/Xo997ECiVy7hZcAqdD
         A4iP+YUB3M2DC0xzgwi640cmWmJyxlyIjjKiuUh0Cqr/NTzxgRUXVV02YTZhsY0P72H7
         Al3sFD5a8a3OEyKei6CHibeJQutYRZzNtWSaOKa+K9QAwjyZwEhZyJ5iILNIdILsgRm/
         PfJI9vRZ51eXnEU9AQv43n1knNrOfBcgawX5mn29k2+owwDyFpmSHYIQnELkS016qXPd
         /vmuztQa1PFeBnkwDnq2JiPyNTvaqiQ0Nn6jCojNV1bYwWnD1jVeDPnLn8NIk4PEcRxQ
         sj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vxLgXb6vL5kj6dYd9RuDEdt2qHv+p3bKsh1PxXIHTu8=;
        b=BTks7KI66LOzM9RF720gtxgDUoM155eEK69J+M7YDJ/mjjoAi7aC6QVmRhzn2KRtIW
         L+qeRKhXhDZ9Es8gHhCk6OPWi1/vHuRYbhFzYxHvcCrFnlpkMhJw+1QlvB+Du1oZVyvD
         1vdmDlq1eyB6melalohvoXYeYF4njO1nxlyWpJ7hhlBIXPS+a+c42bOcyRk1PdmA6uZO
         ps1FBZs28o8VPCg5dhcNnCeF5xgKYHQiANjE4KweHi1EAsaNuz3KkwNoeZXJ0ougOQvW
         1oDBoqV4MNlOEBuWbU2vXQjCo6/sS45sqlaM4xAj9/omFVG4BK1Ewchp0zsgRjnVJJDU
         1cDg==
X-Gm-Message-State: AOAM531neBg0TSewVwFlo71PLq3WS0dNBJnCNOM/9HKD0AMHefuqeeF7
        YG3UQc9nEmrvsUHrQ1NJhGjkdVykivueBAUUYV4gww==
X-Google-Smtp-Source: ABdhPJwPAjxIJr+9IfvrvghxlUbrfXD5G7B10FXZiq3Asoi2FJxeIBImFeLirgmT3TzxwkIdXwzHnghmw6Dh7KtrH1A=
X-Received: by 2002:a5d:8352:: with SMTP id q18mr1051783ior.31.1599604358848;
 Tue, 08 Sep 2020 15:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200908193029.GM25236@zn.tnic> <025308CD-6E1A-41E1-8B3D-E9842CE00794@amacapital.net>
In-Reply-To: <025308CD-6E1A-41E1-8B3D-E9842CE00794@amacapital.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 8 Sep 2020 15:32:28 -0700
Message-ID: <CACdnJusOJVb0xpecFgPQB4N2WhUORikv_1eXAcGfJ3xwBVTo9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 1:35 PM Andy Lutomirski <luto@amacapital.net> wrote:

> Undervolting is a bit different. It=E2=80=99s a genuinely useful configur=
ation that can affect system stability.  In general, I think it should be a=
llowed, and it should have a real driver in tree.

Agree that this should be a proper driver rather than permitting
arbitrary poking (especially if this isn't an architecturally defined
MSR - there's no guarantee that it'll have the same functionality
everywhere).

> But this has a tricky interaction with lockdown.  An interface that allow=
s root to destabilize a system may well allow root to escalate privileges. =
 But I think that making lockdown=3Dintegrity prevent tuning voltages and s=
uch would be quite obnoxious.

Indeed - plundervolt.com is a demonstration of this. Any realistic
attack involves being able to drop the voltage enough to interfere
with a calculation and then raise it again before everything else
falls over, so simply applying some rate limiting seems like it would
be sufficient.

> Should there perhaps be a separate lockdown bit for stability?

If it's a sysfs interface then I think it'd be easy enough for people
who care to just add an SELinux or Apparmor rule, tbh.
