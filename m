Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E422280997
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgJAVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:46:42 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D47920848
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588802;
        bh=33d+5YpKaZy67awLHISI1I7yC3fnUn3elft+nSUfo70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H8qVwXSLBHBvlySX3bMRCImUzAtdDhMN0M2WVdSC+BhPdVLHB6JaG2lptLG8PzAn1
         bHwzTGKFroIJ8Smx3efp1Xh/JSWfn99GH4C0wWPcBvzpei08/4l0xQp+cAViKWFsbD
         X6FqmJyocQeew0SkmCZs1A0keIyAwJdpc1d5nNLg=
Received: by mail-wr1-f49.google.com with SMTP id w5so330798wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:46:42 -0700 (PDT)
X-Gm-Message-State: AOAM533lD5aFjPzAqkfdlEzgdXuKp6dVAsASWSovHwD5pHnx4fO3sCZg
        tqHr60nS/niAGdTBvAGlmt+yWbss9LJQYUDJbeUYwQ==
X-Google-Smtp-Source: ABdhPJxzntZTB8wWJHx/Za84yoWi5C8XrMqY1mtJhANu5XAszOcYJcnKy6ZRNXAgJnVVla+MDhU5PnNh5MKmc1dCjVk=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr11091963wrn.257.1601588800854;
 Thu, 01 Oct 2020 14:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-5-krisman@collabora.com>
In-Reply-To: <20201001205819.27879-5-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 14:46:28 -0700
X-Gmail-Original-Message-ID: <CALCETrVu_Zaoy8HzjtO=+ZeE95sWLtTXC7Xh7BrAbnk0ntWV0g@mail.gmail.com>
Message-ID: <CALCETrVu_Zaoy8HzjtO=+ZeE95sWLtTXC7Xh7BrAbnk0ntWV0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] x86: elf: Use e_machine to choose DLINFO in compat
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Since TIF_X32 is going away, avoid using it to find the ELF type on
> ARCH_DLINFO.
>
> According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
> have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
> differentiate a x32 object from a IA32 object when loading ARCH_DLINFO
> in compat mode.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>

> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
