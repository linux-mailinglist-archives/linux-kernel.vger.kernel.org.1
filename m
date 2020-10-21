Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901B0295461
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506364AbgJUVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506356AbgJUVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:41:52 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1865C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:50 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id m195so845785vkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6PfWsQc4jQGgwjSKnADuYEPxuKkTD/H1xb8gUpcO4I=;
        b=SdJzXPVlZeOfHYLfdG1K451OGXxkVR/1kkFXYgz/MA0PwE+CLW+eMnGo0m1YCLfqAB
         r7rX1C0tF2eWO9BXOXRtkmFNYh2F4EUCFbWsXb+EekArsDrWUbuOkPNh9aZksP9PHSzH
         fXHNc+pcZKKW3jsEBolR+ntmybXp5r1iVe1pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6PfWsQc4jQGgwjSKnADuYEPxuKkTD/H1xb8gUpcO4I=;
        b=Dr8XQ3i5AQsaI4ssuOOKMzphatjG7+oNqJTSsWZcVk1CbiDqbAKQbBpVz2ihM6uaVf
         iCMejviOETcjQJ3xwbuGanmglJSJZ6dmMqCw2oCFeml1A6Dml+x57F83rM4yIRD7xF3W
         mVc3uVUJ+bfxEFLZK4kGDSU26ejjPaIRoN3cUykmeq3R+Fiv1j4hw6a0r49Ep/CLH7ZC
         v2SN9NFYhEkFHewEBCRwB7f2IikUXnfPm71AHqfEdRLwndc/FmC37T25WSfLI0dCEjKQ
         uNVLIOQwwNtcpb0IH5CU5FOcX0LRtEqG96bAW5z47DZucHjpnf2nhVNkJedyDYhBYaKz
         b8rA==
X-Gm-Message-State: AOAM533nnXRYgKAE1DCBYTw7J94aaqnjMV5Rg8dwtLmsiZCnmBUZJ1Zq
        a2tmipVbg8dLjfboeU87QYhvCfWk4Q/h7g==
X-Google-Smtp-Source: ABdhPJwGriqqo5pSGH1S3hRNguJ5iV3i+c+5VdiILN/D7y7ysUZAIhTEXkxawkW4thDLB03Vxhp2UA==
X-Received: by 2002:a05:6122:804:: with SMTP id 4mr3531971vkj.15.1603316509811;
        Wed, 21 Oct 2020 14:41:49 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id c129sm368983vkb.16.2020.10.21.14.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 14:41:49 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id h5so1840508vsp.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:49 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr3759906vsl.4.1603316508776;
 Wed, 21 Oct 2020 14:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201016192654.32610-1-evgreen@chromium.org> <20201016122559.v2.4.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
In-Reply-To: <20201016122559.v2.4.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Oct 2020 14:41:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uq6ywMzQhZiEyifpsvyQiXV-YjAPJw81V5FxVkTSEuTw@mail.gmail.com>
Message-ID: <CAD=FV=Uq6ywMzQhZiEyifpsvyQiXV-YjAPJw81V5FxVkTSEuTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nvmem: qfprom: Don't touch certain fuses
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 16, 2020 at 12:27 PM Evan Green <evgreen@chromium.org> wrote:
>
> Some fuse ranges are protected by the XPU such that the AP cannot
> access them. Attempting to do so causes an SError. Use the newly
> introduced per-soc compatible string, and the newly introduced
> nvmem keepout support to attach the set of regions
> we should not access.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2:
>  - Use new core support in qfprom (Srini)
>
>  drivers/nvmem/qfprom.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
