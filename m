Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35DF303B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbhAZLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbhAZIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:21:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A30C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:21:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so1929042wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+jmRovbHoJFIPsxdXAY7r0V1zGJfwiz2YjhcYRzpajM=;
        b=PxUN3nqggnDRnjIg//589fa4L1h6sSUPQup32s/k9tsY1DOKHbiY07oQpUffQPQ0S6
         Hjyb6TEEApQdEuHzAXuTm9jOnPEHJWUxI/neKhqfWxZgx576UI8YQORSxwI0f8HpTvnB
         3Y8arwDxSK4Mbl+fWIXurbvmHeZ1c9tRuCK1JXRa4pQa6OEIsgk1kkKdyWwicY+PiHvw
         FmbZkaml8GNQNpNkeeMS+I2iClvaXvN6gHPAy6D7mkLhLMOpt/mqS5lCBHCxhCOpDmJ8
         DtaDUBVZCPdvJBF/RbcoF7YqQ/RbEYvcRYz59yrYb0Al1URb4qryjElzKZ0vmWu4kMlK
         f4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+jmRovbHoJFIPsxdXAY7r0V1zGJfwiz2YjhcYRzpajM=;
        b=W4kvoC7QgWiTsW7C5ZFa5aAeQz95a4XCleXmm6bO9dw5BNTSKdFaqklvOpmZUr9PEQ
         CPDFMPHWgluHN/uDGHqCPE82PuJJ8iAZNKD6kgFUi+EDv/7rXQzGS0hGInbfY3LHczoh
         wK4G5xS0pqYDZduDHHtIamzUAyXBck5gCVNHckttlnErzdflruyrMt7bol9RlVqMT7dQ
         laolVq+8vcpt4Lg9mz3g/OQ/v9naK9Ocwq+kauahxzkIjk1JSkxS8XzLG7e5qdjnuYYh
         ektq2G7jfUhOMUJ/7DIg5bjvaT6k6o8HZU1i68r1NKVucD3f0NlfZ6j58CHxw2AONq8f
         f2nw==
X-Gm-Message-State: AOAM5316CxEX5jKZO0zxtKdCEbtXeGvttAY8MOx7WXhxuoObkjR1uvIK
        FwemPjBUAIFxebhdWnIN2u7wMQ==
X-Google-Smtp-Source: ABdhPJzWMEJBAbelnI6VV/+tPmVfTI0FrXf0cV2oFryj7tJwUA85QEhadchYojFzQ1oygPTv16rZ2w==
X-Received: by 2002:a1c:26c1:: with SMTP id m184mr3611308wmm.49.1611649264241;
        Tue, 26 Jan 2021 00:21:04 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id g194sm2259715wme.39.2021.01.26.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:21:03 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:21:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <20210126082101.GD4903@dell>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Andy Shevchenko wrote:

> This is a second part of the Intel MID outdated platforms removal.
> First part is available as immutable branch [1]. The series has functional
> and build dependencies, so the mentioned branch should be used as a base
> for these changes.
> 
> Note, that some of the drivers, that arch/x86 covers, seems never appeared
> in the upstream (like msic_ocd).

What platforms stop working after this removal?

Are you sure no-one is using them?

I wouldn't be keen on breaking Janet's PC that she's been using daily
and keeping up-to-date since the 90's.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
