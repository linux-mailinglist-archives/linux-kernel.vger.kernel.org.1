Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2512EBD8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhAFMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbhAFMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:15:13 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339D3C06134D;
        Wed,  6 Jan 2021 04:14:33 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o144so2646242ybc.0;
        Wed, 06 Jan 2021 04:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yU0fjTRPNfy6gMCoPVRsHQ5omWHH9PCG0sYyXVtfyK4=;
        b=Zo2go7CILB7vNmklrz0/Lflug73zqhlisF2XtVFfANnurl4nWDfQToYPw1HB1onw1k
         CQeyhWLj7F3PoyEDxZH5Boj2OG8fblLHWoB/xDLgjiQQh7GD1QYn2EBJTHVcyGLbM3za
         wF/uWOYX9vjp1h5A/q3rfHrFFOoG9zH3jIceCY6lqUgIEwhDPWhcL9ULv3+WtrbJTzzK
         OSz03gF/nj8Yr2B45AaK8ULODR9X0B2iHQwLFg/RloaaSP3Ys8FyQqCT5LiZ6uSAiDqn
         Vx+dCsL68vB3NrAMfpD6XFjCsF3gQo2k0x1zmZry+06S587X4CQoOb/WpHDQsf3So9pg
         erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yU0fjTRPNfy6gMCoPVRsHQ5omWHH9PCG0sYyXVtfyK4=;
        b=EBEq7m3O5kPJ4BrBVvhPwmCD1JerUaCdr0xatNwXFchgW/88GvnNgLfkBGj2kBAzvx
         8tPLjrCXcqnKXusBUl32+1x33fyg/kbaqn9e4d6y8snDFt16NMSM9oKR+/7f+f7kGiHQ
         I37j7yP3rC1HA5Vq/WeZ49qMkU+NPbrAzQ9kD/nirWqU7Ct/Z/YGUmoAIiXZjTw4RA7u
         F7cXZ+Is5AUZCMCYmQaUPiDxcK8lAUttzlviWfkuLxePQPm4EUd/m/EavzMC17qoCeJA
         ex1Xay7qEMeXvf4OWitLc8eyGTwkRpzf5MxqY9Lf0fJj4nSaE7REd8rjJQgTYKzbf7Pw
         wDqQ==
X-Gm-Message-State: AOAM531CQmvZQhO5iMfcDt8qSz6NQbihagmIKit6GP3Q5Y0MXmFr991X
        5gK6k3XRfbJnAu2ARa66ZxQc5B9NsCG1/p7tMHE=
X-Google-Smtp-Source: ABdhPJyHVcVHVEIxytag6D1qsrIQKdh99VoiPfNCHbrssvb4yY5ajzOjKwX7Fmi0L360EDpeCGXd+SVBoxCs6y6rZsY=
X-Received: by 2002:a25:50a:: with SMTP id 10mr5753848ybf.115.1609935272629;
 Wed, 06 Jan 2021 04:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <CANiq72nTkw_6-5u4V8c9ZSGxjCSTZ1cM26xtJjZHrgJKCxcQ0w@mail.gmail.com>
In-Reply-To: <CANiq72nTkw_6-5u4V8c9ZSGxjCSTZ1cM26xtJjZHrgJKCxcQ0w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 13:14:21 +0100
Message-ID: <CANiq72nstrtYxTyJzk6kXjWZ_UOsPYLw=Lni4kLP1uGYLR5k=g@mail.gmail.com>
Subject: Re: [PATCH 0/1] auxdisplay: Add I2C gpio expander example
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 1:12 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>   - Normally, you will want to use scripts/get_maintainer.pl to know
> to whom send a given change. In this case, I am Cc'ing Rob, Geert and
> the devicetree mailing list which were missing.

(Actually Cc'ing Rob.)

Cheers,
Miguel
