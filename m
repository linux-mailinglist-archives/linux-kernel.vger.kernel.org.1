Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552B72D4E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbgLIWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLIWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:53:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:52:28 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m19so5449842lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoZxe45tfXr4/FDvc4CABuzQn5OyKXJcb52tHgb8yL0=;
        b=byRPSi/mKwHLY2fdQcTNrRj6YvGbp+G5DCe532S8h9jvM5zGWe6bGFkBgJLn8a8efh
         wNR1E46A1xONxrnSS6D5a1rIQTyJswuGS7bQtK2cELi3Z4KHz3Uv0BX+UljIjb4CQ0pD
         OkiO0DcVdNYHZ9vc4BJEeAjyOABQDyJ8appoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoZxe45tfXr4/FDvc4CABuzQn5OyKXJcb52tHgb8yL0=;
        b=oOh3TJIRsvTesLVONT8cVss4wjjiMuJ8pQ5R1Omirid9Qn9jk7FzH6uUS1nxQAg60D
         GEL4pVlpDJPio1lesHermegEtzO5ymFLktWy8kt1AYL7/z7VE5WH5s24OROt15Ec02t7
         sfQuc/WGeI/OHBDHvBO6MIPSZTzJt7ZeXz98Zz1VUIHI1E8G0T9yHn+xZZTHflwjgqd9
         9ZGP5R1/w+Ow4CyASeosoraXP4PitHjBQ8wWFAV8Soa3/jCoXPxlhz6yxl3o3FrHDbXy
         3uKmubpk2F+zwhuTziouFWKcr5iWAugbskXEFKEl1nl6MJLsRYjMOMA7qrz1ABxZX8r5
         FDHg==
X-Gm-Message-State: AOAM530VWJ04tclnwtQNV5EgMYkHvakFlXKsNMTCWmWip4CMs+pvWX6h
        2rRTWl8CuS1trorgrXa97BA6A9RUKz/xgQ==
X-Google-Smtp-Source: ABdhPJxZJ/cM3RH4/8fb3A0ekZ8ZxYAQEt5mjXshxwBbkBAbZMUwyWR0J5D0N7zVE9236FURaktTMg==
X-Received: by 2002:a19:be16:: with SMTP id o22mr542705lff.109.1607554346934;
        Wed, 09 Dec 2020 14:52:26 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t11sm306779lfc.204.2020.12.09.14.52.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 14:52:25 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id a9so5446496lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:52:25 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr1565679lfl.41.1607554345273;
 Wed, 09 Dec 2020 14:52:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a04h2KA6s-m_O2MJ098frTSmxvAg-ngrdP4d9=9YLXmyw@mail.gmail.com>
 <CAK8P3a2piZwSjDudPu8mOEBnRHFAXRBMcRZsqS8b6YD3Kjwsow@mail.gmail.com>
In-Reply-To: <CAK8P3a2piZwSjDudPu8mOEBnRHFAXRBMcRZsqS8b6YD3Kjwsow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 14:52:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkby5F6EpGxN3kXaxf8YPkXKb+873hSE7Ly+zEJZrXrg@mail.gmail.com>
Message-ID: <CAHk-=wgkby5F6EpGxN3kXaxf8YPkXKb+873hSE7Ly+zEJZrXrg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 4
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 2:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Stephen Rothwell just pointed out that one of the fixes I added today
> was missing a Signed-off-by. I corrected that and uploaded a new tag

Gaah. I had already pulled, but since I hadn't pushed out, I undid it
and re-pulled..

          Linus
