Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70542E1174
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLWBrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgLWBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:47:11 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 17:46:31 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id q66so2527692vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 17:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVeZOGMmzBjAt/jJlRYm3vvparurfThT4dE7jPf3pmU=;
        b=ZCyrsfGDjYLS75SI08k7N99qK+CiNNvTMr9CE4Re08jBzpyL4SnIAtau/7LzO0kcR9
         bgLzB5tA7RApW62yW3i+8kG/Cs6jeldSBLB+qxxS9HRH7APnYQka95MJxyJhDjSMS/l1
         kZzS6K+C4uNVXdjy6Ms/M/z8d5QDaJQrYN512qfmEebX+yOO1NM3+piR2US65Ypy+qsB
         nLQ6o68ZeuccLbCIZGiXbkrYbTX1UGXwFSOQxXskM63xA4yorTmvFaxMz7uYq2JAUOBP
         tlHSQKHKkYevih3wfeGurWzr8ZXIVJ0I9y4dA1u5K/8a+HNJ0oz7c3/Lxt7oMRZfnZSm
         0Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVeZOGMmzBjAt/jJlRYm3vvparurfThT4dE7jPf3pmU=;
        b=SKVF2kyZ0mfEX4YpQaVQeh16NI4pGWrCD9QKDYfruAUJwM/INkNmKWcYV+sAv5dIKe
         2qfEwy4+lslKSZH/1J9LxokDOUrXrGc6ykhjcOlKh57tfzrjt3lDrvI+glGH8cbB/vPM
         OqjV7jS7Vt+2j2WgiKD6udOQcktpYFJd5YI/jJ3CVEYyjy0KQyIataK1Low0c5SHaloX
         8k8B8s042mIa9NXq+7/nia9QPhsSANJLmvz1oO+EpnI+Gee/zMWQc40efAZyTDsWKW5a
         EZfPSNgPZO+UwjQvcOLmfG1lD+ag10I1ds3AakFUF38x4/68DVOt1YgTJB4yDFntMXYL
         a96w==
X-Gm-Message-State: AOAM5332muKD//WnvAnShs9ZEXV5yxXN3/9uUDFRErHLCyaXCrQmn4b9
        YT6Moipq+Vok37xwjkaZ6Rq6yiZWCYcjL8ev1ic2m9PMfw3oiftY
X-Google-Smtp-Source: ABdhPJwA4Iw+Xk0PVFZBvQBuxBSzzxqYgpwa+zyprm3TU/IdoYLmepuBLandtVtZawzRFlK30vna0tgk6feU+iCj9Vg=
X-Received: by 2002:ac5:ce9b:: with SMTP id 27mr18528181vke.9.1608687990059;
 Tue, 22 Dec 2020 17:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20201222121904.50845-1-qianjun.kernel@gmail.com> <eb9eaaa40c6643179d20a6067865c283@AcuMS.aculab.com>
In-Reply-To: <eb9eaaa40c6643179d20a6067865c283@AcuMS.aculab.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 23 Dec 2020 09:46:17 +0800
Message-ID: <CAKc596Jsmp_EoeC5tT+YcOutJR7O5Pqmsc=96C-EFDY5b5mePQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm:improve the performance during fork
To:     David Laight <David.Laight@aculab.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@aculab.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:42=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: qianjun
> > Sent: 22 December 2020 12:19
> >
> > In our project, Many business delays come from fork, so
> > we started looking for the reason why fork is time-consuming.
> > I used the ftrace with function_graph to trace the fork, found
> > that the vm_normal_page will be called tens of thousands and
> > the execution time of this vm_normal_page function is only a
> > few nanoseconds. And the vm_normal_page is not a inline function.
> > So I think if the function is inline style, it maybe reduce the
> > call time overhead.
>
> Beware of taking timings from ftrace function trace.
> The cost of the tracing is significant.
>
> You can get sensible numbers if you only trace very specific
> functions.
> Slightly annoyingly the output format changes if you enable
> the function exit trace - useful for the timestamp.
> ISTR it is possible to get the process id traced if you fiddle
> with enough options.
>
>         David
>

Thanks for your time

I have closed the ftrace when the test program is running. So the time
diff is without the
ftrace interference.And what does ISTR stand for :)  thanks.

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
