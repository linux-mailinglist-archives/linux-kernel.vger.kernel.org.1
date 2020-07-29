Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4AC2318D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 06:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2Ey1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 00:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgG2Ey0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 00:54:26 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EDB2076E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595998466;
        bh=qKrraR9NNIslZgxj1wQ1vHsohPP6apLoeUeP34L0yeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cfv14R5CD6tKHCHGjEyPsAyF8wtQbXgcnmvDXcadFj4JPwx6LISfOyCWtF7hm5Xeg
         SeevyVBc9yAut7QwO2S1LfhUEHc10ueO9C6NJ1Ls0wMnCXlF882Wosz1Ujp9MQxwzp
         lZFb9VCHZkmJhu1FfPYuC4w3uiVeQ4UNca+bVpMQ=
Received: by mail-wr1-f50.google.com with SMTP id r4so17309873wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 21:54:26 -0700 (PDT)
X-Gm-Message-State: AOAM531pV+vjzeJXA1RodSx8i1AEac87MBRZBDZ2W3lQfpQpLoeq2Tbp
        fWXiAI+5YZSnzkpYZQkBJxyR3TtusKDniEUivBMxCQ==
X-Google-Smtp-Source: ABdhPJw7KPjb1NFfmPs7SlH5Cq5Plb5/6UxqgThFUmLR0QZg+x5Q62tT8dZo33yVKYCqnyVYHZvD/GeFnAg5EZEq+UU=
X-Received: by 2002:a5d:5712:: with SMTP id a18mr23117753wrv.184.1595998464923;
 Tue, 28 Jul 2020 21:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202229.1195682-1-krisman@collabora.com> <20200728202229.1195682-4-krisman@collabora.com>
In-Reply-To: <20200728202229.1195682-4-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 21:54:13 -0700
X-Gmail-Original-Message-ID: <CALCETrUqMGfqNHX3Rv+1Uhd2J2pUUN+0yqMPFtLQcjAh1TDGWQ@mail.gmail.com>
Message-ID: <CALCETrUqMGfqNHX3Rv+1Uhd2J2pUUN+0yqMPFtLQcjAh1TDGWQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] arch: x86: Wrap TIF_X32 checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> In preparation to remove TIF_X32, add a wrapper that checks the process
> is using the X32 ABI without using the flag directly.

I'm not sure what the right solution here is, but all three of these
functions are in the ELF loading path, and the callers of all three
have access to the full ELF info.  Let's instead either stick enough
information into bprm to figure out what ABI is being loaded or pass
in a pointer to the ELF headers.  The latter might be a bit nasty due
to the way that the ELF headers have a different type for compat.

In any case, sticking this into per-task state (task_struct or
anything in it) is silly.  The full ABI info is on the call stack, and
there's no need to keep this particular bit around forever.

--Andy
