Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B05426E541
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIQTQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgIQQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:18:44 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA41C06121D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:09:37 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q21so2394418ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpwgO2gE232MQ8MlmE9oGUJ2SqqC1OkAKiHLBPpysXo=;
        b=CREaOxf0kmFXuOoQR8BoDazJ9PauASn2hhUtueJmHKUzGZIMo3Ku0zwjy+44ikxHGQ
         jk37ySD4ZiQ8GQGyARaRhw2O94qzKeXxNsXdu6FyyGVPw2XPEV1xk7oxHJ+ZlP+gcWVP
         OgLYU81pbMSjlgquQ2oHnYV9j7hwL/zoyF4JsVKImTcm3348Gqh4eLshHr1H0VXGdwOW
         rfpBHNBInXkrYmadwYOl4Rs22EPCVy5JTaI+niPxnBnsw/LY38yTEw8UDFxgk9XUtRqj
         jTz2qkmmeGX7qm7n2/cqzU/gSmD2PE5LbO5BTpG3Yc+x1bss77NWd0rn4PrS6oKO71hI
         hpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpwgO2gE232MQ8MlmE9oGUJ2SqqC1OkAKiHLBPpysXo=;
        b=hoWiroMTN3rFRcgLRvq27/r+Nf/0zzDG4zd/D7FVgY8atwBoBZO6BaRQDCwSoIh1JH
         U2NsN4qQef1ir8alCjP+StlPw48wKFGdr2gc4Cq398F9vqvN7gu4XGnJVP69+RNmEZGy
         bOL380Z2cnQG8bYUIKlqVTXR+/AujbraffwW5qAvc1Nlq65TsT2MjMMtm4rKLEYV9Zly
         ZYdf1HpJuD9Pj6TCVGZD0ACSicO5L4PxMY7FoMZLKCG/2RYO5jOgdz5zGLA21KE5gQhm
         3h07omI9ETK0+cHh1Aj3HLMitdv3KHjjQF7ISClehbKGOc9AMlvusb7kgZiXMEfbdTTF
         kqig==
X-Gm-Message-State: AOAM531lnY0DXKk70MHHhAlzKiwqyZf+Ydmoojg7lFpQA58aisru9KCO
        uVsBIrfdtw4R3DNXDR+qkeN1Rw==
X-Google-Smtp-Source: ABdhPJz6dpPUOs9zY2r2UAdlGLE+UGCQulYBlk4T3lLoPIPgRjUzAdpgzKBUersByMvs+M3l/UuKsg==
X-Received: by 2002:a05:6830:1518:: with SMTP id k24mr19291103otp.21.1600358977119;
        Thu, 17 Sep 2020 09:09:37 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id c14sm241959ooi.9.2020.09.17.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:09:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 11:09:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH RESEND RESEND] remoteproc: scp: add COMPILE_TEST
 dependency
Message-ID: <20200917160932.GP1893@yoga>
References: <20200915012911.489820-1-acourbot@chromium.org>
 <20200915032529.GA7762@uller>
 <CAPBb6MXGGn-QGZvCycfMNO-PW_pBhi+B0QWoa=iESBp1P-eZrw@mail.gmail.com>
 <20200917141320.1a1bb9df@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917141320.1a1bb9df@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Sep 07:13 CDT 2020, Mauro Carvalho Chehab wrote:

> Em Tue, 15 Sep 2020 12:43:26 +0900
> Alexandre Courbot <acourbot@chromium.org> escreveu:
> 
> > On Tue, Sep 15, 2020 at 12:25 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Tue 15 Sep 01:29 UTC 2020, Alexandre Courbot wrote:
> > >  
> > > > This will improve this driver's build coverage.
> > > >
> > > > Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > > > ---
> > > > Hi remoteproc maintainers,
> > > >
> > > > Second resend as I got no reaction for almost 1 month on this one-liner.  
> > >
> > > Sorry about that. I fell behind on my inbox and have missed your
> > > previous attempts.
> > >
> > > This has now been applied.  
> > 
> > No worries, thanks for the quick response.
> > 
> > Mauro, the patch is applied on
> > https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git/commit/?id=5185e3a9dc2d68bb52e3e12400428aa060b87733,
> > will it work for you to merge this into the media tree and apply the
> > pull request on top?
> > 
> > >
> > > Regards,
> > > Bjorn
> > >  
> > > > Pretty please?
> > > >
> > > > As explained in
> > > > https://www.spinics.net/lists/linux-media/msg175991.html, we need this
> > > > patch in order to merge a driver series in the media tree. If that
> > > > looks ok to you, can we pull it in the media tree along with the series
> > > > that depends on it?
> > > >
> > > >  drivers/remoteproc/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > > > index c6659dfea7c7..d1fcada71017 100644
> > > > --- a/drivers/remoteproc/Kconfig
> > > > +++ b/drivers/remoteproc/Kconfig
> > > > @@ -43,7 +43,7 @@ config INGENIC_VPU_RPROC
> > > >
> > > >  config MTK_SCP
> > > >       tristate "Mediatek SCP support"
> > > > -     depends on ARCH_MEDIATEK
> > > > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> > > >       select RPMSG_MTK_SCP
> > > >       help
> > > >         Say y here to support Mediatek's System Companion Processor (SCP) via
> 
> Bjorn/Alexandre,
> 
> Can I just cherry-pick the patch from:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git/commit/?id=5185e3a9dc2d68bb52e3e12400428aa060b87733
> 
> Adding it on my tree before the patches that require it?
> 
> If aren't there any other changes for "config MTK_SCP",
> this is the easiest way for me, as I won't need to pull from
> a stable branch from your tree and wait for your patches to
> reach upstream, before sending a tree branch with such changes.
> 

I don't see anything that would cause a merge conflicts here, so that
should be fine. And perhaps we should just have picked it through your
tree from the beginning then.

Feel free to add my:

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
