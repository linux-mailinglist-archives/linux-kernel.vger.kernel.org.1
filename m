Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C721D22BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgEMXHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731815AbgEMXHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:07:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:07:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so1380881ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AISywjaIigbZvM5wrGKe3nZxsN8rSRNo6sOvjusdnS8=;
        b=Uzk3ZMzxMHYI0Jjw3+l5m9Q9Wo7N0ohxWcqxXfgobzt7uyR3kBGf/nWToM//QOLkxa
         WYGNDh2ssyoA5t3wvD4bKOJ3FzbPoejK85Gc3uR5fVVEuAv1goPPxlzMjuEIXhDAyrqa
         4SjCmVPcKv981c1X/lwHnQcnV37ZB3+z74yYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AISywjaIigbZvM5wrGKe3nZxsN8rSRNo6sOvjusdnS8=;
        b=dhSP/BPyiGW66VzkRRIaUBmMUdNhtI3HodhTUZB/Tx3zojHSDGZlCGa36c9+TxuxXZ
         ud3pdekTsfP44Km4H4yb3ModSw3EO7LzpxAu8QvEEOy3nIhXxZz9iaPpHCnITNpDE+UI
         VuCpuuMhRSd1PVWzKaCaLlqdsD8GB9sf/gXq49gUyUbT7TdkQP2yNZi/nGfY3WkHxZMf
         0LY5gwFFWhKS+AvIM4jMp/SZwfGAIJn1GWZv/Xda/wptqpBvWcWkmtrAOzusVe/NqjNZ
         lVMRHA/Iq3Oyk7dLdyv+QvNfiNKfyJKrATyVVANUV8CP+ktAO9eifJM4gqtV99PTEixt
         lQ4A==
X-Gm-Message-State: AOAM530ckVnrhnl86l7axneNt0Ghypg6ClKvtSX22m1auEm8lLDhvXFT
        xloCAFacqv6kjEnAHK0EyTq+kA8QOGs=
X-Google-Smtp-Source: ABdhPJy1axCoHb1EQddIkBLp+7nKGivaVxzfdD+zFtiNrmw9KZ1tQSFrSvdgqlDqoeGXdj4B4k9euQ==
X-Received: by 2002:a2e:8155:: with SMTP id t21mr784036ljg.5.1589411254683;
        Wed, 13 May 2020 16:07:34 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d19sm569140lfj.8.2020.05.13.16.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:07:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w10so1469404ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:07:33 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr824451ljg.204.1589411253419;
 Wed, 13 May 2020 16:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
In-Reply-To: <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:07:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit4EqOntq3Y8-d6spWYQT7r-U3kTLcagGb2vbAhwvrJQ@mail.gmail.com>
Message-ID: <CAHk-=wit4EqOntq3Y8-d6spWYQT7r-U3kTLcagGb2vbAhwvrJQ@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Right, in particular since Linus started building with gcc-10 already and
> would likely soon run into that problem if he hasn't already ;-)

I don't happen to have stack canaries on the configs I actually boot,
so I didn't notice.

But yes, we should get this before 5.7 and mark it for stable, since
F32 is now gcc-10, so people will start hitting it if they enable
stack canaries.

         Linus
