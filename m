Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904282E2F54
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgLZXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 18:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLZXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:04:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE555C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 15:03:24 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w79so6262417qkb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nsrdnHl2ymHw5nAkWFU1ly2vt+T4UebmmNGblcnfiUk=;
        b=sJBkcansVXOc3fiTsWxr/o0nqzuZxwq2gJsQHc4iNoGMt0aFfjPU5CqQJEiFi2fwv6
         Cxu/i3IkqAFq7DLPFd6xQ1rYnXKlftOc8nPuii5shk3M8n2CZskHIGp+6XXmEbv7RGpF
         PC4mlNakMAPn3+X1bKdjEjS4EV+8iyMTpT5CU8Pge+QCIsaUMQTBPUK9Y848QWZMxYYu
         MyQyl1cmR/aaVr6XvZf8kuplY2L+cD76Nndu/QdfTvonzk60WixgI9ZZ+W2ggTNkrd9A
         uw5k+GZhT6mhzM1dpWMmUp8aFKUnUciAxsBRuuANm8B2nv05zPosBNGIOMlFLg7jRKg/
         KvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nsrdnHl2ymHw5nAkWFU1ly2vt+T4UebmmNGblcnfiUk=;
        b=ILH+FQQMNQFlvVsTRbZobgKswvx+EY4SgHjX2tLCohK6IcAUpNBHQiKefOXdjS4/8/
         2MCNqwFii2EyxCq5FtHmKUg6Vb9bx7WRd9fTAy1wv2VrjsU2OMS0iGDFETBi8XfNpq1h
         AMQJpRndTjXz/i0m7LWl6iJtqaNGSxQEjUb6TWEVzyQxbV3twgQ0aCR27SCBXX0r2Anp
         HfHEavvl3JsBkeqJSvGqCMxQSF5EThRwjW8Nt8P/tmxWaDpQtL4qn+gRUhVsgU6VmwQn
         odNbeBYj8tXdznuVewPAzeJJ3Gdh/WN2jDqzJ3qT9SvpxzRNy5jxPY4/vX15zfj3O6IQ
         WT6w==
X-Gm-Message-State: AOAM531jOiDL//6mqjwI1R+Hw5s2HPW7Ly30LvIh8Qxd/pepLfoDXvn5
        C8zVqd7Iiwvk1/ZQBctc6l+/zrKxFcxef8M3VNThdArk0Gc=
X-Google-Smtp-Source: ABdhPJxJdstm0wYwwN9lYITrGutBpxl1rUto099ufu7khCjg0c1Krku0k3hUqiy9Msv5f52YxAh22qOlnN3QTnmCOgM=
X-Received: by 2002:a05:620a:557:: with SMTP id o23mr38869464qko.52.1609023804054;
 Sat, 26 Dec 2020 15:03:24 -0800 (PST)
MIME-Version: 1.0
References: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
In-Reply-To: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 27 Dec 2020 00:03:13 +0100
Message-ID: <CAFLxGvxVfLhfqxt8C1j_1V_oOpda_CE_s2QaHcv4hcZ2Euy_UA@mail.gmail.com>
Subject: Re: linux.git is broken on a case-insensitive filesystem
To:     Theodore Dubois <tblodt@icloud.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Sat, Dec 26, 2020 at 11:41 PM Theodore Dubois <tblodt@icloud.com> wrote:
>
> I'm currently hacking on Linux trying to run a sort of UML-style thing on=
 macOS (please don't question my sanity :), and I've run into various issue=
s stemming from macOS having a case-insensitive filesystem.

Sounds interesting, if you have questions on UML internals, just ask.

> The one you run into immediately is: there are a number of files (mostly =
in netfilter) that have different uppercase and lowercase versions. net/net=
filter/xt_DSCP.c and net/netfilter/xt_dscp.c are quite different. Last I ch=
ecked, git would pseudo-randomly pick one of these to check out, and then s=
how the other one as having unstaged changes making it look like the first =
one. This causes problems when switching branches. I've worked around this =
with a sparse checkout that excludes these files, but it's not great.
>
> The gitignore also contains the pattern *.s, which excludes *.S as well w=
hen git is ignoring case.
>
> Is there any interest in fixing these?

I fear it is a little more complicated.
We have different upper and lower case variants in include/uapi/. If
you rename them, existing programs
will fail to build.
...which will make users sad and Linus grumpy.

--=20
Thanks,
//richard
