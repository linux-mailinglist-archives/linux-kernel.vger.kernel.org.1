Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43820EF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 09:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgF3HPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 03:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgF3HPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:15:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30987C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:15:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so6045796wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qomXq2ActQZN/6bFPVvt+u08Ypzth62dhj61jRlqIqg=;
        b=mHPPQN9W6sb5xzGjh62onzl2oulcD9KtmeoN3pj89jyErg91srjiDxZWGa0QP4AU81
         hNytKu4gO1Hf57LjmGAHupV3KhZ6p7CP5e2bf1da5aZ/2Z8cECbVqs1BBE0k2MvEYqYS
         AN13UDyfULgP0X2RttKExd9B7DOT7Y79cE+/fIOh/sYi11Hkq0VwmsCYk2uA/11QhZQf
         capG494GGtRpc/Iecx47e5KMHddbnKyn/QXCZkCqBhw2n1GIR7jnkgI4Gtr8lyi2rsBX
         5S8tnxAbcNGgp/h3MCUI/FhDtuUhaGODB7BFHDnSfKDU+7ImIZu6J1q0Ec9+OQ4JXn42
         Kbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qomXq2ActQZN/6bFPVvt+u08Ypzth62dhj61jRlqIqg=;
        b=B4UIcpw99S74Zgnn/PgZohEtlazBBfxh+sUMOK0+dRGOntxtNb6dRw8cY15+d4xF9v
         Mcq4STtQ9ziNaUloaJ+3VcP4umGhSYkOGVap8kiwyeUW+WzCPpdEpH6RhWM8EXNR653L
         TxOHbScZ7wIXT8ZbGyhGhwG6iC5uZ0f3/FfkdEH/VH94R6R/HCuBc3YwpCiDKninWo/D
         Xd+zYg5CRLJmfO2CM18To0vDUsypZHiPeRCklSnDKcSR0Bw/sVMPWdXB3U/Har4K2Jqx
         0S8ZOUxRdgJEjgUZ/7yERJ3sGy7OlakES+ZEAfl+3gmpJn1978U72e+d/Gz0zOaTLRGp
         U4Zw==
X-Gm-Message-State: AOAM530dfoUIUxik4JPajY6oRgXW25du7NY1oFW2fZ8RPU7R/SNEkbIh
        zBL+PvLtAKMc1heSkoc8Z67w3vXfiKqGUrXhIyi67g==
X-Google-Smtp-Source: ABdhPJyKohk0LvsHxuOJ7RF09tiNLq0s5bjM/CBQtjGt7EOC+N3RWtGru1+JzCh2phyG6SALIaXkSdAO0MtBxqVEh7s=
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr5429652wmb.16.1593501339411;
 Tue, 30 Jun 2020 00:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 30 Jun 2020 15:15:28 +0800
Message-ID: <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with space
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 5:57 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
> parsing which did not like the spaces in the string.
>
> Fix this by updating the regex to allow strings containing spaces.
>
> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Tested-by: David Gow <davidgow@google.com>

I've been using this patch quite a bit, and haven't hit any problems.

+Shuah: Any chance we get this into the kunit branch sooner rather
than later? The KUnit tooling is quite broken without it.

> ---
> Maybe it would have been sufficient to just use
> CONFIG_PATTERN = r'^CONFIG_(\w+)=(.*)$' instead?
>

FWIW, I tried this myself, and it seemed to work, but I think I like
requiring the quotes more.

Cheers,
-- David
