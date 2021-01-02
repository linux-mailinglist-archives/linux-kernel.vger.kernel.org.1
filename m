Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A122E8859
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbhABT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 14:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbhABT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 14:57:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DBC061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 11:56:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so54953253lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE+VAh0BTaBdR4cAH/pHpELHZjB0ILoKk6QrjLdeBTo=;
        b=hWgFCOcZcvb5hSCxT56O0m20hBRbZtMDA3QiLFzkAjGbnRnP5lrZYAR6+4/H5sUQUc
         t1PwylJ1YTO4rGnGh56Pb2fvxyB+ykr7oa5g9tFabW2wnFYngIVild8e+0FgJwqvRwIa
         Y5zHyqWeTY1W0XwqStOrf20Oir8tAS01IP434=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE+VAh0BTaBdR4cAH/pHpELHZjB0ILoKk6QrjLdeBTo=;
        b=hDxyZIuZblz5RzQve1YMqvnpz6lJKcObx7ItEhCYHucYD/QzdAqjZRfIiUaUqeh4XB
         1fUT5/I7hM3yhlTP7B5PoWiPWR0bPcdDx08L3hVborO8usHJK8yOdbpdx8A+wI1eBkO6
         co5mAeB51wQxAX2ZQ+GL688AcePuF4ghIrejMu18s9LH7pQU9do5rWGS6i3xP6XG62P1
         DhYh+TweVlUEHGy23/yMRYQdWM223IIbPeAsh0urOQJzAdsztxU7T0sQV6T/UAq1UNgO
         J5dASpYmVXdeCiz7YsImZZREf2rt4UiG0ZXYx6ZHk3gSyXPT6chG4tRnEzA63obNr9JW
         cF8A==
X-Gm-Message-State: AOAM530ajdi1YWYJqr/zcnxSWK7KfRSANlkaZlwxIli5gagY+PdaipxG
        eRhNkDH8KybylbZY9TLYjTIRYXoANYDhsg==
X-Google-Smtp-Source: ABdhPJxpNMmTMJK4lDhAa2RiEiFq8Wz7YJHYzoowh6pexQCQN60s7jATvdq/BO9zAEXrmawqpCJo3w==
X-Received: by 2002:ac2:4e8d:: with SMTP id o13mr28212010lfr.259.1609617383575;
        Sat, 02 Jan 2021 11:56:23 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s2sm6818082lfs.2.2021.01.02.11.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 11:56:22 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m25so54827906lfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 11:56:22 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr31301149ljm.507.1609617382520;
 Sat, 02 Jan 2021 11:56:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Jan 2021 11:56:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHbmzJO4NTsk=_pChcdXYP7bjNFmYhKR4Lh4-iKN-soA@mail.gmail.com>
Message-ID: <CAHk-=wjHbmzJO4NTsk=_pChcdXYP7bjNFmYhKR4Lh4-iKN-soA@mail.gmail.com>
Subject: Re: [GIT PULL][Resend] Power management updates for v5.11-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 2, 2021 at 1:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These fix a crash in intel_pstate during resume from suspend-to-RAM
> that may occur after recent changes and two resource leaks in error
> paths in the operating performance points (OPP) framework, add a new
> C-states table to intel_idle and update the cpuidle MAINTAINERS entry
> to cover the governors too.

Thanks.

Note that I might have been willing to pull your bigger request too,
because thie merge window was obviously somewhat truncated, and the
rc2 week has been very very quiet because of the whole xmas and new
year thing.

But I would _really_ have wanted the explanations up-front about why
new features came in after the merge window.

And admittedly I do prefer it this way,

               Linus
