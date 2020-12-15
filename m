Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE252DA4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgLOAau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLOAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:30:39 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC6C061285
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:29:58 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a12so34896142lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJATZ3Pzn+WgYD4wqGRYoTGeRzf7YeEQUD9oIjU0xJo=;
        b=UsJRHPLQSYv6TvQgpfXKlT4x/2lBeAD8k1Sn+/mMLLkWhoYYufqYwEZVVGKxxmsL3T
         Bt/z5I56ZufFBd8dNGUadpiYF07XTkBlahLWSXiUHRLKa92c06xGTg8WPJJ5BPyUji/w
         590BthW1n603Mr7C/h7/QLLnYsbcwZ2GxMLQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJATZ3Pzn+WgYD4wqGRYoTGeRzf7YeEQUD9oIjU0xJo=;
        b=CZbTV3YxYyJxiltY4Z2YunOM8+l4vUFtxPa7iWeVhtW4PZ5wJubSxOdGIxv4kwb2P9
         y+HfERPFFcGatoV0jiaq3aIt2hN3nIAH3h+lMNkPHTcMs+QprJ+5AfofhahsClJGPmRv
         Cp0p1moNQxZBbam2YMk2FFWX+/cCpLt0aPfk08sTAHUGUDzxDsDBFhF5qCUQCCfdE2WE
         /ArR3/7Xj9rxnKNAhGq6d269jAzB2My90fiffJl4SYxjO/cQf1HEPqZWPKWUywHzEAPU
         BDXNe3Qhs/DtEbNsXVVV+nH3fXJIElDzL01yCp9FzKtzDJM0315sTq85VyY43a26yIK+
         4lDg==
X-Gm-Message-State: AOAM531PXXWIRS3M9PkM4ykDSy26L+u5kNxH2ru0CEVPt6Xv0MLWy2q9
        oKyPQL/TQpERWk3JNhoQxhn0xQGoxaN+IQ==
X-Google-Smtp-Source: ABdhPJyAqPkkw4CDaF2hWPqTSHFo+GX3S8qtqEfhtMHycRpp7bpz047dslw4lxjBLheETDkWWx9UmQ==
X-Received: by 2002:a19:4856:: with SMTP id v83mr7988299lfa.583.1607992195052;
        Mon, 14 Dec 2020 16:29:55 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n84sm12680lfd.176.2020.12.14.16.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 16:29:53 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m25so34847260lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:29:53 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr9874537lfi.377.1607992193016;
 Mon, 14 Dec 2020 16:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20201214182854.14862-1-catalin.marinas@arm.com>
In-Reply-To: <20201214182854.14862-1-catalin.marinas@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 16:29:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2WOYHcrZ+8gnwa6PR14LxDe3PMfqsPYyyoRTysyheUQ@mail.gmail.com>
Message-ID: <CAHk-=wi2WOYHcrZ+8gnwa6PR14LxDe3PMfqsPYyyoRTysyheUQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 5.11
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:29 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
>  114 files changed, 2392 insertions(+), 1401 deletions(-)

My diffstat looked quite different, but that turns out to be because
you use "-C" to generate your patches with not just renames, but file
copies as well.

That's all fine, but can I ask you to also use "--summary" for your
diffstat, so that the end oif the diffstat also ends up explaining
that part (and you end up with a line that says

 copy arch/arm64/include/asm/{alternative.h => alternative-macros.h} (69%)

because as it was, it took me a while to realize why your diffstat
numbers didn't match mine at all.

            Linus
