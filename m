Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5CC242123
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHKULN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:11:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A807C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:11:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so6675790vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81NTZpiDGt+DeUizhccfQdwoJcBOsmeDza4v9LRaS7Q=;
        b=T2pPGoewiPvpKJXBD5E4PN02jutwvTNLcRqdRrgP2E5cscCIODU8xre0K6Osk2++nZ
         OPTK0ZCaP13n0PvGhkr6G8u+FQ4RmvpwBowCG815DBoaD2LVFl3kbbOvb5SUosE1b30e
         t0F5H2mWqYRNhhPVAWztu1uPrp1MZ8ZGHdNpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81NTZpiDGt+DeUizhccfQdwoJcBOsmeDza4v9LRaS7Q=;
        b=FWTGa4NMi6yFlLcZcCJUYurdlSn1bb4OgkdGVkjFpSJzwyCAaXbpZakqLT/bK6LUMD
         h2jNVhong4hsh2MEwmaDp+Fo/ENk/nhMIlcWbiXIZ/uAakyPS5ioh6MKT9mPtbbdpH54
         gz8H7CXD9F2Iwo/qHMRdRJ43hwBfGH2drlgJT2NC7pIBuHU5Lk1tStTxeaxzaDD+1J3e
         2fLo4klF3xSkp+Kor1xOwY6Mc6FAHryiOQJ9+Gw69Sqm1vUJB4ezoTgueNAhOm2D2+wy
         iPVBCQLJ/gUhDXXMm7fknJTUigT3TquBwUofRs96g8we/s30ivjXosl6KPKnY64z5R1j
         V3hA==
X-Gm-Message-State: AOAM532cDnr81a8wZ5xJwyDSVn8gfTQgXckPVCgZ9XLPDw7PdRDxUIIc
        CeCLGz+z67lKPJWjtwIcg/Y0Vr5rrQ0=
X-Google-Smtp-Source: ABdhPJyd3sg9Ms5Kb4cENEuqW6KyWXwH86cuTmItNOVvEOFzsqnwApQktLODNBr2qCtZ17Ha6lFn1g==
X-Received: by 2002:a67:f5ce:: with SMTP id t14mr25943840vso.240.1597176671313;
        Tue, 11 Aug 2020 13:11:11 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id z4sm7546550vsl.27.2020.08.11.13.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:11:10 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id j188so6242625vsd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:11:10 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr26453646vsj.119.1597176669782;
 Tue, 11 Aug 2020 13:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org> <1597058460-16211-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1597058460-16211-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 13:10:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uvsd3YBK0PS5X4ScAtC1q0Xfh8q=JQ1iTRKi=VVSU4Gw@mail.gmail.com>
Message-ID: <CAD=FV=Uvsd3YBK0PS5X4ScAtC1q0Xfh8q=JQ1iTRKi=VVSU4Gw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] genirq: introduce irq_suspend_parent() and irq_resume_parent()
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 10, 2020 at 4:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> This goes with the new irq_suspend_one() and irq_resume_one()
> callbacks and allow us to easily pass things up to our parent.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  include/linux/irq.h |  2 ++
>  kernel/irq/chip.c   | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

Thanks for posting my patch.  Small nit here is that when I saw the
patches listed together I realized that I forgot to capitalize
"introduce" in ${SUBJECT}.  The two patches right next to each other
that both start with "introduce" where one has a capital and one
doesn't look weird.  Hopefully you can fix in the next version?

Thanks!

-Doug
