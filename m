Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15262FA392
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405260AbhAROuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405179AbhAROsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:48:17 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88122C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:47:36 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id v23so1307004uam.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYITA3Yxe+LNUEBbIjMhLMDLo8Pr6qOWRiVR9QOc69o=;
        b=WBp4BQ4iS/nMuJHj2dRCYS1FOe1q70UMadKm9plqyvTpqfBAye6UbGn+Szu9OK2C9t
         /sL8U2B/SyzKpzYyfD/PA0RseoBzXrBcf12M4EFyJMxQXw3jeGXo1UhmVOCddHRiGoax
         Xyfns6tQ10yiERfST33vIWqybEqEXPJWFcPbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYITA3Yxe+LNUEBbIjMhLMDLo8Pr6qOWRiVR9QOc69o=;
        b=d6aL5oPAgp4ND6SMzEPqcX49+UdWK6q/AMpaZ5yKUx4mGSVKpcTDKsP/9mgG7P21QS
         Nrd49pz9IFLHuQQEbOIMmJrVqDTLgtfaEGz2GT8kBz/7TLCL/lsDOF3UjM9MsrPLwfKw
         5KDJ53nJzY7dxu6fMeoDFYZWkD1HLgMTvGyH088ywTBReKR4a3ZinSRaiO2FnrABxq5m
         G8GzE6lP7H1oKB53SAr9TzcxykiBEQoBTuyqlwLOkYF/lUibVtcLgsostETDTwoBF7b0
         EjnmjSN7ivcfMvIv8T9e5EjBqz2FgAKYftR6bueF8yuUDrsl0Mpke4QJVprBqagUAY71
         MLRA==
X-Gm-Message-State: AOAM533YQWRpsb8PfOTMP77YxbMkk5EVB3HcpYrcPItI6I7DyAMySTVC
        MZgzSttyQpDUhEPuCWFAViFUdiOg61Qm7uB5m2wtSw==
X-Google-Smtp-Source: ABdhPJwMOdZBQVMFI+wOY4prWcda+5x/AEFNDfgLueyLCfRiRaIBomu6uUxWpvmwEP1qgrXX6LiK2JHjkjI2sbTLjFs=
X-Received: by 2002:ab0:7193:: with SMTP id l19mr2785323uao.84.1610981255465;
 Mon, 18 Jan 2021 06:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
 <20201015160257.GA1450102@xps15> <dd400fd7017a5d92b55880cf28378267@codeaurora.org>
In-Reply-To: <dd400fd7017a5d92b55880cf28378267@codeaurora.org>
From:   Mattias Nissler <mnissler@chromium.org>
Date:   Mon, 18 Jan 2021 15:47:23 +0100
Message-ID: <CAKUbbx+ZC9cLvcaJnrDYYsrUhfO3dOXJGoLswL30nRzChjwn-w@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Add config to exclude kernel mode tracing
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Al Grant <al.grant@arm.com>,
        leo.yan@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:46 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hello Mathieu, Suzuki
>
> On 2020-10-15 21:32, Mathieu Poirier wrote:
> > On Thu, Oct 15, 2020 at 06:15:22PM +0530, Sai Prakash Ranjan wrote:
> >> On production systems with ETMs enabled, it is preferred to
> >> exclude kernel mode(NS EL1) tracing for security concerns and
> >> support only userspace(NS EL0) tracing. So provide an option
> >> via kconfig to exclude kernel mode tracing if it is required.
> >> This config is disabled by default and would not affect the
> >> current configuration which has both kernel and userspace
> >> tracing enabled by default.
> >>
> >
> > One requires root access (or be part of a special trace group) to be
> > able to use
> > the cs_etm PMU.  With this kind of elevated access restricting tracing
> > at EL1
> > provides little in terms of security.
> >
>
> Apart from the VM usecase discussed, I am told there are other
> security concerns here regarding need to exclude kernel mode tracing
> even for the privileged users/root. One such case being the ability
> to analyze cryptographic code execution since ETMs can record all
> branch instructions including timestamps in the kernel and there may
> be other cases as well which I may not be aware of and hence have
> added Denis and Mattias. Please let us know if you have any questions
> further regarding this not being a security concern.

Well, the idea that root privileges != full control over the kernel
isn't new and at the very least since lockdown became part of mainline
[1] no longer an esoteric edge case. Regarding the use case Sai hints
at (namely protection of secrets in the kernel), Matthew Garret
actually has some more thoughts about confidentiality mode for
lockdown for secret protection [2]. And thus, unless someone can make
a compelling case that instruction-level tracing will not leak secrets
held by the kernel, I think an option for the kernel to prevent itself
from being traced (even by root) is valuable.

Finally, to sketch a practical use case scenario: Consider a system
where disk contents are encrypted and the encryption key is set up by
the user when mounting the file system. From that point on the
encryption key resides in the kernel. It seems reasonable to expect
that the disk encryption key be protected from exfiltration even if
the system later suffers a root compromise (or even against insiders
that have root access), at least as long as the attacker doesn't
manage to compromise the kernel.

[1] https://lwn.net/Articles/796866/
[2] https://mjg59.dreamwidth.org/55105.html

>
> After this discussion, I would like to post a v2 based on Suzuki's
> feedback earlier. @Suzuki, I have a common config for ETM3 and ETM4
> but couldn't get much idea on how to implement it for Intel PTs, if
> you have any suggestions there, please do share or we can have this
> only for Coresight ETMs.
>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member
> of Code Aurora Forum, hosted by The Linux Foundation
