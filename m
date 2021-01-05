Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E92EA8AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbhAEK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbhAEK3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:29:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AAFA2255F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609842537;
        bh=A6vKGpMe7rFxhLcuZGbkPRPGkwqF7MwlyKoHjUv/UkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HjbJePpa8tdPJWRzl3nVpQ9gErSkqBZf8MJNYHffkM67peH1mlKkqq+E6NVE0W5v5
         6LsffeeduCtXWTEEosaZCRkokHIB0T1LbbNhQ39Z1M67bJIeMVgjtAgp4i0yN2ZMFy
         jmuFJx2euaLGPJpDEHPuGNpzp2gpk6w6AFggomBv150y/e5gVT5GN8CVWdtC1nYKIY
         mfZs6slO/iMfhbYGM0JG9D5BayBtv770fDRZD7uOjHm2MZ2PrX9bG3wHzufH2VWRFQ
         niz+XG8MonyDuk9MdbDDLzE2ecXayx3vtEwZVldAlLK9FpmfhZJSDRsV0vN2/WMxkj
         a3Gfl3mYh7j8Q==
Received: by mail-oi1-f170.google.com with SMTP id 15so35508395oix.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:28:57 -0800 (PST)
X-Gm-Message-State: AOAM533VzR/5dfA5KZwFcnPtKXRPVU/1jOKicBq84dM0VvffOLrlg5m6
        XHfrHbqbdPQcOgtDzbEnRTX1RHlbWkJ7eodUMMo=
X-Google-Smtp-Source: ABdhPJyc2UdT2BlNgTAQH1TFvtHr/2774+C7X1WCqCbxZrnleLxowSMhWzobykhUpTmd2yCiO8bo+gIIEHsNk0o4QxQ=
X-Received: by 2002:aca:44d:: with SMTP id 74mr2206832oie.4.1609842536679;
 Tue, 05 Jan 2021 02:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20201230154104.522605-1-arnd@kernel.org> <20210104223634.GB2562866@ubuntu-m3-large-x86>
In-Reply-To: <20210104223634.GB2562866@ubuntu-m3-large-x86>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 11:28:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1E3zWHSkNOaKY80ZfZqVuEe11dr_Rop=eDkbmmHo1Z6A@mail.gmail.com>
Message-ID: <CAK8P3a1E3zWHSkNOaKY80ZfZqVuEe11dr_Rop=eDkbmmHo1Z6A@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 11:36 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> I am in agreement with Vlastimil, I would rather see the BUILD_BUG()
> dropped or converted into BUG() instead of papering over with
> __always_inline.

I see your point, but I also generally prefer build-time checks over
runtime ones wherever possible, and would prefer a way to keep
it in a form that allows that, at least if the check is considered useful
at all.

> For what it's worth, I only see this build failure
> with CONFIG_UBSAN_UNSIGNED_OVERFLOW, which you proposed disabling:
>
> https://lore.kernel.org/lkml/20201230154749.746641-1-arnd@kernel.org/

I'm building more randconfig kernels without this patch but with the
__always_inline
reverted now, will see if it comes back. If not, let's just drop this patch.

      Arnd
