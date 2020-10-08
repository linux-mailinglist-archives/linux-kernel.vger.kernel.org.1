Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F26286BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJHAGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJHAGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:06:07 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042A520739
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602115566;
        bh=bS0l/wIJtDRND8W0efdV/S17wUdgcGyO+U2nsP9YKT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pJ+giGL2pM4ZgcTYomhm617uKI4eenEIRjun0ZlD1EiY3xuQUnR6NbBV1dG9SrV49
         s4RyC/61cIRjvPKdYBShORwp2CIRv7CbAGHuUQy9+sX9HPiguWd1LoGGY2Jor/X2Lz
         M9ZjiODPL0PQL02R2GZ6E/C6Des4YJGm2xBULdmQ=
Received: by mail-wr1-f44.google.com with SMTP id n6so4033198wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 17:06:05 -0700 (PDT)
X-Gm-Message-State: AOAM530OeKsx8zuMBnn6RJ8u7ovapV25+imll1oxeS08yedKDrXdBXD/
        zN17lrZIrjBgI7gvvbVzbv+GvGS55WfJ10BbkyoqkQ==
X-Google-Smtp-Source: ABdhPJwn4+QJw2ybHRs+h9LAqbPLXTIZ0OyVRfGd/uVU/L4Y5hWr0t58YtmHSd6y2U4hai2CM8tN6nrYfFKMAlCYsQY=
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr5998788wrx.75.1602115564523;
 Wed, 07 Oct 2020 17:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201004032536.1229030-1-krisman@collabora.com> <20201004032536.1229030-7-krisman@collabora.com>
In-Reply-To: <20201004032536.1229030-7-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 7 Oct 2020 17:05:51 -0700
X-Gmail-Original-Message-ID: <CALCETrW5Oq0L0G7JrjYLFp08+y4kr0STkmn8cf4LKcHOfz0heQ@mail.gmail.com>
Message-ID: <CALCETrW5Oq0L0G7JrjYLFp08+y4kr0STkmn8cf4LKcHOfz0heQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] x86: elf: Use e_machine to select start_thread
 for x32
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 8:26 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Since TIF_X32 is going away, avoid using it to find the ELF type in
> compat_start_thread.
>
> According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
> have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
> differentiate a x32 object from a IA32 object when executing
> start_thread in compat mode.

Hmm, I suppose I can live with this.  It's not fundamentally worse
than any of the other ELF compat hacks.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
