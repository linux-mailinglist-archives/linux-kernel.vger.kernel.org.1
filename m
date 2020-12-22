Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572682E0F32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLVUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgLVUO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:14:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE4B22AB9;
        Tue, 22 Dec 2020 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608668056;
        bh=SDxgVG8zKVxkLjSV9gs57cdSEjVw4fxdhXZThJc8eLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mNsLTVcrmvOJAho2PGYLZkcUrYJCpN9CnGdsrymi9pgzPYQMXUy8TYwSDiatRYBZN
         BFjo59dPF9OOvqRII1dpYpHV+lrM5HALvyo+NWYUIaPW44LYbosqXPLVASSKPICGh9
         aJVgas1h+uCKO+B/gjEuzHT3pekgbiswypPNk0JN5IoV1OVxv+jdFBBgun8u0618wO
         9apL60qqZnXxagJK18P3lTOGD1g9PpeD8IiaaKulWAnWJTZrTdLwyr8te6NNbT6K2+
         p70EoJfbKx7EUhuOH5B4cYsx6yUnt0zIopOMVRv0Rf4kNEGYhPQZa+lgsdFZiY+ZBD
         miUkyQeXL9bww==
Received: by mail-ot1-f48.google.com with SMTP id f16so13018808otl.11;
        Tue, 22 Dec 2020 12:14:16 -0800 (PST)
X-Gm-Message-State: AOAM5312LH1/Y5yrtdE0GHTm9lnijywHTFdlZOXUVrhMWBXfA6B3vPro
        FT1phX8/09EQsOD1hau3ZPwpGTZbk5OegLZSDb0=
X-Google-Smtp-Source: ABdhPJzFdIPnmpM0uIPDyq8a1Dknp4Dn1QkIO3uNZ5J2TkWcsujkX7kz6IB+inRK/KMkHpqK8fSn6K8YgpN4ckn2Dp0=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr17070296otr.210.1608668055604;
 Tue, 22 Dec 2020 12:14:15 -0800 (PST)
MIME-Version: 1.0
References: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
In-Reply-To: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 22 Dec 2020 21:13:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1KioFh+BFpXycWhVtvaEu5qvaTLuqtw7NbYfKzCOiFsg@mail.gmail.com>
Message-ID: <CAK8P3a1KioFh+BFpXycWhVtvaEu5qvaTLuqtw7NbYfKzCOiFsg@mail.gmail.com>
Subject: Re: sparc32: Init process fails to load with generic kmap atomic
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 7:01 PM Andreas Larsson <andreas@gaisler.com> wrote:
>
> Unfortunately I did not see this problem before I encountered it in
> master. Commit 3293efa9780712ad8504689e0c296d2bd33827d5
>
...
>
> I will have to continue to dig deeper into this in January. If anyone
> has any ideas how this could stem from this kmap patch, I am all ears.

I don't immediately see it, but an easy thing to try would be to
disable CONFIG_HIGHMEM. I don't know what the limits are
on sparc, but you can often change the virtual address layout
to reserve enough space for mapping all of the physical memory,
as e.g. CONFIG_VMSPLIT_2G does on x86 or arm.

There is also some discussion about eventually removing highmem
support from the kernel entirely.

       Arnd
