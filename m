Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709F83026E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbhAYP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbhAYPCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:02:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38C232310B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611586834;
        bh=hd/WXSL7nvCB88gXvns199QHmgVVBrlCpN1PP6wvQHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jpPA43bvelk6gF/9cB93LHi7Tly+kXkFx6hG6PHe+9hpQbbKXRCjw499iIjLbeqnz
         AjqmnsIR7Tui3CxngPzhbqCv09a5QdeWAtjObuDMpO+LqJhNRFSxhGOI3B3il2HN98
         8SMTMo41asS0b/1rp4BG5XSI44LSR7AzJe/bh+u5xkk4TPSRVmj8IHhPgU0Y/mMZyD
         yKfIXt54JTHJN6dUxsvM/V/FCAolPrs33scoHlvMVVb+dVdMjXnWCnFPCxTGhnzlH+
         VReByrSeAq6c39B8eS77RfwGjyFPhRP6qBI7/B6nR7II3xm1OfuYKmRET2QcxFTYZF
         N2trskMz/Kwjg==
Received: by mail-ot1-f53.google.com with SMTP id d1so12939492otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:00:34 -0800 (PST)
X-Gm-Message-State: AOAM532wfXJ4rhPEu3swG4sVLvMamLgByVOq7qDV9Dbwm0MwVy/Ouofp
        rQSdKUVAPX+q7eVmhxkUZow5YZ0R7CQ1pwhlRSE=
X-Google-Smtp-Source: ABdhPJw1XagAoMkdlEgNaYOLX1Mg3wGRaGlR6h1xBKgBfrY9aj6SMHjzWNtcB8bOfL/jGHT7EzD/r/eZef5aGiCiEgQ=
X-Received: by 2002:a05:6830:1158:: with SMTP id x24mr712541otq.108.1611586833510;
 Mon, 25 Jan 2021 07:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125105019.2946057-1-maz@kernel.org> <20210125105019.2946057-19-maz@kernel.org>
 <CAMj1kXFcc+0At5+9Keo1MF=TeGE9-eOHtSpK7yVy5jzwXt6KCA@mail.gmail.com>
 <3a98ff1db79c90c96038b924eb534643@kernel.org> <CAMj1kXGTu8AtMnm7NxB8M2xFuXHSKzAx2hjjeaAW2v-usvavVQ@mail.gmail.com>
 <32b49beb87b25303d71fd2f7053c7959@kernel.org>
In-Reply-To: <32b49beb87b25303d71fd2f7053c7959@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Jan 2021 16:00:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGW3yWqBMk8E23e4PnYAXWUGUUeg4xFVyhHtq+v3WLF_w@mail.gmail.com>
Message-ID: <CAMj1kXGW3yWqBMk8E23e4PnYAXWUGUUeg4xFVyhHtq+v3WLF_w@mail.gmail.com>
Subject: Re: [PATCH v5 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 15:28, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-01-25 14:19, Ard Biesheuvel wrote:
> > On Mon, 25 Jan 2021 at 14:54, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2021-01-25 12:54, Ard Biesheuvel wrote:
>
> [...]
>
> >> > This struct now takes up
> >> > - ~100 bytes for the characters themselves (which btw are not emitted
> >> > into __initdata or __initconst)
> >> > - 6x8 bytes for the char pointers
> >> > - 6x24 bytes for the RELA relocations that annotate these pointers as
> >> > quantities that need to be relocated at boot (on a kernel built with
> >> > KASLR)
> >> >
> >> > I know it's only a drop in the ocean, but in this case, where the
> >> > struct is statically declared and defined only once, and in the same
> >> > place, we could easily turn this into
> >> >
> >> > static const struct {
> >> >    char alias[24];
> >> >    char param[20];
> >> > };
> >> >
> >> > and get rid of all the overhead. The only slightly annoying thing is
> >> > that the array sizes need to be kept in sync with the largest instance
> >> > appearing in the array, but this is easy when the struct type is
> >> > declared in the same place where its only instance is defined.
> >>
> >> Fair enough. I personally find the result butt-ugly, but I agree
> >> that it certainly saves some memory. Does the following work for
> >> you? I can even give symbolic names to the various constants (how
> >> generous of me! ;-).
> >>
> >
> > To be honest, I was anticipating more of a discussion, but this looks
> > reasonable to me.
>
> It looked like a reasonable ask: all the strings are completely useless
> once the kernel has booted, and I'm the first to moan that I can't boot
> an arm64 kernel with less than 60MB of RAM (OK, it's a pretty bloated
> kernel...).
>
> > Does 'char    feature[80];' really need 80 bytes though?
>
> It really needs 75 bytes, because of this:
>
>         { "arm64.nopauth",
>           "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
>           "id_aa64isar1.api=0 id_aa64isar1.apa=0"          },
>
> 80 is a round enough number.
>

Fair enough. This will inflate the struct substantially, but at least
it's all __initconst data now, and it's all NUL bytes so it compresses
much better than the pointers and RELA entries.
