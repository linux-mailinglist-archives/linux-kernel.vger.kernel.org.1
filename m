Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80812C9834
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbgLAHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgLAHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:34:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D6C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:33:27 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so2162357lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uB5Ijg4lsZ53TyQb8q6EyzIkeiWhB7LJL2nbLGLbbto=;
        b=akz0P6W9TIvX78pdFt3x1U3pOjYlqQeMGEzmtvBMIB7TAf7CvTdet57qNnnk+fYXqk
         n/bustEJOYl3nW96Q39N7Vj3BFZNrTCaldycgXwTGZfE8AnbP+znwmlmJu97uoVON+j2
         cmsgPfJ1PvqMyrKpkC69OW2HWuQvr9YMvfjckOCVxsY16OFqckUFEwB3XFkFj3/9lZCi
         m7SAGUHReP+zQCVCHaMmCWi68toEWHtTTjm1x6E5SwXFexDCyJTnCeS54k5zePf3D5ah
         vSGQU2msLdAFtdco/MlcyD9KUECAhQyYmIDfZCcrh/E9jadPwJw0a9GFcpMuU6YMwvaV
         5MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uB5Ijg4lsZ53TyQb8q6EyzIkeiWhB7LJL2nbLGLbbto=;
        b=A6wSBD6NIU1nrJJMsft83/5rF1AedBa4z3EDfbkTYgnFq/I9+5m2nVlrSi/URZxpq3
         ZvF2axHMOvquc1CSNbr03XOhfLYMBmZRdNsf1aCyQAsd/xzyjXKKTim1vt9GKsWh3vqC
         l88s3MlfpnJ2SyZTpYbUwT+OryeCiKe4bE5tv7vvMDU/tQ+9YhIXJZjlDq1yvWeMM7ax
         II7YbwMspiYL/vHKu1970E1O8SS566FXXH4Hv5Eyh9zQkH25Vn1XpqkttGnR03jFsbko
         /mc42HIJWrelsJ32SX2kkvyivFuysRqqyGSFx6rRixS/8Z53ElKK/4ugc0k+nwc4fq7u
         qDqw==
X-Gm-Message-State: AOAM531GOCSBQngKfnqyIAeugsh7epgPPMqYepz0fk0JOokin7fCJ1XB
        W9xZIwfj7qMwL/t9dQV4xuRuGf8Cp1YpGalQZJZdBA==
X-Google-Smtp-Source: ABdhPJw+XQSv9wF8wBAXUMZzU8fnW1PAeTTRaqJ6mMpsxVkNfJgpjkifY9dpiOSjGroEUQc9aGDQJKIDRBP7fLA6khE=
X-Received: by 2002:ac2:528e:: with SMTP id q14mr579418lfm.34.1606808005880;
 Mon, 30 Nov 2020 23:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-3-dlatypov@google.com>
In-Reply-To: <20201130233242.78413-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Dec 2020 15:33:14 +0800
Message-ID: <CABVgOS=91XtTv5j71MiE15pMBLj=VVqqK6XzCHX4LfndrsMYxw@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: tool: stop using bare asserts in unit test
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

On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Use self.assertEqual/assertNotEqual() instead.
> Besides being more appropriate in a unit test, it'll also give a better
> error message by show the unexpected values.
>
> Also
> * Delete redundant check of exception types. self.assertRaises does this.
> * s/kall/call. There's no reason to name it this way.
>   * This is probably a misunderstanding from the docs which uses it
>   since `mock.call` is in scope as `call`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This works for me, and seems pretty sensible from my rudimentary
python knowledge.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
