Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1142F27F911
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgJAFe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:34:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:34:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so3426761pfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Hxu1/8uWO5dT1F+Fj0QUW+S+tLozKOVBkM9Qf0CzG0=;
        b=Qk0MKWhZubOTHngyLAHEmyn0bRX9FgKY//QSGPBVllkeVLleuWunQWbXaVnf3JxDKo
         9XcjWSbanfELjs/kKov26ou7uBaFbt8Cdgq9y/WPuAK+k15dMo7PYFX/hVHt1egpyn+i
         tdbn+GqRChZwCatocZz6ifyo0gYe9xR2ECmrPuDlSbqH7+/sozLzdlXGtSz5ulo0C4wx
         5CM1as2avZjwE/9MofMM48cjTM/YDNROaAaxUGcsGpZC9VRT1ISEKBMZLgfytRAoPNYo
         qVRJ+7Pj7HT1/FoPgqYZ+l/ev03GyEnZ1PmJqY9m8PcS7yhAiSBRXS4FAE1OYQB3sRpU
         2nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Hxu1/8uWO5dT1F+Fj0QUW+S+tLozKOVBkM9Qf0CzG0=;
        b=lJnSN1XGb9PhH3nFHgB1Dvzp3ObLCVwYPUO+IuvKgRl4s/0jhIorDwTAEIY6bOWIHM
         lC0wssM48+ZV5CilED0uwiuQXonSk6IdGXdCQMx+hNUUMZvLZVvwYTu02xdE+WzTIBRD
         mPX+VULrUfWcXshp7ZpxmmB8joHZKCTsGQ4DG8hYQVJHq4HVRzpuR4cy44JUAMikTKfx
         93JWPLI99hJHuJ4at/56SRIlnTqcKbv2gUMKqVzEpumKP+a45Nhd7ULAGofnXQkW2RTy
         2o84LXDpwk0MG7RQeuNab3uBdZWstWpzQC2CclA43D/wKO9Pd/lMg8hTpkIXU0P1jlgd
         Oy5A==
X-Gm-Message-State: AOAM530QiJWE78rIO+5X8jdjfIPb09pkHnE923IT8UcEek0Mi1xy/B0+
        T+srUchRW76d7sHRR8P4wt/d
X-Google-Smtp-Source: ABdhPJx17lXdgyF42SQih/6QFby4y82FoFd8iyDG5u1l8Msh8Qyw81A49PngqtFcsmqZX/S2+ncgFg==
X-Received: by 2002:a63:464f:: with SMTP id v15mr4751281pgk.330.1601530495671;
        Wed, 30 Sep 2020 22:34:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:188:5adb:1423:88c1:4321:a364])
        by smtp.gmail.com with ESMTPSA id x3sm4641456pfq.49.2020.09.30.22.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 22:34:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:04:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: qcom: Add SM8250 SoC support
Message-ID: <20201001053444.GA3203@Mani-XPS-13-9360>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-5-manivannan.sadhasivam@linaro.org>
 <0a6a765d-1b80-9d1b-f881-b75f13bd5b02@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6a765d-1b80-9d1b-f881-b75f13bd5b02@mm-sol.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,

On Thu, Oct 01, 2020 at 12:56:28AM +0300, Stanimir Varbanov wrote:
> Hi Mani,
> 
> On 9/30/20 6:09 PM, Manivannan Sadhasivam wrote:
> > The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
> > the support is added reusing the members of ops_2_7_0. The key
> > difference between ops_2_7_0 and ops_sm8250 is the config_sid callback,
> > which will be added in successive commit.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 3aac77a295ba..44db91861b47 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1359,6 +1359,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
> >  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> >  };
> >  
> > +/* Qcom IP rev.: 1.9.0 */
> > +static const struct qcom_pcie_ops ops_sm8250 = {
> 
> This breaks the policy compatible -> ops_X_Y_Z. Could you introduce new
> method config_sid and check into for compatible qcom,pcie-sm8250 string
> there?
> 

I thought about it but during previous submission review Bjorn mentioned that
this config_sid got introduced in SM8150 and there might be chances that future
SoCs could also use it. That's why I was inclined to introduce a new ops instead
of checking for the compatible.

And the reason to use "sm8250" instead of IP revision is that I can't find the
Synopsys IP revision for this. But if you strongly prefer IP revision then I can
just use "ops_1_9_0"!

Thanks,
Mani

> > +	.get_resources = qcom_pcie_get_resources_2_7_0,
> > +	.init = qcom_pcie_init_2_7_0,
> > +	.deinit = qcom_pcie_deinit_2_7_0,
> > +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > +	.post_init = qcom_pcie_post_init_2_7_0,
> > +	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> > +};
> > +
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.link_up = qcom_pcie_link_up,
> >  };
> > @@ -1476,6 +1486,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
> >  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
> >  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> > +	{ .compatible = "qcom,pcie-sm8250", .data = &ops_sm8250 },
> >  	{ }
> >  };
> >  
> > 
> 
> -- 
> regards,
> Stan
