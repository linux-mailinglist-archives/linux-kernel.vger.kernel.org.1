Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A692BA22A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgKTGPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTGPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:15:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF057C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:15:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q28so6444299pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AyMJ5Jjc9M0+Vn5DFGods4kzuxVeXcTZ/Clleml5bcU=;
        b=iETF/GNsaidhEBNG1AcL7VZuw6ai5ZFYpWTmaUYVpBD2H/oU4JQXTrPthez15tYgHy
         UxMM9ai7PiyUoLctdGQO4U+5DfIUUuooBtHsTrlalSJRJ+pWic+4hTHH9haBQI82CNaz
         k5ss1ujoh3lcLPepB7KKDzX981aWhEUjfGRKcao/s6jGw+gf7N6D7cpdZTzjjcsUG8f3
         c+na6OwEQRywXmYcHFtqkNOnYmwdCPmv/kgdRmg6ACopLz0jvBKzqZCiAmGwpEOUXRZb
         YZXnqIIOrHDg0s1EgU/LJ4vMvRg87GEQaWY2QeXHqaKTnWFV5E+WxQfJRlrvw1xEgKkZ
         pUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AyMJ5Jjc9M0+Vn5DFGods4kzuxVeXcTZ/Clleml5bcU=;
        b=QgopBjNnZdu4fnB+/yWEDgeuisCu7yp9dZu4TZnilyM5Y7EAM1sGwgXTtHJQkWySEi
         BUMxQqlXAD3LD+nTvTx91jr8BdYcSxPOc4wd+gNuL5t/WsXI36NJ16hClu4kwkcAaXES
         e1mum6SYkgxblWd6dAqfM54DhNcxBPN5hrM/G5oOyDlLPanwv/tuPaNCimWrqBT21aAE
         sSYfEcxd5jkLkgOqoykiW7YOEveEn7C2pXFqg5V9aTQu+H30W0o2hbQ8Rf7LfWVMHozj
         dX9L4T+V7EcHpiFnXZzk0DwPzsLV18fnpMq7tPYCSyloPd1cDGwdivpRn3iD3hsetCvy
         gMEw==
X-Gm-Message-State: AOAM533SUJ9o34YpEWIALpQy0BA8XFKtc8V2Z9WzErlzRsQYzqTiMMHm
        xY62I69mkZ3LVW+sdDQ26zAe
X-Google-Smtp-Source: ABdhPJxAvE+E3O+sd6rYhWFr1N80x7ojCA44s14+QLRWptjp62e5AsrHubXbu0e8rna028fe+/8cKA==
X-Received: by 2002:aa7:8759:0:b029:18e:f030:e7a9 with SMTP id g25-20020aa787590000b029018ef030e7a9mr12365779pfo.60.1605852920203;
        Thu, 19 Nov 2020 22:15:20 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id y14sm2054599pfr.73.2020.11.19.22.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 22:15:19 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:45:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Bhaumik Bhatt <bbhatt@codeaurora.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, cjhuang@codeaurora.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        clew@codeaurora.org, loic.poulain@linaro.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: Unprepare MHI channels during remove
Message-ID: <20201120061512.GB3909@work>
References: <1605723625-11206-1-git-send-email-bbhatt@codeaurora.org>
 <20201119211046.64294cf6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119211046.64294cf6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:10:46PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Nov 2020 10:20:25 -0800 Bhaumik Bhatt wrote:
> > Reset MHI device channels when driver remove is called due to
> > module unload or any crash scenario. This will make sure that
> > MHI channels no longer remain enabled for transfers since the
> > MHI stack does not take care of this anymore after the auto-start
> > channels feature was removed.
> > 
> > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Patch seems reasonable, Mani are you taking it or should I?
> 

Since I already picked up one qrtr patch, makese sense to pick this
also.

> Bhaumik would you mind adding a Fixes tag to be clear where 
> the issue was introduced?

This is due to the MHI auto-start change which just got queued into
mhi-next. I don't think we need a Fixes tag.

Jakub, can you please provide your ack so that I can take it?

Thanks,
Mani
