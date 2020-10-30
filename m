Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA529FE71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJ3H3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3H3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:29:45 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FEC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:29:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so4778900ots.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1HNzlzE8Xe7BCZntASgYibGuSDss2gCPnUeL9DbFBE=;
        b=cKBxh4rpRRVGV2Cb957tV9l6Ra66YSurvzXoClIOYdQY/ei1i3CbqFC9aTTrIw1L2t
         IpYOM8EvHbLuViHSLyypWh/CEEPPMt/liBjWKnCPQMD30F/43wG5NVHyb4FzaOpJhcp4
         vJLo2CfsImacHJBRSJ2iNDGsIhMyu/NJIo8oKczVxCpyg/gj3me0SgywvMjlIxPPqi0o
         ovmtQmRY6jxcKtuZeFQMsyx0iW+FJTAppCCcsB9BnwpJ/vB842bmFm0/xsaWWG/gtJ6m
         JlGg0yAp7p7+OdRV5nASm50hm8DWLYwP6cgXcNN58QQVzEQwQ0yyr84LGcMQ60F24wdu
         DDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1HNzlzE8Xe7BCZntASgYibGuSDss2gCPnUeL9DbFBE=;
        b=Ke2XKtjua57mPQRUUTu8FqzrpVr5luVUVaBIePhA2Ut86LsohX/0rKSnwR8Ze7D/zD
         SxicDHUheRal0bkUmlzDupe1nK3VNxNhfbOHYqUcJrhqGpNWB61gkYAZc/C6C4MOp+jD
         sQkbSqtPL4B26zsx7eKUIF9QSS6eRFr8zgAWjjC3UiiOVLS2xBysWGILU0S+qnL16ilS
         KD/o06rHl5C9MMTQDnNCDdPDgS21QRcm9ibgQynxfNq75yOKjNUdSyCbuB3BJooW+MHN
         RUDEerP7SAcP3nQ7xIFYqyugRAFOmFTuGahbFnLHX+arPb9KsrekFHnpT4D6/Su6CNuY
         Otug==
X-Gm-Message-State: AOAM530f7yL6YArcEfRFUf6Ayg/Xcih2YH8ZG70/qkvzw1J6yj2Qe25j
        amXAAT7B0An57I6gVuw4Qs3u/ywwmeNP/dvWyh66Pue8aGc=
X-Google-Smtp-Source: ABdhPJyPjxqNT05hEOD1VR+nwGQUXUkiOTyHEMAQa+LIPzla6zfvuL4s6VnTUq6JP2szt+CYg3pvlE06kyUuNT13sjg=
X-Received: by 2002:a05:6830:400c:: with SMTP id h12mr738486ots.102.1604042984696;
 Fri, 30 Oct 2020 00:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201030061242.92510-1-john.stultz@linaro.org> <20201030061242.92510-2-john.stultz@linaro.org>
In-Reply-To: <20201030061242.92510-2-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 30 Oct 2020 00:29:32 -0700
Message-ID: <CALAqxLVQDEQGfjhyu9y-jzLC727qWdj2h-bDHzag0K3o-niFBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index 40f91bc8514d8..a490e78890017 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -44,6 +44,7 @@ config ATH10K_SNOC
>         tristate "Qualcomm ath10k SNOC support"
>         depends on ATH10K
>         depends on ARCH_QCOM || COMPILE_TEST
> +       depends on QCOM_QCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y

Doh. Apologies! I flubbed this line (SCM not QCM).  I'll fix and
resend tomorrow.

thanks
-john
