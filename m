Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62532E92A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhADJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:33:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADJdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:33:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 686C021D79;
        Mon,  4 Jan 2021 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609752790;
        bh=5n7vJCpQwW8zSmDr93dZa9kN4blfmo8jxJGKpx5U5Hs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ftoL/c1zbxvRqYOhI6xG9lR6Zd8xQrcIdkz21Bod+Eobw5xzXnq8lJZhQqQnqbZwQ
         lVj/vjSUMIsVwWbtXNUW60C3IuJ7KZGOwA0oIfJ7HklKAEgM9JBR4+Q7oTzyS8uDBc
         v6dgpKp4qKB05yh2INfdD2sJD7dpemaIxsiuFOPQ55/n7DU/bFF9BiWlXZD/xCMzqJ
         b1bHhuWTzZs5l+bkGEcJW8V7TXrrtwMr8bBbHClUFyNvoxWzJz1KPYMyTKcW/k1+l0
         S0d7cfLN2XIfwG8pGt8IJEngpGTZ9GKzjXU4IHBP8xu/PH/pkDYZ3mWjxl4SzCIKxC
         6/zq5OVpFTZFA==
Received: by mail-ot1-f50.google.com with SMTP id b24so25471500otj.0;
        Mon, 04 Jan 2021 01:33:10 -0800 (PST)
X-Gm-Message-State: AOAM530852ciU5J6jvG9qCBuFeEGkI1Wq2BNc0rYazF6EjJdgB9SaPQQ
        zoIXx1eUt2CEXbvmREC8d2B3EJWDaKQiWW58pXA=
X-Google-Smtp-Source: ABdhPJyvdjWMT5twGvJHH6XoUBUHgxZe3u552CGxz2czq0O52xp1FBCMoMRuQcdfPTQIS7jtnngPTRPudqMRlUqi1l0=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr51940100otm.305.1609752789802;
 Mon, 04 Jan 2021 01:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20210104085806.4176886-1-arnd@kernel.org> <ad54481b-15da-e795-0c1a-bd54d3e8ab87@physik.fu-berlin.de>
In-Reply-To: <ad54481b-15da-e795-0c1a-bd54d3e8ab87@physik.fu-berlin.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 4 Jan 2021 10:32:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com>
Message-ID: <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com>
Subject: Re: [PATCH] ia64: fix xchg() warning
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 10:06 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Arnd!
>
> On 1/4/21 9:58 AM, Arnd Bergmann wrote:
> > Change it to a compound expression like the other architectures have
> > to get a clean defconfig build.
>
> Slightly OT: Has your other fix for the timer regression on ia64 already been
> merged? I can test this patch later today.

I have not received any reply from the ia64 maintainers, I assume they were
both out of office for Christmas.

      Arnd
