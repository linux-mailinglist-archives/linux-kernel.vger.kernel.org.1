Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2A21F927
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGNSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:23:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B04C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:23:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so2110355plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOF0KcOAMey7OwWBu3VFMKyGMjn/UASQWe7FxH8TLu0=;
        b=vW+kdZOHDYB0wFd2aZAEfh34lR/RsGq/FAgduQn0iRN8XwQpEwSIIlpSTG9pqyiRCN
         xb4GAKOEa/3TyDcDpWRZEHVAjR84mfIUcP4JMjohCvOrhWKRgFFpi5MytyW+8HNrFzqY
         rkMVi5StksEfOVNXAadKtG78bNLAFbGZnlxUArJedsxwJzYniwnL0tNCw1E2Rd34y+m2
         YQ1R27qymK/zonFgwHYj5LV22acK0VqxZOetBavqS/btegW4oyMBNyQ4JxIn/Mi2atIg
         x25v7Juqepuz/UOVcvKCj0oCy4b0YM9OZtEqTj1B2niZ7lbgRAtt2ih62tf6OB5meHK/
         rv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOF0KcOAMey7OwWBu3VFMKyGMjn/UASQWe7FxH8TLu0=;
        b=Vvff0WKNf4ChHSsB8xUhHupyKM7+sTvPhbnmybpxUCux75L5IzHRYMzC4Gf7PA/aom
         b2TFJbr1aqtDcWiwc0RFL7PAds+L9+R/kfs58hozxevCZMcTlGc+8/heyl8KbWhrn0w8
         dN/LeRkK8nrBtTm4BbmTycjV7+LXxvRtP61vOGoAa4/vGoIoRWHcE9AgdCxHfitjPiOC
         sUI0zI7cpaSB+Tmn6cUhgcD347sMWFfmW5wFWSpzxVogC16oUN2dRRwLwNkxi82s81qZ
         a9ybUO67FT7y0A8d9jjyiOLrQA35Jnug6Zdm9BFySx8wkNtbx7CryVE4IY1Cy6lFn8so
         A8RA==
X-Gm-Message-State: AOAM533LbuIrF1270v8HlmH0+IoQEzq2KsrELoDuhwLNuUvz9Z81Ql+9
        olgwboinQ7gHtLOKrJMsKmJl2O/lPi4EDrMYN4+97Q==
X-Google-Smtp-Source: ABdhPJwrudGFuKZJw+FbkVIqwln+dxgpYN7wHF7xLlU/GLaACH6N2a56+HOTD/+Lzx+ZGKnn9RX78xhgpVuEYxmRjj4=
X-Received: by 2002:a17:90a:d306:: with SMTP id p6mr5541989pju.25.1594751002608;
 Tue, 14 Jul 2020 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200708230402.1644819-1-ndesaulniers@google.com>
In-Reply-To: <20200708230402.1644819-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jul 2020 11:23:11 -0700
Message-ID: <CAKwvOdmXtFo8YoNd7pgBnTQEwTZw0nGx-LypDiFKRR_HzZm9aA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2 net] bitfield.h cleanups
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 4:04 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Two patches, one that removes a BUILD_BUG_ON for a case that is not a
> compile time bug (exposed by compiler optimization).
>
> The second is a general cleanup in the area.
>
> I decided to leave the BUILD_BUG_ON case first, as I hope it will
> simplify being able to backport it to stable, and because I don't think
> there's any type promotion+conversion bugs there.
>
> Though it would be nice to use consistent types widths and signedness,
> equality against literal zero is not an issue.
>
> Jakub Kicinski (1):
>   bitfield.h: don't compile-time validate _val in FIELD_FIT
>
> Nick Desaulniers (1):
>   bitfield.h: split up __BF_FIELD_CHECK macro
>
>  .../netronome/nfp/nfpcore/nfp_nsp_eth.c       | 11 ++++----
>  include/linux/bitfield.h                      | 26 +++++++++++++------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> --
> 2.27.0.383.g050319c2ae-goog
>

Hey David, when you have a chance, could you please consider picking
up this series?
-- 
Thanks,
~Nick Desaulniers
