Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A381D2AA263
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 05:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgKGEJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 23:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgKGEJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 23:09:31 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 20:09:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m16so3671408ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpAfVVjgmSK3TmddDXe5MIH+iN8xL47kEByfErGtVvs=;
        b=qqrX9/Q9kWM5Hap5VqxZRuBzpk+TCPCwB2DK0d7bCQJv9e2ODwHzqawgp4Z1/BME0E
         mc5bB22vycMiYxW6Lb3c3reutDclxHw7FfKhk4gijTycG+Rj3BJ/fpjvOlevLe7iPFXH
         90eUKN6JH86AH6eu7zCKI3aNK5Iik6jzaNjDliUG5eXokIinJ4WKVao73VTUvO6RHJRN
         Dh309SDDL4PyqEKGThRnB+qf/2HVMn6fCtYFOPRK5Oy9nbEhVTS5DQ4VGJ1D6vLvqmPn
         PA0jTqyXpYzh7sVOs+/wwedE6j25cOPvKfS5aQ2hqYp9ZgAHIZE5+YMsK/iWoDxZRZ80
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpAfVVjgmSK3TmddDXe5MIH+iN8xL47kEByfErGtVvs=;
        b=jGPp0P3KYJQEfaoLDprMioDaazo2HR9RjMiDoaaCX9Y2Y0UxkaEWGcXZUzv8zlTGCd
         gSb+sfh7IsPtVd7pW3ElV6+JZYx7GnsjZgR88D1FAOul5ZVi/kpqVz21LxqbRUfhOu4v
         KWrJcGOX3L3HPZFuvIJbRFQq1oqXkGCwvqonZNTl+IRkZF7odceQg/DcW+Ym/7u7EIoU
         udU3Qwr6URr6qTlrZeMVdyZrVoj3LkqogOzRU4WUwVK94VvVP1qt+pTOvN9RnwhxWLhp
         K3+JYraj3ihyNkm4gj9NPDBt7JD9mt+k439Z1z6Oe4qFwGW8fymeHcQVCZnqrehGmdve
         vwrA==
X-Gm-Message-State: AOAM5328MUhuEC8R7s1st7tOPA0RVjhkWy/zTzBf7gajp3rT6gMZcBsQ
        3v8MVjt0R68tEYHi02kirrNo4UVjugw2tHEhvW12FQ==
X-Google-Smtp-Source: ABdhPJwquss92yG7I1ZRnnJ5suJ/Xcui705PIWdISDMrw0xVQ+ZekSp6zhR9hvvPcTCR4ttgp/64K3qiWWgZ8RMJlSk=
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr2053113ljh.141.1604722168145;
 Fri, 06 Nov 2020 20:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20201105232440.1049635-1-brendanhiggins@google.com>
In-Reply-To: <20201105232440.1049635-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 12:09:16 +0800
Message-ID: <CABVgOSnVj+EXZ13vgx7pj3fFJ7yx9xPYU39nuCP_v_fNYpN12w@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tool: unmark test_data as binary blobs
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 7:24 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> The tools/testing/kunit/test_data/ directory was marked as binary
> because some of the test_data files cause checkpatch warnings. Fix this
> by dropping the .gitattributes file.
>
> Fixes: afc63da64f1e ("kunit: kunit_parser: make parser more robust")
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
Reviewed-by: David Gow <davidgow@google.com>

Thanks. I wasn't able to find any issues which required those files to
be binary.

For the record, a link to the original issue, which appeared to be
with whitespace (spaces before tabs) in git apply:
https://lkml.org/lkml/2020/3/13/920

Cheers,
-- David
