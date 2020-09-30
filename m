Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9D27E25E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgI3HM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgI3HMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:12:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9851CC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:12:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t17so526372wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s1wjMNA5rw4V3d3XLlqHbiQ1yLvTv96M18kN0G/rZyI=;
        b=I6z1rjhxpTUdCqqIPash/YIr8P6QUv2aXnhPg8uTwj85Z5oNBI/QECc5RJan8QA3cQ
         8UghgM6EeO73WiMy7AWqKLXew08cS93Tdlt9U4+pB1TLaqc0iq039W2O+Hn5dqnQfpWP
         WfzNAspw9wr4xE3eqW7sMDciIDlOj195Ex8oKhfRAlQSg+4iFiij63pCEkIQMUXNwnFL
         WgcEOj/xX1lD5+4FaiABw5fpmA/jTzWUa+tVsqWpqvqfcMetPS/12GqFjUi7ElrJ0V86
         4rjLyL2bGWp9p79NbG3B4i9OOkm0vx7Xd0lbllPwBjIN435qkRo2lYkp+eb5GIgw/aYM
         NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s1wjMNA5rw4V3d3XLlqHbiQ1yLvTv96M18kN0G/rZyI=;
        b=kQr07KhWHts3qedfcZ2m3Z0ljjkOKgAU8DQy7rQenjkvdoRBkbeKB4QffyNWTgtonu
         7xyF9WPjcYK1oCCdxVD9owbx7AXGpC9A90LeOnHlHnZdHu353+ctyDsaFJ6dJslaz9k9
         nj84usJz0ng/lKFuaZObwrj9WvDTzIAe2/mTv7xrmpd7CxkK48SI9zdCih3unzq/U04U
         cSC9LetyQiATN3hDt3qfGontqJ+FvQ5y01egLJab9WbPi/b6kCNRY7WnWLeOK+mFEQEr
         phSe1jlULm7TmsNzafSSa7/Dn+QNF70tNs25+wlAWPW6HnHsmzSnkS5FkCj+oflY/Jgu
         62tA==
X-Gm-Message-State: AOAM530HqWXwF+qqz+iVMuvyfr1wVLFVYnTun4Jav4p5J9pC7YJHh1nv
        y/KLBxqqHmfyHBkC7JIaOl1Apw==
X-Google-Smtp-Source: ABdhPJw+iSkXXDCsKJGx4BH5LaU0Z2efYBQUMOnZ6dnuVwx8lofIAjQuyHM6Udav59wFt+7XahNXRg==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr1452990wmz.26.1601449973261;
        Wed, 30 Sep 2020 00:12:53 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id q12sm1272110wrp.17.2020.09.30.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:12:52 -0700 (PDT)
Date:   Wed, 30 Sep 2020 08:12:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: intel_pmt: Add OOBMSM device ID
Message-ID: <20200930071250.GI6148@dell>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-2-david.e.box@linux.intel.com>
 <20200929095106.GG6148@dell>
 <e23b255493c78d80558b9226920b3c7d54d7c84f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e23b255493c78d80558b9226920b3c7d54d7c84f.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020, David E. Box wrote:

> On Tue, 2020-09-29 at 10:51 +0100, Lee Jones wrote:
> > On Fri, 11 Sep 2020, David E. Box wrote:
> > 
> > > Add Out of Band Management Services Module device ID to Intel PMT
> > > driver.
> > > 
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel_pmt.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> > > index 0e572b105101..8f9970ab3026 100644
> > > --- a/drivers/mfd/intel_pmt.c
> > > +++ b/drivers/mfd/intel_pmt.c
> > > @@ -55,6 +55,8 @@ struct pmt_platform_info {
> > >  	unsigned long quirks;
> > >  };
> > >  
> > > +static const struct pmt_platform_info pmt_info;
> > > +
> > >  static const struct pmt_platform_info tgl_info = {
> > >  	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
> > >  		  PMT_QUIRK_TABLE_SHIFT,
> > > @@ -200,8 +202,10 @@ static void pmt_pci_remove(struct pci_dev
> > > *pdev)
> > >  	pm_runtime_get_sync(&pdev->dev);
> > >  }
> > >  
> > > +#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
> > >  #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
> > >  static const struct pci_device_id pmt_pci_ids[] = {
> > > +	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },
> > 
> > Why are you supplying an empty struct?
> 
> Because the OOBMSM device doesn't need code provided driver data, but
> info is dereferenced in several areas. We also use kmemdup to copy
> driver_data under the assumption that it was provided. We could allow
> for NULL if driver_data is referenced directly.

Just check for NULL.  No need to create and send bogus data.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
