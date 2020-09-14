Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081B26879A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgINIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgINIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:52:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9228DC06174A;
        Mon, 14 Sep 2020 01:51:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so9817366wme.0;
        Mon, 14 Sep 2020 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxikpLF2+OFbtV/m24+r7ZSnG57yMpe1VFQzaF4Sh7Y=;
        b=B1dtRXvaJGYTVutAJNv3z79M7R6GBPsh2uIjFBZbWBF7hJp40praNGFVH7FUKE5LCg
         CVuRMmh5gqEsJc3ipH65REMFaszMwap7k0x5vKSP9jaQnJzVOK6m+gDZJjTfUKh6dK/h
         vODikBsj5ASKoiGlBFVHxTWaPOwbLcgA36MC/BhQLndrzWxziYjhgGLnyFru3RW0SGXC
         rUCs2ICuswFkHSbyzH/Dv9T6FswXONoNtH9bXiYl6KB0yHsjRoTp3LNFFzgNHmcr+Oxw
         WoImJWAPfSL0BsJCYlYWrfndV9J+U4wG3/I6+UCo7AupfHU5TlgMaiHdrU3XACHL0K3F
         cJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxikpLF2+OFbtV/m24+r7ZSnG57yMpe1VFQzaF4Sh7Y=;
        b=qMVzX7RlZhQqO33XOVwSBlv3fv5zbH19XsUyFyPA+lf8eeKIoX7JKSTM1LDu/5rvYc
         cqypN6NDwnnkN6tOQcWuYR4TcjSmplN6GZRqeeWU1shU/rBL4tp5jIDzNRZlmgvo/eV1
         d5zhJmkK5XBut/kiSL2xQ0otD5v5lu57B8lArImFqBJ/ws5hFDD7hJrv6/dg6cyu/JVf
         GldOQpgDw+p54qcwEf5kmsC6bVeayttCKFehU1PPhxnzaLcjNTrJifBcfVEePHhN+sXI
         o86DdcI6fe42tNMiuAsgcEZKidByJx86ozeARrkKipkqOods6Z4EUFO67UpZixUUAw4l
         wJJw==
X-Gm-Message-State: AOAM531Fzl80oT7zT4OI7tYpnjY8A+av+V8yhUQfdoBxh8L8uJRRLnmn
        1a/vrdtiojFxXIHm/YmxNSo=
X-Google-Smtp-Source: ABdhPJyCifLIgNPlZsCx1owCD98no3A41z96/U1P34QFDGdnvOhcuAVFARIco+QqAJk7eXqTT8/QSw==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr13810557wmc.176.1600073518255;
        Mon, 14 Sep 2020 01:51:58 -0700 (PDT)
Received: from BV030612LT (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id h76sm19258310wme.10.2020.09.14.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 01:51:57 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:51:54 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Message-ID: <20200914085154.GA8474@BV030612LT>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
 <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
 <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
 <20200914070227.GA4491@BV030612LT>
 <b9053e939dea2b67ba9804aec1a110f5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9053e939dea2b67ba9804aec1a110f5@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:07:18AM +0100, Marc Zyngier wrote:
> Cristian,
> 
> On 2020-09-14 08:02, Cristian Ciocaltea wrote:
> > Hi Marc,
> > 
> > On Fri, Sep 11, 2020 at 05:22:41PM +0100, Marc Zyngier wrote:
> > > On 2020-09-08 09:20, Cristian Ciocaltea wrote:
> > > > This interrupt controller is found in the Actions Semi Owl SoCs (S500,
> > > > S700 and S900) and provides support for handling up to 3 external
> > > > interrupt lines.
> > > >
> > > > Each line can be independently configured as interrupt and triggers on
> > > > either of the edges or either of the levels. Additionally, each line
> > > > can also be masked individually.
> > > >
> > > > The patch is based on the work started by Parthiban Nallathambi:
> > > > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> > > >
> > > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > [cristi: optimized DT, various fixes/cleanups/improvements]
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > 
> > > Who is the author of these patches? If this is a co-development,
> > > please
> > > use the relevant tags. Otherwise, the author of the patch must come as
> > > the first SoB.
> > 
> > I took the authorship for the driver patch, as mentioned in the cover
> > letter. So, if I understand correctly, my SoB should be moved on top and
> > I assume I also need to drop the related comment line.
> 
> Not quite. Please look at Documentation/process/submitting-patches.rst.

Yes, I have read it, but most probably I missed the information that
clarifies this authorship change handling.

> If Parthiban and Saravanan haven't authored anything in this patch,
> then drop them from the SoB list.

Sorry I haven't properly explained this before!

Their contributions to the driver code stopped in 2018, when v3 of the
patch series has been submitted.

> If they have contributed to the
> patch (which I expect), then their SoB must be preceded by their own
> Co-developed-by: tag.

Starting with v4, the work has been done exclusively by myself.

> To sum it up, it probably should look like:
> 
> Co-developed-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Co-developed-by: Saravanan Sekar <sravanhome@gmail.com>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> This is of course an assumption, and you should check it with the
> individuals above.

I have recently contacted Parthiban and he agreed that I can take the
authorship. So I should proceed with the 1st approach?

> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...

Thanks,
Cristi
