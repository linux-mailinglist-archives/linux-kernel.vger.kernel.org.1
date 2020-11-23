Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E992C1136
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbgKWQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:59:03 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44355 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgKWQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:59:03 -0500
Received: by mail-ej1-f68.google.com with SMTP id k9so9490095ejc.11;
        Mon, 23 Nov 2020 08:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzvwGaD9/OHMgznZpLRtc18jBESjKRSL5NHyPBpz3bE=;
        b=FbHz+yU7CdiKNJgHTHJZO+aGgDPJH05d/kbCP/MrJK3S4Ra9Q5+fHv8o5YPmSRRGg4
         VM9sf0WAFeOL1WnYF8Byjee5HOXsaAp9BkSAwJ2MxtgzyDsqYolj7+0HeQvrysncf31g
         pvgG/YQISpUH/3NHpu+uHcQAYfNkllIoFaQa/r2sE2jXu2TgmZJ55Kr9TVcjInsiT4jQ
         gWVbSDynt8rkiT86h9Gt278U1JiunHSjug8GvgF4CG0uISutFvcEe2K9dxowoOd9zogv
         7adEiDzPCo1pOWW6XgHHYefOpJBKcIDe28U1Z6LggC5ug21MRttRw67Iijg57llYq1Mh
         +zpQ==
X-Gm-Message-State: AOAM533F/4T1N8JPFOpK/gH6UgyflXUNaX2mCcKhv8leZkaMb05IYj7E
        Y9x0NM6e2ruxb5xBmKl2nQo=
X-Google-Smtp-Source: ABdhPJx8QBW8QFVwjDZADkajTlp0sdT5KxLzuXfAW5mMQG9nVWU0QE/iJo+TiJ/og54KjLJtRpsapw==
X-Received: by 2002:a17:906:7e55:: with SMTP id z21mr496501ejr.154.1606150741074;
        Mon, 23 Nov 2020 08:59:01 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id cn8sm5335926edb.18.2020.11.23.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:59:00 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:58:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201123165858.GD214677@kozik-lap>
References: <20201123095108.19724-1-alice.guo@nxp.com>
 <20201123095108.19724-4-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123095108.19724-4-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:51:08PM +0800, Alice Guo wrote:
> Directly reading ocotp register depends on that bootloader enables ocotp
> clk, which is not always effective, so change to use nvmem API. Using
> nvmem API requires to support driver defer probe and thus change
> soc-imx8m.c to use platform driver.
> 
> The other reason is that directly reading ocotp register causes kexec
> kernel hang because the 1st kernel running will disable unused clks
> after kernel boots up, and then ocotp clk will be disabled even if
> bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
> before reading ocotp registers, and nvmem API with platform driver
> supported can accomplish this.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
