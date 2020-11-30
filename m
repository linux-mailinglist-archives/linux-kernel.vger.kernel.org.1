Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23512C90CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgK3WOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgK3WOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:14:48 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB83C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:14:02 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so785547pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKeppEv6PxhpaKISV122YrtS5AvgtBbtMsR/8wmYbyU=;
        b=Y3lGqGYO/7M9p+z2hXtjP7WuIHaHG8DZl4ziWsAfd8PA6E5+xhzEu7ZMVFwcGYj6pN
         fr9blZ8XcH6UKrSguCKiyOejzgp+lXi6oVmXrGAbcuG5PWrUCyzTPQzuIB49fN9pkNLN
         rKd1IzRP/KiyVYXVvp4OBqhA0DF9XQkr80DXkA8f0YFYaYJ+X05YZpbMANcJqFG9zRjN
         +AyX77nKcVK7TvY0AsDwdjIs8xlswcm9ZBX4MozPqcvNEy1PdYLf39ImR3hsfOCiFNfL
         /s9LXejjHWbOdD3T/aVGnoGCehMHMGcsMbKeig6EzQFIzYO7TpXFZOXenQGiZP1pkiGL
         LJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKeppEv6PxhpaKISV122YrtS5AvgtBbtMsR/8wmYbyU=;
        b=ta7fVw+vNXPJDLoFrKAnVa87TsHceudSxzZ0wUobBTKbwo3Cs1YD/VaDYpdMvr10yM
         6KC8rDh2FVPiimLQhmLBaH/w7/6ienMYveooHETxQaXVpf59uXQ3Th7M8wyfL5GvxLWY
         IsfQy7dQJKvCNnfkrl1HBWpr2lRheVCsM5weiw+DGYvPU9nYX7fukCdbe1vLJolXz5mq
         tHDQEOpC/DNgsCkh5U8q1dRnsMQEFVKaHMs0nsuinc/oX6YIJCEUDM6egj7Ij0Hj/YHD
         qyTJ2MPiXzZBGwozY6/IRIGbGbyqS5yjUUD94lulOvOKB1XZ5k0AoxJamfEx9M6T3AJ7
         900A==
X-Gm-Message-State: AOAM532Vk1TL/RmaVixYuREy8s/t/CTPXOYfYrSARcr5YhZUPDMkiIF5
        mQRxnhKpqmprrQiAnK4yEO4zDnGJpU8oRk7RiILWNQ==
X-Google-Smtp-Source: ABdhPJwP1AffYTptZdTji0rnn0WFzX3DAWXDOotDTZ/j+UDPrqUpGPJjtDW3DClRkD19T0Bt1RYkstZ/IzSVRmeDuxo=
X-Received: by 2002:a62:ed11:0:b029:19a:e1cd:ca96 with SMTP id
 u17-20020a62ed110000b029019ae1cdca96mr7046798pfh.38.1606774442044; Mon, 30
 Nov 2020 14:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20201123225759.3658122-1-dlatypov@google.com>
In-Reply-To: <20201123225759.3658122-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Nov 2020 14:13:51 -0800
Message-ID: <CAFd5g44JgvUBZteUY=KVCiiD+yu1DtYE+phm4R4uxcH7N22Ffw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: provide guidance for testing
 many inputs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 2:59 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> usage.rst goes into a detailed section about faking out classes, but
> currently lacks wording about how one might idiomatically test a range
> of inputs.
>
> Add a new chapter for "Common Patterns" and group "Isolating behvaior"
> and this new section under there.
>
> Give an example of how one might test a hash function via macros/helper
> funcs and a table-driven test and very briefly discuss pros and cons.
>
> Also highlight the KUNIT_EXPECT_*_MSG() variants (that aren't mentioned
> elsewhere [1]) which are particularly useful in these situations.
>
> It is also criminally underused at the moment, only appearing in 2
> tests (both written by people involved in KUnit).
>
> [1] not even on
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
