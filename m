Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA6242E56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHLR7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:59:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFDC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so3226236eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/cIJeE2yfgVM1ZrtP/9jp14hYxY3Vu0/YCadb84AWQ=;
        b=jI3J/b3sbr7lMKeERD0GITknMh9Uxa+SplZKxUOvdDtzVOtMq4sbbMjULlVaTTjPsl
         b6ZbrqiZvtr1sqNoBR0Z/OPksGY4OjXSaOovTptxM1hz6ZDb++D2GV0IE+GzOKqYA1mF
         Rk5bbZ3M7f75UO+LZE8T1d84BJjKfgSc9gyZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/cIJeE2yfgVM1ZrtP/9jp14hYxY3Vu0/YCadb84AWQ=;
        b=qz7OYEow/HR/reKI5BGOmj2Fdap+Wuy7UWGhFAWO4OshdBmEE0Sc89w7A/9SR+9SAm
         Qqm5wSpm+FBCJGpO4mdRijRFz4dwcWEbal26uORk5btuz8553pEKcjtd9fh43NS02Svu
         3l3wuOu0KbUE82h/XhaQEvf3KOLbv4vNBM08a3Vgy6adfESugZaKvodjlJCu3eC8Zqtt
         RdFveiOhuTvkFXYTl0NjNujVNDQuOB1eD5sPscTC2JdgDBX+irIQeCCreHpCLDVCeZfn
         AZG/qYUmMd/wjFCI2nYnNdzkZNEiiZ/sKel/1eY9PqDZrtBQ4EC/Yp3prgrKAiKITE+U
         aWlw==
X-Gm-Message-State: AOAM531ei5SxhU9oYDqUa2fEoKW4IpOaW2kHDl9d5ObsldDaAeJaTrh4
        0Ux2S9JHqcCxheOrVi5MqnSG4GRCwicasw==
X-Google-Smtp-Source: ABdhPJzPe5NyG0jl9WmdABKN6Aq9cHNXKcupjIZkztdQbLMRId6GTdQrq6UlPHcSaSLOJCzB8SSnzA==
X-Received: by 2002:a17:906:bcf3:: with SMTP id op19mr944142ejb.1.1597255167034;
        Wed, 12 Aug 2020 10:59:27 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id v5sm1932917ede.13.2020.08.12.10.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:59:25 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id m22so3226121eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:59:25 -0700 (PDT)
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr946622ejv.534.1597255164979;
 Wed, 12 Aug 2020 10:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200811222803.3224434-1-zwisler@google.com> <20200812014324.rtvlhvopifgkw4mi@yavin.dot.cyphar.com>
In-Reply-To: <20200812014324.rtvlhvopifgkw4mi@yavin.dot.cyphar.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 12 Aug 2020 11:59:13 -0600
X-Gmail-Original-Message-ID: <CAGRrVHwQ4EpZy73n4NTLhDZNGN4Gi_FUL4BjWw7ruEoGHENZEg@mail.gmail.com>
Message-ID: <CAGRrVHwQ4EpZy73n4NTLhDZNGN4Gi_FUL4BjWw7ruEoGHENZEg@mail.gmail.com>
Subject: Re: [PATCH v7] Add a "nosymfollow" mount option.
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 7:43 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-08-11, Ross Zwisler <zwisler@chromium.org> wrote:
> > From: Mattias Nissler <mnissler@chromium.org>
> >
> > For mounts that have the new "nosymfollow" option, don't follow symlinks
> > when resolving paths. The new option is similar in spirit to the
> > existing "nodev", "noexec", and "nosuid" options, as well as to the
> > LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a long
> > time with equivalent implementations.
> >
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> >
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
> >
> > More information on the history and motivation for this patch can be
> > found here:
> >
> > https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
>
> Looks good. Did you plan to add an in-tree test for this (you could
> shove it in tools/testing/selftests/mount)?

Sure, that sounds like a good idea.  I'll take a look.

> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thank you for the review.
