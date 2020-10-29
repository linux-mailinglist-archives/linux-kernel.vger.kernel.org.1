Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5C29F414
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJ2S0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJ2S0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:26:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29599C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:26:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so4218340ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qrar9dmRm4zwdoSrcFwY/wHsTikC9FDxVpd6kfA/rMU=;
        b=nC2+zmQ8BbqhTLDDWr43qkKPAGZIIiM2rE/6dNa6mi0K1d6OQl1UMc7FfPoJwxy6ps
         x6jtM8eI+8jRP2aq0Xv4xlQhGD5c3KvTJS3AkuzG/MBnjWIK7DrpieObKzkmYp5W8vby
         DspwpJHFYhIGvSsF6tpHBWFC3HDR93XfkClwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qrar9dmRm4zwdoSrcFwY/wHsTikC9FDxVpd6kfA/rMU=;
        b=V4VGhG84ljBzMC/I1c1WgFz63uIcweQLPzeT1/SKKiXzAiEt5OKH2vI1AuVcDLWCu8
         mgGV/FgyCZHZD1Fyn4a4GRbTqIwgOwVcZN7xcc8P7t6XIJHVxleb/sMTPBPITcexgLMZ
         e8pcjqRQzNV7KNwFyvL+PSIgUo92/9Nfaa7gC9MWZDJJa+UDhN7R8Cb/cYXg91PMVx1L
         vuOxRGvaUJOFd3/GtFZTEWB82AHxV6Ai+6wiTq48mC9Wg1JEBP3ycfRcWFuherOreZeu
         +oAxU08+ZA1xZflg/9/0uleU9KDAf+lOEPgAvdWv76DU067XKvm5541RFtMu/wS82Skq
         +8bw==
X-Gm-Message-State: AOAM531WrYQTHVda+Ngp1Y9nXNLm2BoHrdGwkRrm64WJyrS1nDcxJRK9
        dmn76XTd3GC3l7VDpqmfBNPd/etOgaO0nA==
X-Google-Smtp-Source: ABdhPJxNFflbr74wxxMkIuzDHNvMZy8Xp4XeEE+IYowyqto6785NquzN8+13U47rdNIwxQYIMfYW0Q==
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr2333574ljk.445.1603995969220;
        Thu, 29 Oct 2020 11:26:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v18sm355536lfd.162.2020.10.29.11.26.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:26:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a9so4557180lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:26:08 -0700 (PDT)
X-Received: by 2002:a19:41d7:: with SMTP id o206mr645895lfa.396.1603995967726;
 Thu, 29 Oct 2020 11:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-2-kitakar@gmail.com>
In-Reply-To: <20201028142433.18501-2-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 29 Oct 2020 11:25:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com>
Message-ID: <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mwifiex: disable ps_mode explicitly by default instead
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

On Wed, Oct 28, 2020 at 7:04 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> On Microsoft Surface devices (PCIe-88W8897), the ps_mode causes
> connection unstable, especially with 5GHz APs. Then, it eventually causes
> fw crash.
>
> This commit disables ps_mode by default instead of enabling it.
>
> Required code is extracted from mwifiex_drv_set_power().
>
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>

You should read up on WIPHY_FLAG_PS_ON_BY_DEFAULT and
CONFIG_CFG80211_DEFAULT_PS, and set/respect those appropriately (hint:
mwifiex sets WIPHY_FLAG_PS_ON_BY_DEFAULT, and your patch makes this a
lie). Also, this seems like a quirk that you haven't properly worked
out -- if you're working on a quirk framework in your other series,
you should just key into that.

For the record, Chrome OS supports plenty of mwifiex systems with 8897
(SDIO only) and 8997 (PCIe), with PS enabled, and you're hurting
those. Your problem sounds to be exclusively a problem with the PCIe
8897 firmware.

As-is, NAK.

Brian
