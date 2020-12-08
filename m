Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918C62D2A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgLHMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgLHMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:02:25 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F0C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:01:45 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so13713249pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PmpbR0lNoj9VnAkrz0sCDobCoEgFQge5RfqspxivGXA=;
        b=RFTDK+74SxIEeKDK4dhFG2z9kiUFS6U05JkOfvTezHJMMLCE3wTHwQdSBJYI2l+2bT
         eGsNFO2krKW6nOrR49Y5cqW02yWv1jyoCU/EdIi0wv32a9TtMJUHoBtLyrlJyNvBLDtC
         YbrIAZIs21AL/r/M8zU9PMZm/2IOa8s66hU/1J0U9XsRNxImhWCj2i03Sn7HAu/uNqkx
         37AY8F+T57z5TbVkoTeRfI2omicBCn626AC30PU+QBkD3w3DrVWBAzclvOjcbSvCzLKL
         sp6wVoYdB4kZrJ0q76QGDI9348zUIyUNpnCDLpv76+h5GRZHZ1v/CAMxcXrNfITWyFG6
         So1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PmpbR0lNoj9VnAkrz0sCDobCoEgFQge5RfqspxivGXA=;
        b=eMvFrxe2UDs87uur3YIasE21Mgqzjfglf9IVXBp3M5C3meps8ffjrOdq6AONeiXLgm
         2mwQTk5PlMOc8jjQDhQlGneWnz9kLbyr+sbD3s5SYUlBB16/xUUWXDngJEWybUyHwaXq
         uBNggabCjDLQ3HN27147Jcm72MUrMGwkziQ9NUGm3fbu4XGTtRtVhuwrnN7KSYBuzbRI
         dhGe/0Z5ocVOsfsUHUsfzt3s7UnoMJu3/tJhb7PSo3jSIfkvjEOCD9R5R5LxGAalC5GA
         EXryZ+HQNEHew507Sw457zXBKE/YfCi4EgEqZcZK5HMqVrEaYTSmQyVnTtIJg8xN/mAs
         R3sQ==
X-Gm-Message-State: AOAM532iXHxGa2wvdzhHswdTy5IZyhQMIVPHKakrSlpSlwk+Onlrp8kp
        w9gGWh41htWP0Amz2cXBIiPA
X-Google-Smtp-Source: ABdhPJycYufHqsyhMb1VD/taJ1qit7vFzrYrEC1Ux3Jc/jPVFgc42OtPriVLNnnaB74avvOfDi0nLw==
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr3956210pjo.61.1607428904737;
        Tue, 08 Dec 2020 04:01:44 -0800 (PST)
Received: from thinkpad ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id z5sm11867314pff.44.2020.12.08.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:01:44 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:31:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 0/5] Add PCIe support for SM8250 SoC
Message-ID: <20201208120135.GA139519@thinkpad>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
 <20201208094712.GA30430@e121166-lin.cambridge.arm.com>
 <20201208104557.GA8081@work>
 <20201208114023.GA31860@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208114023.GA31860@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:40:23AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 08, 2020 at 04:15:57PM +0530, Manivannan Sadhasivam wrote:
> > Hi Lorenzo,
> > 
> > On Tue, Dec 08, 2020 at 09:47:12AM +0000, Lorenzo Pieralisi wrote:
> > > On Tue, Oct 27, 2020 at 10:30:28PM +0530, Manivannan Sadhasivam wrote:
> > > > Hello,
> > > > 
> > > > This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
> > > > There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
> > > > controller and PHYs are mostly comaptible with the ones found on SDM845
> > > > SoC, hence the old drivers are modified to add the support.
> > > > 
> > > > This series has been tested on RB5 board with QCA6391 chipset connected
> > > > onboard.
> > > 
> > > Hi,
> > > 
> > > I would be merging this series, I understand patch {2) was already
> > > taken by Vinod - should I take {1,3,4,5} via the pci tree ?
> > > 
> > 
> > Vinod merged patches 1/5 and 2/5 as they belong to phy subsystem. You
> > can take the rest of the patches via pci tree.
> 
> Would you mind rebasing them on top of my pci/dwc branch (with Bjorn's
> tags) and resend them, I will apply them then.
> 

Sure, will send now.

Thanks,
Mani

> Thanks,
> Lorenzo
