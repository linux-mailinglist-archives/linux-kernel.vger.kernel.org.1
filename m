Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988962A7744
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKEF5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKEF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:57:20 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903FC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 21:57:20 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id p7so620605ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 21:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlTE+5QXS18sXrL6D4KQC5d2Bo1EFlNxgmWgYZ7DFg0=;
        b=es3AODzU2iUwcMpdIoRei0G4xKF+9OIyQfwllwFlnnpZE/XGBckaMTNLqvyff3OMfh
         7fL5m4b7S5cqyUKDD2Sz636oDz0+VI4byMjn+0Juv9bMu4gAGckOrRbgjEEti1efFylk
         dM6xxdr7/56jwpUQjHYKF8577HHYmC9h5DaNkOdYgnUXso32u9Zyd/bDyzT4FIXZYSpR
         MyoSgTWB2GokYpPKlN6T73/VFFo/o4HXWCd61mxB3RafmWXJo40GECeT0ySAtWFxpR70
         PHoPq0QLbtHPOzkRAbufWD6odojj6Q9NWQAjeqILM2TRX8LZPXYPeAs7F9B8QGbV6DUq
         1Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlTE+5QXS18sXrL6D4KQC5d2Bo1EFlNxgmWgYZ7DFg0=;
        b=bT2zvXBAW96TTopJUcgS7VvE7PwCUBFPZUQLA/RIEPWUVUgUqOnGUFE7ghOaKu2+XG
         9nTgyIlh5RNa1iTG5BBvUz34elmwVJ9QzUvJ3BdLgn23J1fcMnKYKwQm4SJkeLR1+ZSi
         X+xP3pq9TUxr/XNLNxWLAVhROr1gGwvikYm8vN40AJRrYlB7c/5niiPEXuc2orI2DiiO
         ty97Jlvjw7r4G5URBhiDBdmvFF9MFFXSbhSufpl2VIeiqTlcWxUmesXtc+ukJJYfT3JT
         spRh2KfH7pq7xBPsrav6KUsZp6ATZlUOv/4GYg8QhWXy4zERPOaSMVlRVhutmd7VbLnq
         UbDQ==
X-Gm-Message-State: AOAM531GAWLe/IqN+uWCNrIu+fPWMVZsAsfYge4RxC/MX9j5ZRftHxvX
        7pOFJTMQn0AWTzwmn9SrRbXGPRHQYH2/H+q+4cCDTQ==
X-Google-Smtp-Source: ABdhPJxmVYMswfSGq3abwHWr8OWtR+XmTNccSp+mhngdMAcZJpwmHM1rpLcO04y2HGg5FimcvElwEHdVqk+r1UwxiTg=
X-Received: by 2002:a02:c952:: with SMTP id u18mr817380jao.139.1604555839634;
 Wed, 04 Nov 2020 21:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20201030172731.1.I7782b0cedb705384a634cfd8898eb7523562da99@changeid>
 <20201031130546.d2b94345008e807f548dc068@linux-foundation.org>
In-Reply-To: <20201031130546.d2b94345008e807f548dc068@linux-foundation.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Thu, 5 Nov 2020 16:57:08 +1100
Message-ID: <CAATStaNeQAQgzwCwENJwSEQ40x0aTaBvSnoi860MVSL9wBw8fQ@mail.gmail.com>
Subject: Re: [PATCH] proc: Provide details on indirect branch speculation
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Joel Fernandes <joelaf@google.com>, tglx@linutronix.de,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>, NeilBrown <neilb@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 at 07:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 30 Oct 2020 17:27:54 +1100 Anand K Mistry <amistry@google.com> wrote:
>
> > Similar to speculation store bypass, show information about the indirect
> > branch speculation mode of a task in /proc/$pid/status.
>
> Why is this considered useful?

For testing/benchmarking, I needed to see whether IB (Indirect Branch)
speculation (see Spectre-v2) is enabled on a task, to see whether an
IBPB instruction should be executed on an address space switch.
Unfortunately, this information isn't available anywhere else and
currently the only way to get it is to hack the kernel to expose it
(like this change). It also helped expose a bug with conditional IB
speculation on certain CPUs.

Another place this could be useful is to audit the system when using
sanboxing. With this change, I can confirm that seccomp-enabled
process have IB speculation force disabled as expected when the kernel
command line parameter `spectre_v2_user=seccomp`.

Since there's already a 'Speculation_Store_Bypass' field, I used that
as precedence for adding this one.

-- 
Anand K. Mistry
Software Engineer
Google Australia
