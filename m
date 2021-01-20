Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA62FDA55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392803AbhATUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbhATT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:59:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14878C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:58:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m5so2878498pjv.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+k0SrfNNojXVlS+FWWsgz0nGxFtAPSlogEfBj1d6JA=;
        b=Y3gG8xOPJ8D+dF6VXJ17Q7dkXwg1bT0aTPLtMypbfI3wv7a7sePGgyGCScrhthaPMO
         4bQzz63E1fJ+0zuCS8rAhQyg1m19iQH4YyxWTbDTDP8DPwhoIQNei0waglqR4jhBZEIm
         /TNuqEzFCQCbtPIoldae4ZV7GJUClb+U0TrgqXiJp4fImKgH2ndDPTbGtvZ18Wjd8eFA
         pbZUjkWimd/fg6Yk6/V8F21JsGEQMiwsShVip6qVQlxm7wnK0EkbQCVlQhCtQqwTXc8a
         0dfaOvi3vstupvAEj8ya1KHb9CKiHwhooFc4D0mNp69PsEC21lY/z5bKsa1d/eofJEAS
         boBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+k0SrfNNojXVlS+FWWsgz0nGxFtAPSlogEfBj1d6JA=;
        b=Crnf11Ldqq5Lg+skPoqcktcoIYnBtMKbxq5RAJNEAWZ1BtwaIECSJ3YSWyYJFVIyP0
         aeeu9H23jbyxUsSost7+bgZ7w9b9NWb4TwoO+3R5PZUwMHao+faS+1UjPDvhorRaYvDr
         TARPtJaqmJI7IvQoIc7TQpPzpJgMojPASFDbUyOyFjFAhDyRqX3DPJLYQS0bZsRueUC9
         /YYvs1yLl7kkkCwwcrIQRajyjNXVzQUZPaLZ6UVVQheYEzV1+AJVl5gQgB3A2ZMJMOO0
         cULXNhnSIbGIpe23MAtYHcmegQB5nFm3UnJhKafLJY3G4UKVg6IRWMAKJCd0hS0MxLKp
         jkxg==
X-Gm-Message-State: AOAM530HxBSYiXMN+FjR1I7AmIPS/oNS0hZAbp5o0VCCcq60Xz1ahWsj
        3SHvCc0bUBAVbS59q+ITfuaOoWr4SuEdg0wW/9I=
X-Google-Smtp-Source: ABdhPJzf7p4CXCpKfQtwW28/zKqqGpnmvCQcBeJZt0n4T5Nj1R9T9wNVrGtLE4Euw8n3Al0xo6tHslFt6snjB0xmbSM=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr11408514pll.0.1611172704529; Wed, 20
 Jan 2021 11:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20210117212252.206115-1-hdegoede@redhat.com> <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk> <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
 <20210118133449.GL4455@sirena.org.uk> <a1ea81b6-8aff-274c-f1b2-a06a27650b25@redhat.com>
In-Reply-To: <a1ea81b6-8aff-274c-f1b2-a06a27650b25@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jan 2021 21:59:13 +0200
Message-ID: <CAHp75VeCSOxJr1qMoXj04hnXnZiXdG4PAQ9oaKJNHWXaTqCrVQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Christian Hartmann <cornogle@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 1/18/21 2:34 PM, Mark Brown wrote:
> > On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:
> >
> >> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
> >> not being able to do active low interrupts. In theory we could hit this
> >> code path on ARM devices using ACPI enumeration, but I don't think it
> >> is likely we will see a combination of ARM + ACPI enumeration +
> >> WM5102 + GPIO controller not capable of active-low interrupts.
> >
> > I've not seen this issue on any ARM based systems.
> >
> >> This overriding of the flags definitely is necessary on the Lenovo
> >> devices in question. I could add a
> >> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
> >> seems unnecessary.
> >
> > Possibly just an update to the comment to make it clear that some
> > firmwares might legitimately set the flag?
>
> Ok, I've extended the comment above the override of the irq-flags with
> the following paragraph for v4 of this patch-set:
>
>          * Note theoretically it is possible that some boards are not capable
>          * of handling active low level interrupts. In that case setting the
>          * flag to IRQF_TRIGGER_FALLING would not be a bug (and we would need
>          * to work around this) but sofar all known usages of IRQF_TRIGGER_FALLING

so far

>          * are a bug in the boards DSDT.

board's

-- 
With Best Regards,
Andy Shevchenko
