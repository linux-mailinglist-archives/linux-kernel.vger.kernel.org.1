Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597422D6AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgLJWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394034AbgLJVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:24:37 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BCFC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:57 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id q10so3648921vsr.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mhjTRkoHG5wDB6hSuZ/aPIC7H/s0skSuoErD8uNBws=;
        b=Mk0qsv8nQsIb+74vLlttYyB+sauWfKgHNsogJv1aie+18w0M3Qt7pPiZtt3aTWwfau
         8SizigN8Zf9VFxFgSDbBcEAXw45HsRgJGbE6fmhqqt74pJM8FhSgNf3+hqNOw0DqMHiQ
         riKNI5bvy+Az1UUENpaPsMTQNH9v/HcbODbcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mhjTRkoHG5wDB6hSuZ/aPIC7H/s0skSuoErD8uNBws=;
        b=Fjcm9kDnDtjepOcVlrWJFWIr+41vz82vyF2VOSr+NqauQmaKH5tIyxdNhMOP6nR2UU
         H0ZnGU3kV6v8t/uJkRn/riOmbwIVb6Jh4rcDyuU+qeR6uwipDOaF0QSzwn32BbjcjQkc
         8KCNuHcF8BtRQRcIH6G/dljGHjX0TNj/tmnLRzSDQ+NcJn+zX5mirwinAIoH83jpUli9
         StpOwVnZ/CBEnqjHR9ofVqROSN4c55pgYkrLcno7dh+e0uKb83MGKwA+9d71/OuALQVg
         i71GASFv+dWsEGk8TpFXsnuz8rsJ+NGYHIIbQeNVs1Bl+KoAz+H2AyyNR6UE1875xDRM
         cK2Q==
X-Gm-Message-State: AOAM530XioxkWyE/CMlVD4cvhxjZ0ElXa3+I6QrRxhsiJbYblYywQ9lf
        F33XWb7ysw5KwgMbRZgpzZHdNeM2gEwvNQ==
X-Google-Smtp-Source: ABdhPJw6yJ6gez+56bBrd0lNwnu3OwYYnKGDCBhkEVBbui4YcqjYFm3/RM2/meX81h2iAP0MNaZqoQ==
X-Received: by 2002:a67:2d8f:: with SMTP id t137mr11076486vst.28.1607635435976;
        Thu, 10 Dec 2020 13:23:55 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id t127sm691653vka.3.2020.12.10.13.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:23:55 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id v8so3677256vso.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:55 -0800 (PST)
X-Received: by 2002:a67:70c6:: with SMTP id l189mr10697172vsc.34.1607635434758;
 Thu, 10 Dec 2020 13:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20201210131913.v2.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
In-Reply-To: <20201210131913.v2.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 13:23:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U5AvDR0mhaGH77QKTvPCAMH7fc5eCNFPcSqnSbrxKMhA@mail.gmail.com>
Message-ID: <CAD=FV=U5AvDR0mhaGH77QKTvPCAMH7fc5eCNFPcSqnSbrxKMhA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Warn about overclocking SD/MMC
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 1:19 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> +               pr_warn("%s: Card appears overclocked; req %u Hz, actual %d Hz\n",
> +                       mmc_hostname(host->mmc), clock, achieved_rate);

Ugh, multitasking too heavily.  Clearly this is wrong format codes...
v3 coming shortly.  Sorry for the spam.
