Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25332CAAF4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgLASmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgLASmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:42:37 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7037C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:41:51 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id q137so2663095iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifLMTCdzkypMnKPu3DENVsgsRmsClQAlvMw8Ok6iiAU=;
        b=qRokkZ5KuP39HZaO5JOt7KGeoqhmN85W00thoyigFbmg3j/o9ov2WHLCHd1WLQmWqo
         KKeaiO7UIqiUwDvuO5HXNiS3cvETsMZfMXqX4Haua2TkE4d4lU0Kg2ZgCH0fs3I6KRE/
         pL82YpuI/jwbxyF4rNjfGj6t2RCRsczDhCy5iS8/gc4/3eXjSvK8qboCduiazpZtl6CF
         aO1XTnuCm/80gy61ryXKi2834ZvkbWUHeM3vBy9AvOZAyNzu4ZaIvqTSJiz/SCSaQgsD
         99NloyqvvbrqdijkryKLwzI2VSJ9Vy2i0RQu/sJAC1yZ2ju0B7rrc6FLIkHsQplas3L+
         VsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifLMTCdzkypMnKPu3DENVsgsRmsClQAlvMw8Ok6iiAU=;
        b=l+ANyEGGrB4i3/D78h1EY9+9bKTL4F1+ngkmlFJz2xWheqOMqBEO/caU/7BJIx+ciu
         FB86LEVJGjhpKAhYda+prtXGg41749ODHfVR58//DkpevChGIvgNZSfJfW4ggAW9g7m+
         hmmI3cmzdLxmcU8YJK7OIxtNokS1dssfUfGKCALjaX92qtMYkEpklund0620TaHNwpTH
         +2MYSewMKaAgUl3FK0eymOqefuZXVaA2NnkMnAZYWQ4UJFXIzEDhI9iw//kqRzUGoJvX
         QTDp/6lLGIMxpSiKbU+8whbFNHRjjjMg33ovJS7uLd2n44UV317ZrK3ye+8F0/5DHVg4
         ndZQ==
X-Gm-Message-State: AOAM5303E69P99jr+Mp2/l6Ru6lh9o1s3iUSVK0+kQ7irwjjhcGeKPEd
        ZqHinJM2vE1uyD1PVcvTJsn4wOiNxd6IsASHsL0fqsiPFm8=
X-Google-Smtp-Source: ABdhPJyec76CXBVIfKYeX0dCaUek6qDX//GwRZuF5v3JWnkcINH2r7jRKEgj5uXOlI33emBdMLGV6QMf6Gl65aLke3M=
X-Received: by 2002:a05:6638:22bc:: with SMTP id z28mr3866376jas.62.1606848110912;
 Tue, 01 Dec 2020 10:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-4-dlatypov@google.com>
 <CABVgOSnMAGcMH-Y0o_KhMbyNYb1y4Wx6SFZO2d3=XUjefvmuSg@mail.gmail.com>
In-Reply-To: <CABVgOSnMAGcMH-Y0o_KhMbyNYb1y4Wx6SFZO2d3=XUjefvmuSg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Dec 2020 10:41:39 -0800
Message-ID: <CAGS_qxr3PYi16tpQg8WcQBeDpD_j2ZwB91snjKOm6C=_ptTF=A@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: tool: use `with open()` in unit test
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:33 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The use of manual open() and .close() calls seems to be an attempt to
> > keep the contents in scope.
> > But Python doesn't restrict variables like that, so we can introduce new
> > variables inside of a `with` and use them outside.
> >
> > Do so to make the code more Pythonic.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> I'm fine with this, and it clearly works fine for me. Out of
> curiosity, though, is there any difference here other than it being
> more usual Python style?

Files aren't leaked if we error out due to some exception before we
call close().
And self.assertEqual() and friends raise exceptions on failure, so
we're toeing that line here.

But other than being more robust, it should be equivalent.

>
> We've struggled a bit in the past toeing a line between trying to
> follow "normal" Python style versus adapting it a bit to be more
> "kernel-y". Experience thus far has actually been that going out on
> our own has caused more problems than it solves, so I'm all for this
> change, but I do admit that my brain does understand the older code a
> touch more easily.

Ack. Python's lack of lexical scopes is a bit disconcerting.
But from a readability standpoint, it's a bit more self-evident than
having to write it would be, imo.
So I think following more standard Python style here outweighs the cost.

>
> In any case,
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> -- David
