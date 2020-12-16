Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25212DC7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgLPU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgLPU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:29:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C2C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:28:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o13so28501387lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sdiSM66MjBACu0zHAXSwkL8qLMh6dKH3+Vq3Xu+DKc=;
        b=JQZT0N+OQJzK7lZMDRdcTRxW/Iw2hvDnlhE6ggGkTDfFCxoYg3KcFQtpkMz1eEEEtG
         z4GKZCx3VuCvcthE/0YBpG4DCDzahOJkNosc0TdHm4/ZeQPRru9dQza0+sHPp2txbGIt
         cugVnLazCPAchdSY9p/FCnb8ToawMJzpbT0+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sdiSM66MjBACu0zHAXSwkL8qLMh6dKH3+Vq3Xu+DKc=;
        b=V+bRYGp18lpIdqA81jtGRpPZ1VS/HdPamspzcnL2N8yfjmGhyskYWaC0NW4c9ElP0W
         p4INahj9VsmYogkpNbeE/EaU6jHrlXIu9akdNQzh1LlRvks5gMYDRyMrsnh8RQqpoqyl
         Gdpgks7eIaKVyEHcPsIQZ5YT8nDxl0JBEYVXR/kjKIO88F7AzJMMdOXx8cOLywmp1/9Z
         dLY8zpF65070B5xQUCccg5NWA0emssu1B5/exOLgUBW3Eff33Zbmta1WOwh5nK/0Pq1z
         +AzzPRRTH8fWu90g8jQJhWminukqdZPWknbuiPDdh2yKM2UfBiQJ+TcOh9ft9LBL1/LU
         N2Rg==
X-Gm-Message-State: AOAM533HPDbTd1C7Y/ZgOwHVGSn+EDbdrg2jKSKxnOaX9F3e7+IoeZQz
        o3zQCMEj6bmggjLzatqQGPFFXmzuXElH1A==
X-Google-Smtp-Source: ABdhPJzf5lt8qh8VfWXtiG9L/H+CJiC/zQwhftT5i2/HnFoQQOpeY2rWd9nDbN1QPP/0XOixas/isA==
X-Received: by 2002:a2e:b70f:: with SMTP id j15mr16110993ljo.60.1608150511325;
        Wed, 16 Dec 2020 12:28:31 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t28sm411970ljo.45.2020.12.16.12.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 12:28:30 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id s26so17010666lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:28:30 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr14046133lfc.253.1608150510023;
 Wed, 16 Dec 2020 12:28:30 -0800 (PST)
MIME-Version: 1.0
References: <202012151215.E7AA7D6@keescook> <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
 <202012161221.18C0E3B5CC@keescook>
In-Reply-To: <202012161221.18C0E3B5CC@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 12:28:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=2M=4iV5vQMMMGzYiP6Fnx8CpYXomGqKwV1u3-uOq5w@mail.gmail.com>
Message-ID: <CAHk-=wg=2M=4iV5vQMMMGzYiP6Fnx8CpYXomGqKwV1u3-uOq5w@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:23 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hmm. Yeah, that's a bug. I think that's an existing bug, though. I feel
> like I scratched my head on that too. I will see if there is a sensible
> way to have Kbuild "notice" that -- I hope there's an easier way to
> invalidate all object files instead of adding all the plugins as a dep
> to all .o builds. O_o

We already have some support for checking the compiler version. I
wonder if the plugins could add themselves to the version name in
there somehow..

But I don't think it's a big deal, and I won't worry about it. I do
hope we can deprecate the plugins some day, it has always made me very
nervous to have random code at that level.

             Linus
