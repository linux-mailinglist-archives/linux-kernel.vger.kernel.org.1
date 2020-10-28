Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2229D906
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbgJ1Wlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbgJ1Wip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:38:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5BC0613CF;
        Wed, 28 Oct 2020 15:38:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 13so668363pfy.4;
        Wed, 28 Oct 2020 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Johbs0Z75egiQIroXUJ+H8W2j2ZD6gGHPT/5rOZ9E7c=;
        b=OoqhVhER1UzX3UYvODFWFHzjIjN5ME0+4Stvf1J5DRaht5nxVCeMn5gZQmVEdTtXih
         tU9fU+LWsNZimK/PY/3B/a7/7Zimlqq2KXnQ50N1QT8lFCvmgrupewCjON3RmkhXTewc
         b6ZvuAWavkDTBO8xa9RM9aYCCqJ+k0tsm8CHCn703paAaKs6HBEzBJRIBoPm4eUT7l+O
         RFmYTVBV6k0YIdKg0cGPf22vp+OKfs0Nlv0/XZQnmNWIuAkW7+tjbvJbLoE6O+bz54i4
         UfAxNuik86rIHqZnaiGpc+zuh74r4R3h82qyfK5d+kuQ50eB3gl42gS6Df1vw/3Yx83C
         Q77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Johbs0Z75egiQIroXUJ+H8W2j2ZD6gGHPT/5rOZ9E7c=;
        b=E6+bP9QWNAA35HuFT7Aso0s519Sk2++kxjoMyZ8wwG95cU04SO1wRo4r7jQyCMsFOM
         zoJMm/0QmKMu7YGKkN2LiXfxGdR/JR13g7Ocb9OBA/u60q9BtKunBZ/oIygWLPNWyg4U
         ji46zmqOjG3n9I41m6OU1pqMXdj3BkwdSZ9OkFseKcyNrZ241sR/zL/EVwH89pClMKC9
         WBA24QUohT2qDqHTbFPhlloPCLPn+TPDjlyYPEbnzwyyhoizV53NRGnzGBirbAM3kaQ/
         gV273eBW9spfsMULtXWPa+uSjTBpYTvAbXkHcj2oxcsVTQK08qM1/bD0dKHCyw+K19YD
         c3rw==
X-Gm-Message-State: AOAM533nv7YdqfFDW2iaZQ2/Cspqh8B648WYU1SR5MnJABfobBhBc0rv
        wvxhQNC1F2GzvLneJdcOgD3Mkbyes8Xk5g==
X-Google-Smtp-Source: ABdhPJzrvhA9APnYxoejVZrytwFTXVwlDJ+tezyAIzCrEr05XV1nsPR7nOjQR0dWM6o8UmBfXNUogw==
X-Received: by 2002:a63:9d04:: with SMTP id i4mr6401980pgd.375.1603892793062;
        Wed, 28 Oct 2020 06:46:33 -0700 (PDT)
Received: from localhost (23.83.224.115.16clouds.com. [23.83.224.115])
        by smtp.gmail.com with ESMTPSA id p22sm5176338pju.48.2020.10.28.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:46:32 -0700 (PDT)
Date:   Wed, 28 Oct 2020 21:46:29 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
Message-ID: <20201028125812.GA59692@nuc8i5>
References: <20201020135806.30268-1-zhengdejin5@gmail.com>
 <875z6wdq62.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z6wdq62.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:33:09AM +0200, Felipe Balbi wrote:
Hi Balbi:

Thank you so much for your comment.

> 
> Hi,
> 
> Dejin Zheng <zhengdejin5@gmail.com> writes:
> > According to Synopsys Programming Guide chapter 2.2 Register Resets,
> > it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
> > reset, if DWC3 controller as a slave device and stay connected with a usb
> > host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
> > slave device when the DWC3 controller did not power off. because the
> > connection status is incorrect, so we also need to clear DCTL.RUN_STOP
> > bit for disabling connect when doing core soft reset. There will still
> > be other stale configuration in DCTL, so reset the other fields of DCTL
> > to the default value 0.
> 
> This commit log is a bit hard to understand. When does this problem
> actually happen? It seems like it's in the case of, perhaps, kexecing
> into a new kernel, is that right?
> 
It happens when entering the kernel for the second time after the reboot
command.

> At the time dwc3_core_soft_reset() is called, the assumption is that
> we're starting with a clean core, from power up. If we have stale
> configuration from a previous run, we should fix this on the exit
> path. Note that if we're reaching probe with pull up connected, we
> already have issues elsewhere.
> 
> I think this is not the right fix for the problem.
>
I think you are right, Thinh also suggested me fix it on the exit path
in the previous patch v2. Do you think I can do these cleanups in the
shutdown hook of this driver? Balbi, is there a more suitable place to
do this by your rich experience? Thanks!

BR,
Dejin
> -- 
> balbi


