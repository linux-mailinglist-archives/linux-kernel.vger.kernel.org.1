Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E562BB7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgKTUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgKTUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:53:41 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3934DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:53:40 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z16so9995912otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm5oQGDIWj52Bp56wXe66Os4mWl35FpTbKVQbQHjiA0=;
        b=Q/ayshPw7MqVSNseI330O4AYlTJ4Xssc3g4VnY0j0IDdzFMEowMylO8koqPB01IYI9
         t6ZFW87UdnQlfA0XS8AhgxB6uQ4CUOIKV+qklIG+JulBiVk0DopsABcifPjKvwZEFQyd
         pMDL9hBMf8V10ABQl6nxC7VrDcQcLsUU+xZeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm5oQGDIWj52Bp56wXe66Os4mWl35FpTbKVQbQHjiA0=;
        b=tTtijpZYwWC+9pasCMa9TCmxb1NqJjL8HgBQG54y8R1z7ZJ+EdIHOgPAoM1ou/EbRG
         zeVE1mtS/fNM/dFJC3GT8wICgr/YTIU8WQchil94mBObOemj2D3U1+FhlUUgSgmDroBZ
         jJAUnwC7AwgXbjSC03+DmkOgOgdOeT4ZfJVJ329+lX4hUZebg9ItkeoUxFuKWQD2PIX8
         LJ514y6h9uTZNW2y8gIxVnZfbVmY0p3HTEJQhWgzKCq4NqPVvI9a9qIrTQnAPJNtJtpg
         1gtvZm4h1UbRZ9O5BakCtK/IO7aETbfpRZSt40HC6WWHQgypBCmIqeDCKdE+sFznp0KU
         9nXg==
X-Gm-Message-State: AOAM5305gupYRhTxrmQSumG2Do3jcAdLrWRhdPONCtzhq2GCajEZjTCl
        DCKm38VdVG9A4yIE93ZKN6mh/wnM5yYQGA==
X-Google-Smtp-Source: ABdhPJzRThQjBQfMzeg3V88YUAvKp9uK3QUJSPm2KH4DxwbmQLDCtYFhzRKtnqOB3XlKhdNOoxkhTQ==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr14972021otf.125.1605905618529;
        Fri, 20 Nov 2020 12:53:38 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id c190sm2222432oig.34.2020.11.20.12.53.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:53:36 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id f16so9985398otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:53:35 -0800 (PST)
X-Received: by 2002:a05:6830:1291:: with SMTP id z17mr15586229otp.229.1605905615285;
 Fri, 20 Nov 2020 12:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20201028142625.18642-1-kitakar@gmail.com> <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
 <7db5b6cba1548308a63855ec1dda836b6d6d9757.camel@gmail.com>
In-Reply-To: <7db5b6cba1548308a63855ec1dda836b6d6d9757.camel@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Nov 2020 12:53:23 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNPcXtTWS8pOjfoxiYOAcRMmsqZwXe3mnxOw388MCEu9g@mail.gmail.com>
Message-ID: <CA+ASDXNPcXtTWS8pOjfoxiYOAcRMmsqZwXe3mnxOw388MCEu9g@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: pcie: add enable_device_dump module parameter
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

(Sorry if anything's a bit slow here. I don't really have time to
write out full proposals myself.)

On Fri, Oct 30, 2020 at 3:30 AM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> Let me know if splitting this patch like this works. 1) The first patch
> is to add this module parameter but don't change the default behavior.

That *could* be OK with me, although it's already been said that there
are many people who dislike extra module parameters. I also don't see
why this needs to be a module parameter at all. If you do #2 right,
you don't really need this, as there are already several standard ways
of doing this (e.g., via Kconfig, or via nl80211 on a per-device
basis).

> 2) The second patch is to change the parameter value depending on the
> DMI matching or something so that it doesn't break the existing users.

Point 2 sounds good, and this is the key point. Note that you can do
point 2 without making it a module parameter. Just keep a flag in the
driver-private structures.

> But what I want to say here as well is that, if the firmware can be fixed,
> we don't need a patch like this.

Sure. That's also where we don't necessarily need more ways to control
this from user space (e.g., module parameters), but just better
detection of currently broken systems (in the driver). And if firmware
ever gets fixed, we can undo the "broken device" detection.

Brian
