Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FA2B5AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgKQIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:25:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:25:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so5063808wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oDCDOFuMCyzf722THYXakIEydXcxLkTRYIREuoCgsVE=;
        b=lZ2wJqM02LbFfCp3d3pEr84EDXOnljrvRqVPL8Er9sypd0nd8Pi/Bgbv1tSQ9uWHG3
         Ln+PHulLKnlU3iih/mOOlmux2kOsWhtqJ7cxxMvTsItoYv60BAfZO5AKfCt8hu36iw4H
         yOYhUCdgpFarxtfpSDflDqUh0+xV/icgUE7wHDCLWMcQ6lZjwK/T80VmqRfWqEaEf8Lb
         UdVcaIB846K29AluWVfXxkMlZ66+5959tsOjA0NyvSJei/c0EAs78NkS61Y4NsWqAsF9
         nCdoW+yXxLvB+5KVB0ZTO3gppazSaTnHs3Q/B7VieCsk82tVxTAzpIGLkk9T//9t/JeD
         Nw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oDCDOFuMCyzf722THYXakIEydXcxLkTRYIREuoCgsVE=;
        b=QymmSGnWOYD3hTyMIeuVJUYQ7Bst2H40tLE+4DMTjokZzzWzZWdhghV4XODTk8MBv7
         ies030XIL/PRplObDCQiVDo3Mh65tWAe0Wuu5injIWrss0h0dc7hLYgkq3CVUO+HOAMZ
         sAliR+os3g1mpRj5i2cRToIcJ2O1DtpjTfclbMGFX9DzwSPcRsaRq0qivUGiMbHhPM/0
         /tArXXauGKkiL6o5l+Vqyu/qZuMI+KpsyCLhG7S0BOX7yT5PE38TAf0x9ZPTx/lvQDe4
         4txx/qy9WHsMUKXdr+8NM18KRv/+9a1fQ9H0TH8xlt2Rhiq5nQrWJbTXpHc34RsKlpNL
         2Vmg==
X-Gm-Message-State: AOAM533+hd4JESdM3mFxoGkTFi2semqUksgfadJMMjHHmXxOB2ASv6oH
        IbEHs7cab4qNcjIIfLboUhIqsgGbtIebKkC8
X-Google-Smtp-Source: ABdhPJwPxLWHqNmgL9+5fFTaZzFQKhoJUypdtfK/Fnwv19SMKas+qVXe6Sbu9703WSbc9JyGoj2X+g==
X-Received: by 2002:adf:df88:: with SMTP id z8mr23701771wrl.113.1605601508989;
        Tue, 17 Nov 2020 00:25:08 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm20063698wrm.8.2020.11.17.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:25:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:25:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201117082506.GR3718728@dell>
References: <20201111170613.46057-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111170613.46057-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020, Tony Lindgren wrote:

> With commit 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack
> registers"), the cpcap interrupts are no longer getting acked properly
> leading to a very unresponsive device with CPUs fully loaded spinning
> in the threaded IRQ handlers.
> 
> To me it looks like the clear_ack commit above actually fixed a long
> standing bug in regmap_irq_thread() where we unconditionally acked the
> interrupts earlier without considering ack_invert. And the issue with
> cpcap started happening as we now also consider ack_invert.
> 
> Tim Harvey <tharvey@gateworks.com> tried to fix this issue earlier with
> "[PATCH v2] regmap: irq: fix ack-invert", but the reading of the ack
> register was considered unnecessary for just ack_invert, and we did not
> have clear_ack available yet. As the cpcap irqs worked both with and
> without ack_invert earlier because of the unconditional ack, the
> problem remained hidden until now.
> 
> Also, looks like the earlier v3.0.8 based Motorola Android Linux kernel
> does clear_ack style read-clear-write with "ireg_val & ~mreg_val" instead
> of just ack_invert style write. So let's switch cpcap to use clear_ack
> to fix the issue.
> 
> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Laxminath Kasam <lkasam@codeaurora.org>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
