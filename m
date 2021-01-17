Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BD2F94CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 20:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbhAQTGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 14:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbhAQTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 14:03:39 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 11:02:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so8057813ede.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4xcfgcrrBIcBhORUZhduWLLV8ym+o2ltWoOSy1l0dM=;
        b=zW0/5bPbpe3kbL88yMdiAr6BVrkLHCzmrzz/SgdumM4LVqGUc9NGZ/i4nBtRhOxc5C
         cM6JmHAvBUzytMaWyZeeGBeJ4Ct2eFgXESIuFflFWVWdzl+obQKJOLQYuLQfY8i1YBdT
         0puSD7aEFN4gzJNlAYTkDMOqeUxCw0Ngl2xA3UKCSwk5wr15NrqC0DFY4RT+XbTNhTp2
         gHtDQWeWTBCxg9SywtcVTde/gd2El4JSPKj60SNJklQZy/UwtdlggH0CUhMh0oTwMrCT
         YUKt/c+uXUSJvfzapMxwUCoUnP9jpvKsJHTdDwrn4Qc/Z7an9ZeKrLWKlBsLg7d1jCdR
         DRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4xcfgcrrBIcBhORUZhduWLLV8ym+o2ltWoOSy1l0dM=;
        b=pD+PWjsQ4z4fYc0YLEOjBI4O0YyEcm8VfZ3Ht66sztN2bUjnCaRSgUQIvJ0X6oR52C
         2JYwxHidLNUlVwRtzGsOp3leHJJdXbi3HAbnvCJ51awhYVO1pTL7fLGkvS57am27uaFm
         BYHg2DFnKSHNbCy31nt5lGIFkLK8GahZPNtotLFpisP6F8NDlR2A8IxPKHTt4tAZvn9v
         fOYwIWpwdR58rxyj/ngYhkfhlPvva7wbPKcHNYdcq2PLSmXc6gLimHMSjBhx0zOdXrA7
         Svq8SPGnBCQVQER/nTAJQB4y2hPFNEH7u1tdXl89e84RQTQd+qg3oOI1ArElOhT2NyYf
         B2rg==
X-Gm-Message-State: AOAM531CeJnnwOV8xYPBYhdaxoRu7s+Gc6JxvJRt5YVS6pC+4zxaFj9V
        brYU5SqxmmMuiJ7/0sIy6pqwAUmaUR+aJjaVjKVpHw==
X-Google-Smtp-Source: ABdhPJxTa9eC4SVYp5cPI1AafYblIVeFfmcM2kEMEeGV+24v4q+SQLojpBHxJ/Sxime8585xaXHpAYeuSO0HN/esCdg=
X-Received: by 2002:a05:6402:1102:: with SMTP id u2mr17013263edv.18.1610910158542;
 Sun, 17 Jan 2021 11:02:38 -0800 (PST)
MIME-Version: 1.0
References: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
In-Reply-To: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 17 Jan 2021 11:02:28 -0800
Message-ID: <CAPcyv4hGu3r=m+7Wkf3a94G=ZM4cQB87pt0ThadoUrk8cY7ovw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Make it possible to reserve memory on 64bit platform
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, kerneldev@karsmulder.nl,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>, gpiccoli@canonical.com,
        aquini@redhat.com, gustavoars@kernel.org, ojeda@kernel.org,
        ndesaulniers@gooogle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 2:43 AM Wesley Zhao <zhaowei1102@thundersoft.com> wrote:
>
> I was trying to reserve some memory to save logs incase that Android panic or hang and then
> I can read the logs from QNX side from the memory reserved before on the Qualcomm 8155 hypervisor platform,
> and I find the "reserve=" parameter only support 32bit,so I made some change and send these patches.

See Documentation/admin-guide/kernel-parameters.txt

        memmap=nn[KMG]$ss[KMG]
                        [KNL,ACPI] Mark specific memory as reserved.
                        Region of memory to be reserved is from ss to ss+nn.
                        Example: Exclude memory from 0x18690000-0x1869ffff
                                 memmap=64K$0x18690000
                                 or
                                 memmap=0x10000$0x18690000
                        Some bootloaders may need an escape character
before '$',
                        like Grub2, otherwise '$' and the following number
                        will be eaten.
