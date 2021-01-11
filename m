Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00D2F21BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbhAKVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbhAKVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:25:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5BBC0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:24:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lj6so318723pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRm+BijPKOU/rUYvlIyBpR5Ozh0y7fiadDPD2OBagxc=;
        b=AKpOd3qvdthJIPjjkuNyUdVd3bOcbZNJmvkB6r/Kz5XPDOJEsNxaElJe5XqEYMhJlG
         PeZ57yRAgxnSEgai3ljCQHgTgKO4RAn2Yl3sDVUNHksKXT7aRB3OHlEmI5OlIWlYiRrC
         9DVKmDPDQzZenC17YfJ0LsFR2/+BcnS8TEaN1lhUF09saumuieO7eFUVJKIh9tLdPTOP
         e4V4q6UNmRSC7bZelnTzMPgODv/2HIvVCPWI/vNU3E81SW6jFXdqCb7NcGmH+rSMs0V4
         aDDIMA4uu3NX5GoEmb7UAF5nDTtiZZzXVXdW4UJuJVFBP8WUUxrDS2m6uja+h8iqGvRd
         jzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRm+BijPKOU/rUYvlIyBpR5Ozh0y7fiadDPD2OBagxc=;
        b=qJ27TaamcYq7qS/uTLE08v8a4blUQgLtvbcHiA7hMny9a6CB2/+X/xuyNH3x2JN+hP
         oRZhk6kCJ/eO17Oc+oJJu9z6Zm4f7fCvC0EhptahQtmsLC1lO+S4Zi2Ewfnd7Gw98Dau
         338NrOXEbTAY4bupbh42/71Jd0cMBItkBTVjFjQsrfCj+p3WwGAq1Ucn0hgKC9Nbqs/8
         4lle4D8GFC9wl4AeoEKYCWy/Gyb879kZ+gupC/yZzmjA5Say9EBm1dlzKKxMEYedl1tK
         m13EzU5FmT/sALkH1DWrtqZGyyzN4eO1dv9RkAkn21ci+UrVPiGyOGEtGbScJNWojVII
         CbLg==
X-Gm-Message-State: AOAM531TRfS/FYifr6N035gE0mRzQ9/YnFHrzAvUpZgH/gsnIc0xpn1a
        QWsN/srqcwy1QP7vAd+/PE+YqjVrTmJ2TnQ3q6tUng==
X-Google-Smtp-Source: ABdhPJxeVKpnDtUGqu2KNhL6FH5SFQMKtas8woPQeILYCP8KsYPmGSjZqchdZ1hUz7hzeIq6Ngwr3m+R4716BPFi3jE=
X-Received: by 2002:a17:90a:de03:: with SMTP id m3mr901144pjv.20.1610400281705;
 Mon, 11 Jan 2021 13:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com> <20210107234803.1096592-3-dlatypov@google.com>
In-Reply-To: <20210107234803.1096592-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 11 Jan 2021 13:24:30 -0800
Message-ID: <CAFd5g463LHZmtwu4MwKBOK8b5_0rpBpGUFZEC00qVwxEJXgpRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kunit: tool: move kunitconfig parsing into
 __init__, make it optional
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> LinuxSourceTree will unceremoniously crash if the user doesn't call
> read_kunitconfig() first in a number of functions.
>
> And currently every place we create an instance, the caller also calls
> create_kunitconfig() and read_kunitconfig().
> Move these instead into __init__() so they can't be forgotten and to
> reduce copy-paste.
>
> The https://github.com/google/pytype type-checker complained that
> _config wasn't initialized. With this, kunit_tool now type checks
> under both pytype and mypy.
>
> Add an optional boolean that can be used to disable this for use cases
> in the future where we might not need/want to load the config.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Very nice! This makes the code much more readable!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
