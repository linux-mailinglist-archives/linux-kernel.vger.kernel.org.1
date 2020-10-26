Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB62996D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793110AbgJZTbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443473AbgJZTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:31:01 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBAD2085B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603740660;
        bh=f7P82vPmD4tyivT8IKAlNL0tj2fOqyqNaKxejRNtMnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uEIF0Ws0lck8OEWVlc5hCo+BdL/1lJcpsGNCIeA/ge3mg+dsDorqkDtuLOJMq9RsV
         yB04+n/vEB7rJUuOqQSvwS4NN0Jbh9vYJT/W643Ru1R+xxuXMha3Rip5CSjlmwiJgY
         bFgMfXE6gVtwsSDYUK44lm3FK3h1IkXBrpyByEDI=
Received: by mail-qk1-f182.google.com with SMTP id a23so9497885qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:31:00 -0700 (PDT)
X-Gm-Message-State: AOAM533W1RJgWBnoeLM46U2oAfZwf2n5vsH1YZNn9ZF/SPPb69yRpr8I
        t8xz95Ki261ZqItnUSy1HU9s4AS9o14P817Ky98=
X-Google-Smtp-Source: ABdhPJyYMf/3S17bU7BdlSl94Cctz5Z5skGtfApcEBxa0lLxz3PIYxLdvfJZ6MrpWYTdifabR+azrln7b57cgP//Jyo=
X-Received: by 2002:a37:4e57:: with SMTP id c84mr17640126qkb.394.1603740659790;
 Mon, 26 Oct 2020 12:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160342.3705327-1-arnd@kernel.org> <20201026160342.3705327-3-arnd@kernel.org>
 <20201026170151.GB42952@C02TD0UTHF1T.local>
In-Reply-To: <20201026170151.GB42952@C02TD0UTHF1T.local>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 20:30:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16zU7CRJniQHKi4Qeie2+jAs52HoYX9tgK2j5hb4HtMg@mail.gmail.com>
Message-ID: <CAK8P3a16zU7CRJniQHKi4Qeie2+jAs52HoYX9tgK2j5hb4HtMg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: avoid -Woverride-init warning
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 6:01 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 26, 2020 at 05:03:30PM +0100, Arnd Bergmann wrote:

> > @@ -335,6 +335,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
> >               set_bit(ICACHEF_VPIPT, &__icache_flags);
> >               break;
> >       default:
> > +     case ICACHE_POLICY_RESERVED:
> >       case ICACHE_POLICY_VIPT:
> >               /* Assume aliasing */
> >               set_bit(ICACHEF_ALIASING, &__icache_flags);
> >
> ... but it's a bit weird to have both the default and
> ICACHE_POLICY_RESERVED cases. If we get rid of the default case, does
> any compiler warn? I suspect the masking in CTR_L1IP() might be
> sufficient to let the compiler see we've handled all cases.

It's not an enum, so the compiler doesn't actually know what the
complete set is and doesn't warn without the default. I'll send a v2.

      Arnd
