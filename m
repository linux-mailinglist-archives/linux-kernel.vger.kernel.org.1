Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE92A1910
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 18:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgJaRo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 13:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJaRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:44:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D6C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 10:44:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i19so1947607ejx.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYymDSvAjnOBuTCwmQOuAuneZZmF8XYRT3DXFmwhG4w=;
        b=mRSl30Y8Pokj9fAFTpg3zLdoJuqAmrX8n+L6HmN3ricdjCoTiReRdH0naV5nTRW+4P
         20l4CtJt6JRy7T5NBcDXJm3AakdN/b3LCFW/HdmEQW0IG8Jy3JQs/JdVSIh3YWoxYB2r
         6UOPshRG+RqQt42dcwtKqIOd6+BZb3Y8AgOjsWdNf7yx/+cYCLzZKZdr6Rr0KwRFzmGD
         DpP5zMDDWh31sZK9WdBfaOwwvOzvauUD82pYpuwKuo/GDBF+VDm0QMsF1nvSJZqQlpMP
         uvsUnY6/8pdRRMxS95SrOpqI9AABw2HHAyziNgosxHBz1KG1QzFgL5gKQjhKMAPnfHWu
         OUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYymDSvAjnOBuTCwmQOuAuneZZmF8XYRT3DXFmwhG4w=;
        b=m6eKGQ5NmqXXWjmfYBES0KoWp54uDsN6FLp+RMi3gtbENxmaEXvFDI2PLTH6ZvtbSS
         XVTd63YQW5RBjB437izSXkhByf5sLVsM6GHzgxSb+oQtHyOYsD3esSCU3HDXbGaTzv4S
         mGcOqxZV6qr990EeclH9Om9X3RXvcMLK8dYaSEPeEGa+5qQu+b5AUC28Pi9zt3ujyZPz
         6Ius6iOP2BO+fx1C7AUiFBRQqgR+OMWZla/5wWSnKP4k0UsgrS3CVbouU9cxQPG4MHu+
         BY9zeNuAqgSZMMefhmgP6yBRhrHkbWAKZjZr4DzNyJfY8wK/iqDKGXgQRmQSWI72bCnO
         ajfQ==
X-Gm-Message-State: AOAM530O4SkF+x/8JX/wdc46dct1iNuaArmsC7dAu6cNgdiSCzC557jT
        6NmX/yYQjeXYMh0LtcBNhJSWWTl1Yi2Z3IL1Dqc=
X-Google-Smtp-Source: ABdhPJx9LgBeYorWWM5W6EJfNjt/5Nm4S0/qj9lGM8E2yR9DqVwWIarGUhQhnnbwdqew4Clue7XlI/4v2uRuBbAfIlU=
X-Received: by 2002:a17:906:f11a:: with SMTP id gv26mr8317551ejb.376.1604166268032;
 Sat, 31 Oct 2020 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201031094345.6984-1-rppt@kernel.org> <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
 <20201031171608.GB14628@kernel.org>
In-Reply-To: <20201031171608.GB14628@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 31 Oct 2020 10:44:16 -0700
Message-ID: <CAMo8BfJ4ai4UHD36JZb2ETiFe9SeqpVQw5tsNLrSF8sUx11ccQ@mail.gmail.com>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Ard Biesheuvel <ardb@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Oct 31, 2020 at 09:37:09AM -0700, Max Filippov wrote:
> > On Sat, Oct 31, 2020 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > Please let me know how do you prefer to take it upstream.
> > > If needed this can go via memblock tree.
> >
> > Going through the memblock tree sounds right to me.
>
> Can I treat this as Ack?

Sure, for the xtensa part:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
