Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF062C90F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgK3WZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3WZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:25:03 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D6CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:24:17 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id ms7so468968pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP10auY5b/+hzNiyTCTFtYJxVIRMIAgFsrP2yx2Sg3Y=;
        b=fKA2uASNNmUSAdH8RvG4OeS9vDii9vjtJ+qPy6l79wdX0Bhc5GCox+clxnSNfQpv5Z
         rPk1xCj6/UQ1NuWfJU9U3gLdsaloMVIAB/Ew/H1Jy5xlXQNf26auNbfF9rOh6mqvc1MJ
         gXdzMmEDbcpK9xd0QgQi8Hs1dLExTrGkI64CH1qQn3ewgb2S/PjTRlXBEvbXwOrAKxfN
         5PbOpheLTUXENkl4qhw3fc6MMK62GwNDrzYeKNO9UXo9QoDdU9EHs24cCNP/+yJ2/mV2
         Q1aOf/HeL8HiNGq95TXtUkneTvfnhlea8rCm84CqNwXPxPcrW8/XMERy9Vyn52xu0tPg
         6Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP10auY5b/+hzNiyTCTFtYJxVIRMIAgFsrP2yx2Sg3Y=;
        b=tpItDMAVfh2HagXDh3UZXvL/q7G0Jy3eEdI6tv/XLwR0GolQV0LRWg5L5aHJFGqDBx
         /VNrCJhl8WKcJtIBwhnF6ovA91hrXkurulwPmdgicY5K5VQ8kogBRs9fGAHoEynGpnwt
         N3psjuQ84tpQ5k8w+koXCQbEepOOi5wNk8rZSQ2hFBuoCk+AWvI2N1OKkovgcppV6klT
         nFgFV93vPwvy2+F269nQXI52hKYvSfeNH0nNpaSfohuhZgh662LJ6Grl4EG99HG//emC
         VngHSrOjUpgWJ7fcXIIWEHO9o6J7+XhFR2TxEo+AANkmY8kCykhvNsYL7qzcgyDQiK7u
         pKNg==
X-Gm-Message-State: AOAM533CZbq+Gp7nJLX2vNutquXtGRV7cl670GpZ4gctqgApzH0y9Ayx
        Sg3BqH8THUn+PMOQBjEQ0FLyinwRxMqUnL2Ckc84lQ==
X-Google-Smtp-Source: ABdhPJwBW05dCKp6JwGQ8qZLyIPqU+sgllBKgG9WsgW8WuQeZ5sRlEKY2B/Pl3nXeVEzHxE+VL92fIImTrWF0SBiI7Y=
X-Received: by 2002:a17:902:bd09:b029:d9:f7c8:6210 with SMTP id
 p9-20020a170902bd09b02900d9f7c86210mr21302705pls.80.1606775056561; Mon, 30
 Nov 2020 14:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201115185759.169279-1-98.arpi@gmail.com>
In-Reply-To: <20201115185759.169279-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Nov 2020 14:24:05 -0800
Message-ID: <CAFd5g46mV_BKC8JQkw0vTXzZfy-dQ=N0jO_DHe-nBrWZimYVCg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 10:58 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
