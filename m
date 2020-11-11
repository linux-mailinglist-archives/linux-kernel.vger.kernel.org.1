Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3D2AEF04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKKKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:54:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483B8C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:54:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so2107321wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKBslUBP9kktfn9VgRKwOuMNKsTV+oRwCNwB2lP7zyA=;
        b=PErN+jDW4s2Azl+Hojay/VTn6bhzc8/mzD1lC04I9B1IlBS5/JTqi2xFrShDIaLIyk
         Okpy9OhzahT4VnOd+RJWu0Lpo5qjW4Cz9eGsUhJFqUbTugUqblx+25IL8KUmmWS7OCTe
         MVHNFT6UDob1ZqMLEuytQwJ2Xr9fipGuoy+t/MUbUsWG7w0XMNdTm7yHugX+X71/FOZ4
         OGv8duL9raG7DH8MwGzeSY7UYShcmkuwIT8gVpWqXO4jBrMnlLdCYcNiY+WXX9be5jsq
         RJ1KlAieni5SdipVYp3SjBiaQGFsLfml1ZluK9DwsqVuQlrW8KfBbo5Ek9+d3BQqfYMI
         PXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NKBslUBP9kktfn9VgRKwOuMNKsTV+oRwCNwB2lP7zyA=;
        b=kOuCOCYdMFyAsQbxjEg1oaC+u0q8IDv47G0R+2jfEwNfEAz+1WA7OtfCy9CwCtZ6m6
         5aeDWpaqiOLxP8sG8HTF5mGlcZOjhW9cYW+puFJ8Xk9wZCLCTqkaFnTX7Q/WlAVkXPyI
         GpH3fTg9/YUgNNnI/pUeTUwoQDDSOw1vXqoZORSqQC1UDF4SpArCwjQC45pCEnbse6ff
         kXhGvb+EkrsmlyIyyObTiTEiMqCxqvRmkUciYeAceKiQMwEgE/CgihN3Jh6yJq1FaJUh
         opk3rySftJvfmF+JtbQ1ZtitK+kpip0XmqTY27pVyR+XgauWzDtzZr27VAiJ6rPgTKdn
         xZyg==
X-Gm-Message-State: AOAM532+1854sGSYmnLLJfyIWVxNagnG98px0fhqSdo4zjmcnxvdg9Km
        t8Ok7wQb4in2GUp3Geh0uK8=
X-Google-Smtp-Source: ABdhPJwZtvIs/hBp/w+nqDmqttbkbteefjcyLpZ+SeMUXoLsIIeR/PJlOHTmMJHkVGjful04q0H09g==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr24535093wrw.67.1605092085018;
        Wed, 11 Nov 2020 02:54:45 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g20sm2088560wmh.20.2020.11.11.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:54:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Nov 2020 11:54:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201111105441.GA78848@gmail.com>
References: <20201111050559.GA24438@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111050559.GA24438@X58A-UD3R>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Byungchul Park <byungchul.park@lge.com> wrote:

> PROBLEM 1) First of all, Lockdep gets disabled on the first detection.

Lockdep disabling itself after the first warning was an intentional 
and deliberate design decision. (See more details below.)

>    What if there are more than two problems?

So the usual way this happens is that the first reported bug gets 
discovered & fixed, then the second gets discovered & fixed.

> We cannot get reported other than the first one.

Correct. Experience has shown that the overwhelming majority of 
lockdep reports are single-cause and single-report.

This is an optimal approach, because after a decade of exorcising 
locking bugs from the kernel, lockdep is currently, most of the time, 
in 'steady-state', with there being no reports for the overwhelming 
majority of testcases, so the statistical probability of there being 
just one new report is by far the highest.

If on the other hand there's some bug in lockdep itself that causes 
excessive false positives, it's better to limit the number of reports 
to one per bootup, so that it's not seen as a nuisance debugging 
facility.

Or if lockdep gets extended that causes multiple previously unreported 
(but very much real) bugs to be reported, it's *still* better to 
handle them one by one: because lockdep doesn't know whether it's real 
or a nuisance, and also because of the "race to log" reasoning below.

>    So the one who has introduced the first one should fix it as soon 
>    as possible so that the other problems can be reported and fixed. 
>    It will get even worse if it's a false positive because it's 
>    worth nothing but only preventing reporting real ones.

Since kernel development is highly distributed, and 90%+ of new 
commits get created in dozens of bigger and hundreds of smaller 
maintainer topic trees, the chance of getting two independent locking 
bugs in the same tree without the first bug being found & fixed is 
actually pretty low.

linux-next offers several weeks/months advance integration testing to 
see whether the combination of maintainer trees causes 
problems/warnings.

And if multiple locking bugs on top of each other happen regularly in 
a particular maintainer tree, it's probably not lockdep's fault. ;-)

>    That's why kernel developers are so sensitive to Lockdep's false
>    positive reporting - I would, too. But precisely speaking, it's a
>    problem of how Lockdep was designed and implemented, not false
>    positive itself. Annoying false positives - as WARN()'s messages are
>    annoying - should be fixed but we don't have to be as sensitive as we
>    are now if the tool keeps normally working even after reporting.

I disagree, and even for WARN()s we are seeing a steady movement 
towards WARN_ON_ONCE(): exactly because developers are usually 
interested in the first warning primarily.

Followup warnings are even marked 'tainted' by the kernel - if a bug 
happened we cannot trust the state of the kernel anymore, even if it 
seems otherwise functional. This is doubly true for lockdep, where 
locking state is complex because the kernel with its thousands of lock 
types and millions of lock instances is fundamentally & inescapably 
complex.

The 'first warning' is by far the most valuable one - and this is what 
lockdep's "turn off after the first warning" policy implements.

But for lockdep there's another concern: we do occasionally report 
bugs in locking facilities themselves. In that case it's imperative 
for all lockdep activity to cease & desist, so that we are able to get 
a log entry out before the kernel goes down potentially.

I.e. there's a "race to log the bug as quickly as possible", which is 
the other reason we shut down lockdep immediately. But once shut down, 
all the lockdep data structures are hopelessly out of sync and it 
cannot be restarted reasonably.

I.e. these are two independent reasons to shut down lockdep after the 
first problem found.

>    But it's very hard to achieve it with Lockdep because of the complex
>    design. Maybe re-designing and re-implementing almost whole code
>    would be required.

Making the code simpler is always welcome, but I disagree with 
enabling multiple warnings, for the technical reasons outlined above.

> PROBLEM 2) Lockdep forces us to emulate lock acquisition for non-lock.

>    I have the patch set. Let me share it with you in a few days.

Not sure I understand the "problem 2)" outlined here, but I'm looking 
forward to your patchset!

Thanks,

	Ingo
