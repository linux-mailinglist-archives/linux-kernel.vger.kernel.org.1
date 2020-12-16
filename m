Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0F2DB7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgLPASy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLPASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:18:50 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C4C061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:18:10 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so43992601lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSxsSZiOCbgtfRHvrrIs2XX2MVFXaSUOKKGOgV0Mcrk=;
        b=TFKlJ8Q4glsD4AXv5lM6i64JQSQQPxQxGpCL70H0GW/XQAWPmkhmcOURnWERPAqish
         sxMunE0mxSSFvqSEkt03mIL06y9I3pUtR7PXy7YeIb0qfCODPdczUlJdYuHfB//sEJ97
         U2AsSzqIO9Raypy2Wl8Iue3unVB0rltOBVyEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSxsSZiOCbgtfRHvrrIs2XX2MVFXaSUOKKGOgV0Mcrk=;
        b=YV36Ed+bd8NvRR6vmdGsTD9pWlKrXankg9wtLs9FHTDWmwO5jHLjLyknIsgoZz7RFD
         3v5JDcfa9Bs7hEHxkNLMxR0rBXt3sLlsu+gMGPkRV6M+xI8MfH3q8fs96uXofbKxbbet
         Z82Gh/ZKDjRaHbVrzkxcWIgiDVGPKbZiRDn4OE0KBBKwTybCXOd3D4Kr/r4ZXyLVxFeX
         Z3fcA9E0dm5EO9bIWkLtRliedLtqWvsZf/bxa4VtE9UPkquHCh/oDkzv5aXkCDTUbtCc
         THQCQuigVy3zKzd3saJqHRZOur1zAa3FE81GIsE4XzdA10kzsaR+Cx768Si+himw0KdF
         Rp1A==
X-Gm-Message-State: AOAM533a8p2mygK9h/aLtRkLddUWvvfQNJTe5wq7UeOX0czHzNFBsNuK
        RRq1I0lChSLX0i9gXiz8mOoLGv2lnKh+mQ==
X-Google-Smtp-Source: ABdhPJzAVMy1ooAY6EkxkLrq/A8hVDfQkuCAUp7Xg8Bxu6CR9I6Jey6xY3n/N9VyR5gMOlDUHsGohg==
X-Received: by 2002:a19:6415:: with SMTP id y21mr5379562lfb.120.1608077888149;
        Tue, 15 Dec 2020 16:18:08 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v23sm52363ljd.78.2020.12.15.16.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 16:18:07 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id u18so43978805lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:18:06 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr12994128lji.251.1608077886478;
 Tue, 15 Dec 2020 16:18:06 -0800 (PST)
MIME-Version: 1.0
References: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
In-Reply-To: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 16:17:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMs5Q9VwEP_gfGmUR3R+_xDRA5pprbgznaFuq48pY+wQ@mail.gmail.com>
Message-ID: <CAHk-=wiMs5Q9VwEP_gfGmUR3R+_xDRA5pprbgznaFuq48pY+wQ@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.11-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 4:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> - New Intel PMT telemetry and crashlog drivers

These have _very_ annoying Kconfig setups.

First it asks about INTEL_PMT support.

If you say no, it then asks about INTEL_PMT_CLASS, INTEL_PMT_TELEMETRY
and INTEL_PMT_CRASHLOG support.

I've pulled this, but I really wish the PMT support understood that
whole "No means no" thing.

Please?

              Linus
