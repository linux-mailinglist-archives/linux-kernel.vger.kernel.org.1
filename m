Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE62C20EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgKXJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgKXJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:12:19 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:12:18 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m9so16904785pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnkrvzjGaZpOvYHvxOZGnFaqpCbly6IyuUX8y1JLV34=;
        b=iJWDXdP0Yl7fg/b6lAhLnu7BQkcZ5b/VoBWvOppnEzGB6B93Mv1fUFXu+NEmyIv3pV
         88/58ioU6xEmaje4RQ8BaFwjdmWNzbT6O3ds19HcP52egrg25BgxS6ID88xP7o5naUx7
         YeNE9F9oDc3Kdrv/ZJcljA69FMHUQXj9slqM26jVwvf2KqM7r/LJSK0WBAcOJqlJ4gw3
         ZNRCaUvxOajIKoPdXzflUcbNjAO83ij2cntHJuyR3c+aXbgcXSGrQQTt0VEGE95p0MBQ
         cyOWNxbSmvVPKGMnYcfWwDmkdk/NzicJnOMwHvY4ngBq2bRi8gXTHm590ps3UCdyndsI
         +sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnkrvzjGaZpOvYHvxOZGnFaqpCbly6IyuUX8y1JLV34=;
        b=d26f6DrrD0GA+c7S0KmP0ar32IC1Gu7U4DCy1ISCh0EZv84JnxDjL4M1msHKUKYEji
         a9uZyEkKDEaDgCo2XOICXNd4aUHdPLqSIghHdPqgyUMWv54xXKDI3nuYoSO07zGOU5kX
         p6fjfgSXWyD23EOcxtScUF7PGfVmGZd95mCHcuoXeii38RDDeDSod7+ODiKjlCBzF764
         8dTT5afnM5P0eSaIy2ndcS14Xe+LoOiMwgDBwW9GHvulaHJC/3lAOgFPiYVX9gUiEfRd
         8IUXgsRkmcgdIgbtfEefU8MM8dMkwY8o+OF7yC/dvCnu/DKcW7FIJz0mds1n2I/EoJaS
         Zaqg==
X-Gm-Message-State: AOAM530+BCKgZ58OlPybIYXmduhScesHoMYAgGq7WY0Rta8nz/mYKVHJ
        Lk7wcH6IaeakysVLNfrSPpaTmKoaBpe/JW+5Tso=
X-Google-Smtp-Source: ABdhPJz/26g5+bFLzfQRwhQmkzrUNBhAu3bSuSdgi0MqSTPolVRT+xnEEx4sUB+zbdl1/si3rDLzGeDylXORrZ89z6k=
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr3913508pjh.228.1606209138147;
 Tue, 24 Nov 2020 01:12:18 -0800 (PST)
MIME-Version: 1.0
References: <202011220325.oB7oeTEq-lkp@intel.com> <20201123105317.GZ4077@smile.fi.intel.com>
 <8cb2dcbdef2446238c6a1fe8e8b74504@intel.com> <d848db76-a351-ecd7-2755-d268e1b335de@intel.com>
In-Reply-To: <d848db76-a351-ecd7-2755-d268e1b335de@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Nov 2020 11:13:06 +0200
Message-ID: <CAHp75VfxWwHja+QG-9Fhkh=6nd18RahgkS96SDL+y_uTR8o+jA@mail.gmail.com>
Subject: Re: [kbuild-all] Re: sound/soc/intel/catpt/loader.c:654
 catpt_first_boot_firmware() warn: consider using resource_size() here
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:06 AM Rong Chen <rong.a.chen@intel.com> wrote:
> On 11/23/20 7:41 PM, Rojewski, Cezary wrote:
> > On 2020-11-23 11:53 AM, Andy Shevchenko wrote:
> >> On Sun, Nov 22, 2020 at 03:52:27AM +0800, kernel test robot wrote:

...

> >> This sounds like false positive. From where it gets the idea of resource_size()
> >> for the *start* offset?!
> >>
> > Indeed it is false positive. I've already explained this in:
> >
> > RE: [bug report] ASoC: Intel: catpt: Firmware loading and context restore
> > https://www.spinics.net/lists/alsa-devel/msg117145.html

> Thanks a lot, we'll ignore the warning next time.

I think the proper solution here is to notify smatch upstream to fix the tool.

-- 
With Best Regards,
Andy Shevchenko
