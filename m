Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D22BA441
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKTICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:02:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46976 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKTICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:02:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id q206so9471928oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNW2tMEqeVMvx00SS3WlWpA2yC7CPr7bbQBd7mo/OdM=;
        b=U/wuCE0oH5ZPNjJRm1Jx6sHUo3rCOE7l4SIHHeytWm1nPsc5GTCW9RLjwnWJsWIiYb
         IflgznfwAnPLhcS7wkxr/cSVUKR0rBEKBZE3fiwgyY0v4RWmI9wfyfqRyHyDjr3HSXBQ
         IxdbSYZBICkIhaGSqy2YM2TGPa3DO1spwRUz8vSopDkOF6mdWwSF8f3Bur6O7IeDZ1uM
         zgyEg5gTs9kzUarcwchuIMINObah9FHv//9/xIxa1lokentINrQSqihMgDhOfbrGocf0
         RqJC+83MCMue1m3otlAcSpQ2UXqBE0j+uLHAzg5DdXeUR/BvNIv4Bfz24rj5b2Og56vH
         Ujog==
X-Gm-Message-State: AOAM532+WeJrQIW8pVptFK4DH3OfMvriT1vMfCkJX+OvqCq7+A+KZq9O
        gLX4SIzy3p1Rf5X3fhlVpshvP12MlQz+LpE86L7cp4XeKTg=
X-Google-Smtp-Source: ABdhPJyCk3kYjnyDhMztComlhPO59zBYUUFW/lu6YKHfj3Pzhcnpkg1JnW6JN6uVFE00P4w42rRAYZtYnlSRj1HbDWI=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr5276812oia.153.1605859368606;
 Fri, 20 Nov 2020 00:02:48 -0800 (PST)
MIME-Version: 1.0
References: <c6b1d9620af3e8f89dd0157a41fa4147294b251d.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <c6b1d9620af3e8f89dd0157a41fa4147294b251d.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 09:02:37 +0100
Message-ID: <CAMuHMdWOrPhS-QML+aK4PKj6qp2DDcWO2XbAzZ2U6XTKkGFK6Q@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Remove redundant VIA register writes
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 5:51 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> There's no need to write the same value to the timer latch and timer
> counter registers. Values written to the counter registers get stored
> in the latches anyway. The write to vT1CH copies the latch values to
> the counter.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
