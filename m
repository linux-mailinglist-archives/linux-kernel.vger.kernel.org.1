Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAC29D596
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgJ1WFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgJ1WFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E448C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:05:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d25so870912ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RgMxKcrxfWcCrPGpUNDV3hziCJkG59Qu7/5cCUuIBQ=;
        b=IyTD+Hke82m6aRlezzLOka0h4MepZinimVyEYyRZqSWlegMfn0lYc8H/2OUV8yMtSq
         tMzhUkYkKnHUX8dcuDZIbjXEUAObRpf/BEeMw+pgRYZiIMJ96queOmywsDyVJ5OxWOxr
         HEl8PS8ayrpRyfa9dqdJZlbekwaI2p8yDlWxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RgMxKcrxfWcCrPGpUNDV3hziCJkG59Qu7/5cCUuIBQ=;
        b=CetSrZVk1MoawFiu8/Apolv/zoEOPobUAgK2y4JZS2UHsdGkfHPfaBtdvYv6yt3X1x
         VuSFMG1ZUzSrdCePWU/g3dPHTDEhMCPVvZCJOe9lm2KYvu6TLxAZzv6sIzWgzeLg0OZU
         j0s2lCFCOtZKk6r89Z2EKqVfcn0q9Ufd3i6V8+QB9nmZNV+fNkQuylp4Os2MU8bi+Mvp
         9aUF5iIFUw14Bu4wlZ9+oYwe0yH8Quv0Yp2RQj38BRKnmPP7Q4LU8vqOf/pDwV5LiU+n
         UmATFlwg0+/Ec/7L6F38tYUreWS3KC2yJ0FWSbgKiChI37tbiu6DAclvmUdww0/aTycj
         IasA==
X-Gm-Message-State: AOAM530xjOsIyk7AiOTBDQBnSzHGXXinZAlbHxndMwpIfcA/AlW+c3F0
        kEW+7+swbZToh2GmMsjshVhZdEZi/cXD7g==
X-Google-Smtp-Source: ABdhPJy3ms7ueMYmVIgk1i5+gsODtxvLuXXtkffnmXgFWmMJ3ZQgwaG8l5sNXwqyYOiDimTi3UkpTw==
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr545562ljj.134.1603922710748;
        Wed, 28 Oct 2020 15:05:10 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d13sm78647lfb.281.2020.10.28.15.05.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j30so767586lfp.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr450997lfi.89.1603922707215;
 Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-3-kitakar@gmail.com>
In-Reply-To: <20201028142433.18501-3-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 28 Oct 2020 15:04:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
Message-ID: <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mwifiex: add allow_ps_mode module parameter
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 2:56 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> To make the ps_mode (power_save) control easier, this commit adds a new
> module parameter allow_ps_mode and set it false (disallowed) by default.

This sounds like a bad idea, as it breaks all the existing users who
expect this feature to be allowed. Seems like you should flip the
defaults. Without some better justification, NACK.

Also, I can't find the other 2 patches in this alleged series. Maybe
they're still making it through the mailing lists and archives.

Brian

> When this parameter is set to false, changing the power_save mode will
> be disallowed like the following:
>
>     $ sudo iw dev mlan0 set power_save on
>     command failed: Operation not permitted (-1)
>
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
