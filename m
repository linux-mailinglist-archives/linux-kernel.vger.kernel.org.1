Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3B2D839F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391213AbgLLAsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733022AbgLLArb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:47:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257DDC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:46:06 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so15843775lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p8BkEtCdcNBP/TpCqa88TfNrEdwTBnXM61elkmQDlU=;
        b=vPmJzs+nnMzMYiLeSl4C70AwwAUmtSXcRtz7EHFhXOG3+HSYoFdEGzQYdbnIfuLhe1
         cpLA6/bKDco/ZW56K0yojauLy12p9RMJ4MYQUMAZkQKn1JGQikvuaZfR0PCAwR/VHwqu
         l8KSlmgfW9XQH81QbMWcZWDg6fTfP5u9gInsHFToPISthtmCvix2Zi4MyAVk8WOEDUbJ
         6rVaVkrA8lMaHHNzl8tzPLP3FKzwRwCbx4UWePv66IKRrK3BWVszh2/HuHa0/BXzK05/
         +RmxfJa60vjGUHEMlcdmB6LQFBStfB7tIZX79j1mfET935nYYecl+y81TGJ83zzfgTnD
         hTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p8BkEtCdcNBP/TpCqa88TfNrEdwTBnXM61elkmQDlU=;
        b=M8v/8E4Cd5UMEEZxUrxkUHXvt4d2aIaRO8aNSHYlPNg4KQcBedRwA4SXG/TkxeTWW8
         7rBjANl2U6cwR8UI/t+NIAO+mxWMIoQ3jvO3iW1MXcjZzi8mD6OTyxLk2g4/aW1HLWRK
         vTKGeZ3JHV0d5L2U41N5a0XFySjYxhvEiH4q9PzWkjwRm9hc5qeq5w71BLgM7HmRa4rn
         sk1KZ95xbKKJUFS6aXdjZBvSrYIUXRP99fDezqfRRCOEaaGmfxrYjCbRs8qUpiI5mQXc
         qiTqrvbFWjJBG9SJ0jlBgVuQat176/L9V4VLZA8u9L8jAVyGPzBV8OJesH5mhkSin4f0
         P31Q==
X-Gm-Message-State: AOAM530BDFSTna0edhss8ggLhtzBJ2RxuLZxXJMXew3lOkDL8pfmmypu
        sfVNSHSUt18X3sWT+u5ZUDdKRDWiqNsE5pe1887J/Q==
X-Google-Smtp-Source: ABdhPJw+G3KfJG3M7IoDnPiDCepv2YgkNV/jArpapqMifWmjCRwgJbTiMDpguzIYWZxJHM0zdf1udksfd+uvUSH+FdI=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr2692550ljo.368.1607733964618;
 Fri, 11 Dec 2020 16:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20201210192536.118432146@linutronix.de> <20201210194044.065003856@linutronix.de>
In-Reply-To: <20201210194044.065003856@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 01:45:53 +0100
Message-ID: <CACRpkdbKZzaTq+Am6q38Ya5wuUjiMbLE5g2i8bb_mJEWTkXgCg@mail.gmail.com>
Subject: Re: [patch 15/30] pinctrl: nomadik: Use irq_has_action()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 8:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> Let the core code do the fiddling with irq_desc.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose you will funnel this directly to Torvalds, else tell me and
I'll apply it to my tree.

Yours,
Linus Walleij
