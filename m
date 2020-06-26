Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612D620B244
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFZNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgFZNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:15:07 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC4C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:15:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g11so4453406qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VhXrfn9rZyyElsl+ixbfQu3b3ECvLdJTiMGy5aiGuwM=;
        b=fKCcF70RlxM+1whp8dP25qWYRUeKG5PcYnaE0I7RaAFjyuCfSAmFKxpaDT9yWGfTc5
         4X9l9LDbU+5gqqeLY65zLfIMZkB3OG4+SvYM2Zt3NJPefJ2RFTvQMg7OF3K3XWMCQhNV
         qber0Wjvf6x4Aud5J4LKq76f4tEFql1M8Axwb13GgnuFXVoK/BNHrVeHnfSIOy7osu32
         seyberAJXZlzxHqaYiTjQaAglvwA+6qq8hJt0ZS09u3nA3MZJHhkUYgJtuJ6PfcCuPin
         u7dLzmTx1TsoX+PbcO/5NYK7c07SZJeiIgsuGv8LMCK7Wpq5MmMzJ+7z30si8SipkIch
         YxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VhXrfn9rZyyElsl+ixbfQu3b3ECvLdJTiMGy5aiGuwM=;
        b=rVUwCkWqIiFZD1LmXDRbMTb1jTiahhJU6zfwEHOEKo4w5c6PaqqRCAYKzstzOycrLB
         266QlxVErEqr3hoOUn9e9OgZyWXEHHj6/GPLdva2uoRc7uBePCLYV8GlMHNhUWKiHpc5
         JfnL04R49SCR3dwkb1cUB5Ye5zjuAMFqyNaNDM/nVOMLCKY2h2o6rAmxTpaMa1L4qYgy
         jy9o7LcXjUOU/X2hKK8aCmPw+OubIAprhfYQmQUiuwzV1xZMuPcTbQeZG/yCR7GnyHAn
         4gozEWjHSQOVJL1QW6vTJ0fI/ywCeDFfg5XpW3p99p3mqeF7ubzNmBGZ+Z2xvXRrVWkL
         zi6Q==
X-Gm-Message-State: AOAM531zdo42HYx3UJxdRUBTQ54BH8mniArDQno2B3Pc6ATXVQD5A+no
        JIFxqw7U4L9RTqzKTau0ASoKQA==
X-Google-Smtp-Source: ABdhPJxbRLN+jO7ctS8zXhG0GA1tOBmFddfktHHRgvosynJvPKT1ZHFNzvGilm7pfOY8khugHwvuEQ==
X-Received: by 2002:a05:6214:942:: with SMTP id dn2mr3083310qvb.161.1593177306525;
        Fri, 26 Jun 2020 06:15:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 207sm8322790qki.134.2020.06.26.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:15:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jooC9-0007B9-92; Fri, 26 Jun 2020 10:15:05 -0300
Date:   Fri, 26 Jun 2020 10:15:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling interrupts in QEMU TPM TIS
Message-ID: <20200626131505.GA25301@ziepe.ca>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
 <20200625172802.GS6578@ziepe.ca>
 <0a524093-e744-e266-6087-ddc17b5c598c@linux.ibm.com>
 <5b3267b7-57d5-badf-6664-9d47bc9909e7@linux.ibm.com>
 <20200625231934.GU6578@ziepe.ca>
 <a2e38eea-a137-ffea-ecf1-98f1e3ba1036@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e38eea-a137-ffea-ecf1-98f1e3ba1036@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:25:57AM -0400, Stefan Berger wrote:

> > I don't think the tpm driver was ever designed for edge, so most
> > likely the structure and order of the hard irq is not correct.
> 
> Right. For edge support I think we would need to avoid causing another
> interrupt (like locality change interrupt) before the interrupt handler
> hasn't finished dealing with an existing interrupt. Considering that Windows
> works on IRQ 13 (egde) and Linux driver cannot, I guess this is a good
> reason not to move QEMU TIS to IRQ 13 and try to support interrupts via ACPI
> table declaration.

Generaly clearing the IRQ needs to be done before testing for pending
IRQs - ie as the first thing

Move the write to status up higher:

	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
	
        [handle 'interrupt']

Then if new events set a status bit they will generate an edge and
re-enter here.

I don't know why there is an extra read at the end of the handler
either, seems sketchy.

Jason
