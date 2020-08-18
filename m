Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF482480B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:34:42 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC43C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:34:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so16134205oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaNLfRHzjmAhC1MdbIpHRe1zX0H+Foac1RDS2VP3MjY=;
        b=V8m3BO+xQsaDn6apX6pTobxkTbSUhaMeuMiydfuHreAWCgHIaA991/fUS80QjjH6tr
         9Lfd3ND0qs72vIyYPvdS6NX4eSyCjqJVLGkwnfxit5pv0DWj0rzvb75ZfUBuogBAKUEI
         ZCM+qe2Qpg8RDHCsOOwIW77ytRIC3Oh97zJ80dKa7gO0DSp4imvOur356ErhatfrY7ow
         4xJg4OQdWztwPcPMt/d45VF32M4g4plqkKxpWjzFAjts+apj2yvLW4Nw6pF6l2X1i6Lv
         rBCIYWRNFhsVsun8E2QDtNBeFTf+/IwwbOb7SNoenOgPJJA9D6tXe9vH8SJJJ81AAEuf
         LbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaNLfRHzjmAhC1MdbIpHRe1zX0H+Foac1RDS2VP3MjY=;
        b=VP4HhgUk5miSNo6FaAinq6vncnxAHtql40+qJs1uSjONELFSqYj5QDYt6pwj/Twoi5
         7SyU20oBfNeVA1xEhg8z2JoI+DqtS0vDRqOHrZBG1gYXs4JOrQ25t3CAWLr6rw2DdP2c
         rm0wf+sgJcfbAZCpoqD9DTKWxitb2RDO5MpA3/iiPhMu8s20+ExKpPc4zijh6s2O+1Kz
         ZakkUMK7PUjkGnBDqRee7Kxc8HOY175WJuXancOEZrqseUSuPRD7Piuoi9mydCwcz84I
         sseeWYDnZZY/cTdRJcAMpB7Rnlg5f0p25GmSpIS8LjNGpcIFh9htsWyFJMdM+ED3Flv6
         AC7g==
X-Gm-Message-State: AOAM533bx8JOmNNZ9gQbYrZlwwwVQSkaGYnEZND3NriFgwcvwranE2qO
        J2qVO8VXwIKhNTyUrKhwJerHpCJqTiZE3bKIOZf60Q==
X-Google-Smtp-Source: ABdhPJyUI34+cEe7L+qs4oF73ktcijLK54TBk3MsXc7f1Mxc3Kxj21GJmXN46BOFLKz3XUly164YYJYQGgakd45oPhc=
X-Received: by 2002:aca:5145:: with SMTP id f66mr12152867oib.172.1597739680577;
 Tue, 18 Aug 2020 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200813163859.1542009-1-elver@google.com>
In-Reply-To: <20200813163859.1542009-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Aug 2020 10:34:28 +0200
Message-ID: <CANpmjNOvS2FbvAk+j8N0uSuUJgbi=L2_zfK_koOKvJCuys7r7Q@mail.gmail.com>
Subject: Re: [PATCH] bitops, kcsan: Partially revert instrumentation for
 non-atomic bitops
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 at 18:39, Marco Elver <elver@google.com> wrote:
> Previous to the change to distinguish read-write accesses, when
> CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
> the non-atomic bitops as atomic. We want to partially revert to this
> behaviour, but with one important distinction: report racing
> modifications, since lost bits due to non-atomicity are certainly
> possible.
>
> Given the operations here only modify a single bit, assuming
> non-atomicity of the writer is sufficient may be reasonable for certain
> usage (and follows the permissible nature of the "assume plain writes
> atomic" rule). In other words:
>
>         1. We want non-atomic read-modify-write races to be reported;
>            this is accomplished by kcsan_check_read(), where any
>            concurrent write (atomic or not) will generate a report.
>
>         2. We do not want to report races with marked readers, but -do-
>            want to report races with unmarked readers; this is
>            accomplished by the instrument_write() ("assume atomic
>            write" with Kconfig option set).
>
> With the above rules, when KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected,
> it is hoped that KCSAN's reporting behaviour is better aligned with
> current expected permissible usage for non-atomic bitops.
>
> Note that, a side-effect of not telling KCSAN that the accesses are
> read-writes, is that this information is not displayed in the access
> summary in the report. It is, however, visible in inline-expanded stack
> traces. For now, it does not make sense to introduce yet another special
> case to KCSAN's runtime, only to cater to the case here.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> ---
> As discussed, partially reverting behaviour for non-atomic bitops when
> KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected.
>
> I'd like to avoid more special cases in KCSAN's runtime to cater to
> cases like this, not only because it adds more complexity, but it
> invites more special cases to be added. If there are other such
> primitives, we likely have to do it on a case-by-case basis as well, and
> justify carefully for each such case. But currently, as far as I can
> tell, the bitops are truly special, simply because we do know each op
> just touches a single bit.
> ---
>  .../bitops/instrumented-non-atomic.h          | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)

Paul, if it looks good to you, feel free to pick it up.

Thanks,
-- Marco
