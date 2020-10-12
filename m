Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64728C3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbgJLVKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgJLVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:10:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDBC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:10:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so4087702lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOrsHQ9G0rV49VAs2/iNWIJn+1lOPikyMFMBKkjaheA=;
        b=BqY1wpuuQn3G1w0Woz3taoq7oAVgBmBGKcGnvU/9Hto8MXwhep/mJvOHOCbH4pbMPR
         pOTYs9G2/fuh6Pj4gxxj8bRiSZ/FEmQXDGvPw6h7wdkfOQLSdW5hVRh4KEiOW4dHqGUc
         lJseq5/bodsWCL0JHfWpr1hSmiv6vlgTU98J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOrsHQ9G0rV49VAs2/iNWIJn+1lOPikyMFMBKkjaheA=;
        b=d7cvNcrwqEfqTflxVrcqrtvJ59QI/MM2MWrzIkwV6TwyGM983tXOeXFKX8A8bpt9LE
         fWzVhu3M73qLIZYi+JgAEloCEvb5PHOMXa4pBgoyn9T3gxdtciPR1M9tn7zbR2CIwGf6
         UefO3UzUBM3xl+fpIZTCfVGstVd8oE/WH176p84lQU8nCYw5KGm+1aJ2SKpBRLolHf6o
         ngN6MRs0OUEcX02ZVij1jNmi+JHkB98T0Y+uQ20JzsJ5J7oXccT7/53C6hfkiPxtcIRx
         oi1PoGdWfh8bhgLi+x0QRNuNsHcdaDt7DLz4a4rrnMX8XNuoKS+nzvUouXCxJqqdDg7B
         +Q1w==
X-Gm-Message-State: AOAM532EK84ohQtHYAcN/eI+Uzx1vfNf/YGKLl4zXoCQSC4yFJuJhyu7
        eqU6agF6cXKhiN2NbpfW/HCpsxGOdbEq3A==
X-Google-Smtp-Source: ABdhPJz+JaHNAsU4UBPrnzBHpWADLJ8frmjmkmGOqm6KpaheEehXenZ9oBSLdzopXt7K8ymTNqQNlQ==
X-Received: by 2002:a19:c112:: with SMTP id r18mr8229675lff.208.1602537028201;
        Mon, 12 Oct 2020 14:10:28 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o206sm3615299lff.204.2020.10.12.14.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 14:10:27 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y16so17069756ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:10:26 -0700 (PDT)
X-Received: by 2002:a2e:898c:: with SMTP id c12mr1471060lji.285.1602537026541;
 Mon, 12 Oct 2020 14:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201012101012.GD25311@zn.tnic>
In-Reply-To: <20201012101012.GD25311@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 14:10:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
Message-ID: <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Borislav Petkov <bp@suse.de>, Mike Travis <mike.travis@hpe.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:10 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull the x86/platform queue.

Hmm. I didn't immediately notice this new warning, because it only
happens with the clang build that I don't do in between every pull.

But this pull causes new warnings from clang:

arch/x86/platform/uv/uv_nmi.c:250:23: warning: implicit conversion
from 'unsigned long' to 'int' changes value from 1152921504606846976
to 0 [-Wconstant-conversion]
                uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
                                  ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and I think that warning is correct, and the code is wrong.

In particular, we have

     static int uvh_nmi_mmrx_mask;

so it's a signed 32-bit integer, and the code is treating it like it's
a 64-bit mask.

Of course, it also looks like that 'uvh_nmi_mmrx_mask' thing is a
write-only variable so it doesn't matter, but can we _please_ get this
code fixed ASAP?

                     Linus
