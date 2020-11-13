Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9B2B2630
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKMVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:04:21 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BDEC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:04:19 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so8628797pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bu54NTDDzZAvafBN0qstmnnIgcbv3/RJ0zdchAkmdlc=;
        b=gtpsQ8e6BmSuHGCtSgJt6cRIMSJyxWRCuyI5kmjzmoZHHt5LtjxXmRbyq2hXcDaI+Z
         +Vza2NlXxsuTtuRSt9dseQT4WA+dosVLoiJ5TOHnLumpOe9X6rTVCo+qgNgSe0iRMM4x
         1lhcNQK8J790mRL0lPjReVBKLOn0QIUU5iTPXdxHYEZVBMQulHCxk/OurFaT7LwrCwcC
         /o2KuWvflZWIAVAK9ryx9bdXkLImM8xBe9PMmqABqIV3IXA+8Sk870erD4tRgEkgo4XT
         YNUO4MYxH18OpTDP5S7EBXRexL6Yw8xw0g7p5LNnEV1sPG7uGm53NXt3FMxIejR+fBvn
         SkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bu54NTDDzZAvafBN0qstmnnIgcbv3/RJ0zdchAkmdlc=;
        b=YClGLcCuw5RtViI5vz8sxtM7V93IKJ4yHgIDzCwiymY7oVM6hHDBbIMncG7rObgk6y
         b8nMQ7h/IYvgKPddPGMX2TBtiVlK+UEtDNhdk/q9pmEUZns/RUgspqluU01veVs2CA0e
         /KSl8kexBr48a53zeCw5Kip/lAolvNMkWkM450B5E5F6V1EMqBu1RRUJtA69sZA8S8E5
         RafV1D+HWxg1m00zWuVPguPUYDm+m+42b0r1UDEpHXclKEyUaaP0b5Cp4fPFCv0HljOt
         GU+ExZGv1HU9bLIS4XVUvAUfPsCMuGMM/RKpFqLAgDB9LmJjSW2sLBMPsg6V8ArOr2Gx
         XSdQ==
X-Gm-Message-State: AOAM5337uynyJ50v2S4djdS/NPusvf89Em5yRGrVYVpal1Sno6Idtcq6
        7L9Q0sdAVZUKXAXZnh+LCMTJbVIUbgpxCOU7whZgxQ==
X-Google-Smtp-Source: ABdhPJyYajVZOWzH6XOD0g2LgooZ85ku860FshnMKczmtJTjFknjDFRERcSwd5flqJyyMpLuOpG0bXDD9h50VJKcG3E=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr3314262pgo.381.1605301459249;
 Fri, 13 Nov 2020 13:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
 <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
 <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
 <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
 <61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com> <BYAPR11MB3256ECDE31F1900EE1D9254687E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256ECDE31F1900EE1D9254687E60@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Nov 2020 13:04:08 -0800
Message-ID: <CAKwvOdn4-CYtszj324JoOL6GBtUAeieTocc3cQyVUJJvd9AG6w@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 1:01 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> I can do it this way:
>
> In the global header actypes.h:
>
> #ifndef ACPI_FALLTHROUGH
> #define ACPI_FALLTHROUGH
> #endif
>
> In the gcc-specific header (acgcc.h):
>
> #define ACPI_FALLTHROUGH        __attribute__((__fallthrough__))
>
> This would not be #defined in the MSVC-specific header (acmsvc.h) -- thus using the default (null) in actypes.h (The per-environment headers are always included first).
>
> (We do all macros in upper case, prefixed with "ACPI_")
>
> If you can update your patch to use ACPI_FALLTHROUGH, I can do the rest (above).

Sure, I can do that.  I'd need to wrap it in a little more logic for
__has_attribute to support old GCC versions, but that should be
doable.
-- 
Thanks,
~Nick Desaulniers
