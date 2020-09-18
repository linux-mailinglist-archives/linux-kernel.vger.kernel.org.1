Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FB26EA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIRBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRBPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:15:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:15:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so2370717pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye9U5Z1Xjhjxx6IHX1IF2aylGGOYm0oyrokW8q8w0DQ=;
        b=ln85D9+ocg96bPbLhAqGNIF2WN8J1MzqBJeNW3yDfVw1L0TYlhR3EFzlC8LdFSc5Bj
         Xd7PALIluOFzaCjJ8QhQY1YD6qffI2IL8UcxSbtx5WfdJZjo3hm8wAR+JIEG4Z3h3CvB
         4q8F1CgNfEzhIQYysGIfrt7meA4zkKs+nfBrKzS4GxHY/h6tpD5piudvbFvZGpe4zhys
         QXiKjVMDRn99kdLjN7Ww/YobEpwu3QouVcYPNcrwrtblAXD504Wy0FNyNesv6K7cs3ZM
         3HI/zG+hDw1q9WwznfrZCIoG9DW1UTPqzpy8JTNuCkBaE2ugxbMhsr+5JF183L5NpNvQ
         TBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ye9U5Z1Xjhjxx6IHX1IF2aylGGOYm0oyrokW8q8w0DQ=;
        b=SAKJACbkzdEKCwBElw3ubrJovk1PKY0eh9/N2gk5Ci26ZF+4wqpAF+glSR1iK4LArE
         ostakdxyehxqpeznjrT093vCdkzH+rkil4u/LHSb5HDw1CvtBY7W14VL9XjGLEjkzpX9
         90B3FL9aS2TnW5xv/7nzGnrxmg59FestAskJn79zFjBUAwgHvTH9CQi/8DuptriTeOCw
         XkhH/RDYFXcyJV8oZglKDToIBuvQxzLtB/5mYILV1LY4Lfd7MWsqVY6UBo7pxI/lbCFR
         yYqffGqta/3FMYvoGeVeJKQrgayIVde9fHRlITLQX+SYD13uZSJ30EGvIEn1xcGuSCY6
         jEaw==
X-Gm-Message-State: AOAM531dt27feLfWfMsv1kbph9K9xzZswhYFSgv113g1VyuLOfNeQTZF
        3bnORXB14SkC4+ZfMYx0o17g9w==
X-Google-Smtp-Source: ABdhPJxlAjX5BNF1kLdlQa+6107QR/meVQ372dneIBIcNaEjGttWd6yMJcS81tMpZIMBK9MPzfZAgg==
X-Received: by 2002:a62:3706:0:b029:142:2501:39e5 with SMTP id e6-20020a6237060000b0290142250139e5mr14250349pfa.52.1600391707896;
        Thu, 17 Sep 2020 18:15:07 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id 126sm892191pfg.192.2020.09.17.18.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 18:15:07 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:15:02 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200918011502.GA27646@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
 <20200917051253.GA3094018@laputa>
 <CACT4zj9LuJoy9mX4Fqm+jZf1bDa5oUZcR6mPa-otW1mXfNLh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4zj9LuJoy9mX4Fqm+jZf1bDa5oUZcR6mPa-otW1mXfNLh1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

On Thu, Sep 17, 2020 at 06:12:27PM +0800, Ben Chuang wrote:
> Hi Takahiro,
> 
> On Thu, Sep 17, 2020 at 1:12 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Adrian, Ben,
> >
> > Regarding _reset() function,
> >
> > On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> > > On 10/07/20 2:10 pm, Ben Chuang wrote:
> > > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >
> > > > In this commit, UHS-II related operations will be called via a function
> > > > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > > > a kernel module.
> > > > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > > > and when the UHS-II module is loaded. Otherwise, all the functions
> > > > stay void.
> > > >
> > > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >  drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 136 insertions(+), 16 deletions(-)
> > > >
> >
> >   (snip)
> >
> > > >     if (host->ops->platform_send_init_74_clocks)
> > > >             host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> > > >
> > > > @@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >     }
> > > >
> > > >     if (host->version >= SDHCI_SPEC_300) {
> > > > -           u16 clk, ctrl_2;
> > > > +           u16 clk;
> > > >
> > > >             if (!host->preset_enabled) {
> > > >                     sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > @@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
> > > >                     /* This is to force an update */
> > > >                     host->ops->set_clock(host, host->clock);
> > > >
> > > > -           /* Spec says we should do both at the same time, but Ricoh
> > > > -              controllers do not like that. */
> > > > -           sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > > -           sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > > -
> > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +               host->mmc->flags & MMC_UHS2_INITIALIZED) {
> > > > +                   if (sdhci_uhs2_ops.reset)
> > > > +                           sdhci_uhs2_ops.reset(host,
> > > > +                                                SDHCI_UHS2_SW_RESET_SD);
> > > > +           } else {
> > > > +                   /*
> > > > +                    * Spec says we should do both at the same time, but
> > > > +                    * Ricoh controllers do not like that.
> > > > +                    */
> > > > +                   sdhci_do_reset(host, SDHCI_RESET_CMD);
> > > > +                   sdhci_do_reset(host, SDHCI_RESET_DATA);
> > > > +           }
> > >
> > > Please look at using the existing ->reset() sdhci host op instead.
> >
> > Well, the second argument to those reset functions is a bit-wise value
> > to different "reset" registers, SDHCI_SOFTWARE_RESET and SDHCI_UHS2_SW_RESET,
> > respectively.
> >
> > This fact raises a couple of questions to me:
> >
> > 1) Does it make sense to merge two functionality into one, i.e.
> >    sdhci_do_reset(), which is set to call ->reset hook?
> >
> >         -> Adrian
> >
> > 2) UHS2_SW_RESET_SD is done only at this place while there are many callsites
> >    of reset(RESET_CMD|RESET_DATA) in sdhci.c.
> >    Why does the current code work?
> >
> >    I found, in sdhci-pci-gli.c,
> >    sdhci_gl9755_reset()
> >         /* reset sd-tran on UHS2 mode if need to reset cmd/data */
> >         if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> >                 gl9755_uhs2_reset_sd_tran(host);

(A)

> >
> >    Is this the trick to avoid the issue?
> >    (It looks redundant in terms of the hack above in sdhci_request_done()
> >    and even quite dirty to me. Moreover, no corresponding code for gl9750
> >    and gl9763.)
> 
> GL9755 currently does SD reset and UHS-II reset together.

Do you mean that, in UHS-II operations, you need only the reset on
SDHCI_UHS2_SW_RESET register?
But the hunk above (A) does the UHS-II reset along with UHS-I reset.

> There is no UHS-II interface on gl9750 and gl9763e.
> 
> >
> >         -> Ben
> >
> > 3) (More or less SD specification issue)
> >    In UHS-II mode, do we have to call reset(SHCI_RESET_ALL) along with
> >    reset(UHS2_SW_RESET_FULL)?
> >    Under the current implementation, both will be called at the end.
> >
> 
> As I know, the UHS2_SW_RESET_FULL is only for UHS-II.
> Can you list the lines that reset(SHCI_RESET_ALL) and
> reset(UHS2_SW_RESET_FULL) are both called?

I was not clear here. (The above is also another example.)

Look at sdhci_remove_host() and shdci_uhs2_remote_host().
If the argument 'dead' is 0, we will do both of the resets for UHS-II.

-Takahiro Akashi

> >         -> Adrian, Ben
> >
> > 4) (Not directly linked to UHS-II support)
> >   In some places, we see the sequence:
> >         sdhci_do_reset(host, SDHCI_RESET_CMD);
> >         sdhci_do_reset(host, SDHCI_RESET_DATA);
> >   while in other places,
> >         sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> >
> >   If the statement below is true,
> > > > -           /* Spec says we should do both at the same time, but Ricoh
> > > > -              controllers do not like that. */
> >   the latter should be wrong.
> >
> >         -> Adrian
> >
> > -Takahiro Akashi
> >
> >
> >
> > > >             host->pending_reset = false;
> > > >     }
> > > >
> > > > @@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> > > >                               SDHCI_INT_BUS_POWER);
> > > >             sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > > >
> > > > +           if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +               intmask & SDHCI_INT_ERROR &&
> > > > +               host->mmc->flags & MMC_UHS2_SUPPORT) {
> > > > +                   if (sdhci_uhs2_ops.irq)
> > > > +                           sdhci_uhs2_ops.irq(host);
> > > > +           }
> > > > +
> > >
> > > Please look at using the existing ->irq() sdhci host op instead
> > >
> > > >             if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > > >                     u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > > >                                   SDHCI_CARD_PRESENT;
> > > > @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
> > > >             /* This may alter mmc->*_blk_* parameters */
> > > >             sdhci_allocate_bounce_buffer(host);
> > > >
> > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +       host->version >= SDHCI_SPEC_400 &&
> > > > +       sdhci_uhs2_ops.add_host) {
> > > > +           ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> > > > +           if (ret)
> > > > +                   goto unreg;
> > > > +   }
> > > > +
> > >
> > > I think you should look at creating uhs2_add_host() instead
> > >
> > > >     return 0;
> > > >
> > > >  unreg:
> > > > @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
> > > >  {
> > > >     struct mmc_host *mmc = host->mmc;
> > > >
> > > > +   /* FIXME: Do we have to do some cleanup for UHS2 here? */
> > > > +
> > > >     if (!IS_ERR(mmc->supply.vqmmc))
> > > >             regulator_disable(mmc->supply.vqmmc);
> > > >
> > > > @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
> > > >             mmc->cqe_ops = NULL;
> > > >     }
> > > >
> > > > +   if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> > > > +           /* host doesn't want to enable UHS2 support */
> > > > +           mmc->caps &= ~MMC_CAP_UHS2;
> > > > +           mmc->flags &= ~MMC_UHS2_SUPPORT;
> > > > +
> > > > +           /* FIXME: Do we have to do some cleanup here? */
> > > > +   }
> > > > +
> > > >     host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> > > >     if (!host->complete_wq)
> > > >             return -ENOMEM;
> > > > @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
> > > >  unled:
> > > >     sdhci_led_unregister(host);
> > > >  unirq:
> > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +       sdhci_uhs2_ops.remove_host)
> > > > +           sdhci_uhs2_ops.remove_host(host, 0);
> > > >     sdhci_do_reset(host, SDHCI_RESET_ALL);
> > > >     sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> > > >     sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> > > > @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> > > >
> > > >     sdhci_led_unregister(host);
> > > >
> > > > +   if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > > > +       sdhci_uhs2_ops.remove_host)
> > > > +           sdhci_uhs2_ops.remove_host(host, dead);
> > > > +
> > >
> > > I think you should look at creating uhs2_remove_host() instead
> > >
> > > >     if (!dead)
> > > >             sdhci_do_reset(host, SDHCI_RESET_ALL);
> > > >
> > > >
> > >
