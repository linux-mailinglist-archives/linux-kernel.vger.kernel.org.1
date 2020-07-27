Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7122F73E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgG0SDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgG0SDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:03:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BE4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:03:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m16so8505811pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HUK2rHG97QodtAqtmT31+xBsb58/wIDEA5SoI1QmOI=;
        b=CprVCxC5Df/E5rRlMUu1Inf3anLB7yhmiZVty2ZcaJULvfIdVOTZg6+EIJD6NElbfx
         c7jkAOgmyQPZeQWik5HskOf5OnLhWTJ1lxzzN2ZNa+CuB2U6HJUt+a4TfRaaQYeRWQUg
         zdwdMSZdglSqdubOFkgy+YFmWiIl5fSixQKhI6z2cJ6BZzuKvge9J53xhJbvRVrWAuWn
         D6pGYwGIdEtTHRTAwyYkrNXwMLipAleDEvt7RF1nEDl4X1t1WsATZ+RPPfPOVYDUTVeU
         4T3DAkHJogp+FdpjwFvctA45ny2SOW5agyegHLH6pKmK3Qm7/BuYdHCno8MjqKBrICOl
         qNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HUK2rHG97QodtAqtmT31+xBsb58/wIDEA5SoI1QmOI=;
        b=b+M7s/7amg04/fYK9SHtU59mCLfAYPY/ZcAQg+Vuaq3YRK7PYLqAb26AvvI9mfyWjC
         F5nF9U20h3uB/PGe2bbolWV2DujpuOF/JLkdYn50IPiNsBHmgEAxYmtrBPwetqoBmNRO
         aJmDMrc8vENmff3AyUeSOZSyGjHwPciTfk+DK20IIT6sRSNORqpWl1Twzcu8ar5UhbGh
         NEbz8pM3BMtPB6AtEoCWOgw49z6wy/m5bRC5UMaIyguN9BYsH18sf394RpOUk/ccG6DO
         ExdvzItaTTD/ISyR1u4cMvjsaV1042j2h7UoA34YPLSWGVs5dzLpy8RJdAh67fMeYeNs
         VZ8A==
X-Gm-Message-State: AOAM530LSqH1EgNoidljv5SgHVLL15AYFs92jI9ZGJc3wn11SDQlS2Sh
        pXbhv7s2KZYJO3QMeVuhWbvsqviVw52e2ptllV8Vww==
X-Google-Smtp-Source: ABdhPJwz22qZhfSThB7Mzf/1O0HxvMuy2P7Jof1+xnKvCm2FF0jSEIcNGsHzKJLuEgHbt53bOSTB80vaMpxDEssy/ME=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr495452pjb.32.1595873011083;
 Mon, 27 Jul 2020 11:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGTHR7wWaS+CdA9aR-8wWXa-AC47WBuLe5BEg01pFoKwKBpAw@mail.gmail.com>
In-Reply-To: <CAOGTHR7wWaS+CdA9aR-8wWXa-AC47WBuLe5BEg01pFoKwKBpAw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 27 Jul 2020 11:03:19 -0700
Message-ID: <CAKwvOdnK7+iUyBdBaVTY=5JMK9Fm11PU2sc8ZwYfWs1OYAbeNQ@mail.gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Rob Simmons <rsimmons514@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 4:31 PM Rob Simmons <rsimmons514@gmail.com> wrote:

You may have forgotten to send a body; but yes genksysms is brittle
and upstream development on it stopped years ago.  Put an attribute
someplace unexpected and the parser will silently fail, making the
modversions hash all zeros, which doesn't protect you from loading a
potentially harmful module with different function signature.  If
you're planning on attending plumbers, I plan to put together a brief
talk on the subject.
-- 
Thanks,
~Nick Desaulniers
