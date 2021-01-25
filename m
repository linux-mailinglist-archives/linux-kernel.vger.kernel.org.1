Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACB302BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbhAYTit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbhAYTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:08:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:08:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c2so16548600edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdLQs9YhUyBlZb0691w21OoM7gQzX66C67jTFkr/mjs=;
        b=PhrOFTqhSD76Or0F7QbEfxqm+BbqNn9iOEQYgXFGi3uCzXbCuJkk0zDu9CLjb4Jzsf
         zqeSh0g5FZ7bMnwp1o5HMnJL7m/cdVT/mDKnzwAG/5wEQjlMnB9+sP9uhPqFmCkw80z0
         iU7/aSx2UVj67ovkxa1RfIQ+MHYel0wPyW1HLyzMdWzY6JGwgZFIs3B8dSkcB7tSiGm1
         R5cUo3I42gUHtEfPqI/VDiOk0j+Wsubjr68RY2aG72aFksiuefjkV0ea62QfDBG7HZer
         Ra/p/gJIIvRMMZ8eICr2Q9PA+qnd09AZTfzC9LF2PftRdM2cpsEuriDE+V7SuGGe1RMC
         iMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdLQs9YhUyBlZb0691w21OoM7gQzX66C67jTFkr/mjs=;
        b=dHr2hrUYkij1KYNW5usaDriHyCKp4FroHwqJsBs1s5VAEJi3uCbzI88ZuwdCbIUJmD
         Q2khbagc3Gu/wl3TyVWpyV2EuN9etNegd0+1pmcCc7wu5l+pNqetG2tcPFzZlNmu18Ih
         80f28HI+uV+Yw6c1g649o2vBj7muXyT1gZvjZw9WZzmbpAUTPpdmBeI81QSqOow72AX/
         qLL9uR06aHeo2f01DF4mnl/UsC7HgvWDfNhd1bV+V6LyU9M1PJkIZxTQ16HcFADGRA1f
         NXHA/BSbZMu+vpThqfkbr4KNNrOzI3ZPH9Aa9mWywFJbXiH0mf9jGU0mYrpeoxAQZdhb
         nudQ==
X-Gm-Message-State: AOAM532Q96EX6C8iQHY8S7kf69Iz4FuxapfgKxR9jiaELSYnFHt/Sz4F
        X/0d3fDNG9tootDj4+4scTWZDMOVg8zSKsjCbnK4xg==
X-Google-Smtp-Source: ABdhPJy7Z4G9Po21L2Y3F0cRzdLntpiU/TxO1jJY1JOninMHxU5vtKQjvNzuJY5pAljmUmwR4FFdEU8DIfMQD9V/9mI=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr1802740edv.210.1611601695344;
 Mon, 25 Jan 2021 11:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-16-pasha.tatashin@soleen.com> <e5f1ee17f8e4ac3a5f5077d85318e0ed@kernel.org>
In-Reply-To: <e5f1ee17f8e4ac3a5f5077d85318e0ed@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 25 Jan 2021 14:07:39 -0500
Message-ID: <CA+CK2bB=kLV7gamcpdBr0SJ1mR-JwosL8FH=AiFMUmvGc_FE6g@mail.gmail.com>
Subject: Re: [PATCH v9 15/18] arm64: kexec: kexec EL2 vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +.macro el1_sync_64
> > +     br      x4                      /* Jump to new world from el2 */
> > +     .fill 31, 4, 0                  /* Set other 31 instr to zeroes */
> > +.endm
>
> The common idiom to write this is to align the beginning of the
> macro, and not to bother about what follows:
>
> .macro whatever
>          .align 7
>          br      x4
> .endm
>
> Specially given that 0 is an undefined instruction, and I really hate to
> see
> those in the actual text. On the contrary, .align generates NOPs.

Fixed that.

>
> > +
> > +.macro invalid_vector label
> > +\label:
> > +     b \label
> > +     .fill 31, 4, 0                  /* Set other 31 instr to zeroes */
> > +.endm
> > +
> > +/* el2 vectors - switch el2 here while we restore the memory image. */
> > +     .align 11
> > +ENTRY(kexec_el2_vectors)
>
> Please see commit 617a2f392c92 ("arm64: kvm: Annotate assembly using
> modern
> annoations"), and follow the same pattern.

Fixed that as well.

Thank you,
Pasha
