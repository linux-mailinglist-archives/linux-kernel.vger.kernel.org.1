Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5082CE7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgLDFv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLDFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:51:29 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177FEC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 21:50:43 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so5289390ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 21:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3j/7oE9+JOlE89/YBfJ2ECQfaC6VbEGbVg+m1NXIJs=;
        b=Ldln55MNFQfErM/Bp4Hi49SZCwoWmfd1s1VeRcYfQrf6yOiblaO9XnQABNqhP644hR
         y+97gHZBBo21ySBAXVSvOf9kUjcO/5koBKnZjQBeROKRt+TWXWz3Sxq+wqm5SceV2uFu
         br59gVl72g8B3WTFz2E4M4/koMzWf0BMxWWEJI0rsASWlj1pTbDvZw0vILnPfr5660nz
         X8E/z2ViIkInn4np9p/IH8i6Ylba/yvZ3ONwuQPfs312Z7pruHTEMH4p/Y8LXQ1FhLsp
         9Pe+4QWDi+sORQG2E4PwYlkVEtuYCVUY25r1jIYUAd3CVscfOKKKE96/as2XDKaY0u6A
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3j/7oE9+JOlE89/YBfJ2ECQfaC6VbEGbVg+m1NXIJs=;
        b=Mgo2svSZr3BA/hDK6fST3a040AJuAXWqxB0lLhjygGyz0VMrXijQHuDaVIG4mNEB2m
         aU6DjPVLefCFyOkZr0ge2VVyzQuv69gkeDhEf8pz+JYUwEJNeuuy6x36GMrsG5WvZqmF
         3kzhXI0oWwSPv/xJdKvvj+iqvXuhNwcpy4f1JUpEwZp26yDZ+2McswivpJ9ZG0xSmq+Y
         GMjXj5D9R8HMsUgcvXy02ZEQqhjwuTJotWg6Iw0T4y6qBiW6ERG3Nm83bjhv5Wcf2PVP
         8BDkF6YB1oyAPk41TTAB1Xy3oWBnVmIFuFfn/5JlCYWWdwqMoZxmz8T+Op1JUFpYV4ch
         cv2A==
X-Gm-Message-State: AOAM5334wU6NorgWY6MbAq2Lwh0G3rLo3KscBDd5YaOKDe9n6gQhlHfM
        QFTGI/8ItEYXUF9BXb9wSERZZGqI+ggZAJJkaSVoag==
X-Google-Smtp-Source: ABdhPJyTYElB8m+iVCNjXhTQUpx6v3zANBhXI3KTnkASPyhIIsxdKHnTEKgKRvDnys5wimGjGXLk6FyQ+v6j3h1D3c8=
X-Received: by 2002:a2e:b54b:: with SMTP id a11mr2792067ljn.40.1607061041265;
 Thu, 03 Dec 2020 21:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com>
In-Reply-To: <20201203194127.1813731-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Dec 2020 13:50:29 +0800
Message-ID: <CABVgOSmPFYYrjU5KHgKftU1P2CcCTM_HvxJr2YRzKfuaZWjxSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: surface and address more typing issues
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The authors of this tool were more familiar with a different
> type-checker, https://github.com/google/pytype.
>
> That's open source, but mypy seems more prevalent (and runs faster).
> And unlike pytype, mypy doesn't try to infer types so it doesn't check
> unanotated functions.
>
> So annotate ~all functions in kunit tool to increase type-checking
> coverage.
> Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
> be annotated as `-> None`.
>
> Doing so makes mypy discover a number of new violations.
> Exclude main() since we reuse `request` for the different types of
> requests, which mypy isn't happy about.
>
> This commit fixes all but one error, where `TestSuite.status` might be
> None.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me: I gave it some quick testing, and reading
through it, all of the changes seem sensible.

I wasn't able to get pytype running here, but mypy worked fine.

Reviewed-by: David Gow <davidgow@google.com>

-- David
