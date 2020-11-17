Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A232B58CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKQE2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQE2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:28:48 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE9DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:28:48 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so12698338pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7vfMp2CgOZrJWNS8u7PdOtQnuroqM5mBFyhtl9q2E4=;
        b=XP6YVr0GU4hNQM5JQO3viE5h6gBHHKY4opfoOiQYMGWWwkJKrRuYWV/mUQ7Ru3NIcB
         DfaKEITBpsAArx3yF4S9Jm4ViSQaPjRU8yawS+HqLkyoWnfKL8UlNdSEdC3Lbv8uCEpi
         AggqPDI2k3tPN+gFiH7JUGQKqO2FLns0pYDAXtYdLAJ3t4M282NlnoA4UzyHjV3FClpY
         ce5q0rRcUCfgpORVBLAz9Ikz8vPxNzbxlSJDTaPe/28ne9ZNVG5xOkBjEiOpaNUuBTFi
         w7iZyvZh8p9K/4bTnn8MXGSS3H6CnY/GQJG3HbX3NCI1St3TMQhnv2YTDEaiT14DzBWD
         YXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7vfMp2CgOZrJWNS8u7PdOtQnuroqM5mBFyhtl9q2E4=;
        b=KYXncEPAaec18kF1GVPm3t0/0pHw/FgxFb7v7M3rBLU2LoiS10Aa7DdbOUYrgLYXX+
         GRqD+v0g4elClP8UH9ZttEumwngkSt6ZXH5YCd9GxFunSzV4xTfT5GXdi7/YXaYzXgGd
         AU4qB1DR3ohEJ20alHJZ9Pdt8V5pWCIkswxQMHKlINx0dKZfMwSL9nJsdRGzosYC4m9W
         rjaR0QS8w2vUdumkrU3qZPSLEQe4jyrqvGnVda8qAyv4WJse9QB98F93F70EkVc3TXjB
         lcmlZJaLeM7zvEv+JTqVcYNhpXvwOkePt8KyO5v/t62bBXqYbw17QbQLMtK1Xng6+M8V
         XZwA==
X-Gm-Message-State: AOAM532GH21qByfacDUJkUc9WS/6b8dbf0U1URU6t0n2/01Efczzo8+b
        RIGpWwS5957scEysf94z2Bs2D1aTemmU
X-Google-Smtp-Source: ABdhPJyM2RxfM9pJBw0v3wywIVDu8VBnd7PX9dHEzHUaEFhL6mSVjJfT6WnihXHHqNXDu70GEPMR5A==
X-Received: by 2002:a62:8fc2:0:b029:196:7b53:cbfe with SMTP id n185-20020a628fc20000b02901967b53cbfemr2633566pfd.14.1605587327601;
        Mon, 16 Nov 2020 20:28:47 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id d22sm1174563pjw.11.2020.11.16.20.28.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 20:28:46 -0800 (PST)
Date:   Tue, 17 Nov 2020 09:58:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20201117042841.GC7787@work>
References: <20201117151225.6a50abf8@canb.auug.org.au>
 <20201117042359.GB7787@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117042359.GB7787@work>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:53:59AM +0530, Manivannan Sadhasivam wrote:
> +ath11k list, kalle
> 

Oops... adding now

> On Tue, Nov 17, 2020 at 03:12:25PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > drivers/net/wireless/ath/ath11k/mhi.c:27:4: error: 'struct mhi_channel_config' has no member named 'auto_start'
> >    27 |   .auto_start = false,
> >       |    ^~~~~~~~~~
> > drivers/net/wireless/ath/ath11k/mhi.c:42:4: error: 'struct mhi_channel_config' has no member named 'auto_start'
> >    42 |   .auto_start = false,
> >       |    ^~~~~~~~~~
> > drivers/net/wireless/ath/ath11k/mhi.c:57:4: error: 'struct mhi_channel_config' has no member named 'auto_start'
> >    57 |   .auto_start = true,
> >       |    ^~~~~~~~~~
> > drivers/net/wireless/ath/ath11k/mhi.c:72:4: error: 'struct mhi_channel_config' has no member named 'auto_start'
> >    72 |   .auto_start = true,
> >       |    ^~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   0cc1f3a385b2 ("bus: mhi: Remove auto-start option")
> > 
> 
> The fixing patch [1] should've landed in ath-next. Kalle can you please
> apply the patch on top of immutable branch?
> 
> Stephen, feel free to pick it up in the meantime.
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/netdev/1601369799-22328-1-git-send-email-kvalo@codeaurora.org/
> 
> 
> > I have used the mhi tree from next-20201116 for today.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 
