Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664A301E73
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAXTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbhAXTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:32:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB87C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:32:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i187so4441175lfd.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTvet0cA5VlERgtC2SKba0nr4XReZGr85iq9+W5yFLQ=;
        b=N9MjFFBprfupE/NTW030MsWjnVBdqRh3ew1F4CWJ3Bv3kfLVGKYuD7qDAb90L4SVg6
         HvAGBWFkg3JGqyA4AuQSo/lSrQbT1yZxZMxA3mvIYD34hRbrDwYD/AppYoJyXEF/EELF
         ueF5M03HECaE2WMl8cu8fWYgfG3MvVIePJdAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTvet0cA5VlERgtC2SKba0nr4XReZGr85iq9+W5yFLQ=;
        b=K7cJiJLgsssJ/ULDYOBFHBcHMVHI1127NAOqAfH6OqMQ8EbhQN8zpAFh6FBPRg3NZA
         Rfd74J2hw31lthyjQj3tUhGEF7Z21K/yuO2O9UAkcHZjyp9JSqPBuujFuUamcuIAW1U1
         OdMevE+WC/G6Hgl+6IAxyRyuZilJKDtVrPw7St+ozKlVNsfCrTxBHcyWfLrOGzro61yA
         quwGhLABMxQmmPaGzqVoJ54Ulb5vni9f/EeE+lmNrsfYr1fdE9uC2TH71eDJmfAWLkzd
         EFWnQ6OJHCtljkdDt6U5AU+/Rj39YNYRzElA014PbZO7BxQw+77/ydrdURESiPSkp6l/
         NUkg==
X-Gm-Message-State: AOAM533jl5RfXNWXmpCzJzNYYAMH1XIrTWu8SGo5NDkoqRVOIoirq8Mt
        zFoqqChvM9VNrTLH206j9zh6LbuWGlzdPQ==
X-Google-Smtp-Source: ABdhPJyAg/iY4tbeB57HtuzWmeP6kkCizkcY4lpmejdAMv8/ZFCDJKo08SrEEFh3oYybsJqTwtNeCA==
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr358327lfu.577.1611516737084;
        Sun, 24 Jan 2021 11:32:17 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k11sm1546208lfm.181.2021.01.24.11.32.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:32:16 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f11so12684824ljm.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:32:16 -0800 (PST)
X-Received: by 2002:a2e:a545:: with SMTP id e5mr87321ljn.48.1611516735834;
 Sun, 24 Jan 2021 11:32:15 -0800 (PST)
MIME-Version: 1.0
References: <YA1u24kUPB+B7gKY@kroah.com>
In-Reply-To: <YA1u24kUPB+B7gKY@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jan 2021 11:31:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe0kHRKsNegF+JxCooS_Z0otcEX_Ggz=iN2v3D1Rssxg@mail.gmail.com>
Message-ID: <CAHk-=whe0kHRKsNegF+JxCooS_Z0otcEX_Ggz=iN2v3D1Rssxg@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.11-rc5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 4:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> David Lechner (1):
>       counter:ti-eqep: remove floor

I'm not sure why that ti-eqep counter driver seems to be in your
"iio/staging" pile rather than "char/misc", but whatever..

               Linus
