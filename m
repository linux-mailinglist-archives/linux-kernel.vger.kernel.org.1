Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85712E85A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhAAVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbhAAVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:12:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61841C0613C1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 13:12:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o13so50658208lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQza3UddYXR6eO4r94ZTkx+KQP8jv7dR2DD0yefFXLQ=;
        b=FVApS46Ywo/T+y6oD79x3UdQ65VYtCz6bTRsGKsfB807UgbgL+RxmIAZzL/+VyI11/
         RTw/V0Efer+t7CsO1JfIoyarxhtEGoeJ8ziNMOHPut1/aPFGqPVmWWFZP738KO49A0wX
         IEMGgLZujcKDF3oW6S9KVi87tk1rBR0gSXUvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQza3UddYXR6eO4r94ZTkx+KQP8jv7dR2DD0yefFXLQ=;
        b=CYn6vtK3o/LkeCmUZ/Q7pgMnRzAvnhS1hB9fEr8Z0ioDn7BRWmCDe3tBoLxvesHky6
         yDvs3ig43BTGpiztcoZ7DE/vBL0elRebYDTVOdhbMPE+02UCeRkmKdMyyqQ+Lkm7pDpr
         CnDUcJDRjFauxhLdmBWl3effbFnfz0VBAwunmo0XxlQaPCx7X1gi23seUbeQYMUJMqop
         NY2+Cuz1E608nT9eNNebwyes8Mn+EQLVDMw3DUeF8hv97tnzPwONcwHQKDI85OJjKIat
         HBw54gG/giAfkm06lJCAramvLwypBh4YyvBdII3WBBkefzT75akPh1y0y1MOgEFfzByg
         mjiQ==
X-Gm-Message-State: AOAM530ufPeC+zZuBAJgNuFaHxO23ugqzr2VYqScQIhJ/bsoCX80t53O
        ltkuf72ut7KgZsrXMTmrGuBWEWtyCPidQQ==
X-Google-Smtp-Source: ABdhPJz9jOPpwSvLM5Mbuefx2ocT2jzeQarHQOL4wKO3Wf7VYamUZ5rGkOpZjdGLOb/44es2P1uYnQ==
X-Received: by 2002:a19:c8cc:: with SMTP id y195mr26299665lff.352.1609535523466;
        Fri, 01 Jan 2021 13:12:03 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n6sm6563537lfi.112.2021.01.01.13.12.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 13:12:02 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id s26so50560635lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 13:12:01 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr25990869lfl.41.1609535521403;
 Fri, 01 Jan 2021 13:12:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Jan 2021 13:11:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
Message-ID: <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v5.11-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 1, 2021 at 8:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Add new power capping facility called DTPM (Dynamic Thermal Power
>    Management), based on the existing power capping framework, to
>    allow aggregate power constraints to be applied to sets of devices
>    in a distributed manner, along with a CPU backend driver based on
>    the Energy Model (Daniel Lezcano).

This seems very much a non-fix thing.

Please explain why I should accept this outside the merge window.

                 Linus
