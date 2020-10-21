Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD60295442
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506215AbgJUVdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408061AbgJUVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:33:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:33:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so2291974pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWdO/BEHPBVW0hCFPQ+JR5DZl5CQy5T+Kf+qXCSlmaY=;
        b=vapsFGNt7qONFuQsa3KqFg9vFwXGyaSa+VKM9Od4OikxgZqrXxOJ92ntvxT70Jkvh6
         zNnJqpV1YHNlRGVPjBP2Kdn9h6OM1tcTDkj+VdHJUd/kYop9wMlYOcxZyQnyIUkbzYCU
         aC4DQ2nLP9d4TYOIGzCSdVACDSRYTfo0CyA4enSKwCQ6+qkhSj4X8PrVvOaSdtHPO8FQ
         Luw3hPS1+myvLHe1K7iEMVl3SV21AD6sKF4X0W/qRFz18BlMEzVRh3wOHpFHz1y2DsZ7
         19NR3KuWTORF4UXpLoiH7d5+YSExEwbta0L5pr1Vai1EIEaevKMPGltPzH7PGxAvRXn8
         ihpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWdO/BEHPBVW0hCFPQ+JR5DZl5CQy5T+Kf+qXCSlmaY=;
        b=Sxa1EkjLRI8PSKYo3CTbq/rsUepwvFbcJVbv6vrhByD9FMLUG2xCgPTa6oUjeX3DMm
         IIenkZiSsEKHdEkbZXQgTd2ahyYbS/BFzK8FpBnbodOHpL4sB3GP2PBbB3Myc0ygPoWH
         XduI1U+cQTLbyzLxzh8ctom/FkZ0wRpbrz0CRODfwz6exPR+bD8mtSnMBhKRSHa1O8a+
         pWEaPjT0/h2dFfHOQKMwliaHPN9aZgQzFqWHm1nK+BW71uuW4cY/wyB0KpCjRkDOkhdl
         favF43u6jirjMiI9hDWiHl+Gaxr2L26vJzmYn8pZT9GAvvoD7YEPEGR1fUnunYjA2JNj
         OTdg==
X-Gm-Message-State: AOAM532XHy0uqjQUb1J6A37VU9GEYNuWBJnLeNbtHpAy5KwSoi3ULcfp
        uSiAMnL+EMTtNoF3NPh0EjSWTheEhnw7zo244dPGLA==
X-Google-Smtp-Source: ABdhPJxGlF369VBjuL9KPmdp7qYAXWO3zXA0g1TE1lxNpt0Mt5RIdjomUYCqWdJoC4dnsAgiBDqGBiamcgtX44xgtMk=
X-Received: by 2002:a63:dc05:: with SMTP id s5mr4890090pgg.201.1603315983174;
 Wed, 21 Oct 2020 14:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201012102621.32226-1-sjpark@amazon.com> <20201012102621.32226-2-sjpark@amazon.com>
In-Reply-To: <20201012102621.32226-2-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 14:32:52 -0700
Message-ID: <CAFd5g44CxPuXbHund397PJSQPHGhWy1-7ij7JnJNzCO0NF6dCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> used UPPER_SNAKE_CASE naming convention that usually means it is
> constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> default config in '--build_dir'") made it modifiable to fix a use case
> of the tool and thus the naming also changed to lower_snake_case.
> However, this resulted in a confusion.  As a result, some successing
> changes made the tool unittest fail, and a fix[1] of it again incurred
> the '--build_dir' use case failure.
>
> As the previous commit fixed the '--build_dir' use case without
> modifying the variable again, this commit marks the variable as constant
> again with UPPER_SNAKE_CASE, to reduce future confusions.
>
> [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for this! This is something I meant to fix a while ago and forgot about.

One minor issue, this patch does not apply on torvalds/master right
now. Could you please rebase this?
