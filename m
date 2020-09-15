Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC226AE58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgIOUCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgIOT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:59:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D6C06174A;
        Tue, 15 Sep 2020 12:59:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so4212228eds.13;
        Tue, 15 Sep 2020 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7RLNR+VirUb/uAODVT/yUShu7jNp0ygawaN/ILApZ0=;
        b=eB8YoYOSeUIcRxhZrwQXxQ7Ig+nfGWQ8X1kdmSJ6LXacs3Z+6fAoDmzyEuNu/UXFxz
         hFxMFIT4OwzrCM3u7RJQbbk9fOt2E/0QoAALEYHDE1RXD77ffAYyULXacOTWy6lvlGKL
         l/8T+XO2R7Cm4rcLfPr7Am+NMLDG2NwAMgq1gwISC9waz/kKvysx3B/0XB5+ZRHWfboK
         nW/sSOsc1fiX/10VLy5UWOyBOjWyOuKybtn3OiPKEUIORoYcpTFuvcUA7SI1vAunN+3I
         zMJA3pxY9vR3rv8Lhjpyk74PBEcu03w5oW/ZwbMMMxWbGGyRkvbDxY7s2W8meXR2Ee1b
         tDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7RLNR+VirUb/uAODVT/yUShu7jNp0ygawaN/ILApZ0=;
        b=QiT3wTqP8YKI6e1pTt+kn92Mk4iEB4qt0iIBI1We6wkr+vqgkrBoSa4DlvsGlfoKsT
         oih3gYgaSnimLMc+sS87It07AQUVx34XwxdOINQrjusIzSNqfGTVEr9JXxLHYqFoHUbp
         c4GDyALEAzfTLzf9EVzzo9mKsDGs69BRy7f0lPyx4rMpXFUKNRN3d2MyziE/R+ONt6d9
         b/SSDnH0io5dVKu+kk5x7h77C/2HXV4oTxaTpiigcDi7w/PNhnzi81Uh0wNJ9ZrC6T1w
         54WOyx67nPKmewDIPg+CsAfqI1mqot1DyMqq40jxw3KzEXuxCw2WxZC5Vj4ed+g2tqKC
         74lg==
X-Gm-Message-State: AOAM532izhO5ht6cTeOS1VIV7Sgup5WIykd1vCoW793x2pCzEQAEaAbA
        vwkyqAttD4u5nlchTk+5tc7jiHPj6M7iTfmD7JY=
X-Google-Smtp-Source: ABdhPJwVckPjSdsQxJxnp2l2KOi29DouQvL+6SIfp1k9vTQ6+NG83TwB0YzKYH20/8Q9jWJxUFa8oVUilVv1QfP7MXA=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr24940978edp.40.1600199977756;
 Tue, 15 Sep 2020 12:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200909160409.8678-1-narmstrong@baylibre.com> <20200909160409.8678-4-narmstrong@baylibre.com>
In-Reply-To: <20200909160409.8678-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:59:26 +0200
Message-ID: <CAFBinCCFmb7S9iR7_z7w5=_sOQZ6sMjo7YWdsETObyNa7MP6XA@mail.gmail.com>
Subject: Re: [PATCH 3/5] usb: dwc-meson-g12a: Add support for USB on AXG SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, balbi@kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Sep 9, 2020 at 6:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.
s/close from/close to/

[...]
> +static struct dwc3_meson_g12a_drvdata axg_drvdata = {
> +       .otg_switch_supported = true,
> +       .clks = meson_gxl_clocks,
> +       .num_clks = ARRAY_SIZE(meson_gxl_clocks),
> +       .phy_names = meson_a1_phy_names,
> +       .num_phys = ARRAY_SIZE(meson_a1_phy_names),
I wonder if we should also update the comment for meson_a1_phy_names
to understand that part I had to go back to the dt-bindings patch


Best regards,
Martin
