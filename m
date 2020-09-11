Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA035266517
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIKQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgIKQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:51:46 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A15C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:51:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d15so6495716lfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRvX50M00tmvx7pTa10pVJpXWiSmr8AIn3PnsdFX1po=;
        b=WJXM8/S2PJ4H0OFfbqsmFLuTERhew7lrgEI2nsDP2sENxEsOs2rRflrEdLsK1QE7Oy
         Uv7KwiB4HnCpt/ZJw5VcHvJxySdUqFwptBtuMm9WPPnbktNh9KxED/sqGHqSX2hEzv2/
         sRPbkyekgCVpNMcXZgmUpRvmZLymCfre8W8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRvX50M00tmvx7pTa10pVJpXWiSmr8AIn3PnsdFX1po=;
        b=EHRRpFYcS/p5EVJKdBjg7aDZgfey6ZNNklXInq+5jntNPd86CqHb0SAnVteXSPnnP2
         0SCyfpVqLYyqiX/feOLRVtmXqjZKQL8dnHMxXUGb/LZ679nvXCW1x7GOmOaTp5WPtWZC
         rCekzKGX/RenPMGmbsS1xKb5ZbZnkBVd+E90FBJhv8W4O6fyPjNcSt3o0AqUWZIE+5Yw
         tIjuSq2wMvbFahWOgTqh74M+/PbFxclO2xYmA1rfn5LFhJc2icLYG1tYOiuNcFeZZtBg
         uwiVqS1bW1fRBsaH7WStdv2y01rN4M38dPsZSihFrz9/nSwFmh5MIrLDcVH+SjJAve60
         vzAQ==
X-Gm-Message-State: AOAM530smB4gDL4naR6O9Xln/4j1cun2+dp+EGv+4BEWq0iLZMTSkrS5
        GLmVf/vv37oHnI8qEjnHbd216ZPsw0x66Q==
X-Google-Smtp-Source: ABdhPJxOVoNvMrhz/myPT6s+dSheKTX7KxVTxEjRocS0lRTNLfWT+VWkefC01XMj39N4557Mfpl4UA==
X-Received: by 2002:a19:be0c:: with SMTP id o12mr599921lff.313.1599843104058;
        Fri, 11 Sep 2020 09:51:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z20sm590154ljm.41.2020.09.11.09.51.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 09:51:43 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id z17so6490713lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:51:43 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr626634lfg.603.1599843102795;
 Fri, 11 Sep 2020 09:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <5b1e2536cdbaa5246b60d7791b76130a74082c62.1599751464.git.jpoimboe@redhat.com>
In-Reply-To: <5b1e2536cdbaa5246b60d7791b76130a74082c62.1599751464.git.jpoimboe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Sep 2020 09:51:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6SRtDQqghBcY6mBQYm0b-ZNPWh7oC_-1tdOpG8YQ8dA@mail.gmail.com>
Message-ID: <CAHk-=wi6SRtDQqghBcY6mBQYm0b-ZNPWh7oC_-1tdOpG8YQ8dA@mail.gmail.com>
Subject: Re: [PATCH] objtool: Fix noreturn detection for ignored functions
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:25 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Fixes the following warning:

Ack, confirmed. I assume I'll be getting this through the usual channels.

[ In the meantime, Peter Oberparleiter figured out what was wrong with
GCOV and it's been re-enabled on my system, so I'm not seeing this
warning any more because GCOV ends up effectively modifying the code
generation to the point where the situation doesn't happen with
allmodconfig any more. But ithat is just one particular config ]

           Linus
