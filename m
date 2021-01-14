Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E22F5801
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhANCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbhAMWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:04:43 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6D7C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:04:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s2so3828421oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOwkhQAgNtweZgYmyrlXoMgH8ym5z5w1V+rJvmQv+fQ=;
        b=kJwNWHVPnLhMUJeCvPu8sI3PIqH4iL2mp7HxaA6Ti7QwQL24qrg8smwdLQ0gVTHxto
         nR4124VVq//u+nE/WpRYRhOqDNinS6G6xSUciBqnNP8RVffiHNrzzMxOw8Vj1wN4dWo3
         /vTce6X+VMO+EKoGrxS1d6v6863RBoqhs+B5gwCon1hItNM5JgBJ9taXAsP3ms5gFZZu
         YTWZk8mzx7fbr7zGszoch2h5R1MslFjc7BFrGhW9JUeE9yxIeMgvhdvw/JL3A/JefLLw
         44+KvlvQeHV2Bw3bwBRdUkGHHbAIXCE0sN2NQMcAng19IYmiMuhYTHOwk7a+ORzYcOO6
         +rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOwkhQAgNtweZgYmyrlXoMgH8ym5z5w1V+rJvmQv+fQ=;
        b=a2leWNLropOO4wn1HEuqzxfpSxJyifM5mK47q8CLkgdUtW39Yfbhp3tsWDX+1YQ41l
         TYDB4HGtB3Zr968DTyG3+rx/QDj6gV/tYQJlIqC617yj8sKYZRDNY37cgrRRnmFSlmGY
         lSZ9XSwAq2n60lcM7P0lz3K/FAE/ADlaGP3MaPP5aDOsy04eXmlKU8fDqiFzigl961DC
         F3OZo2/pGsdUgjI+VBUwzPCvt7I2/wtmDe7HlC+he2EJnYPTm0bUHx45+eypMSkDyh56
         cY8BuNz6oeFiQbNpLisNc4NyZFYhQLXTlJg3cj+njiIyhu56kwhV+9bYRZZD/8fG6Bel
         ktdg==
X-Gm-Message-State: AOAM533FBtG6aM6h5yXPoe/IsQ24LO4w+AdXIKTSTOMz81f9IvKm8ui1
        YTce0KcwES9txu6mynQ+qby3Pw==
X-Google-Smtp-Source: ABdhPJwlt8k8vervQGWkTLMPK3UWJLXRvUzPeB35zL+kRjtcd8bJFhMsLRQGYe0jgNMKxKOqwujABg==
X-Received: by 2002:aca:4257:: with SMTP id p84mr844472oia.176.1610575442148;
        Wed, 13 Jan 2021 14:04:02 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g92sm649467otb.66.2021.01.13.14.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:04:01 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:03:59 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Validate p_filesz in ELF
 loader
Message-ID: <X/9uT0ld7OE5pPv4@builder.lan>
References: <20210107235053.745888-1-bjorn.andersson@linaro.org>
 <20210113212257.GB229796@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113212257.GB229796@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jan 15:22 CST 2021, Mathieu Poirier wrote:

> Hi Bjorn,
> 
> On Thu, Jan 07, 2021 at 03:50:53PM -0800, Bjorn Andersson wrote:
> > Analog to the issue in the common mdt_loader code the MSS ELF loader
> > does not validate that p_filesz bytes will fit in the memory region and
> > that the loaded segments are not truncated. Fix this in the same way
> > as proposed for the mdt_loader.
> > 
> > Fixes: 135b9e8d1cd8 ("remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/remoteproc/qcom_q6v5_mss.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > index 66106ba25ba3..2b59e0cbdce1 100644
> > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > @@ -1210,6 +1210,14 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >  			goto release_firmware;
> >  		}
> >  
> > +		if (phdr->p_filesz > phdr->p_memsz) {
> > +			dev_err(qproc->dev,
> > +				"refusing to load segment %d with p_filesz > p_memsz\n",
> > +				i);
> > +			ret = -EINVAL;
> > +			break;
> 
> Based on the error handling for the above and below conditions, I would have
> expected a "goto release_firmware" rather than a "break".
> 

You're certainly right!

Yet another reason for the duplication between this function, the
mdt_loader and the remoteproc_elf_loader is a bad idea - still not sure
how to refactor any one of them to fit the three.

Thank you,
Bjorn

> > +		}
> > +
> >  		ptr = memremap(qproc->mpss_phys + offset, phdr->p_memsz, MEMREMAP_WC);
> >  		if (!ptr) {
> >  			dev_err(qproc->dev,
> > @@ -1241,6 +1249,15 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >  				goto release_firmware;
> >  			}
> >  
> > +			if (seg_fw->size != phdr->p_filesz) {
> > +				dev_err(qproc->dev,
> > +					"failed to load segment %d from truncated file %s\n",
> > +					i, fw_name);
> > +				ret = -EINVAL;
> > +				memunmap(ptr);
> > +				break;
> 
> Same here.
> 
> > +			}
> > +
> >  			release_firmware(seg_fw);
> >  		}
> 
> Thanks,
> Mathieu
> 
> >  
> > -- 
> > 2.29.2
> > 
