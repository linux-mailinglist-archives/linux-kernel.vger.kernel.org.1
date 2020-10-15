Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03A28F7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgJORvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgJORvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:51:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD411C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:51:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v6so4539999lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zfqSGDv+yEOvufj9SkONQzGaf2/0wsWCEsO8GC9IHg=;
        b=czqTq+3XFohOXJ6g49AuRL3Dw7MRZTZUfMefn5c5GmP1G4+6XCMxrazGZjrHIJgGi4
         c6M3a+qtOQggFBrWzaTuEqyg4VmV08TTkMCpbN7VLF+lxumR+QWo2wE1NQic6kAs4uKQ
         3ppdo6NTG8V/+RDJ++tu3X1KkNFj1UZ31F1N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zfqSGDv+yEOvufj9SkONQzGaf2/0wsWCEsO8GC9IHg=;
        b=aEXPpo99RZczgaCzKC4wUhKbqv2tR45QpZRnLnSMp+sgUiC2fiRT60uGvKLUdsBXq1
         yaayeK+GU+d/1cjoeTfBFwj3AF1n0a916LFwsQJS63w0KDGsRd7QGheQNC800XPFOmLC
         qNUMgx+ivjUPTp597h6O7zeJxaRKHBaByfyIUynQ2qulT8Uj6Y2UUl+rRdoYdtl0zlzV
         NG+2yaXcSIZsk59JRTWLR+yGTxqKUdq4DQjWfsaia9Vxub9NUolVNuR1enlddlXw6wka
         sfc/el6YPr7oF7hSDVwd2E+vgpe3hnNBng9TwBz9zBE8xXdT7h3y84Vw/3/Zd9yRkdaY
         936Q==
X-Gm-Message-State: AOAM531vtS+FaGUR7ckhIh+0ryjN3hPAogHYF7M0ietzmdRIuPsqIin3
        YNC63ySEr13kqe3ybHN6Uk+/rTYtx1GBTg==
X-Google-Smtp-Source: ABdhPJwe+XN8eHvaXI5J8JEFkB5rQSvHFB4U+8AvqkEgAmv7r4nIT0pYi1n2JtFC0UTP8wkjdsB+og==
X-Received: by 2002:a19:8c52:: with SMTP id i18mr1438005lfj.115.1602784303944;
        Thu, 15 Oct 2020 10:51:43 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f25sm1531160ljk.57.2020.10.15.10.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 10:51:43 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id r127so4545266lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:51:42 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1599742lfa.603.1602784302538;
 Thu, 15 Oct 2020 10:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
In-Reply-To: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 10:51:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP+S4K3yU+FqgGmF+EgcSgk04Eerf3gE-6qObicy346w@mail.gmail.com>
Message-ID: <CAHk-=wiP+S4K3yU+FqgGmF+EgcSgk04Eerf3gE-6qObicy346w@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 6:33 PM Dave Airlie <airlied@gmail.com> wrote:
>

> There are a bunch of conflicts but none of them seemed overly scary,
> and sfr has provided resolutions for them all. I've put a tree up with
> my merge results, so you can tell me I did it wrong here:
> https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next-5.10-merged

Thanks, looks good to me, and I missed the same msm_iommu.c patch you
did, so kudos for pointing that one out too.

                Linus
