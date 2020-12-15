Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304D2DA5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgLOCDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLOCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:03:03 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB60C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:02:23 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so35291965lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6VR7BMk8sGNVAqJdWbIyj8uJ/cTJrWrPZLJ1YvbN/4=;
        b=f2A2ulXY38NAFQ+7xMPn25y/vehQjJbaaQEGIXwzDA/TJCPEyZaUBg3iH4bURFckTz
         h3XsyBZwNUum3P/3tdJR+BniB7ld8LyjqCMCOazbbI2wTIvp2B9Es393YZlv47LiSjwV
         LpEOzhYJZNpy/cX6nzyQyWXpBSHN+l26Jlazc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6VR7BMk8sGNVAqJdWbIyj8uJ/cTJrWrPZLJ1YvbN/4=;
        b=Dr1IeDhpJQ1eKDdnBNxcv99MNc9u+nCJ7rueGhicb0B08qQgThrp4U9yamje42HAF3
         M49Nrp9z81hIQo2CerYZ9f9+HQvf21XAB2w19jZiHnwn4W+YYNlYJW0/RE6kHcyrUoLI
         /3IyjsPJag/kmtcVAQGziMeqwWmMww72YXKRN1voC1yOS+zvfUVdHVRzzzmDu5U8AP+u
         XAbeKuK4UC0aBBVaUD/kM0pImzB39tqxuejmO6T0dqzh5q6feKwlypTXXRX5yPCtpj0G
         ++xdk4fmhuXqhc+HYqCNFRp8S0ng4Pa0e303bP9n7N0gPPG4q+CHdcokUwi1MZ9u8lU6
         wFQw==
X-Gm-Message-State: AOAM530aQ0e5ox1657KzEtiqIGFrtoHV8mHMFyY9QHay1XCEKiModZp8
        flI+RVPlAorsgNMvMxORIKNEgI4dUwqpUA==
X-Google-Smtp-Source: ABdhPJwqCMTV154AKj//Roc6h2qyg6rRM15hwBSI6QPWuRPr/lANgUSBPlxiRDF43bl8y1QKa/S3ag==
X-Received: by 2002:a19:5f59:: with SMTP id a25mr11554250lfj.310.1607997741353;
        Mon, 14 Dec 2020 18:02:21 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b3sm34605lff.190.2020.12.14.18.02.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 18:02:20 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o19so9678468lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:02:19 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr11842790ljc.411.1607997739622;
 Mon, 14 Dec 2020 18:02:19 -0800 (PST)
MIME-Version: 1.0
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733303.10793.16327860918275449762.tglx@nanos>
In-Reply-To: <160797733303.10793.16327860918275449762.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 18:02:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-Br8BKJ3rfdq54HVYv30wjQeV63-k_9Q-j2FfwyzTHg@mail.gmail.com>
Message-ID: <CAHk-=wh-Br8BKJ3rfdq54HVYv30wjQeV63-k_9Q-j2FfwyzTHg@mail.gmail.com>
Subject: Re: [GIT pull] irq/core for v5.11-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-14

What?

This is completely broken, and doesn't even build.

In particular, look at commit a07d244f00de ("genirq: Move
irq_set_lockdep_class() to core"). Look at the EXPORT_SYMBOL_GPL().

How did this happen? Usually the -tip pull requests don't have glaring
problems like this.

               Linus
