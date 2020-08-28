Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF72559FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgH1MXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgH1MXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:23:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B4C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:23:40 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so460075vsa.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+h+5XJ+em1JYNkK91WZyfQCnc3U3ITRWLKDQcz7Tz8=;
        b=Nk2iyxnX3VcxNGcUkNfIcs/0gqMCwNoJycWt9IuI72hQw1RDzGqQYv7T/Oci9THJPg
         YsMMWXtr8YQ7KsKBT36Oi7lM1LgchA/VZvPxFTBcCFQtxVh/gw0x3onsqlTtfi5PhfKv
         R+V/gIIDTMO/xIcnZfV3eS5Zd+KV+JAc0VjP+eOxgIGsySwx3cEJgIu5Thcl/c/sOacK
         UY9ynuhxom0XR3cLW31i2OeeFecjBDmU67bQbmlGl9u5FY6LzL14w5AAFFlROCh6GuNz
         sqk41UtOVvJrfnbDIcYXZ+ta3tieXLtw4292FTBf+++492g/DGSMpiVeowZXfWh0OGId
         Q6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+h+5XJ+em1JYNkK91WZyfQCnc3U3ITRWLKDQcz7Tz8=;
        b=OIKqn8c03AvV9cwiLBwi2qQ6lv20eGiDGXX78+Hy6Va/JjNOLl1/p6MFkaBTcY0E6d
         i8bWAOIii7Ocyy0kr4U3gdG8FHWZMZUjlFx0eckkRXDVLPm8SCmBSpc/QCiee3Xnhunf
         6fkbNrQrPwPQ3RRF9REwwuz74HCvY393eFYr7ZoI6LJigR6j4yt95h3xgrOXD+W6LFQd
         RQxU0VWKhCBKMvIry70hzWbSQ3RzgB+P8Ds4Im+d/ZYvt77S34THi7GCv8EhAC0PcbO2
         eAMORstoM/r7NaKrm6/L+ie4ptKFpIS8bvNjkP2d2pces4efky6jLvS41Txb2zn8ZTAK
         aYBQ==
X-Gm-Message-State: AOAM532Zk94a/MyjEn+asD/lbQcf8nznl6baZLvgHBQwYeaXXYq6QaXf
        yccymVRdnueS+1wnQa8h2FGKsmBns71zqCv5FYqWgQ==
X-Google-Smtp-Source: ABdhPJyjruMDViNwBvxoZ1ZSIkD9wSIeXDFzCU5GboJ6CETuh0DyRNRlHDBPQo2WEgCHhwlh2jCNV5uFFcOWjVVFIfw=
X-Received: by 2002:a67:f8ce:: with SMTP id c14mr634530vsp.14.1598617419004;
 Fri, 28 Aug 2020 05:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvUwH2FA9GOeA_7GYpLA31uOmEpg32VKnJ8-d5QSK4PdQ@mail.gmail.com>
 <20200827090813.fjugeqbb47fachy7@vireshk-i7> <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
 <20200827101231.smqrhqu5da6jlz6i@vireshk-i7> <CA+G9fYv=XLtsuD=tVR1HHotwpKLkbwZVyPr4UhY-jD+6-duTmw@mail.gmail.com>
 <CA+G9fYvSEHua0EpW64rASucWuS-U2STAZxufrfN75UDspGt2cA@mail.gmail.com>
 <CAPDyKFrpOqpBiSvkvO7sXHiQDOwdXYmx-80Ji5wW79QF-MrOuQ@mail.gmail.com> <CADYN=9K3D3OZ5T_K+6MfcgVLRoktPB6LvwDiXGj-+Zpq3faYfg@mail.gmail.com>
In-Reply-To: <CADYN=9K3D3OZ5T_K+6MfcgVLRoktPB6LvwDiXGj-+Zpq3faYfg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 14:23:02 +0200
Message-ID: <CAPDyKFpNVJZ0FddJ8naXYp-oZr-mYSOH-5iXG-wASZEFozBJJQ@mail.gmail.com>
Subject: Re: Kernel panic : Unable to handle kernel paging request at virtual
 address - dead address between user and kernel address ranges
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 12:29, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Fri, 28 Aug 2020 at 11:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 28 Aug 2020 at 11:22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 27 Aug 2020 at 17:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > On Thu, 27 Aug 2020 at 15:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 27-08-20, 11:48, Arnd Bergmann wrote:
> > > > > > > > [    3.680477]  dev_pm_opp_put_clkname+0x30/0x58
> > > > > > > > [    3.683431]  sdhci_msm_probe+0x284/0x9a0
> > > > > >
> > > > > > dev_pm_opp_put_clkname() is part of the error handling in the
> > > > > > probe function, so I would deduct there are two problems:
> > > > > >
> > > > > > - something failed during the probe and the driver is trying
> > > > > >   to unwind
> > > > > > - the error handling it self is buggy and tries to undo something
> > > > > >   again that has already been undone.
> > > > >
> > > > > Right.
> > > > >
> > > > > > This points to Viresh's
> > > > > > d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> > > > >
> > > > > I completely forgot that Ulf already pushed this patch and I was
> > > > > wondering on which of the OPP core changes I wrote have done this :(
> > > > >
> > > > > > Most likely this is not the entire problem but it uncovered a preexisting
> > > > > > bug.
> > > > >
> > > > > I think this is.
> > > > >
> > > > > Naresh: Can you please test with this diff ?
> > > >
> > > > I have applied your patch and tested but still see the reported problem.
> > >
> > > The git bisect shows that the first bad commit is,
> > > d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> > >
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > I am not sure what version of the patch you tested. However, I have
> > dropped Viresh's v1 and replaced it with v2 [1]. It's available for
> > testing at:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> >
> > Can you please check if it still causes problems, then I will drop it, again.
>
> I tried to run with a kernel from your tree and I could see the same
> kernel panic on db410c [1].

Anders, Naresh - thanks for testing and reporting. I am dropping the
patch from my tree.

Viresh, I suggest to keep Anders/Naresh in the cc, for the next
version. Then I can wait for their tested-by tag before I apply again.

Kind regards
Uffe
