Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602AF28BB81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbgJLPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbgJLPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:03:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:03:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so10307578ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dOxxPNjr/iGY+8h7dwDR7hTiVWYmoip3CgBNC9AuzuE=;
        b=ZGopY0hZEV5bwj0rj2DunzilMiAZsTy6XqBCL3e4yGwYyDmBQwJOJDyCVzZ2j9Of0n
         L3y8MEG4r5bV/kgzPhbInVUsTh8sYlj7a3PNkPPPnbMuYdvFNARz/UKeoSIfW5G1fVMw
         3Fd1+CeWdd+GLTZfx+Xtu9CwWoDlpiYfyY49H87H5q5RUxBJ661cW7pzOMaBWZMwMgKv
         X2jgK/3D6jWpcEI+DheIEZWfkYvMEM7JMfPlqwrPTd/ou5d+ilfLDp6qpOFHlWRWTD6R
         Yf5zFkEoZf2Ki80GnomDrA+25ipQ1Aq5Dx/Cm6qCj1RSMJR9561EacIlB7R7kqNY/Vd4
         outQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dOxxPNjr/iGY+8h7dwDR7hTiVWYmoip3CgBNC9AuzuE=;
        b=LkNmuq9P2OL6rRfZBDK2MY7M0WJ2mBHmtDvk6AB0kxOPvIgGlI+1RKAp0WSxPVDprM
         uqVmtjwp6v3dnYeoM6Yexz8LzKGVdpN+hIF2Rj5tFkJzbYas8ZZUAKRcgj0fXOTJpY0O
         wLgpbHzCs+K0DbmN0uFnvNmnLiDHAkD05tcKI75x4fEWVi7A+oCTijWbefub2rGMU5Za
         zvXU9MbaDMKjr/M7XbjeY0LNX0JZd3tdslvNnfK3M6fo/rRO5NfTyr4WIIT0UqIlSsac
         9DyeinTjXjTdPdlj67D+l1CW71726lsPf/uUeQfB3WOpTjQY9MNwywsGIAVj2FBT1zBf
         rWPA==
X-Gm-Message-State: AOAM531rdQGct+gTqdu52pMIDaRtX/+ta/YB8lp7wOjjuJO4Kdrt1D02
        4y1Pml+aGvNJgq8jJsyM7GD3RaiRDUpn+vv8Gmo=
X-Google-Smtp-Source: ABdhPJwpeAItH4JeuVaGeeVfh9CLzdfNJeMzvWGFfuNkMvzJI16Jo9eHNZuj8faSiuVR/SQTmqy29exZ6embZffhdk0=
X-Received: by 2002:a6b:e017:: with SMTP id z23mr16873712iog.110.1602514980900;
 Mon, 12 Oct 2020 08:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUK3sgpHyY1h_pdzJzkX1bY46opLYytRKRzeCxBNzTX4A@mail.gmail.com>
 <20201012134255.GB2023362@gmail.com>
In-Reply-To: <20201012134255.GB2023362@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 12 Oct 2020 17:02:50 +0200
Message-ID: <CA+icZUX8s3WrdunQZvf+ANu90M0v41oP7669O7_0yrjzmxXauA@mail.gmail.com>
Subject: Re: Missing [GIT PULL] request for <tip.git#locking-urgent-2020-10-11>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:42 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > Hi,
> >
> > yesterday, I saw Ingo tagged "locking-urgent-2020-10-11" in tip Git.
> >
> > Did you drop it or was this for Linux v5.9 final and the git-pull
> > request was simply forgotten?
> >
> > Just curious.
>
> So I ran the pull request script to send the tree to Linus, but on final
> review decided not to send it, as there was a pending bugreport against the
> tree, it was very late in the cycle and the commits were pretty fresh.

You mean the lockdep recursion in debug_lockdep_rcu_enabled()?

- Sedat -
