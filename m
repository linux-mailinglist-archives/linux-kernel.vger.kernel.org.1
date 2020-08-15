Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AFC2452EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgHOV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgHOVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77820C09B045
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:21:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v4so12972624ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoYSOcagikdOmgPviZEP2LliGHPAyUYpPZFQ5sfcSPo=;
        b=Uv7csibiolw1CuDlu16Gy1hKMGKzL80fWUarG895vX9a1+KeDE9e1ot+4TvzccwzMR
         7s/XPY7UZdQ9YZUx9LK4npjhhqyLxQNqNQwHgvbJ8JQtshZui0zkyL6ja2vXp8W57rPJ
         Rzfj5yclo7NtNqAedLzGCeYsDz+hP+x+ECSmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoYSOcagikdOmgPviZEP2LliGHPAyUYpPZFQ5sfcSPo=;
        b=pgmvYHoRsHXx6xNhZ8AC71c14zcpeMyy+IFDxJMiYly2P53GJoAXY4XvplO7Llde24
         6E+Uqq914CEmdBYsQHucwDXIca+bPQ6V8LWJmNwQCKWCf/THy0spceaDQasd38jl7EVz
         okZTS4yoAcXRIzIs6hLNpPLbROqiDRRXEOt5gVeQqHI8PVc26Hf8atujPgQlXrYf37+v
         7mo/y6djrCC/9MOuMmSiB6O6NJpvYtoyFhcdJOp2S1YHt2hgaYZheLKlVWg/xhQwn6c5
         RH8tlYiF+/nngSi6OHyKRjhklwsDkAFM0dofunskgLpOQnDVdhtVTERVdeV0KGzsOU8T
         1xnA==
X-Gm-Message-State: AOAM5303bdkyjyFloRGr8a3ItkglDEPUxhsds2Y+nqVTz8jxwwRnYQqH
        46WWTJtJZcXx5ZnUvKGJaU6wuTkL3vTlcg==
X-Google-Smtp-Source: ABdhPJyWO5RxHfQZ398PoqPX/0VEbrLvj+cUBbBdrXRn1Cq6aTqvGZV29lpawRhrM2nLdGAan/Lwnw==
X-Received: by 2002:a2e:9f46:: with SMTP id v6mr3431315ljk.66.1597504890738;
        Sat, 15 Aug 2020 08:21:30 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y21sm2630108lff.34.2020.08.15.08.21.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t6so12898880ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3202606ljk.421.1597504889274;
 Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 Aug 2020 08:21:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
Message-ID: <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
Subject: Re: [GIT PULL] edac for v5.9 (part 2)
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 5:36 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Here's one more pull for EDAC with a driver that I let slip
> through the cracks.

Shortlog? Diffstat? Just what am I getting?

                Linus
