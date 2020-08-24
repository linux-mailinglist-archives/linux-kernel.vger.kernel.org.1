Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE02508E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHXTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:09:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:09:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id u18so9781804wmc.3;
        Mon, 24 Aug 2020 12:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkYuZ+AU/xmAHBPjtK9v9v+eSex3YmMEccb9nQ0uFOg=;
        b=YDbdWh6Sf+rnXJK525OJXzbExo+KGCvF7M9T2/tnRY0ZGHjg6y0KgtDqvGHWPRLdS1
         YxP5bD0RVtWohGGfP0KQQxmVOl9vspQbZE3et/y5aod64ap6UpkwBeuVdyn5s/zo6g+p
         yIvzw0RkG3cOU1u29tc6i/AI0v++d02mdee9ThYC6k7j+GdvA58sD95zEBNO6MGKuh9Q
         Hmni0aauuziq03Cpt1M6qP68GjPQbd4URfARf/H5g5pItJJNeGoKgvGOp0dDbAe5zcKj
         IN1H1MLz8k2KNuljUi6CoKvNWEJMBl8QwLtPp8qzq8ObhMmSdSDbDLbdsgayNPetGIfG
         VyEg==
X-Gm-Message-State: AOAM5319HyF/l7dLtPmAhB7xqUYrzNzh4pICffzDvpzEYANqw8voa4s4
        r7bU0FyXBYJaLjv8wooULFI=
X-Google-Smtp-Source: ABdhPJyqfbE+cdOfZ4IGBp4XY991J2Mg2zGm1lFpUETzbAozdFqX/22fzbavZUIVBbh0wo3qFzcasA==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr672535wma.60.1598296160696;
        Mon, 24 Aug 2020 12:09:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id o66sm954229wmb.27.2020.08.24.12.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 12:09:20 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:09:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mm-var-som: Add Variscite
 VAR-SOM-MX8MM System on Module
Message-ID: <20200824190917.GA8631@kozik-lap>
References: <20200824160247.19032-1-krzk@kernel.org>
 <20200824160247.19032-3-krzk@kernel.org>
 <CAOMZO5DquPR9BmQP0kZfTqNJmRabPe1Vtc801M9CVCPFCd1usQ@mail.gmail.com>
 <20200824185713.GA5343@kozik-lap>
 <CAOMZO5B71L7+d_bUY2D=fjhhg5QFEnTsq=U84+7k9nhhmxV04g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMZO5B71L7+d_bUY2D=fjhhg5QFEnTsq=U84+7k9nhhmxV04g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:03:53PM -0300, Fabio Estevam wrote:
> On Mon, Aug 24, 2020 at 3:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > True, I'll fix it up, thanks.
> >
> > Any comments for the Symphony DTS before v4?
> 
> It looks good.
> 
> One suggestion is to remove pinctrl_pcie0 for now and add it when PCI
> support is in place.

Indeed, a left over from a removed PCIe node.

Thanks for review.

Best regards,
Krzysztof

