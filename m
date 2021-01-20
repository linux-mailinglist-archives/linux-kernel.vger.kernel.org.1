Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57122FD60C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbhATQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403985AbhATQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:50:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF71C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:49:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c127so3419612wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUDg6TphmanEAstHgN26xAlXogE8/4FgyIPvwhmL7gs=;
        b=pghiOVPTDppHJ45SSMy2+CHFk9YLriSho7mdmM71ABsaxcBoFv3ja6EEAbJkf5fut1
         moGYip9Q1qdPy8y4PyQmDoI8F3NhweKRHJyYT6RVMgzcirgaWmSM2g7Hs1eCsPvVeqAQ
         Q9Tap+PfCVJTLJbmIpzQsMDcH4Pgt/9Wg0ut+dezxUd9sU7NI39nu5yftOWPfdjqtC5o
         f8/TLGh5A3BMY9NwmgGHwE0aiRnk3zEm2KI4zvQhwSbTeZrQvRDJIpVhtw+/fplBTQCo
         lSpsQygOwAoS1thaJoWKph0ap8WwR3uWeNh6HyM4d1PFoC0cpEZpkxM70rPlvlgCBYPK
         oAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUDg6TphmanEAstHgN26xAlXogE8/4FgyIPvwhmL7gs=;
        b=ozLqfDN3UYAlRobc2nHFCpz71y4Mu3foIkzC9WQcf3/h2vyaU6qEiyR7jvQKgPPB9k
         BUIgsDsk4lWpBfTLLreWB6X3LfKwhOhguFYRlL37gOwNVmcWyCYUBbciQKitC5/fIOmt
         cTWhJJWBx98mYwbgebse/foTELTRaBpG7ejUJCw4MkGkfiYkRFNmdfFvD8rVcdZx9BRH
         DB52QZyHGEptpSacgfca1VctB7SNfC/3LwX+NM+dPkY8DWEm5HMhGdqYosRaMDAuHZzD
         aNuUqrNzY0PBYf+2k7pNJDdcG6eWHDhya7UVAWAn03tcZvAkfPXgE0RHV8fbJ5bfQGBZ
         Tu0w==
X-Gm-Message-State: AOAM530aujVf76MqH1XdH7UmgB4RhVgYMSWICibesKQpQ8804AE4sFdZ
        72Th5s7QOR8b9d747fctSZ7NAuspizWqmPww8ZBFVg==
X-Google-Smtp-Source: ABdhPJz0wZLMLD+76EyvUtDPstR+U0u7fb1/8zCKqlM+va0UuR2w0QT0/wXXhaj0lNefqt31Z564snWdZ0DTedYcOUo=
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr5148677wmq.126.1611161358342;
 Wed, 20 Jan 2021 08:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <c586aa93-52d7-bd6c-3d5-77be4ed4afae@namei.org>
In-Reply-To: <c586aa93-52d7-bd6c-3d5-77be4ed4afae@namei.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 20 Jan 2021 08:49:07 -0800
Message-ID: <CAJuCfpG0+_4x=F7dpKabgmGwDf2KGcCcEfXixLBef6+zg8uNjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     James Morris <jmorris@namei.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 9:02 PM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 11 Jan 2021, Suren Baghdasaryan wrote:
>
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
>
> Almost missed these -- please cc the LSM mailing list when modifying
> capabilities or other LSM-related things.

Thanks for the note. Will definitely include it when sending the next version.

>
> --
> James Morris
> <jmorris@namei.org>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
