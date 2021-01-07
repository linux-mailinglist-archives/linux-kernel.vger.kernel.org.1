Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0C2ED3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbhAGQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:02:12 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13A2C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:01:32 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id h18so3807945vsg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVKKP8zyOhDGnVR/3YtVW7x0rMfq/5w74jBHoVaOHoM=;
        b=YzKeDedpF1bzFmpNO1agtIykqm2SpYPV+ylY3RIdrRWg5SSRe2e/uEqNZYOB/46vwq
         qv1EwNw4g/C/7UwIgET0XB4Q/sLp9J9wV0c4OysveHLbf6HduIEgPt9od1onfYInUFeC
         I7E1ppEiLKlUPYfQL8nOB1v6B1DOMhv0EOq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVKKP8zyOhDGnVR/3YtVW7x0rMfq/5w74jBHoVaOHoM=;
        b=I5WF11fb9/vfXRmFXX8oAT9e6xjypKd0Ko1wtTsDJsm5hfI6E+GSeJUtW9LN/YMnb8
         T1iV0FzxsCgkpEgLbLpNIPcssVySOHNvzUiVttbxt4PrSBf01hay/wUnY9fWi0J6UkjI
         P+GziNNHu8eljZ3WixbLmp1ja15aUYuDZmcrlGB9TrrSdzgJl9sxJ5IPlrMxViD5xsxZ
         he6zWl3YFnexE3fhsuP56Hl+UekyMGCdsJhqjavYwIDO2z4KbalSwCV0j8nXw3aBt4/M
         vV6SKfrB0uh10j4GtIbrBLYoYXXxc/9Eh2RhnCjlAlDrsZePchzSBWFMtMZUAATDgPx7
         1/QA==
X-Gm-Message-State: AOAM530Cckrznsed5gCUbNL48seCMsQ143vXTkRomksEGXdpshOUdEfj
        /2f31i0gXGupY6FLUFV2In9zV8VNSaCTew==
X-Google-Smtp-Source: ABdhPJzqC/wN2DsmgxLZ1Tdv/7wbJdd4YN6shYJFX/QB830QhI7uWBkgYOaaRc3D2uj6gVJOYCVtHQ==
X-Received: by 2002:a67:bd0a:: with SMTP id y10mr7512890vsq.28.1610035291474;
        Thu, 07 Jan 2021 08:01:31 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id j8sm808923vsn.33.2021.01.07.08.01.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:01:30 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id y21so2413345uag.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:01:29 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr8049339uau.90.1610035289548;
 Thu, 07 Jan 2021 08:01:29 -0800 (PST)
MIME-Version: 1.0
References: <1610008770-13891-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1610008770-13891-1-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jan 2021 08:01:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WbvfbU4G2H1a1LrG=fwASn3wscHwOymvO1uJwU8aH70Q@mail.gmail.com>
Message-ID: <CAD=FV=WbvfbU4G2H1a1LrG=fwASn3wscHwOymvO1uJwU8aH70Q@mail.gmail.com>
Subject: Re: [PATCH v3] soc: qcom: rpmh: Remove serialization of TCS commands
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 7, 2021 at 12:39 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> From: Lina Iyer <ilina@codeaurora.org>
>
> Requests sent to RPMH can be sent as fire-n-forget or response required,
> with the latter ensuring the command has been completed by the hardware
> accelerator. Commands in a request with tcs_cmd::wait set, would ensure
> that those select commands are sent as response required, even though
> the actual TCS request may be fire-n-forget.
>
> Also, commands with .wait flag were also guaranteed to be complete
> before the following command in the TCS is sent. This means that the
> next command of the same request blocked until the current request is
> completed. This could mean waiting for a voltage to settle or series of
> NOCs be configured before the next command is sent. But drivers using
> this feature have never cared about the serialization aspect. By not
> enforcing the serialization we can allow the hardware to run in parallel
> improving the performance.
>
> Let's clarify the usage of this member in the tcs_cmd structure to mean
> only completion and not serialization. This should also improve the
> performance of bus requests where changes could happen in parallel.
> Also, CPU resume from deep idle may see benefits from certain wake
> requests.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
> Changes in v3:
> - Update the comment in include/soc/qcom/tcs.h
> - Update to keep req->wait_for_compl as is irq handler
>
> Changes in v2:
> - Add SoB of self
> - Fix typo in comment
> - Update comment as Doug suggested
> - Remove write to RSC_DRV_CMD_WAIT_FOR_CMPL in tcs_write() and
>   tcs_invalidate()
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 22 +++++++++-------------
>  include/soc/qcom/tcs.h      |  9 ++++++++-
>  2 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
