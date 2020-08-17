Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934B247093
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgHQSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389992AbgHQSLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:11:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32730C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:11:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p24so18844139ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6ypGmjV5QV8jczV+szLTlCNKbExU317d5C4pfNiTBA=;
        b=QH5bN5Gl0drAhXI9N8YU8pV3AJfFsH6TLbTiToy4QTiLV3wHSVJrCCvk30GL/VgIkr
         EdsKYoeupPRFWraUKqeA6dkSCAgTnc3+e5DwhP6Rm+mLU/RaToNv3g5yAjLvWU/LFbkg
         LL+iH2FzEuvMYTChY0GdDSD/0+V17fIWjFDk/t60eywxrLTFs1JRJRl966CPgxVEsYTP
         RBVFEDkfRbbfVeRY6PDvUhjiMeAcPnodPtkW6nt79CitdTJJwODfnrkTNOP+2fwbRqim
         9gMVCedpFDgw5IfJRAiz0hcBikYdorq3T/BiK9ZSyxZBFV4TKBwvPztc7RMkBVqMtEE1
         rIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6ypGmjV5QV8jczV+szLTlCNKbExU317d5C4pfNiTBA=;
        b=BJCbFBnVKDqpqKXicjE+b0+6vL1nhG5wXBKF0OUWd1zx6M1PwZ/9yKoe58cHF2FRwN
         D0dw8cq8e1unbY4jbSG9KvPoYiRV51rQHzxieaFlnEbULFFjwzp4BUdsOiv6c0CKMQps
         Yq/2w5ZEh3yFZZuoSaHNsuwS3esSJcv18UxrfXpNjKVo0ktPZ0tGbqNoBSSsiq6jSUQt
         2I/xBFtIX/QaQNl76PvAtu7+b+H4ChnQ2q+Fl5W8VQqm+6RaUUCu3rl3LhlT5yIIvpR6
         L4u76r/d+AqrgUbYdxt8BPeS64dYel5A1sXpDzHPJCWXBJaC+8q1QhF5hs9m0kCRtgu6
         4sBQ==
X-Gm-Message-State: AOAM532vcsKDgokMnnKimnDSAW8bp5F6csiNaN7wP3tFg66q4RuBrLpQ
        Jz5KmKFpWEmvFLpuFpzAAJhxeEchg5Lizpxd29aqtQ==
X-Google-Smtp-Source: ABdhPJzNB/PgsaWp8IxtULbKUmClytzwV/KE+ZZS+LO1yoO50MWhcV5EgmW5ly7qVI8Y0AbPjo1CmP6k7pPLX3eHcks=
X-Received: by 2002:a17:906:1cd3:: with SMTP id i19mr16089941ejh.552.1597687873687;
 Mon, 17 Aug 2020 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200805045955.GB9127@nazgul.tnic> <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com> <20200817151357.GK549@zn.tnic>
 <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com> <20200817174102.GN549@zn.tnic>
In-Reply-To: <20200817174102.GN549@zn.tnic>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 17 Aug 2020 11:11:02 -0700
Message-ID: <CABCJKud6M+u-TUZ2w5zdPPnwJQ1b7wxXwg8Rnoc=rBC6zMvRxA@mail.gmail.com>
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
To:     Borislav Petkov <bp@alien8.de>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:40 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 17, 2020 at 08:58:26AM -0700, Sami Tolvanen wrote:
> > Sorry for not clarifying. This was in a tree with patches for enabling
> > Clang's Control-Flow Integrity.
>
> Well, I just did:
>
> $ make CC=clang-10 HOSTCC=clang-10 allyesconfig
> $ make -j...
>
> and it built fine here, no complaints. So your toolchain must have
> something else.

Not the toolchain, the tree has patches for LTO+CFI, which tends to
break with type mismatches. This doesn't affect just building the
kernel with Clang without other changes.

Sami
