Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9B2F7DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbhAOORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAOORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:17:19 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A06C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:16:38 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q25so9649413oij.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xHR45BqFHfJv6MRdRPDoE4iFdlHt6oL+toEf1xWKDZA=;
        b=cbuuzmMVLKv9n8TGJd339eGVm4FcqTMDikQXx3IlQj12fUSPKdq+dKusZjF6QbWyfI
         tm4cLI9OY0i8wcoFCCbm0H/xMlLcCLXil6wd5omCEn22h5vOGsPadKhHZnErtCwo2+GW
         AS1Ckll3ozEuAMsSGH9BaVG8OaBcLa19CDjB7FXXfR2JAYIqWhvie+gd/6pEkDIDjABa
         eboI0DzO37riZRWRJnCPauCn/n3nwI2Kuf66WIZZGbHnanboE7riBgZuTU1ktieQD/Cn
         HP0Jo1n72C//V8InSPcCOF9O+rECvLZdrxLfo4GJ5sWRnUV3bY26H6mOdFay30xGaLUe
         C8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xHR45BqFHfJv6MRdRPDoE4iFdlHt6oL+toEf1xWKDZA=;
        b=mbZXpl1qslzy8nDULzuIqo57xUnLPZRqKiT2PMc+Wx8lmDXqZrn6h3T0SmrEKA/N/z
         eMuYWUqs9HGzhkGS85jZQi1FbfzHbdVM/bCPyztC1IFe8zwkBm0dtKbdwubUwJ7Atzka
         rlymzMlX5PcdCc5hoiLnFi+YUrtYqUdyVcXN6XN21g1g1/zu4zoPIcAHMOKGFSyvsF99
         WUX2ZOGWXmXL3/F9oMkbYddKPMxIon7tGj+inzqARUwPauhWMJoDCUc0bUzeVrhdHQQk
         jPuokjQp8iJuUVr02RWY/PsnKtra4nqzyVx+VmFAayyDCoAYJa891uzZBaCj0ZD77ole
         fbSg==
X-Gm-Message-State: AOAM531RWP4NNSwfC+Tg5LjWQvtqViBk9omzOaGnZblAiDX3z9o1aTU3
        2Mq/bkZXXk2wv67Qj7AtrYxHeQ==
X-Google-Smtp-Source: ABdhPJxDXfSziU5l3j+1xSDFWqiLhsDJUzsFLoMdrn3jJMVI/FFnjq+oJSffaPRo/doc/oi3dxILVA==
X-Received: by 2002:aca:540e:: with SMTP id i14mr5716363oib.57.1610720198253;
        Fri, 15 Jan 2021 06:16:38 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a18sm1805011otf.33.2021.01.15.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 06:16:37 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:16:35 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: dts: sdm845: add oneplus6/6t devices
Message-ID: <YAGjw4Vz21IFk9yL@builder.lan>
References: <20210114203057.64541-1-caleb@connolly.tech>
 <20210114203057.64541-2-caleb@connolly.tech>
 <061f8c37-533f-b694-f9a8-393cb9a34e01@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061f8c37-533f-b694-f9a8-393cb9a34e01@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Jan 06:28 CST 2021, Konrad Dybcio wrote:

> 
> Please move gpio-keys before reserved-memory to keep things sorted.
> 
> 
> > +		vreg_l25a_3p3: ldo25 {
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3312000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +		};
> > +		vdda_mipi_dsi0_1p2:
> 
> 
> Add a newline between the "};" and "vdda_mipi_dsi0_1p2:" to keep it consistent.
> 

Done and merged.

> 
> After that, you can add:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 

Thanks for the patch and the review!

Regards,
Bjorn
