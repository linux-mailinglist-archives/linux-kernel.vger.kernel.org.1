Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE572B7FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKROoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgKROoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:44:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5366C061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:44:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id oc3so1208105pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wi1tklYoU+4Q/BdD+it/ualPtR5EztUZa56jdKuDyDs=;
        b=TqMS4BiprOHGkvbm/xiKQnITqSoHYZ4NlIRjexMJPgoTxMgGkRIO4ZIkXsqT6jTAbf
         9uCdIBAwl77/nhCg9xDQOrdS3cjiZkRQYE/oWWEfdlgG2TNLf2CgfhUwMdSlM4Q7XlNl
         gtFXIK1an9xUvq1LQ9tXIVZFfb+rrXB50yllQ1J5kKFcIcc5nn0sAuk1BVCHZktzR75W
         1sBd6t4dYif6KYW8R69NpBs6I1MmSz1Nng+dmMoIMuRWVp+R4lNqPGjCPYvplZDV5fy7
         +2iiuOL6ERlQo6qcIMNYqafp/lZtIHQIrfDWNLUaT2uvjhAGNVv65Fys5u5WHpD3nYJn
         VvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wi1tklYoU+4Q/BdD+it/ualPtR5EztUZa56jdKuDyDs=;
        b=TeW4HMWJPxteAzxskDm9eMOfJZJKsnIfJjWRNSPe3QGrFlVAPQKNh6ygSPcLJxOtDH
         qj7YvIVTb27UmLuX1bCc79Pd8ICSBppMK4TrgmIZ9ay0ivEXZ7EtZuAh109XJCW4gU7D
         SaAPh2rVxqevAaVEUr0kegxi7cYUvecMzfTNkb9aJ3IFsbDuZfub7+ZPHcz3BEhE0c3o
         BzQJ/E3p+K1NmDU0qYWH/DLywvK2p/OQM97WVP520bQDD+yhn6iN2bd7kKPvLEGwYFmd
         EC6cAoyEL4nSUy9H/CZHP+OE6jkv5viWsG6E72qm+7h5GwX4JUnYY9Gm8WxHUkKdsW6k
         DeFg==
X-Gm-Message-State: AOAM530kVc4f4v5wOoUZw9KDDGiOL0jkpqZ4Za00d+x1ue3HM7SwPHJ4
        daQ1GioasADB5MWbIqUsL8Hi
X-Google-Smtp-Source: ABdhPJx3dbWXij883VJ/7IaBRRF9jyjwMBK0HE9oi+np7RYbL45jFvE/U6ijF9mdN63vfRKK9SEGaw==
X-Received: by 2002:a17:90b:11d3:: with SMTP id gv19mr288958pjb.232.1605710650071;
        Wed, 18 Nov 2020 06:44:10 -0800 (PST)
Received: from thinkpad ([2409:4072:400:708e:ac67:2882:f617:a8ff])
        by smtp.gmail.com with ESMTPSA id y5sm2833325pjr.50.2020.11.18.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:44:09 -0800 (PST)
Date:   Wed, 18 Nov 2020 20:14:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, mturquette@baylibre.com,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naveen Yadav <naveenky@codeaurora.org>
Subject: Re: [PATCH v2 2/4] clk: qcom: Add SDX55 GCC support
Message-ID: <20201118144401.GA8942@thinkpad>
References: <20201105104817.15715-1-manivannan.sadhasivam@linaro.org>
 <20201105104817.15715-3-manivannan.sadhasivam@linaro.org>
 <20201106093819.GE2621@vkoul-mobl>
 <160538612750.60232.17440819605514427384@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160538612750.60232.17440819605514427384@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 12:35:27PM -0800, Stephen Boyd wrote:
> Quoting Vinod Koul (2020-11-06 01:38:19)
> > On 05-11-20, 16:18, Manivannan Sadhasivam wrote:
> > > +#include "reset.h"
> > > +
> > > +enum {
> > > +     P_BI_TCXO,
> > > +     P_CORE_BI_PLL_TEST_SE,
> > 
> > This is for test and we removed this for upstream, so can you do that as
> > well (not parent will decrease for clks below)
> > 
> > With that updated:
> > 
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > 
> 
> I half understood that. Just an FYI that I'm waiting for this update.

Looks like this change is not needed. Can you please consider merging
this series?

Thanks,
Mani
