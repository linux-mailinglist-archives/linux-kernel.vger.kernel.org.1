Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C528E71F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbgJNTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389644AbgJNTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:16:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:16:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z2so735929lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLBC1OBCAHPnlJe/kwABmB7Gu/SxbFcXde/KY/08Vw0=;
        b=MqBNMvj6g8fhP9nN08YJSxZGfPY+UdXwbQFpRboG//A1f/DWy3z3Q7zQpX51uTIAUM
         zcX/BJ55DNTdSFID5z00t0gYnxZsI3PDsax39wRQm4dYNf3qR+5dPY5qCG/9gKofNiEA
         OTOpn1bZl/jnoEEpVblH2kwT1UBknAUZXCU0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLBC1OBCAHPnlJe/kwABmB7Gu/SxbFcXde/KY/08Vw0=;
        b=lxKfyeoRe9nFLmH/hk85j2rXcriwZifGdQEGv2MzZg2h9Yg6PbThDFDbzTSv7//bGW
         e8rhEsltqmQMExA/bNe7JSl+B+O/e0A0/J2T/fs2s+iWc9cGY66oLZApEhI0NsgVtm+z
         iiFkatUlIR6fBWJeF7PUc7KhQVfGisGGgLEnFJs8GJ8tWKEnT85LOW74l9S6kMg+Fbfc
         XLLOcgkgQz5pDlN+uJkmnPQ2Inasarf/NUem9OFSK4TH0tcmm0tB2sGfOcsX/2N4wEPe
         XkB3erqgNbVNWPc4J8TT3DnXUKnp+gWi59oX/e2cLR30lZGAH8iyF58vIYmGLYDiXi9i
         uVRg==
X-Gm-Message-State: AOAM533B40D/p7i+j34BnB2QzFo7jvfHCbYZ4h+dQGx6LncQHwpnYWE7
        eQ+Hf7AXKy05X+yiA3sLLSRMkHA0gq7v4g==
X-Google-Smtp-Source: ABdhPJzZp9LnfTTODaJdADjPkz7ElmdxscGNEpoEF7nd9gylZ96VOTIhIXcfAhfH4ucz58rmEmdYzg==
X-Received: by 2002:ac2:4548:: with SMTP id j8mr221839lfm.470.1602702973664;
        Wed, 14 Oct 2020 12:16:13 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v20sm215664ljj.50.2020.10.14.12.16.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 12:16:12 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d24so684534lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:16:12 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr240074lfa.603.1602702971895;
 Wed, 14 Oct 2020 12:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201013160353.GA19438@8bytes.org>
In-Reply-To: <20201013160353.GA19438@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 12:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
Message-ID: <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.10
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 9:04 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> there is a minor conflict this time in include/linux/iommu.h which
> should be easy to resolve. I would attach my resolution, but somehow git
> [show|log] didn't show it to me.

So when a resolution takes one side over the other (as opposed to
mixing two sides), then "git show" doesn't show it as a conflict any
more.

The reason is simple: at "git merge" time, git figures out the common
base, so it has all of "base", "side1" and "side2" to look at and does
a three-way diff (for the simplified normal case). So it can see it as
a conflict, because it sees both where you came from, and where you
ended up.

But once you have resolved the conflict and committed the end result,
"git show" (and "git log") doesn't do the whole expensive "what was
the base" thing any more. "git show" just sees the parents (so "side1"
and "side2") and the end result, but doesn't really see - or care -
about the fact that some time in the distant past you also had that
"base" state.

As a result, "git show" doesn't ever really understand the notion of a
"merge conflict", and all it shows is really "whee, this end result
looks like neither side" as a kind of pseudo-conflict diff.

Anyway, thanks for the describing the conflict, it was indeed not
complicated, this email is just to explain your "but somehow git
[show|log] didn't show it to me" thing.

                   Linus
