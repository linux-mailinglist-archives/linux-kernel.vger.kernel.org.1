Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBB29830D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418047AbgJYS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418040AbgJYS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:26:33 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53583C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:26:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x1so470544oic.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x67Xs7cDC5M+fx38P4s5d7Yp9lo5OaAtAzZ3xPA+vSk=;
        b=eKB7skNqyjyJU+VyjQrlo5csNL4bvCx+guk+76Np1XRpkZsRRcGWOz721Najlt1EnL
         lD9Y+AGjldgTY/nJN0merC1WDL/fZRIoZpdcQ4H2CBMqSkUVALs7KxUKz9EIyFQ1H1/t
         dSWCs1SxwlJ5rhibzF/8PcqFllLCGuTX7arAt9ebfyS5JZx4DnydR8fptMF8X1Tt2HFP
         s2lM56dnboWfODq1h1mcoAlZ1cFPv+SqKnPIJApF/qnk7/22OXRG+qSe+otOXBpY6qZQ
         m98lMm4yNOJdmtzQRMcFq/SJexdj9pd5woYQlZpUgcjIOdtgB52aDPtqSXhpkRnQQtWm
         Kcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x67Xs7cDC5M+fx38P4s5d7Yp9lo5OaAtAzZ3xPA+vSk=;
        b=cYKN9JIDZEPWG7Pip/ZPF/K+9kbbnTle39yBCsYKWCgnKBjcFXP64fEiWQNIBjETgs
         9ECewDfwbLwutDZ+pNcETHaiIJjMhe084b4a9m9DpaNPrLnmfkyp8zRUQRTyBVBWvnWC
         Us4STHI2Q/Edw2S28KZ66c6y6r+xBEqYT5hbXnzknZh6sG00xPwxrg/pI//0q1CNevas
         HdStnaUL71fkNon+8z1RZKIuX96FS3aRdRZniC1dy1+8M+Li3VTw2r6M/sng7oW7RM4z
         ZXEbVlQx+V2LHuIRUA0UletzmLcXaEu2x9TFPSAiRx4e0y4JOqbI+8P1lWhw4zV2sout
         ET2w==
X-Gm-Message-State: AOAM533iRtl1hvn1wCXyW+5bJXO+XL41ArDcNfhwNs4IuQ0hm7/L17Tc
        cCyrIVGI0K1nJOrELkyYSK4xtOI4mPK/h2JM2Dx/6HhsXl0/4A==
X-Google-Smtp-Source: ABdhPJzdDeF2zVZrUT1wnh+ZYhv+2rWkXggi+FrhntvzAl7wqTjMWOi/91Q36prlwieQ3A/vRrBugPEp7R6ALOt+TeA=
X-Received: by 2002:aca:420a:: with SMTP id p10mr8296719oia.117.1603650391544;
 Sun, 25 Oct 2020 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201025101537.59133-1-dwaipayanray1@gmail.com>
 <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
 <CABJPP5Cec7jKfaygRaxm-z5gzhg-7cBX1GP46NRQDM6rfhg3Ww@mail.gmail.com> <6c1c62cd8ac119a6d8a84f262f11eb509ba0e7cc.camel@perches.com>
In-Reply-To: <6c1c62cd8ac119a6d8a84f262f11eb509ba0e7cc.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Oct 2020 23:56:00 +0530
Message-ID: <CABJPP5Cc9H5w57qko372iU4t+_if2cp1TbOfTNRd9zt7bGDW5w@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 11:49 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-10-25 at 23:40 +0530, Dwaipayan Ray wrote:
> > On Sun, Oct 25, 2020 at 11:29 PM Joe Perches <joe@perches.com> wrote:
> []
> > > Using $rawline would also change comments and that seems wrong.
> > > Any reason to use $rawline instead of $line?
> > Yes I used $line initially but changed it because quoted
> > strings were being replaced.
> >
> > Like:
> > __attribute__((__section__("_ftrace_events")))
>
> Right thanks, that's a very sensible tradeoff to reduce code complexity.
>

Okay. Do you see anything else that I should cover in the next
iteration?

If there is no other problem, I will do the space addition one and
resend it to you.

Thanks,
Dwaipayan.
