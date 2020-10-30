Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C702A07F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgJ3OeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgJ3OeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:34:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C3C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:34:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o3so5344854pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aw/VF12mK0i6Qcr+s24GfzXWS/XgMV9QCU8EN9tQ+Kc=;
        b=h0HxsmW6ed7k6XoRD+SXKe7j/wgUC3VJY/H69Wh9al5l5EcQCfsnYEZL1EY0oru0j0
         OTXN2SoMMhVc8u+JtShuzVueOOqHKaFAVbXHt1YtHrpZaLyafCAdvEEIDg0jSXFTjsVh
         j4xhD3NAmEhE4rtMNfc/vq5jNvRtocZcXSUIR/XL90H6yaTGsPWmKnPa/iKmolOLpccU
         fAPbFDKqnpMUj2ao+7ici6JSsPLIe0VGwmTj75kWVs3b8iUdA8DQCfYTVHM0OAIzyeNs
         HCHB3FHAob5dBEH7Q+zpJIwL+YeCGurCUWqHOPclDbEuwt7Diisg8a2ud482JtYIp+0H
         ImZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw/VF12mK0i6Qcr+s24GfzXWS/XgMV9QCU8EN9tQ+Kc=;
        b=cMN7WuofHS0k91AZ/qsWHQyOvdKDu+fX5NZV7t/2A1AIahGEh1S7AbQNBCSQgGjcyZ
         60du0kQ2KqnoakPONhuMkwlV2lM6DP4Sf5NLKS4TAUq0Fx0MFWYeceN2p72ycJ3H/Q7F
         807txzWKYnOqhZvhBLy0zpQs9fH7imitBYGTUdjLb9/isL9ZwmJkap4IxYeRHdq25/Dm
         sUTXPaHSK6zdPEMD89jM9vn6AfKnNxBge2Ck9RWwU3Kr/W45Jk32VmSf+xfX+gmd/S0i
         /oY0kKHYr11Qi1EjEBetC0uXSp+klioEBTnE4g1M6Gv6W3shIpTh//02eBROSsThO4rr
         sg+A==
X-Gm-Message-State: AOAM5302IAOw7bcFcLOViA9UE8nxpk99AhsB9UmNKy0PVGhKAtVWJVmF
        ycnsBBMhTfjXHlGu6/D0BtshP22QUpvn28VYWpRWjMlGjVA=
X-Google-Smtp-Source: ABdhPJxY/TdlQkvOVEcGRXnHnLHjsX/ZAjmEI8PHDGmCk/Xd6r0Gqm8rZ99E+lcArVp2gdGhskPtAlGv1y+iwxXDQT8=
X-Received: by 2002:a62:343:0:b029:15c:e33c:faff with SMTP id
 64-20020a6203430000b029015ce33cfaffmr9148758pfd.7.1604068445385; Fri, 30 Oct
 2020 07:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201029100647.233361-1-coiby.xu@gmail.com> <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com> <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell> <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
 <20201030142242.r4jqhvtzh7hnahuv@Rk>
In-Reply-To: <20201030142242.r4jqhvtzh7hnahuv@Rk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Oct 2020 16:34:54 +0200
Message-ID: <CAHp75VcqPh4fWhdLYaETmgh0jvS_m9vzXgppgZX2nE8avSGymA@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:23 PM Coiby Xu <coiby.xu@gmail.com> wrote:
> On Thu, Oct 29, 2020 at 07:04:44PM +0200, Andy Shevchenko wrote:
> >On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:

...

> >There are pros and cons of each approach, but not above.
> >
> Can you elaborate on the pros and cons of each approach? There's
> convincing reason to prefer __maybe_unused over CONFIG_PM_SLEEP
> according to Arnd Bergmann [1],

First what comes to my mind. Perhaps more, but somebody else may
extend / correct below.

ifdeffery (pros):
 - compiler doesn't need even to look at that code

ifdeffery (cons):
 - if depends on configuration and thus harder to test coverage

__maybe_unused (pros):
 - removes ugly ifdeffery in the code, increases readability

__maybe_unused (cons):
 - it's a burden for compiler (increasing compilation time) and to
linker (to drop the section)


-- 
With Best Regards,
Andy Shevchenko
