Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32A02CEFE0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgLDOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgLDOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:40:43 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:39:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y7so6861247lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sWIE6MSVnFN2Z1SFZ8QW/N7guFxVpjF1mW79UulhJs=;
        b=RfcUNAfKbPRmMKo7OcV+vcKhf8gkhXXWbgOjRQECyb79B5Kr8J55uu34UsLfxxUPom
         7NEJDhsiYI7XXFxNqQi/41lLal9d1LYqnr2vQSWhl3ZGT+woctsjPXr9Xr09HeUYzwTH
         4sYKrvzexNplNWsyr+AQys2/4I7jeyHKWANdgJPA6jBiijImp0602h+mSteHCWlDfmdQ
         YXwBsfYJFRRA/jFkwq66l0qkO33EWCS+8WPE3EkBo2bnFfj2+Uqy0cJgUfub/OsjLexQ
         u9GN3Y0hEQuLeV1vRg2wJQtiSAp8QqgrVOF0XuFxzBGyVyWGORmIgknoFXE6kB3bnUWZ
         7dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sWIE6MSVnFN2Z1SFZ8QW/N7guFxVpjF1mW79UulhJs=;
        b=G11CNwQnI6WuWBX/HNthhltQQj219i0cQHjUCyWCcY0MgS/s+zICeDINDo8XdPduI3
         5AuJICTwvYYTiby43ClRg6lPOfx3otuMjaOaOxZOtS7Ny+mHyqWru7tefG5vi0QrSFjN
         ecuqW9SXZS0RrUdE2Yn2xyGUKxBz4nmuV0vf/ft/wKJKp+G+MZSvo1W5ktXQxr0evHwh
         RKHxF4/LE6/sPpVf7yQNfPlT9uEO9jz8uBjTgdieTODNnG1ECTIUo+9rkAsN6/yufTMh
         EjPsSR6/Kbka+3Vsx3ulw5oo1o71MBdIFOPowLzyUiAevRsoE4LoOqP5iegY9hT3VfLW
         mRXQ==
X-Gm-Message-State: AOAM533cGEQDtv8sIv6EAQavIBCFNO7X+X+bauiFol6w9do0rXy1BQe3
        k413yursFWhodikB+EaTkxzFSmxvMb56C9q93S5i0w==
X-Google-Smtp-Source: ABdhPJyskVYAzDS48JDvWbmfiXfOC8BuBYtUHBD5BXTQ5EFVNcQqiqycMB0UDj7GVEp894YzQizdbfY9OTD5WfpyvaY=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr3697375lja.68.1607092769314;
 Fri, 04 Dec 2020 06:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org> <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
 <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
In-Reply-To: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:49 +0100
Message-ID: <CAPDyKFqS5touMvORyovCS-QQrHZg+0LGob9DtS1m61quvXYezw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 15:14, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Dec 4, 2020 at 11:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:
>
> > > -#ifdef CONFIG_PM
> > >  static void msdc_save_reg(struct msdc_host *host)
> >
> > Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" as well?
>
> There is no need since the compiler can figure that out already when there
> is a reference to the function from dead code.

Alright, thanks for clarifying.

>
> > >
> > > -static int msdc_resume(struct device *dev)
> > > +static int __maybe_unused msdc_resume(struct device *dev)
> > >  {
> > >         return pm_runtime_force_resume(dev);
> > >  }
> > > -#endif
> > >
> > >  static const struct dev_pm_ops msdc_dev_pm_ops = {
> >
> > You may also change this to a __maybe_unused, as long as you also
> > assign the .pm pointer in the mt_msdc_driver with
> > pm_ptr(&msdc_dev_pm_ops).
> >
> > Ideally the compiler should drop these functions/datas entirely then.
>
> I don't see a lot of other instances of that yet, and it's fairly new.
> Maybe we should fix it before it gets propagated further.
>
> I would suggest we redefine pm_ptr like
>
> #define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)

Why is this better than the original definition?

>
> and remove the __maybe_unused annotations on those that we
> already have. This also has the effect of dropping the unused
> data from the object, but without having to an an #ifdef or
> __maybe_unused.

I didn't quite get this (sorry it's Friday afternoon... getting
tired), can you perhaps give a concrete example?

That said, I have applied your patch for fixes, but let's try to sort
out the above to make sure we are all on the same page.

Kind regards
Uffe
