Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7C28FC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404170AbgJPCd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732301AbgJPCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:33:27 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2722DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:33:27 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s89so653161ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeAo0ZW9nO5a2yB9Ja+DmEq0V11E5KXr2FZaCu/+mi0=;
        b=Xs2WMLWedlpEY/miDjOlsAq9oiSULmq0nKx1UIQgemi8Xr3HLMxZbNo23e+1RpQ6ja
         nzeKMoaejfBboLgSlv1TX6VFfiKIL47FxvbB4Y0QQg+0IzoMsMVS5x/eREpdyOp1YeQ9
         stRSpbsA5xhlaS1KOa2FzNPHmVmRcSIL+CEp16Sz+u98VavmymDX3gkdruVyEz73vgCf
         cPfUuD3TYWYBixLNUcirACSFVpYbLPT0HiKnrYXVMfR29qdEv9kXXsrXw8J5LYq+H5LK
         UHr+kOlazRYnahr1LRP2Qk/I8Gmdil8IjeyXG9DeD7NWR/jxIh+I5W3nkpXS3VRymYSP
         XZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeAo0ZW9nO5a2yB9Ja+DmEq0V11E5KXr2FZaCu/+mi0=;
        b=AfdJj22L/rwVs1uRKDOJQ4hIXyquvQtv3rJHlfZ2WJqyzxfZ5WIb8XwObJwPvh5iZW
         bRWRZpC2/X9WU1kgpuS6kAHq9EyW37Du1UadyT28SN7IHDOu+UGUK0PGVPL7UpDztb+z
         6zuIdTMKInStoz/iDTuMlt4sIr0tIe0JQFHcz4VueMPozKEk32l9Vs6H/3IZcz8D+IZr
         lNuTs88TlScMCwAL6NDwyBwtaNbZWq49l8TaVejhKQjqhEe6hP7CaBg1lyRzoHBJUolD
         2VjB+nGnV80G1rqhy5k9Ix+ki3Mvyy3vAHvjaWxVgUE+Wc47o8+MI0WmKgVaEWjU2xuU
         EnIg==
X-Gm-Message-State: AOAM531TVQoOlF3NyyjLUlMxMCnufC3o8Hu2LX+NovdeB8rU8LwhLPtN
        zRTPC/v72giEiyGQmzDca9ctrDNWqYvtqz/3lFE=
X-Google-Smtp-Source: ABdhPJwS2TSMReajtMJMPsUFeC+l9+Mmq+4hySJ+T+wU4RVSuJrrAmuGj7+jl0ZsB5yiLCTZn4fGT19ThLnZWdakGfM=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr2088076yba.22.1602815606507;
 Thu, 15 Oct 2020 19:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de>
 <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com> <20201006083834.ejbl5itjvkbqbmby@lem-wkst-02.lemonage>
In-Reply-To: <20201006083834.ejbl5itjvkbqbmby@lem-wkst-02.lemonage>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 04:33:15 +0200
Message-ID: <CANiq72=cz-bvbGU_cY+Rwoq_hJAXBEur=Yw4=Cs2APxp5yODAg@mail.gmail.com>
Subject: Re: [PATCH v4 00/32] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Tue, Oct 6, 2020 at 10:38 AM Lars Poeschel <poeschel@lemonage.de> wrote:
>
> Changes in v4:
> - modtronix -> Modtronix in new lcd2s driver
> - Kconfig: remove "default n" in new lcd2s driver
>
> Changes in v3:
> - Fix some typos in Kconfig stuff
> - Fix kernel test robot reported error: Missed EXPORT_SYMBOL_GPL
> - new patch to reduce display timeout
> - better patch description to why not move cursor beyond end of a line
> - Fixed make dt_binding_doc errors

Picking these for linux-next (including Rob's Reviewed-by). I have
spotted a few typos that I corrected -- I will note them by email.

Cheers,
Miguel
