Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2926B208
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgIOWkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgIOWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:34:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6EDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 15:34:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so517824pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RefOWSaF/+yw4enLs3JNCZKSsuLRuxsPClHLLnrcCk=;
        b=bGjml3eDUh9hqjjXmz7B1idkmyKG5l0ER88thJ2VNXsmqILy2Syr3sVxQ4oHhRAdlJ
         GGKbFRnGwh6A4PtC0IDELU7DjpzOp+WRWw6K/aTZlluGf/6hUXvE1haWq8aRnW3ekzsk
         bNSNUIPlTmmrNfHDZvlGfHMT1e81BfWmlvWqpfmCp9LfluYGoC5SGQGXM/WDtL3Ml119
         gJgCWJrWxr06Aw5p9UYWHgrEv5v5ES3c2iTLcvct83AUXb5TFajLwN2tdny9hHsdh47b
         EoQgFxprLte03IcECGT9ft+v1W9htHRlmBkcbBZI7xAwAGip2uC6Oop+qI7GsrESPSOf
         TfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RefOWSaF/+yw4enLs3JNCZKSsuLRuxsPClHLLnrcCk=;
        b=XF6e1kCAcVHqE2qCKsz3rR+DLhoiEhjVZnq7PYcpw8J1UacLsOenccXkeqGuHHcnAY
         If+Nh9vUuvQhRZ9Vd1CNOek4prDkHHlkQjoyEoVw8wT0l56jJs78wQ2scEYHELKFHsd6
         dVIGgvSGXLxw1OD9CaE1cJqRxyXvoBuF6EhvzXWluH5MjRHibS+484AuHYaVE/ek7f2E
         7G5AUPENOPMDd8H64VkUQ+VnXbw+Ak+aoey/IcfXe7z6+cTnOdhfnpxknq7q14NYmb90
         wabKeWEefxey2Bnm67V99Xi3YZR9u7tp3ErI/cPSQZbEq8+Yz7NvipoqKCpWOTXfrmjo
         FLZw==
X-Gm-Message-State: AOAM530qd6AHKhcrWlBM4mjMZvlpcmY55TIitKMukU8rrI0BDWHjAHrR
        kOKNkQglkkMLl6OZFlaPVRLRmbMKnVcZiKBrHOBQgQ==
X-Google-Smtp-Source: ABdhPJwKiRTrSlUSc+vkxAbQQs3GrsBGedZYrAtFykksTYJsgwv9CZtXL8WVdLugXl5OsyjVT2t2/szjoJ2s5PbMTU8=
X-Received: by 2002:a17:902:7295:b029:d1:e3bd:48cc with SMTP id
 d21-20020a1709027295b02900d1e3bd48ccmr5124412pll.10.1600209292167; Tue, 15
 Sep 2020 15:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic> <20200915210231.ysaibtkeibdm4zps@treble>
In-Reply-To: <20200915210231.ysaibtkeibdm4zps@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 15:34:39 -0700
Message-ID: <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:02 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> panic() is noreturn, so the compiler is enforcing the fact that it
> doesn't return, by trapping if it does return.
>
> I seem to remember that's caused by CONFIG_UBSAN_TRAP.

Indeed, if I remove CONFIG_UBSAN_TRAP from the 0day report's
randconfig, these unreachable instruction warnings all go away.

So what's the right way to fix this?

CONFIG_UBSAN_TRAP enables -fsanitize-undefined-trap-on-error  (not
sure why that's wrapped in cc-option; it shouldn't be selectable via
Kconfig if unsupported by the toolchain).

Should clang not be emitting `ud2` trapping instructions for this flag
for no-return functions?

or

Should objtool be made aware of the config option and then not check
traps after no-returns?

I suspect the latter, but I'm not sure how feasible it is to
implement.  Josh, Marco, do you have thoughts on the above?
-- 
Thanks,
~Nick Desaulniers
