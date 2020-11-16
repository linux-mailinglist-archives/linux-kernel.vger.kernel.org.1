Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA12B42CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgKPL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgKPL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:27:07 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:27:07 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id d1so3101547ybr.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RA52pn8MaZH7xZTx5g2jPIp9RO4lpE9y7bIaH6ByAsk=;
        b=QnkJ2u358zISGRf1VPFWi64uQmLAG1WEH4mYIho/obEwuolz7skMiKeOaoAZ46cFvl
         ehlK1W1tSQs+x6WfwFUIgxFiE7GnpJ9k2geg/QMYT3jFTCndmKYjLRwt0EQ+4Dn4JTJz
         soRR2SXpI5pGjdKjDyR5+8AxcT2+LLpa//AnsIZOn3Uy+FlhKl9SD9hjs5QgoxuPmSWm
         2pE0bAHBF0s+5lXfVmahUWriO9DZXqtuRlrFQXHzcElmig7p4n4T80XVxQSRKwl1/i2f
         J+0dovANyKjPeHqk0tCQTTjmJIqV8Pyvj1lgGePu0nJB50SLtSKJfd/xp4DlJmc8u4Uh
         KEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RA52pn8MaZH7xZTx5g2jPIp9RO4lpE9y7bIaH6ByAsk=;
        b=Ns5pO518wGDW8yqpSTq/4O/JES0J4Y1qrDwHdXGWS35jgU90ndqKo5O50BOcCrNR8k
         LAU5AvqiBFVulUvTABBddNqE9kaGFQ10iXJlxK/nLRu+gQ8O5np3onE2I+ZGMn+/FIzs
         nUyjCdXByvz85QrwA+J/xaMS46Tt7TzSq/CzjU3q1QZaxhIKeQEah3wkZUZKqOQLSZjm
         UbY1yrMfIep4AVc53YtfiuvJUf/Qt/T67oTPk43rbCW2Agmkzxob8NdnnXKY2PksB6Br
         /pC4UiR551Y2GEpoCGpwlRiROEvbzrhSqzCOUjKYhSuf0rp9LWgnRm9/S+dmy3hdFDKM
         ycRA==
X-Gm-Message-State: AOAM531a4RZcvAeDkThtSEI2OmRMOC+tg2PVoSdW1W7o18KhWZAtTD1S
        9qTZhpm1YLxt0wbuhDrfubt59M7VaXQxfcyg+Fo=
X-Google-Smtp-Source: ABdhPJzjfl9/35Dd1Y6pTSPvYKRWPlcS4vGXRhWd4wl8umrpYsgOxNvTM75khAokdWpVrWt/zKSjReU7jM82xJC4svU=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr11652278ybu.247.1605526026684;
 Mon, 16 Nov 2020 03:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com> <20201116043532.4032932-3-ndesaulniers@google.com>
In-Reply-To: <20201116043532.4032932-3-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 12:26:55 +0100
Message-ID: <CANiq72=1qmMYa9kejXqCDyjTU1RSgKc1VC-C4AdFFqQkwFVLog@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough pseudo-keyword
 in lib/"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 5:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> This reverts commit 6a9dc5fd6170 ("lib: Revert use of fallthrough
> pseudo-keyword in lib/")
>
> Now that we can build arch/powerpc/boot/ free of -Wimplicit-fallthrough,
> re-enable these fixes for lib/.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks fine on visual inspection:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
