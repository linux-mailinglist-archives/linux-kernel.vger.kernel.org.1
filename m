Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836462F6E39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbhANWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbhANWaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:30:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96631C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:29:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so4239182pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfloksm1SzDZHkQm/k7XRNgYEOtyR/QoHOtukweU6Go=;
        b=jAy/zgngnl7Cr8dZ1T6s8xX7k7uJo2CHAKNkrDhsaLe7PMYCMXzpUgsLqXx0PyB4HA
         x3MMXaBTb8stzzM2yQlrJBcf9HjmOx60qncvKR5Ka+ByULIxVIgBpNATbYtslrgOUegA
         cFzRjQH/RFSEqOcyuzk96g/BSXDF6tO7LazgCeXS4T4h1BkJIZ33mMrhWzWxoY74Zeua
         FYeouTHj0CXdnovOYkXMjXeeyqYsa4TKdn7L9FaJu1Zv9FLwbsrPIj8hirQilPC+NuuS
         7Mx5+KWu6Wir/fhMR+GDmhxWxV4sjRIM9PSZNWTT1m6UGPxqK8Z83NmNUViKm86dwj4b
         2VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfloksm1SzDZHkQm/k7XRNgYEOtyR/QoHOtukweU6Go=;
        b=Ex+s4gmwkzrTSq9pMdcW8+GAqkgbRIv4RuYjz3kcbxC5keoKKdYn+C4CkLcP+/32uL
         /kPzL5hCOEwldKkNs3ew5HD5mkNVlhIIRL5GOXKdP2O4QIWZiazox7iD/fkb77p6aE99
         dCR4ylalt1hsPeEi+h1PyhIT7yfXBWy1EhfCp6Dbs4BjVFI0+TQ5/DF9hWIyhPLWymuK
         MSalZaDE0QuOl2vIuej0EZqiR6XFeRpGCClS6WLBS4gob/yJTuVv4wMTwkgpLLQE/rii
         qyrMIzNEIaossacb8hu3R4rM5sIYuV2rwWQ0WjR3Pz/M8wswjJCWoM42uCUVcX4q5sG1
         46Ng==
X-Gm-Message-State: AOAM53296OgVXNXTQJzrrmOwadr4T3g2qJv7x+Bi22g9X2AxGSf0vRAK
        9NKOeTzRChG5cM2SqrQdvIQd9FA+Gc1eSaiUvO+FuA==
X-Google-Smtp-Source: ABdhPJxIRuKrgiI26rwZ5dYnvENjdprC/CMY3G6TwD8w6ga+aQlc40GZow6nwH0yRLNwSYFROZNh5WYQ7Mw11dCILoc=
X-Received: by 2002:a62:1409:0:b029:19e:14d1:efb0 with SMTP id
 9-20020a6214090000b029019e14d1efb0mr9313677pfu.14.1610663378574; Thu, 14 Jan
 2021 14:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20201216002246.3580422-1-dlatypov@google.com>
In-Reply-To: <20201216002246.3580422-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:29:27 -0800
Message-ID: <CAFd5g45JEkdy8vmnr2F19uCVXwYC4J=neNR0ZyL+weaoxrM8DQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: include example of a parameterized test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 4:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit fadb08e7c750 ("kunit: Support for Parameterized Testing")
> introduced support but lacks documentation for how to use it.
>
> This patch builds on commit 1f0e943df68a ("Documentation: kunit: provide
> guidance for testing many inputs") to show a minimal example of the new
> feature.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
