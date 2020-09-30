Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222F727EDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgI3Ptz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgI3Pty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:49:54 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7BC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:49:54 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so1110264qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8/IDDg3h30xL2yKxOXfAZ6SYDQxULsHhio1WiSzVoE=;
        b=b3/eSZrxq9ZmquVDBHUWHZcW8jE3GZMuVJn04cLVnXRpAKQlax71RkHw+TItyAcXOf
         D1/wbcVY1Tp22JA5trNf+ZAjp240f5Hp/IFo/bGRg5t96yAw73K+jPG6eeK7GgW9RdEC
         ny3mkwjN6Jbxx0cHBrAXUvhnEjA9uZ2q77xjQDVhYp6ayW0dfk4vY+vvylLCH4n3iIou
         EBVZoV1Mq2driC9DQmvoOR/tuiJl+S81PanPTc7I0Y30DOZRuJSte5ZddOgYWDDA+3Ku
         d6XBGCk1g17KTfCR9ZIbDx02vyCkW9AKXbdcDIwXXfv6XZ3jt79qZ0dt4xkzIRLPTPkL
         OZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8/IDDg3h30xL2yKxOXfAZ6SYDQxULsHhio1WiSzVoE=;
        b=BXcWjWajvm3tRRookARxD+wR4AG4EVWN98+89KbOj8guenw2P8zbVXmT7YByZ7SAa8
         ITNWPK4OWWxmjBhBdLmT0kl1W/7nHc5liBwWDhorVtIGiYvLit5k8qLk+6hpIYGd9wi2
         MyRkA5U0CT0pFtNMPXHFhPfA3H4s4gJOgIQsiBTx+2UnJs+fmkQcu4Prhj6SCyNwwGBb
         t3VOLBKCvPY++hpRTTn6E3V5phS/fI+FX3uRFM0Ru13GThXdGh7jlyrVHDaYJX/xlNNv
         /f3ul0OZnE3sATzw1YBPEtYce/I5qlmHhI/oFZJS94wrMSGEIxwDCrtQ8fGSHKvEM5O2
         Yq4Q==
X-Gm-Message-State: AOAM5300g8x55PewdeWiA5hqfWI43GQmMh1K9owBWpMyXVe/YW2SBMeA
        6mh5p85+fwrWEjhUDfLACaczz9ZF9GpdDXKvZnTmRg==
X-Google-Smtp-Source: ABdhPJz35tnMcZ3NgGf2cA0sbRzUPpGd/75eBd+InpyMs61ib5CN5zyPrAngEN4AeGJwKtjR6R96dAebjOvm9ebx2O0=
X-Received: by 2002:ad4:4d52:: with SMTP id m18mr2946409qvm.55.1601480993835;
 Wed, 30 Sep 2020 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com> <20200930050455.GA6810@zn.tnic>
In-Reply-To: <20200930050455.GA6810@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Sep 2020 08:49:42 -0700
Message-ID: <CAPcyv4j=eyVMbcnrGDGaPe4AVXy5pJwa6EapH3ePh+JdF6zxnQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        0day robot <lkp@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:05 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 29, 2020 at 03:32:07PM -0700, Dan Williams wrote:
> > Given that Linus was the primary source of review feedback on these
> > patches and a version of them have been soaking in -next with only a
> > minor conflict report with vfs.git for the entirety of the v5.9-rc
> > cycle (left there inadvertently while I was on leave), any concerns
> > with me sending this to Linus directly during the merge window?
>
> What's wrong with them going through tip?

There's been a paucity of response on these after converging on the
feedback from Linus. They missed v5.9, and I started casting about for
what could be done to make sure they did not also miss v5.10 if the
quiet continued. The preference is still "through tip".

> But before that pls have a look at this question I have here:
>
> https://lkml.kernel.org/r/20200929102512.GB21110@zn.tnic
>
> Thx.

Thanks, Boris, will do.
