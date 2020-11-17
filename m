Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809032B6B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgKQRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKQRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:15:25 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C540EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:15:23 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id x13so6762346uar.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYSb0M0fe9VUi0Yz4rN2g/1snkt7mWNkgZy0eLYCtxw=;
        b=T/laoseh6koUPxSpKTpKUbL/ofH4XlN3e6fbu4/QbEK1o2Xmq7cJt/tP66EXZtFiBa
         DwUNIkT2bd5fl3g+LgEritIPR3J86JOYC3X4kEs8dawSy9q480jQD63ZgvdANMRNNnuB
         7UXrLsOUdIopkr1Z0KYMrHOoWFu+z2a9ic/AsQVnBCJYRTvTzSilQmUAJTUffr7cDhpQ
         PfLJT4np+Cbyift0EAxQ7IQJuJ0r19pDREoQQiwehj8VZfGv9QUitIfnlPyaWkAoIhNA
         K9tzDtRXlQSaYLQhsBPAet2WRlN/PWx5yNEU+c+eZ1G3BCQBXaHL8mUr2ZecH7QdeLn+
         ASiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYSb0M0fe9VUi0Yz4rN2g/1snkt7mWNkgZy0eLYCtxw=;
        b=jUXPEaY5iZqRskphSsDWq/iktFUgk8aSNM68az4/vQZUwAF3sMMLwH75YVGNWMvzAm
         v9Uru5iTrwaNOgrO17FAPTO0c87dlpUsqxHwmDGGjd5jkuJEyIwJ6h1hl3q4nAzqDIRl
         dcmSMve6QGF9bN7KodxBxn56ApAZzz/AeZFbSOeWx91ryIPFZJ+a27EFTBjoZsuFjhVI
         y23rlAu4Y5iyoJ+1ffuC2NGQX2Yn5gtw5OUH2++XDvKSgcENekfWvDXEjHEba1IxcP7D
         hmKEujHg84qZKASUvb5HQ6BoQf74YbP6kkNDDzmcsqEqHX6GuGcMsy2RtD0Qo/zUJs7C
         xcEA==
X-Gm-Message-State: AOAM531mh/QVsWbp+2MJKKp1cTXv/YhrI30y2Ttno5m+VxieKjrskuue
        I3JGrEcjqtsty1x7R2BO25+vUhv4tGOe0MImx0qeBQ==
X-Google-Smtp-Source: ABdhPJwmehKHszhtCrvkt107pRksUJsS/ubL0KFY0b6kTiGnGtqW1O2aFcJhTI5DeQaBzbUxtzy41vhjXrzVvPZEfOs=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr593298uaj.104.1605633322970;
 Tue, 17 Nov 2020 09:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
 <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com> <DM6PR11MB2876A043535B8EDE5286FBB0B8E20@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2876A043535B8EDE5286FBB0B8E20@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 18:14:29 +0100
Message-ID: <CAPDyKFp1nR_Qx5p+ou1cZns9MvLVWD5bTuFCkMpu_EbHxh1Opw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 14:46, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi Ulf,
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Tuesday, November 17, 2020 7:27 PM
> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >Cc: linux-mmc@vger.kernel.org; Linux ARM <linux-arm-
> >kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Raja
> >Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan
> >Mohamad, Wan Ahmad Zainie
> ><wan.ahmad.zainie.wan.mohamad@intel.com>; David E. Box
> ><david.e.box@linux.intel.com>
> >Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay
> >SOC
> >
> >On Mon, 16 Nov 2020 at 15:22, Zulkifli, Muhammad Husaini
> ><muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> Hi Ulf,
> >>
> >> Thanks for your review comments. I replied inline
> >>
> >> >-----Original Message-----
> >> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >> >Sent: Monday, November 16, 2020 7:41 PM
> >> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >> >Cc: linux-mmc@vger.kernel.org; Linux ARM <linux-arm-
> >> >kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >> >kernel@vger.kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>;
> >> >Raja Subramanian, Lakshmi Bai
> >> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
> >> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; David E. Box
> >> ><david.e.box@linux.intel.com>
> >> >Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops
> >> >for Keem Bay SOC
> >> >
> >> >On Fri, 6 Nov 2020 at 05:10, <muhammad.husaini.zulkifli@intel.com> wrote:
> >> >>
> >> >> From: Muhammad Husaini Zulkifli
> >> >> <muhammad.husaini.zulkifli@intel.com>
> >> >>
> >> >> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations
> >> >> handling") introduces platform specific SDHCI clock operation.
> >> >>
> >> >> This patch declares the clock operation for Keem Bay.
> >> >> Add clk_ops for SD, EMMC and SDIO operations.
> >> >
> >> >The above commit message doesn't really tell why or what goes on here.
> >> >Can please try to clarify that.
> >>
> >> We missed out the clock operation handling patch (Commit 16ada730a759)
> >> and did not handle the clk_ops  for Keem Bay SOC devices.
> >> These 2 patches (Commit 16ada730a759) and (Commit 36c6aadaae86)  are
> >merged at around the same time.
> >> We catch the issue later when trying to boot into v5.10-rc1 with Keem Bay
> >EVM.
> >> That is why I created this patch to handle the clk_ops for Keem Bay devices.
> >
> >Alright, so the previous changes were simply not sufficient to complete the
> >support.
> >
> >>
> >> >
> >> >>
> >> >> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel
> >> >> Keem
> >> >> Bay")
> >> >
> >> >Is $subject patch fixing a bug/regression?
> >>
> >> This is to fix issue on previous commit. It is a bug fix.
> >
> >Has it ever worked?
>
> Yes it is working. Tested with Keem Bay EVM.
> SD/EMMC/SDIO devices registered successfully with this fix.

I am not asking if $subject patch makes it work, I understand that it does.

>
> >
> >Did the commit you point to with the fixes tag, break some other existing
> >functionality?
>
> It should not break other existing functionality.
> This is specific for Keem Bay SOC only.

So, you are saying that it has never worked for Keem Bay? But $subject
patch makes it work?

Can you please re-spin and update the commit message to better reflect
what goes on, then I can apply.

Kind regards
Uffe
