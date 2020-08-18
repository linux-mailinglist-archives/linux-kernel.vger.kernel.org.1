Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B3247B85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 02:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRAcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 20:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHRAcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:32:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14DC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:32:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i80so9267190lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPpTb0t7NWl2AkDuMRniXSMDNHgBHw+QLsYUwO1P2JE=;
        b=NjWhrAjrvkHU2ylYxZvVwKjcvWjKRCBpUHi3A4Mzbm5224Dzvl+GxESdBwYSfOe0Sy
         3bC7l1xRZ+YqZW0PjTykihcJ0GgNN8b59RpqhcAvhesX+yLFzbfpHcGWfn/HlGXILcd+
         P55aib9nxwGvEMGcdr1HikiMTeu4AeieUKQ2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPpTb0t7NWl2AkDuMRniXSMDNHgBHw+QLsYUwO1P2JE=;
        b=pX5WI8BPA3aBLFhgAIk8ap47G+0/53+CvlfgnhVn7VH3WX/3ZJpj12ahlneVVZcD2/
         hZxUQYNEwFALsrfQ4Pmb1hfsRLXZooGsrRHjYFXfSM4mkBXUKsB0GTXz1aai9rTjllJs
         8ESuUTwBIR6fkbR7QpjTkvZqrlp2MNDzebaz6KfBmbwYCrMNITy8SNXRUuJL6+R1ih4s
         3cPDrZw4GOVE5vGyzlk//n4Z/3BDyzjvrpdlKkcPvhXQeMNicKNx1DdQFJaUUbaYInMv
         pI+vZGktRqt2gPre0ihpMJ3H0A2v/DCNPXmyGguLnUJFompFHLNlSTyUymPKYik9ecZg
         3qnw==
X-Gm-Message-State: AOAM531eeLwggiYcl+7lbe+GZDD22TcJpKz5JI8HUVfnag5c8NjrKinF
        EN3WTxGLkDvUuekUOvWdojMjbWAqbAcZtA==
X-Google-Smtp-Source: ABdhPJyEyQKJpK7Ho3L5GZnzWeHhWra5VKLEtFvR/iCSFXigMwNEquGQ7zoVbfPfl52Jgiq6rWsEmQ==
X-Received: by 2002:a19:c1d6:: with SMTP id r205mr8472386lff.141.1597710769834;
        Mon, 17 Aug 2020 17:32:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w19sm5366654ljd.112.2020.08.17.17.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:32:49 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h8so9301250lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:32:48 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr8424056lfa.192.1597710768609;
 Mon, 17 Aug 2020 17:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <202008171624.8E3C303@keescook>
In-Reply-To: <202008171624.8E3C303@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 17:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKsEC8TUhn5mXapPV7sY_ZxpR-hini75zJ2e-iX+SUNQ@mail.gmail.com>
Message-ID: <CAHk-=wiKsEC8TUhn5mXapPV7sY_ZxpR-hini75zJ2e-iX+SUNQ@mail.gmail.com>
Subject: Re: [GIT PULL] mailmap update for v5.9-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> It's a programmatic
> reordering and the addition of a pstore contributor's preferred email
> address.

Hmm.

I pulled this, looked at your script, and went "that's not right".

If you want dictionary sorting you'd use "sort -d".

But the commit message says "sort -f".

Looking at the *actual* ordering, you do seem to have actually used
"-d". Or I'm very confused.

The end result looks ok, I'm just confused by that alleged script.

            Linus
