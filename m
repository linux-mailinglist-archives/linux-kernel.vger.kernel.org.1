Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B56201B82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbgFSTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389884AbgFSTm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:42:27 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F5921531
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595746;
        bh=u7Q+9lveWuHW5aLyR3G8V9eIOsfyptLC0kbPADPFrWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sjMuI2k5LnSDBQHixU8X+Wt9nQph+at6Oenp0L/mHoX0a6okbEocQvP+kub+ELobb
         jBS5ODQUzGGPJDcgS1iI6wVPLkmKPBlup8JbaTHN9QXhyYFqr9UuxFUxOczlDcOOso
         VfPF5cETeyzJBik4k2r/frMc/+bkQn7obx5HuEao=
Received: by mail-wr1-f47.google.com with SMTP id c3so10749327wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:42:26 -0700 (PDT)
X-Gm-Message-State: AOAM530ApfvrxqATiX5AabV8UVxgpDBoEvaxE8YRtmPnj9BQ1wBp9obP
        WZV/PsDgc0YDb2xuU6k8bhBt1BIaXlN9CKUsJxzzbA==
X-Google-Smtp-Source: ABdhPJx5azSOHLfoMlVfQaoY+OUvFQy0JEKqZUc1FxYz5irmT1AzPU+k9GiBgkz9x79ch9sgMeLhdc8wqHh6EjJuqC0=
X-Received: by 2002:adf:a111:: with SMTP id o17mr5623209wro.257.1592595745224;
 Fri, 19 Jun 2020 12:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <202006191236.AC3E22AAB@keescook>
In-Reply-To: <202006191236.AC3E22AAB@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 12:42:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Message-ID: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> The terminator for the mode 1 syscalls list was a 0, but that could be
> a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> listed first and the loop construct would not test it, so there was no
> bug. However, this is fragile. Replace the terminator with -1 instead,
> and make the variable name for mode 1 syscall lists more descriptive.

Could the architecture instead supply the length of the list?

--Andy
