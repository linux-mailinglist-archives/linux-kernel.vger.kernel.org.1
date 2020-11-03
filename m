Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AD2A3773
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKCAGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgKCAGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:06:33 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B90C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:06:31 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so19850629lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHMOmkhlRWyq97AfxS2rXTffakjk5zbzZZUU7niR7ko=;
        b=hv08MmKqPW2kwHXqrNQp2ucUSP5RIUEfSR109ZFv/+GCfvLMMs748r0m1pga8q2tP7
         NKctrAbp0S6uaLSATDuyAfO2MPnGC4c4ilXwVCDYmawkODWJXJ/TkvVBDFuStFWWuL1R
         ySxawLXlGOyaudd+de2xvN3RGV4tNKoNyIGq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHMOmkhlRWyq97AfxS2rXTffakjk5zbzZZUU7niR7ko=;
        b=D8cB0oiMBbFwHKzkCOtAnl78anJtjH8kEwFHlq7NL0XwlY9O28DaO4kL4u6ilKqlvV
         6E548Gk6UC+ZG1ROGZMtyVsPJ8/2afsrjdTOwzByBwW5WNcg6zjV13N737KWhjVjsTUn
         fhqlwBTfTBjDbBrm1Cq9qXGPRxnkCtrDEEnS0QGkntoF3XuJ+BQKxr8KPBM1RSaG5urR
         ovK29MmOdfp+qkgMTAEAuCGUkdiiulqCuxD+iJzY9s+V5MXAElZBn39XBwftdMLKwl+D
         1YJRa0eM6VLU1QFPoRk5xb5J28gOwWqoHvVJkBYKZIHHK4aYk+Z6mFahQFx9Q0wpRQ20
         n0Ww==
X-Gm-Message-State: AOAM533pTrCrN5l9dOqevULqtBuLCnDAS2Vi2lPqIwF6zmUEk3wj3qri
        HRBad0pVBu4VbA99DYUqflh0ytIMg9sz1w==
X-Google-Smtp-Source: ABdhPJw1F2oWzyt2ConAqdvO1ATul71/sCe5jM+6GsbMN0GSuR0yTcoJasUnTawUhVtEcCmvPMHfEQ==
X-Received: by 2002:a19:3816:: with SMTP id f22mr7007439lfa.210.1604361989308;
        Mon, 02 Nov 2020 16:06:29 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f6sm3245674ljg.83.2020.11.02.16.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 16:06:28 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id i6so19834318lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:06:28 -0800 (PST)
X-Received: by 2002:a19:41d7:: with SMTP id o206mr7188801lfa.396.1604361987822;
 Mon, 02 Nov 2020 16:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20201102112410.1049272-1-lee.jones@linaro.org> <20201102112410.1049272-42-lee.jones@linaro.org>
In-Reply-To: <20201102112410.1049272-42-lee.jones@linaro.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 2 Nov 2020 16:06:15 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOobW1_qL5SCGS86aoGvhKDMoBzjxbAwn+QjHfkqZhukw@mail.gmail.com>
Message-ID: <CA+ASDXOobW1_qL5SCGS86aoGvhKDMoBzjxbAwn+QjHfkqZhukw@mail.gmail.com>
Subject: Re: [PATCH 41/41] realtek: rtw88: pci: Add prototypes for .probe,
 .remove and .shutdown
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 3:25 AM Lee Jones <lee.jones@linaro.org> wrote:
> --- a/drivers/net/wireless/realtek/rtw88/pci.h
> +++ b/drivers/net/wireless/realtek/rtw88/pci.h
> @@ -212,6 +212,10 @@ struct rtw_pci {
>         void __iomem *mmap;
>  };
>
> +int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
> +void rtw_pci_remove(struct pci_dev *pdev);
> +void rtw_pci_shutdown(struct pci_dev *pdev);
> +
>

These definitions are already in 4 other header files:

drivers/net/wireless/realtek/rtw88/rtw8723de.h
drivers/net/wireless/realtek/rtw88/rtw8821ce.h
drivers/net/wireless/realtek/rtw88/rtw8822be.h
drivers/net/wireless/realtek/rtw88/rtw8822ce.h

Seems like you should be moving them, not just adding yet another duplicate.

Brian
