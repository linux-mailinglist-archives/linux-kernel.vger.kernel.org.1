Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B349321E4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGNAxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 20:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgGNAxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:53:35 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B855C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:53:34 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id m18so2832639vkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBmPGkwb8F27DgB7ghpu4ldmH1wyapHT/SdG1wNVoGM=;
        b=DsVuBHOSfihKaNkABXRm4ftNILFS5xlzW6RCsluK4T11o2qaXfRJa5N0UNwsp+0kCJ
         53tVV/PwX28dzQ54HAuuCIN7gy+nUOCPu2EunQOHMCfOVUG950g7F3158McC+Q3pXBLw
         KdViqNVDKlGvtHk3ZRRKIfsi3+Ub9nFkvXgaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBmPGkwb8F27DgB7ghpu4ldmH1wyapHT/SdG1wNVoGM=;
        b=fbf6/Q/GKXIKqFh4FPYJNGvbQLhqI5X3/P/N/nGeIKXrBvaoURUcSYeBiUKKPdIUmU
         1koEsUWINxddmvbg+R3068nHEjJYp86CgGAPlCXesaMl0hWT91R9IrwyBncbKX8trpdw
         6oxaSLkFG4iYOYK0gFqfP39k7ZoS3VIK17GpjuHW3ugBca4pdmePyEYO1KfD1K7Pn8Ek
         4WlulIBnjwyISlcOnTN3I0E2kre5tYHpclSE8dv223hX7zZVHwk6grxfjfJmfKT2CaSk
         shvGFVeV3II/GhbbHGFSXJ75o3cu3VbwOqE9nknB604zVVE/B+LzY+GT6AgfS+7P06XV
         rGvQ==
X-Gm-Message-State: AOAM530B4tn7ZB3NXSInSaQu8STlkeZWAIBRY6Tlu1s1rBozCV3ynqlg
        xKcyVl3qagU98kX/2QmfFD02eoaO7KE=
X-Google-Smtp-Source: ABdhPJw9KDSy7PuaAgYz0ybvCYnXfDLwg8YQtmk+acRfMp36k9w7l4kd/3YHGu2kclF0TWxQVxqkmQ==
X-Received: by 2002:a1f:24cc:: with SMTP id k195mr2027651vkk.61.1594688013356;
        Mon, 13 Jul 2020 17:53:33 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id q7sm1890405vsp.14.2020.07.13.17.53.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:53:32 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id c7so4952083uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:53:31 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr1932767uav.0.1594688011224;
 Mon, 13 Jul 2020 17:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org> <20200710124152.GC1567243@kroah.com>
In-Reply-To: <20200710124152.GC1567243@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 17:53:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJQaAHsDb6uvKpwU87qtqTQgNeoiuRr2kF9pqjBLhLpg@mail.gmail.com>
Message-ID: <CAD=FV=XJQaAHsDb6uvKpwU87qtqTQgNeoiuRr2kF9pqjBLhLpg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Drop the icc bw votes in
 suspend for console
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rajendra,

On Fri, Jul 10, 2020 at 5:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 09, 2020 at 03:07:00PM +0530, Rajendra Nayak wrote:
> > When using the geni-serial as console, its important to be
> > able to hit the lowest possible power state in suspend,
> > even with no_console_suspend.
> > The only thing that prevents it today on platforms like the sc7180
> > is the interconnect BW votes, which we certainly don't need when
> > the system is in suspend. So in the suspend handler mark them as
> > ACTIVE_ONLY (0x3) and on resume switch them back to the ALWAYS tag (0x7)
> >
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> > Note: Patch applies on qcom for-next, which has the ICC support patches.
> > The tag macros are currently not exported and hence the hardcoded values.
> > Perhaps if and when https://patchwork.kernel.org/patch/11619705/ lands I
> > can refresh this patch to use the macros.
>
> Feel free to take this patch through that tree.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Could you post a v2?  Bjorn landed some of my geni serial patches to
make console / kgdb work better, but then I realized that your patch
no longer applies cleanly.  It's trivial to resolve, so hopefully a v2
should be quick and then Bjorn can land?

Thanks!

-Doug
