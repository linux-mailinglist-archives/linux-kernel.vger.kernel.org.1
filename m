Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A381C805C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 05:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEGDLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728666AbgEGDLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:11:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:11:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y4so4488451wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=EDZcbDkryNHUq+1LtvqavsxqGBJ2zTgq94L3okmprwpunnwTqR843h/HBRE9aU+gHJ
         V4HcsR9N0EJlXs7fC0Wt4d5cyP4EvYKBZDbJQ7xDwC74mBhV6Om8NAOKru6gJ1ylLOzI
         wE2MB+h/1AOPbbHBAdNE+XMuiBgywyQ60Mia14JbAEGLC+u7ZOLY/dhydgzotaUpF8uY
         QwnYAynKqDtPfZzajgUJo2uvhonRZF3QPRJ1e+E9RdcEmRGMFnbFw6dAtUCuCksgLmmn
         6JieoL6lt15z7QZ0COWZ8gB9QYLbTQg/F+92uVog9oKiv4936wfJgOmksAKdpwWjacWY
         YYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=CwkUx5KYcjiFVTNQLfSEEAzML5QKzDIx0R8/6mmmrbPKDBSe3cWPPdA3JbcfYGFHIt
         w+YSMQB5inVWl3Bp021jkxrfNtoSEF6kZa70GHlyXTfC2/oni7CKk0xJqwPxMUtKMUz3
         Pv7nZMpC1Sr36jUuPcd/gOuwoG1S8INwQcEjvXFGwA+EIxMXAySsLHVlEebUL2/KXJwW
         ltQ+eEn1NW7sj0pYJOwqvjJ1KI98bBIiuUW3cclb45G8Y7H8L141p2kXvSxZYK/zQWny
         9QMnX2BntqGvK8dBSg6aPAp+laxUOtuukzrqwOcFBhB/yKb98WqeHUuVj0WdX/kMV66w
         qJSQ==
X-Gm-Message-State: AGi0PubHy4ZPMeo0NWAKxyhn+W34iIBWhx68yJlMjbUqV7rn6TStz+pN
        BD1QOgiwub45/zlAZpgNakPlCcOMqy/HBYQPrNEX9A==
X-Google-Smtp-Source: APiQypLBDSZbDJjvDYDKUk2tG5mW4OE2larhjMHIL+GzojR08YDhbTwnOD8/jg18+7ituZ8OLmGHSBh19zzrRajSfq8=
X-Received: by 2002:adf:e34d:: with SMTP id n13mr1519574wrj.249.1588821081532;
 Wed, 06 May 2020 20:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102714.8023-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102714.8023-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:11:10 +0800
Message-ID: <CABVgOSnxMd1ZdEQ3jHxtok1oQcMKh=UMtxZufeS9fv-q9C3-AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        =linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David


> ---
>  lib/Kconfig.debug | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e7ec..d1a94ff56a87 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2064,8 +2064,9 @@ config TEST_SYSCTL
>           If unsure, say N.
>
>  config SYSCTL_KUNIT_TEST
> -       tristate "KUnit test for sysctl"
> +       tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the proc sysctl unit test, which runs on boot.
>           Tests the API contract and implementation correctness of sysctl.
> @@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
>           If unsure, say N.
>
>  config LIST_KUNIT_TEST
> -       tristate "KUnit Test for Kernel Linked-list structures"
> +       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the linked list KUnit test suite.
>           It tests that the API and basic functionality of the list_head type
> --
> 2.20.1
>
