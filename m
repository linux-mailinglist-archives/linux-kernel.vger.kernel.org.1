Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C49262DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIILJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgIILH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:07:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02ADC061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:07:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jw11so1180359pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vov2dA/KW/bn72Ejzr9klJyhX5C88qedShxokRR3aNg=;
        b=R365BsX7Ty4AzzqOSLwELZjOZev1K7gL80aq+v4OVAV6+F4TcWo9C+0dMIYzsLxkVx
         +i8yCdt9e569HVDNWo1DDHrtItgxrB9kATz3/PqjbR3nbgUDebwF3G81O7b3dWiaTKlK
         g+lOVocaZ8uCYuiExZFnnyj+X9iT3nXMfAdEj+yNQaaQcoRBKK6qR1KbGsKRr10Jep/j
         h0cUBCGDCrWIydOWCVVWvoay4gX2I2PZDWgd/MZyXWFWKNpTN3t/Nm3tV46jQIpc3Nu7
         hYmUfP2voxzFM4xbvV3h16QnYOELlaYWGHnkkz+YBlYP10XikBbMa93P8JkODTS0UwCn
         uPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vov2dA/KW/bn72Ejzr9klJyhX5C88qedShxokRR3aNg=;
        b=sLlr8pKQlfPOlQamV++e6I8VC1MaciKbp1/I80dMQ/j8sdOSBQdNJMp4F6Fi1pTLHu
         81Eu0eRPijAz0UFVuIUCAPm+4I8QVh9ozK8Rw6MVJFP7g7JdyseX3dBco2n7a0BW+mLd
         dssyB311RZvQ5ZQOKTK1lkeVfLd7lZp7YqMFaJuixyWn6Fo8UXiMDctgYfwARPXCelUM
         dvfHA+p6Np9MaaXG4u3WeDve3QZyUOq052YZwHi1lwLrw1Me3gKkJVo9dYOH74RGCreZ
         UIST5/uGZlrYvmr+edpz4inEg/fLDWLusB9rn8sR3f0fKT/mosVBG2Ol+ZJH0L45WtFu
         bH0w==
X-Gm-Message-State: AOAM530iS6iWwfNv6ZC9ZGktVXHjk5iBMhmQ2Uw1YORXYL9b8AbvYPjC
        Z/x3NdZH2FTVBr+BjIgXbRLSMQ==
X-Google-Smtp-Source: ABdhPJyCZVgnQXi30pqYsiZcXXeTmANMigiEsaDsJ6dg0Pg/CZzHHwSMlI2D1oXOAeWt1zTAKG+xhg==
X-Received: by 2002:a17:90a:13c7:: with SMTP id s7mr393903pjf.124.1599649633150;
        Wed, 09 Sep 2020 04:07:13 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id j35sm1804786pgi.91.2020.09.09.04.07.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:07:12 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:37:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20200909110707.jv2beta5rdr3wux3@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
 <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
 <20200831104453.ux5fb5bpt57tj5am@vireshk-i7>
 <CAPDyKFp1fCE3bBKngcia1LBKHEkQRoVzUwZYE6+Y++Hu=6aJfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp1fCE3bBKngcia1LBKHEkQRoVzUwZYE6+Y++Hu=6aJfw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 12:57, Ulf Hansson wrote:
> On Mon, 31 Aug 2020 at 12:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 28-08-20, 10:43, Ulf Hansson wrote:
> > > On Fri, 28 Aug 2020 at 08:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> > > > find the OPP table with error -ENODEV (i.e. OPP table not present for
> > > > the device). And we can call dev_pm_opp_of_remove_table()
> > > > unconditionally here.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > Replaced v1 with v2 on my next branch, thanks!
> > >
> > > Just to be sure, this patch doesn't depend on any changes for the opp
> > > core that are queued for v5.10?
> >
> > The recent crashes reported by Anders and Naresh were related to a OPP
> > core bug, for which I have just sent the fix here:
> >
> > https://lore.kernel.org/lkml/922ff0759a16299e24cacfc981ac07914d8f1826.1598865786.git.viresh.kumar@linaro.org/
> >
> > This is already tested by Naresh now and finally everything works as
> > expected.
> >
> > I am going to get this fix merged in 5.9-rc4, but we do have a
> > dependency now with that fix.
> >
> > What's the best way to handle this stuff now ? The easiest IMO would
> > be for me to send these patches through the OPP tree, otherwise people
> > need to carry this and the OPP fix (for which I can provide the
> > branch/tag).
> 
> No need for a tag/branch to be shared. Instead I am simply going to
> defer to pick up any related changes for mmc, until I can rebase my
> tree on an rc[n] that contains your fix.
> 
> When that is possible, please re-post the mmc patches.

The dependency patch got merged in 5.9-rc4. Do you still want me to
resend this patch or you can apply it directly from here ?

-- 
viresh
