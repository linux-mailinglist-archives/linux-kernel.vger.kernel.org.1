Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09BC1CED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgELHFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 03:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:04:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F991C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 00:04:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s11so2250372pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjsOdjpKMIcNbo6ami1hZItagyqlFnrIs1FP+NhqaMs=;
        b=Nv53ujrcczOAPjDmYsX6nLdFyZ+wS9hhvf3CO4qs8dPFyA2RGLSn3s0GkG0fIm+9qn
         JDAahRkemwNvi5VxsTbffXw4WMrzzhRhGGgABmX4/+xqoAkDjwtTMqTi/XQts2jUcPCE
         XzF6uFNf4lHSAyG50ecxoWsm6c2rCBnfvW1Jm8I+rrS7x0U35xYRdajGwpqHS6Wv8bD/
         Woqfrg5WH+Jq0bYj77ygzUtookxjcjEVQNDxxhBE19s+ehAdPJ5sLWqwXcwHC/IWN3Wi
         5ciWg8DPoMyCP1WMPYS2t35EvMH9/k4NzQOLOrnHYJpnAbFYzx3kKBjIieq825Yn+3Cc
         fwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjsOdjpKMIcNbo6ami1hZItagyqlFnrIs1FP+NhqaMs=;
        b=Hi66S6/7GmAu8nrF9bB/lF1vtOu8Hannjepp3/kwOR3AH77S/iXeK3AsCzqRqhUB5e
         WqA1dmo/Xo7XV71MZ2YcbUlu+I1njOwEHOd+G2U6h6+5v/bg7bp9HVES+Iqq1aZZ2Z45
         IVmmK8D4PSRmEG2tfBidLtlW6Pijjvrzgsg3+CNsvq52srmxRtz2U8S40DSyoAIp4qNl
         8qESSJc9PncOF1nxd2DrMp+2GxTA0bf4gIUu8c8b598/6G2T9tpsz92p0oqIuFMW6qyc
         16oU5Mo4vvTSrHEnTH41cHiKXeIAd4t1AYde9DowWqz8nsdTcCRVkDBQuyTqR0CogNBK
         LpYA==
X-Gm-Message-State: AOAM531z0rg0ckb79bikx/I6uSWVobPocWpvyHcFkQ5ioxFdvrNXEGZH
        2zdlkw5uHcEAT4kGK9lXRC279ICZPA==
X-Google-Smtp-Source: ABdhPJy6ZXpI/dCp7GApF3CegXaGhJm4JkrJYjfoGGAUpAy3s9UzpdSNvF3nMu1KCtE7Av6UgOq8Fw==
X-Received: by 2002:aa7:8c0a:: with SMTP id c10mr9439843pfd.177.1589267098521;
        Tue, 12 May 2020 00:04:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id 192sm10769811pfu.182.2020.05.12.00.04.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 00:04:57 -0700 (PDT)
Date:   Tue, 12 May 2020 12:34:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 0/5] MHI Misc Fixes
Message-ID: <20200512070451.GH4928@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hemant,

On Mon, May 11, 2020 at 07:03:04PM -0700, Hemant Kumar wrote:
> Patches are addressing MHI core driver bug fixes. Patches tested on
> arm64 and x86 platforms.
> 

This series looks good except one comment I left. Once that gets fixed, I'll
club the v2 of this series with already applied series from Bhaumik and send
to Greg as a feature one for 5.8 (provided I get the updated series within
this week).

Thanks,
Mani

> Hemant Kumar (5):
>   bus: mhi: core: Remove the system error worker thread
>   bus: mhi: core: Handle disable transitions in state worker
>   bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
>   bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
>   bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition
> 
>  drivers/bus/mhi/core/init.c     |  3 ++-
>  drivers/bus/mhi/core/internal.h |  4 +++-
>  drivers/bus/mhi/core/main.c     | 38 +++++++++++++++++++----------
>  drivers/bus/mhi/core/pm.c       | 53 ++++++++++++++++++++++++-----------------
>  include/linux/mhi.h             |  2 --
>  5 files changed, 61 insertions(+), 39 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
