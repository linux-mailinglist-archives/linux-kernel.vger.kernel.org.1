Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC32C23F46C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHGVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:33:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:33:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so2870353wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kb51K/JMx93SnPedI+EIdFTSAF1IqBeo/q6vamdS4A8=;
        b=j5fGpkuVmHIE5Ps7zFBfy2Pdo1F76BJ2oz5uWWb95k6tuAOeu9Lp4hnY+11pqXqX1f
         eW1WZpc91IM6WYWcp4j7Pc0/kUgOqrwv13XpEAuwqgjmvnwoIIzpfOy3OE4k4/KCmI8w
         ra9stYzuUfw82bKAJG8gGxGsX6WJE2a3T138c12Td/HoyQKB2GU84ST0lk/zf/LbdF/d
         IBWP4IIg1oHczrZH/o2MdqLogojr6xaCupKt9SwIPIiPSkUipTJx5ONXLtq+8Og5YlNT
         8S80SBjxPsK8ALFVuDrRJDapxKxuC1Z1yAZquhI6AWArhrAHO3gS9bAYqZpoMK3/hxu6
         mVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kb51K/JMx93SnPedI+EIdFTSAF1IqBeo/q6vamdS4A8=;
        b=CX76/v7U6RezzJF8EE1sA/NPZZ/n5+HhhpbeeKEtvb4tAUa/FV3LCp9rjnSGmfExJO
         cePM0cGA/NJzNl+imogAQb+Yv6ES22rFuFsAzHNmiVzNeWuqWhCfaAZzS3lfpzeXvIeA
         GgqxAKSxZu3g57nzuvFLjTe7OSs9ySGJkFanONQQyzLxXrkK/v38IB3vQ6v6WuXK0UNz
         tOPcwsuwoe38+PfyB6y0lwbtIP35waBs67K4w7GPeFi2Rfs2g1ADSFIXGNxZJ6Upr8q3
         dhzPwpW/+ERE29wO64g/7t7WiNN77ECScGczACXa+Mbj2iEkvSb3HV5/zdz4TaN7BpRj
         y5jg==
X-Gm-Message-State: AOAM530GA8HCUzS7Jv/QfxniRzspSubIWeR34p3/n9APsbS01RyQO+Cc
        1ZYPwQ0n2puF/zS8G0S6LsTt4hSmCOpqdjj9gVGeRQ==
X-Google-Smtp-Source: ABdhPJxXQmEyH/oQ6CHELZFCo1U1iD2D6vbAatj8wgGfSPKfqffSXXd1hCvHhnXMVMh8U7IDXpV1HbyO9BWtNAzpZjA=
X-Received: by 2002:adf:f511:: with SMTP id q17mr9909904wro.414.1596836001220;
 Fri, 07 Aug 2020 14:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200806094440.14962-1-98.arpi@gmail.com> <CAHp75Vdpyr=LiOsjgoJ1YscrvFwivtfg58dePtF9aQDYp6V9-A@mail.gmail.com>
In-Reply-To: <CAHp75Vdpyr=LiOsjgoJ1YscrvFwivtfg58dePtF9aQDYp6V9-A@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 8 Aug 2020 05:33:09 +0800
Message-ID: <CABVgOSmXFZL+uxKY9yAn9JVzChZxQDsucSQGAGBxM6OpOkCwJg@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_hexdump.c to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:53 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 6, 2020 at 12:48 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >
> > Converts test lib/test_hexdump.c to KUnit.
> > More information about KUnit can be found at
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > KUnit provides a common framework for unit tests in the kernel.
>
> > -config TEST_HEXDUMP
> > -       tristate "Test functions located in the hexdump module at runtime"
>
> We have a nice collection of tests starting with TEST_ in the
> configuration, now it's gone.
> I'm strongly against this change.
> Code itself okay, but without addressing above - NAK.
>

This change is to make the test naming compliant with the proposed
KUnit test naming guidelines:
- https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/

The hope is that tests built on KUnit will all end up with the same
[x]_KUNIT_TEST config options (which at least preserves the
consistency of the test naming, even if they'll not all sort
together), and should make it easier for people to know that the test
results will be in a common format, and that the test can also be run
using the KUnit tools.

The naming guidelines haven't been upstreamed yet, though, so we'd
definitely appreciate input on that thread if you've got comments more
broadly than for this particular patch. Ultimately, I don't think it
matters too much what we end up using, but having some consistency is
the goal.
