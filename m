Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753B2D805C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbgLKVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgLKVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:02:15 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D7C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:01:35 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id j8so2479706oon.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6i90QejRWkmIAtoo2m52V+3cpqqI+x/pjz3yRdPtZpM=;
        b=hpKUqu/Ei3mZQTjZ91rz/kKo3nKpA0AKeWbNDuUaE9evS19WtP+NAumpYEfWIGuQqk
         bWFeDC/SuID+CEZ+2NmcHMrgJjVoHwYzajS8lCvBAp4h9V39Mo73Nqj09TKEjbXOafnf
         +qUnX2oA5/GHJIpjW3BOXLQAt/P5UoxkmCz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6i90QejRWkmIAtoo2m52V+3cpqqI+x/pjz3yRdPtZpM=;
        b=ITUMHupFRnLfX3C75xLVsLUSJyswfdAJNqMLK+db2JTpcivDDfbCdI3dszkF/fbHIg
         CY6i9eBbcDMeppiN52LgS5DkoVbJVvaHYgfc0j06ex9AZu6OuzsX8YtQccXntnONc1xU
         9TwEXqG/LoPEYxo5qXom1YaXzvx4hIYQuMSpdDoZMbN6HnDebWf7tldMBqdrQ7NCsJgp
         rym89mYfYqtdjDjQLU3RcPGv4a9/1/fJFTo0q0UvEFdCXYO7fdyeBXgrMbOCemX1ouhY
         UkA21ikjZNcRyPAAlrrp2XQ2ZP3DkeSwLxiXOF2w9dGlG9Lj/UjjQUsH0GtIG4ejaRQ6
         9aDA==
X-Gm-Message-State: AOAM531VDZGkURFn4kw4AzLZMd9CGwOezk0Igz09gYhlSoTt99uxumRc
        ny6njN//mxHvf7dZPWG9MXl208sRJ2RHXQ==
X-Google-Smtp-Source: ABdhPJzprHr280jEdeYR/TIgRKI5hM2Gk9E1RVeKZ+F5jQ1SU4KqBkXl2qMu5acHepNcrQCiVBFO7A==
X-Received: by 2002:a4a:4e87:: with SMTP id r129mr11591975ooa.4.1607720493492;
        Fri, 11 Dec 2020 13:01:33 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id w8sm2067963oos.37.2020.12.11.13.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 13:01:31 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 11so9499441oty.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:01:31 -0800 (PST)
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr9095089otf.229.1607720490665;
 Fri, 11 Dec 2020 13:01:30 -0800 (PST)
MIME-Version: 1.0
References: <1607713210-18320-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1607713210-18320-1-git-send-email-pillair@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 11 Dec 2020 13:00:00 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN5UF0KM=xV9e8jTa4XxZ5Tu-yb4yvoaw+56GHx8hf8=A@mail.gmail.com>
Message-ID: <CA+ASDXN5UF0KM=xV9e8jTa4XxZ5Tu-yb4yvoaw+56GHx8hf8=A@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix error handling in case of CE pipe init failure
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>, kuabhs@chromium.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:00 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Currently if the copy engine pipe init fails for snoc based
> chipsets, the rri is not freed.
>
> Fix this error handling for copy engine pipe init
> failure.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Fixes: 4945af5b264f ("ath10k: enable SRRI/DRRI support on ddr for WCN3990")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>
