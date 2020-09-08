Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C788261D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgIHTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgIHPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34212C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:04:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so17005327wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wCKInMiP4AMp01y7AcAOZYNmAalhayJlvDOxChcTuNU=;
        b=Do+mZPrcyot9Cq7+wj0ZmQmXejyYLl0bofS2BdYYI83tdpX5NOpYZter4Sqms04brJ
         svWMpLP0dzLr2MN+KWZEyihNIOQGipKZdXFBmCEGYI+QvlMwLQ0JBJShGuWaCGXN9vmR
         1rqY29SL0FDYy0WNrAeOIr23GWf9mIYvdboI6nSucHWY3wPQ2jIcCa25tgRhIc+BR0aF
         riGa0Mhg1kTM96NrbTr0DvzMOV40kdg5WChrZ9v4L+O3PKqII+E/AZfCNFmq0wP39ZeL
         eAQpNInhdPX+noJiYjjCAA2sD/4nWcOdfm0X+QZkmCymficjX/VWQZJCrmdrGMNmphVk
         L8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wCKInMiP4AMp01y7AcAOZYNmAalhayJlvDOxChcTuNU=;
        b=pTSWP0I5GF3+/DPQS8IzpNtuyBTp89h+pvWCPpDrbdYB2y62q6+0HGDkK6c+Bd9TE8
         IGZqtkAbGjW2X7d3i/dhBeRgEDG5rA0s3k93NBDqR7jlmYAET30SJiJ64eYE6aGgerTl
         0bwMNUIQvWBhKSjfqGRiEp0X38bKZDlhA6+TktmlLcywgXsZ5DH878nrrlsWmZjZygCD
         XPns6ifPeeXNRYO30fLX9VWk1cfPSDdngf/5rSjzUWeudFepPy6/wz68arz3KvAPa8CF
         IIpHYDdtSlJo2D4f4uIXtFMgtQOG+XyJ2aR/RhgE28u+ILqPkOjpSr9YIUl/MdD68dFt
         XHWw==
X-Gm-Message-State: AOAM5325xskxvp1YfizHqolURBLC3KBlED4lkQ35/s2TbyAPS58vOLWd
        hluDQxQzYIOH8B3234vbu7VJEQ==
X-Google-Smtp-Source: ABdhPJyRf0y6bJ9yXJjEkffxrBcG2FgM1rIeygjGlDnJ3Y40S099rThqHAmipZyGUSvBvqq3ul9q2g==
X-Received: by 2002:a7b:cb19:: with SMTP id u25mr3869973wmj.113.1599566638826;
        Tue, 08 Sep 2020 05:03:58 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id c14sm33330021wrv.12.2020.09.08.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:03:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:03:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200908120356.GQ4400@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
 <20200829182405.GA27132@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200829182405.GA27132@yilunxu-OptiPlex-7050>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
> > > +{
> > > +	unsigned int v;
> > > +
> > > +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> > > +			    &v))
> > > +		return -ENODEV;
> > 
> > Please break functions out of if statements.
> > 
> > Does m10bmc_raw_read() return 0 on success?
> 
> Yes, this function just wrappered the regmap_read()

Avoid unnecessarily wrapping functions if possible.

> > Seems odd for a read function.
> > 
> > > +	if (v != 0xffffffff) {
> > > +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
> > > +		return -ENODEV;
> > > +	}
> > 
> > The only acceptable version is -1?
> 
> As mentioned by Tom, this is a check if the board is using a very old legacy
> bmc version, the driver doesn't mean to support this old legacy bmc
> version.

Please add a descriptive comment and define the value.

> > > + * m10bmc_raw_read - read m10bmc register per addr
> > > + * m10bmc_sys_read - read m10bmc system register per offset
> > > + */
> > > +static inline int
> > > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > > +		unsigned int *val)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > > +	if (ret)
> > > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > > +			addr, ret);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > 
> > No unnecessary abstractions.
> > 
> > Just use the Regmap API directly please.
> 
> Could we keep the 2 definition?
> 
> For m10bmc_raw_read(), we make it to help print some error info if
> regmap RW fail. So we don't have to write "if (ret) dev_err" every time
> we use regmap.

How many call sites are there?

> For m10bmc_sys_read(), the offset of BMC system registers could be
> configured by HW developers (The MAX 10 is an CPLD, it could be easily
> reprogrammed). And the HW SPEC will not add the offset when describing
> the addresses of system registers. So:
> 1. It makes the definition of system registers in code align with HW SPEC.
> 2. It makes developers easier to make changes when the offset is adjusted
>    in HW (I've been told by HW guys, it is sometimes necessary to adjust
>    the offset when changing RTL, required by Altera EDA tool - Quartus).

Make sure you justify this for the function(s) you keep.

I'll take a closer look on the next submission.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
