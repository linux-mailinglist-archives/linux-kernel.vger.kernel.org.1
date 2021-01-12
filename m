Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF662F31D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbhALNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbhALNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:34:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1615C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:33:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so2484889wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMb9wiTztKRoS07hzB3mhdKsb+sq4X1Trw3VZKDYs14=;
        b=LulKNfPy6RVKeuhuvL+21DkViXqm+xoh01+ZKNpfO8NcjO0tSBaITJinrbdfENlRvO
         iiiFj9B0zakXBmdRrGQpq8QPe++CE5K8M8Yq68gCWH/jAvR1iAOL0C8UNi/f75vtG7GI
         B8+rXYakqo+ZXricrDxC2lsa6jKFHT4TxSBqO0ZsGTZgYOtwuHQzRB4ff7zKkR795Aps
         ym4/FFqVJS5TlHhjSbFKfKQB9hOf2Omg7HihXK6NpglMTkh97VAg35jyAF+id3eJ3TDN
         kjBRTl4GCIxqWWdMqYdbc9/SkACGesAJlWAdCSPT8tirP2P0pi4PnVDzZiAdn3GJPgcF
         a+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMb9wiTztKRoS07hzB3mhdKsb+sq4X1Trw3VZKDYs14=;
        b=Axe43/ObTnZOE/ENOihtVNGOZE14W0WqxH3A2UqRxJMqyF3BeRi/7ye0C0EFvbvYAo
         AzU/RxwQE6L9zlBALks34pT+oc1y+T4ozwwyt4YSgobz64zRkLbXcsnTt2LnlbTI1+H4
         OGInmz92sb98GwpXE8vKMYpksbsAI+DGKdimW6e7+XyaYzI/zNw51bYtiEdC4Df1pAgQ
         ejFsTtZcDO8zm0NXdc3op/+f0HnlU0F88LqT59qXi/6AYRMLeTFH4B0IPSiaON4F8BDh
         7d38facCroMAkgCWgHw0CgfkjlT/xo6e6pWTAt7NYpHknfS9iLnITyyhgXmj4mMad7Za
         KA+A==
X-Gm-Message-State: AOAM531ERXFDA5RD62aRoooLtXwq6wv3Dy3ENmH4uH8gDEXGIB6KK2Wr
        4i7UTXo1EPsKU6vfVL5Ve4Peyg==
X-Google-Smtp-Source: ABdhPJyOFVSdyqq6SQpZ2Zd2KjwyKoBsv1vg0JznjxGBL8fPkpmpDog+P9sm1N8NGWAeBFVPwKAHag==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr4402827wrq.229.1610458419201;
        Tue, 12 Jan 2021 05:33:39 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id s63sm4156014wms.18.2021.01.12.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:33:38 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:33:32 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] kasan: rename CONFIG_TEST_KASAN_MODULE
Message-ID: <X/2lLAOWi4PHJh/Q@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> Rename CONFIG_TEST_KASAN_MODULE to CONFIG_KASAN_MODULE_TEST.
> 
> This naming is more consistent with the existing CONFIG_KASAN_KUNIT_TEST.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f

Reviewed-by: Marco Elver <elver@google.com>

For this patch, as-is. But we could potentially do better in future --
see below.

> ---
>  Documentation/dev-tools/kasan.rst | 6 +++---
>  lib/Kconfig.kasan                 | 2 +-
>  lib/Makefile                      | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 26c99852a852..72535816145d 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -374,8 +374,8 @@ unmapped. This will require changes in arch-specific code.
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
>  
> -CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
> ---------------------------------------------------
> +CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
> +----------------------------------------------------
>  
>  KASAN tests consist on two parts:
>  
> @@ -384,7 +384,7 @@ KASAN tests consist on two parts:
>  automatically in a few different ways, see the instructions below.
>  
>  2. Tests that are currently incompatible with KUnit. Enabled with
> -``CONFIG_TEST_KASAN_MODULE`` and can only be run as a module. These tests can
> +``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
>  only be verified manually, by loading the kernel module and inspecting the
>  kernel log for KASAN reports.
>  
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 3091432acb0a..624ae1df7984 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -192,7 +192,7 @@ config KASAN_KUNIT_TEST
>  	  For more information on KUnit and unit tests in general, please refer
>  	  to the KUnit documentation in Documentation/dev-tools/kunit.
>  
> -config TEST_KASAN_MODULE
> +config KASAN_MODULE_TEST
>  	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
>  	depends on m && KASAN && !KASAN_HW_TAGS
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index afeff05fa8c5..122f25d6407e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -68,7 +68,7 @@ obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
>  CFLAGS_test_kasan.o += -fno-builtin
>  CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
> -obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
> +obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
>  CFLAGS_test_kasan_module.o += -fno-builtin

[1] https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-file-and-module-names

Do we eventually want to rename the tests to follow the style
recommendation more closely?

Option 1: Rename the KUnit test to kasan_test.c? And then
also rename test_kasan_module.c -> kasan_module_test.c?  Then the file
names would be mostly consistent with the config names.

Option 2: The style guide [1] also mentions where there are non-KUnit
tests around to use _kunit for KUnit test, and _test (or similar) for
the non-KUnit test. So here we'd end up with kasan_kunit.c and
kasan_test.c. That would get rid of the confusing "module" part. The
config variable could either remain CONFIG_KASAN_MODULE_TEST, or simply
become CONFIG_KASAN_TEST, since we already have CONFIG_KASAN_KUNIT_TEST
to distinguish.

But I won't bikeshed further. If you do a v2, I leave it to your
judgement to decide what is most appropriate.

Thanks,
-- Marco
