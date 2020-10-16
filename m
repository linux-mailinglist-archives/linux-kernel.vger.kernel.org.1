Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CB28FCAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394031AbgJPDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394025AbgJPDTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:19:39 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE381C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:19:37 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id s89so720510ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJYKBcCXZlv8WXk+yX5Jl9oyPoOWc+Ilne0ptBVvlTk=;
        b=Kgvx5l+7Pe0j85iMO4evONuKffb750hhQ9Lekmpfb9mM34eEAitpqg2ddMrqwIzh8x
         yhjDI2Vi/bMrkOR/itUYHyNf9n2XBExV2ENlwEkv/OYf21Qm1oqymaroXGC7VLNv16aQ
         skv9gIBbP3smr3JcXOrLN8sfCHE9IgaFbVFeWzfo5vx6Ttmi7RUStpctLgPKFqCXrGb5
         dP3FXxGMSPVr4Rmrj8NXqksTY4vG78CzOXTJL1gStdRHjzLqA6yRIHpOBfwSHMSjGOk+
         wpuocEC8srF80lHJFxOONDmtgWnr9oF7NN7tnaZB9bzw/VVkeeF8ePbVqhVihrvwHpM5
         75Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJYKBcCXZlv8WXk+yX5Jl9oyPoOWc+Ilne0ptBVvlTk=;
        b=dNWG+j5wAd457vzkLd9LPAi555HAD22NebKxU6YZ58y37peF3SiL4kA/RKarf6lhU0
         3lQcej21ntl12sCKWgLLefrM41hJcQU/FaDw0gMSH8MaQkGbdc9anKZOc9lUavlwA61D
         CGgxKomOu+ZVXBRsaPsgUw/uwdDg4CfUeSfmE2guND6u1hT3gl8p40jgJiBRqHCUkQLX
         Kw9DaNa9DAtNJvoTweWlgIccHH+BUvehRePYv4gYedNoXOVfPxyURVf5G4+5yhkELPuJ
         5Sr2a06ISnGzX0sVOt96pASKiUajYnspjZGNzieLRRDT8u4bxNk69LTiSHPLwQmz7FRo
         1bAA==
X-Gm-Message-State: AOAM532bulsAVKMFQC401GyRu2VFIvZtKm96vazBWiENpehtBkQxNHbc
        isBZ37pD/eg+pbQDK0itQwgU92JZz+Z36e/5uC2/oVQCEjM=
X-Google-Smtp-Source: ABdhPJyrLUuMSNlUnkUce4Qu91rC5QD8Zu24wFmsU3aF+Dszr9HLvtOWF8qYutuPWcnoVM5MkmIz0GP9eP3igQJSr9g=
X-Received: by 2002:a25:c786:: with SMTP id w128mr2035771ybe.135.1602818377248;
 Thu, 15 Oct 2020 20:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201005130128.3430804-1-poeschel@lemonage.de> <20201005130128.3430804-12-poeschel@lemonage.de>
In-Reply-To: <20201005130128.3430804-12-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 05:19:26 +0200
Message-ID: <CANiq72n0QNusCdW5VZM99Jb9dw3zFLXFzEAGoBW7VQQikUmCQA@mail.gmail.com>
Subject: Re: [PATCH v4 24/32] auxdisplay: Move char redefine code to hd44780_common
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:01 PM <poeschel@lemonage.de> wrote:
>
> +       while (*esc && cgoffset < 8) {
> +               shift ^= 4;
> +               if (*esc >= '0' && *esc <= '9') {
> +                       value |= (*esc - '0') << shift;
> +               } else if (*esc >= 'A' && *esc <= 'F') {
> +                       value |= (*esc - 'A' + 10) << shift;
> +               } else if (*esc >= 'a' && *esc <= 'f') {
> +                       value |= (*esc - 'a' + 10) << shift;

I just noticed this is undoing commit 3f03b6498 ("auxdisplay: charlcd:
Reuse hex_to_bin() instead of custom code"). Lars?

Cheers,
Miguel
