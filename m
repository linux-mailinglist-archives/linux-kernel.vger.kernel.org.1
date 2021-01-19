Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AD2FBC02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbhASQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391616AbhASP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:57:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:57:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so6455579plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OfkbJmLEDMRVH6PYECwDZwfn1Ald5phcm9+IMsNfgVA=;
        b=ovffRAkUEoLiq26/mhqXNH3l2nM6/RE9NSJyW8xFHWLYtXGwT32AC4K5dn+7/ak5+8
         wkQAVCzk3M3yMAxumcr22LbfC43FjuS41NFTdb8z9rRzOxJfUM2XxbJCv5dV8kVsTut/
         Asxg1oAui4F9crmG5BO3QT+G3oMnbSN27rzXZw4p7/Z6PJLOZIgtrNtiBUQrhJOXb99D
         lclr0Is/CPUkEq+KpDOf0LkbCGsshPMf337aUtY6gwgLnilOJDGJe9svQ18GNjNGyO5Z
         XMOj8/jHCDj69V5TaoHIpjww/0+WHJOsFDXgDCUf8cenDXVJsIQxhr9Lj5feYWy4DmpW
         Rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OfkbJmLEDMRVH6PYECwDZwfn1Ald5phcm9+IMsNfgVA=;
        b=qJCLn5duH6UXS9CnZ0TC0cfLt5mrjuv58OjhGAD12U16Yctsc/k/7iHuyythhDvCia
         U8GSZwcekS1xV/YBYF6dyPo5pwlL2zYlQ3CS/FCQf27oehgNTlKhHkBfsOqPYNm5wA0T
         hioBKGxIA05MelO1yCnT4z1bMS09zMk5YvwBafdm+5uJ8ft3rLqHMrMUwl09iVOFM9RS
         /MJoDL7Ycgrh+PACh+ddBZqE7rMO9ksyk4u3wlge0atFGB/kpxVmC4Mc70siDX77pWX6
         nGUrbwUEhdpuPnvsj4h6D+lCa1cmmhgq4BUltGd7hnUnwqzZh5ySDpbIg4ZFzaqg/ZzL
         8WPg==
X-Gm-Message-State: AOAM533N58VOCoIpERi9nbLLukWpsXEFnx+FEkABWsQ6cE6SqaXIe2VI
        7ddZUQt90TFm4hQuBcPX2kpE9A==
X-Google-Smtp-Source: ABdhPJz/IYFK5HHx8rNrTINYRXczwuXabfQMkiwpkSW0+RDK906XoaNEG/gvssgJ2wdRmOsJZ44yEA==
X-Received: by 2002:a17:90b:33c4:: with SMTP id lk4mr315096pjb.157.1611071825991;
        Tue, 19 Jan 2021 07:57:05 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z29sm2415343pfk.67.2021.01.19.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:57:05 -0800 (PST)
Date:   Tue, 19 Jan 2021 08:57:03 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Validate p_filesz in ELF
 loader
Message-ID: <20210119155703.GA611676@xps15>
References: <20210107235053.745888-1-bjorn.andersson@linaro.org>
 <20210113212257.GB229796@xps15>
 <X/9uT0ld7OE5pPv4@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/9uT0ld7OE5pPv4@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 04:03:59PM -0600, Bjorn Andersson wrote:
> On Wed 13 Jan 15:22 CST 2021, Mathieu Poirier wrote:
> 
> > Hi Bjorn,
> > 
> > On Thu, Jan 07, 2021 at 03:50:53PM -0800, Bjorn Andersson wrote:
> > > Analog to the issue in the common mdt_loader code the MSS ELF loader
> > > does not validate that p_filesz bytes will fit in the memory region and
> > > that the loaded segments are not truncated. Fix this in the same way
> > > as proposed for the mdt_loader.
> > > 
> > > Fixes: 135b9e8d1cd8 ("remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load")
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/remoteproc/qcom_q6v5_mss.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index 66106ba25ba3..2b59e0cbdce1 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > > @@ -1210,6 +1210,14 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> > >  			goto release_firmware;
> > >  		}
> > >  
> > > +		if (phdr->p_filesz > phdr->p_memsz) {
> > > +			dev_err(qproc->dev,
> > > +				"refusing to load segment %d with p_filesz > p_memsz\n",
> > > +				i);
> > > +			ret = -EINVAL;
> > > +			break;
> > 
> > Based on the error handling for the above and below conditions, I would have
> > expected a "goto release_firmware" rather than a "break".
> > 
> 
> You're certainly right!
> 
> Yet another reason for the duplication between this function, the
> mdt_loader and the remoteproc_elf_loader is a bad idea - still not sure
> how to refactor any one of them to fit the three.

I feel the same way about duplication.  On the flip side I don't think we have
to take immediate action... The solution will come out at some point when there
is more convergence.  At least we know it is an area that needs attention.

> 
> Thank you,
> Bjorn
> 
> > > +		}
> > > +
> > >  		ptr = memremap(qproc->mpss_phys + offset, phdr->p_memsz, MEMREMAP_WC);
> > >  		if (!ptr) {
> > >  			dev_err(qproc->dev,
> > > @@ -1241,6 +1249,15 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> > >  				goto release_firmware;
> > >  			}
> > >  
> > > +			if (seg_fw->size != phdr->p_filesz) {
> > > +				dev_err(qproc->dev,
> > > +					"failed to load segment %d from truncated file %s\n",
> > > +					i, fw_name);
> > > +				ret = -EINVAL;
> > > +				memunmap(ptr);
> > > +				break;
> > 
> > Same here.
> > 
> > > +			}
> > > +
> > >  			release_firmware(seg_fw);
> > >  		}
> > 
> > Thanks,
> > Mathieu
> > 
> > >  
> > > -- 
> > > 2.29.2
> > > 
