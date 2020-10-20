Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A881D288529
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgJII0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgJII0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:26:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74892C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:26:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r21so3245444pgj.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hk6Ko+1DLzzZQnR2xkXfN7fTIXCUMPbr5Xa64JxbRMM=;
        b=cR5qGMpyIJzxaze+e1ugQINpveMHTyz5ktns5hq3lwvnpcIvv3REj7ByNjCRDRPjQb
         IMiVsciq5I8fND1RCB/dptg81f8qOfCehE1JvTEGVHarg0y0u+Zq/TyKOZRS1BqD43Rc
         kR+s6W4CQE3gCM0mSdKtgWd1FPkuANdcRe0uxmULG0EgsCNtB/2eEQzm5mjB9ydVBBew
         /aQJd4a65DZS1pOIwCDx+mfT/6zYyUfv5iWe9/TvmY+kxpZii4SXaNuUF95xVN9fKYpU
         gXYGJ5gfZsCs5vswsxj4KAQ8XypKRXykFTCCc21iDwLVAhl0JvmFn38ShywiPw2GyLGh
         BsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hk6Ko+1DLzzZQnR2xkXfN7fTIXCUMPbr5Xa64JxbRMM=;
        b=CHHyZNiXrMph34khmuZo1j7EhYlsF4gCHBBGbxZZCPnqKMSvaElXMLuVYSCu3Ab5Sp
         EOEpyE1lfWLdyQGIesdMvpF8xeacO88xAFinW4+sRZfpFMV1cP/jN5L7Efrqs3HlK6uS
         i/W+J+yZ61/+v/j3syss38Fo1vQFyPvABnH7QLxhYx7nKbhZcW85uE23TWEz7Rpiso6q
         sormv+xhotdykjBGu+lmZmlK02di6PkiVPu1Ce0dIvmbs+UofNSvGffjV9VgQXHtSjNC
         DVmlRiqevGJDZJ8ByNmRFX7eq7em+mippdwUH3lOQx4Xd/EmiLN/+DVBSFrOuTQoSe4G
         sr+A==
X-Gm-Message-State: AOAM531/+bKdTMfjhJf+KYrgoi4BWc57L17LtjJJKI5hpMbpseLocefQ
        /Woe+Cn5KgQwC8k32V0zk37W
X-Google-Smtp-Source: ABdhPJwatc67mAG6qyOxRWhuIUHvlo56J+5AkNnPY+qB6VpNVBzto8CiAkLEzLaCirJUS6aTGgUelw==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr3242077pjq.76.1602231991801;
        Fri, 09 Oct 2020 01:26:31 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id q65sm9541550pga.88.2020.10.09.01.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Oct 2020 01:26:31 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:56:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gokulsri@codeaurora.org
Cc:     sboyd@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sricharan@codeaurora.org, kvalo@codeaurora.org
Subject: Re: [PATCH v3 3/3] arm64: dts: Enabled MHI device over PCIe
Message-ID: <20201009082625.GD23649@linux>
References: <1602160344-19586-1-git-send-email-gokulsri@codeaurora.org>
 <1602160344-19586-4-git-send-email-gokulsri@codeaurora.org>
 <20201008131115.GA23649@linux>
 <7dd959fd2d9375d5529cf52e93aafda3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd959fd2d9375d5529cf52e93aafda3@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:03:42PM +0530, gokulsri@codeaurora.org wrote:
> On 2020-10-08 18:41, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Thu, Oct 08, 2020 at 06:02:24PM +0530, Gokul Sriram Palanisamy wrote:
> > > Enabled MHI device support over PCIe and added memory
> > > reservation required for MHI enabled QCN9000 PCIe card.
> > > 
> > > Signed-off-by: Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi | 47
> > > ++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
> > > b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
> > > index 0827055..e5c1ec0 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi

[...]

> > > +	pcie0_rp: pcie0_rp {
> > > +		reg = <0 0 0 0 0>;
> > > +
> > > +		status = "ok";
> > > +		mhi_0: qcom,mhi@0 {
> > 
> > MHI doesn't support devicetree as of now so how is this supposed to
> > work?
> > Have you tested this series with mainline?
> > 
> > Thanks,
> > Mani
> > 
> 
>  Hi Mani,
>  This node entries will be consumed by ath11k driver and is not supposed to
> be consumed by mhi driver.
>  And yes, it is tested on Mainline.
> 

Can you please point me to the relevant binding or the code which consumes this
change?

Also please explain what it does! For enabling MHI support over PCIe you don't
need this node at all. You just need to define the PCIe device ID in the ath11k
driver and that's it.

Adding Kalle to this thread...

Thanks,
Mani

>  Regards,
>  Gokul
> 
> > > +			reg = <0 0 0 0 0 >;
> > > +
> > > +			qrtr_instance_id = <0x20>;
> > > +			base-addr = <0x50f00000>;
> > > +			m3-dump-addr = <0x53c00000>;
> > > +			etr-addr = <0x53d00000>;
> > > +			qcom,caldb-addr = <0x53e00000>;
> > > +		};
> > > +	};
> > >  };
> > > 
> > >  &pcie1 {
> > >  	status = "ok";
> > >  	perst-gpio = <&tlmm 61 0x1>;
> > > +
> > > +	pcie1_rp: pcie1_rp {
> > > +		reg = <0 0 0 0 0>;
> > > +
> > > +		status = "ok";
> > > +		mhi_1: qcom,mhi@1 {
> > > +			reg = <0 0 0 0 0 >;
> > > +
> > > +			qrtr_instance_id = <0x21>;
> > > +			base-addr = <0x54600000>;
> > > +			m3-dump-addr = <0x57300000>;
> > > +			etr-addr = <0x57400000>;
> > > +			qcom,caldb-addr = <0x57500000>;
> > > +			};
> > > +		};
> > > +	};
> > >  };
> > > 
> > >  &qmp_pcie_phy0 {
> > > --
> > > 2.7.4
> > > 
