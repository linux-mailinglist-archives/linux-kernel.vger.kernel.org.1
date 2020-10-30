Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D642A07BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgJ3OXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3OXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:23:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:23:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so5316525pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cEh0z2QaIyWyWgXHUZ4JK/bshMZzjcuaFOqXK8gUuYc=;
        b=oDxqWuIS8ID0QYyixwqfp11FwFGgtKEgz8N1otPs3YvMU7oYhErwXUGeJMScLXEBjz
         bUGDQfquO1h/VNeNeO6cyo5OCmX3C2uEyvRZOn05gsWJA8ksSTeVBKSNALcqsfSdp7Ux
         /EiVlH7VoxsKk/dD6bams+Y3trjVmgy6d8vGGh45US9ukYUrmIZffJBImOufAffB0f6w
         48LXwV3jd44K8dtdMhMCRshRwa6J78G5J1KqzYUEKPPElPl6WqsnN7McxxVvfNnTdfrs
         EwZHlfNmWY9XE2OalFTvemof28BWP1iFfpTTZy7aBmYrwFC+agLiAPPE8PxsVjFv32tn
         Nyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cEh0z2QaIyWyWgXHUZ4JK/bshMZzjcuaFOqXK8gUuYc=;
        b=ONXge8y53tq21Y+GqE3i0ctLJ/PWlF4YAzVdzKofR0VvnfLkKPR0NdfudzRfQUJ5Bx
         fQIzP8fvH7Qo7ZzIaV7ibdtm2VzHFNCxJAg3emYpWDDLvN04xyMheRfcG5jF46zLFOTP
         TffNDvGfIIInJnJ27hEu0dm+nosCjlnwzGIEjAHnFBxUyGdlgbjQEUs/hGP7xOtgz5IT
         ttPsMhf5R5Hc3pjialrWfne9snd6uduotlLDPH1wz+Z9ocbX2KMhlZE4pGGNQYQ6HOKl
         XPukJV9qzpfHAyfpKPQ+pTMZdUtuP1wehRRVZN1GdiczNuA+10XfX+lltJF/pDC3EGNv
         GRyw==
X-Gm-Message-State: AOAM533DrQzTwIRGln7uI47wrfoltc17NSsJg2YdZ4saD/PiFAUvX7QQ
        RsFlLWTKp9ZPasmlvscfPsE=
X-Google-Smtp-Source: ABdhPJxpNQUlnAq8JXfpSw3TIjQC8Jb0P8QyRyHVeqXjlqH8JHXqzBXyKMnWDepCeGmagD/1hE7ZXQ==
X-Received: by 2002:a17:90a:9313:: with SMTP id p19mr3261369pjo.90.1604067804955;
        Fri, 30 Oct 2020 07:23:24 -0700 (PDT)
Received: from localhost ([240e:472:3d00:779:b01a:f9a7:6a68:30ac])
        by smtp.gmail.com with ESMTPSA id z10sm6176358pff.218.2020.10.30.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:23:24 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 30 Oct 2020 22:22:42 +0800
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201030142242.r4jqhvtzh7hnahuv@Rk>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com>
 <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell>
 <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:04:44PM +0200, Andy Shevchenko wrote:
>On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:
>> On Thu, 29 Oct 2020, Coiby Xu wrote:
>> > On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
>> > > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
>> > > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>> > >
>> > > Have you compiled this with
>> > >     % make W=1 ...
>> > > ?
>> > >
>> >
>> > Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
>> > disabled. I'll run "make W=1 M=..." for each driver after adding
>> > __maybe_unused in v2.
>>
>> No, thank you.  Just keep it as it is.
>>
>> The current code is space saving.
>
>Perhaps you need to go thru __maybe_unused handling.
>There are pros and cons of each approach, but not above.
>
Can you elaborate on the pros and cons of each approach? There's
convincing reason to prefer __maybe_unused over CONFIG_PM_SLEEP
according to Arnd Bergmann [1],

> > By and large, drivers handle this by using a CONFIG_PM_SLEEP ifdef.
> >
> > Unless you can make an extremely convincing argument why not to do
> > so here, I'd like you to handle it that way instead.
>
> [adding linux-pm to Cc]
>
> The main reason is that everyone gets the #ifdef wrong, I run into
> half a dozen new build regressions with linux-next every week on
> average, the typical problems being:
>
> - testing CONFIG_PM_SLEEP instead of CONFIG_PM, leading to an unused
>   function warning
> - testing CONFIG_PM instead of CONFIG_PM_SLEEP, leading to a build
>   failure
> - calling a function outside of the #ifdef only from inside an
>   otherwise correct #ifdef, again leading to an unused function
>   warning
> - causing a warning inside of the #ifdef but only testing if that
>   is disabled, leading to a problem if the macro is set (this is
>   rare these days for CONFIG_PM as that is normally enabled)
>
> Using __maybe_unused avoids all of the above.

You option is valuable to me because I'm making a tree-wide change.

Currently there are 929 drivers having device PM callbacks,

$ grep -rI "\.pm = &" --include=*.c  ./|wc -l
929

I put all files having device PM callbacks into four categories
based on weather a file has CONFIG_PM_SLEEP or PM macro like
SET_SYSTEM_SLEEP_PM_OPS, here are the statistics,
  1. have both CONFIG_PM_SLEEP and PM_OPS macro: 213
  2. have CONFIG_PM_SLEEP but no PM_OPS macro: 19
  3. have PM macro but not CONFIG_PM_SLEEP: 347
  4. no PM macro or CONFIG_PM_SLEEP: 302

[1] https://lore.kernel.org/patchwork/comment/919944/

>--
>With Best Regards,
>Andy Shevchenko

--
Best regards,
Coiby
