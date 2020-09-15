Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5663269ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIOGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgIOGtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:49:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:49:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so1262237pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8Y8jIfnu2JVAS1j+0KEUXwHHRIpYqRhW26zB0qzDvU=;
        b=O1fDZO0OTcPfVTyEkhiGWvaakbkTxJU0OJFtzwi70nuSM1bxWIrUPTq7zpjOn/QhnF
         xYkuFux85KyXuG+8V3yUW0kIh/CaModSD05AlDgShdaoLkOfvfJSsxA++A1Md6hvO7Hp
         4+yBWtCiJm9Lrkc3p7tDW4BiNyWrbAzj3EgZb4dl3CdNLJkgolPXFA2I/JT0JbVZviU1
         182AQxDmGBLRJu4xt1KGfb5dDHSxV7vKzFLIdhZWz4Y6sMwC1dow6rOBXoYizPMdeupQ
         74ROpxiQWU+87RcvEGrA8sprQhgfCACC91xIWHN/MSsPkRBpSsZ8msTFLxwlMzob3EhN
         KeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=s8Y8jIfnu2JVAS1j+0KEUXwHHRIpYqRhW26zB0qzDvU=;
        b=W5aOV6Ehg33h0zXxkexxOYvzCb5QUgzqq0RuCjaVZ0j1oArAbSyZvAuiKcIAIr8v5q
         l4HvcFpAozMYAdJUxXMfFKZCsq7VavtUvqzvf55t5J6GoriT8HfhMbhRJICPLAf5cslu
         fgJGRPPj70UJGItuebugxPTJ6d1qk/wN+Y5zTsSaRxQ9TN/zXTkW0f/CT3PBRlrRWcqH
         uCC1Y2KuC2HMZ2va6hA0zqUac1mEVScR0gs/zc53Yu3wka+pPqn4piFshCChKw4dyduo
         cQ2DcKOQc4VEbM3YQf5iCzWQcnyrGQj0MChr0zBd/wLFmMhayN/0+vtigMmWM4t0OaOv
         nQSQ==
X-Gm-Message-State: AOAM532UNRmZxsj7MFM9T9dlwclZv854F+wJgpg7s0PIqnEoas+3gqK3
        RfV8dQbf26ZOCHFp0RxmkAtAHKgeBU4YBhtT
X-Google-Smtp-Source: ABdhPJwKAZXEdCnhPxhlCR79rvCV/I50ra4JqXvRqFle6q52sz/IfSaVsbgToE+24Qk/c5ywvs0QzQ==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr2748960pjq.95.1600152549827;
        Mon, 14 Sep 2020 23:49:09 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id gb19sm11059249pjb.38.2020.09.14.23.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:49:09 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:49:05 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 10/21] mmc: sdhci: UHS-II support, dump UHS-II
 registers
Message-ID: <20200915064905.GD2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111034.29456-1-benchuanggli@gmail.com>
 <bd374ef8-8b8b-031b-0e59-d6f881cb9330@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd374ef8-8b8b-031b-0e59-d6f881cb9330@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 05:04:54PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:10 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> > for informative/debugging use.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 37b1158c1c0c..c2f6923d296c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -111,6 +111,30 @@ void sdhci_dumpregs(struct sdhci_host *host)
> >  		}
> >  	}
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
> > +		SDHCI_DUMP("==================== UHS2 ==================\n");
> > +		SDHCI_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> > +			   sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> > +		SDHCI_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_COMMAND),
> > +			   sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
> > +		SDHCI_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
> > +			   sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
> > +		SDHCI_DUMP("Dev Int Code:  0x%08x\n",
> > +			   sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
> > +		SDHCI_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_SW_RESET),
> > +			   sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
> > +		SDHCI_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
> > +		SDHCI_DUMP("ErrSigEn:  0x%08x\n",
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
> > +	}
> > +
> 
> Let's make this a host op instead ie.
> 
> 	if (host->ops->dump_uhs2_regs)
> 		host->ops->dump_uhs2_regs(host);

Sure.

-Takahiro Akashi

> >  	if (host->ops->dump_vendor_regs)
> >  		host->ops->dump_vendor_regs(host);
> >  
> > 
> 
