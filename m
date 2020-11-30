Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E315E2C924E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgK3XP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgK3XP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:15:26 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA709C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:14:40 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f12so13020046oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SSKJSpxsVwWxMbkBOUhoAnw1WjSpJJeYO6XDL2pKUQk=;
        b=jLJRS2uheUkshieEj6RPx7EDm843FDmZasOakaCRbxDkYzb6V/dCVEYCGtVic3OD0M
         Gx47VqrX16+W+ILvyuM9BcguvqlCbJvulRJRir863SLnZk77KQaU1dI8TBoZI9AG5ukC
         KxOCNCIDLq7dPd2Cn/AfkrYD2tGPT7SCNfiNXDhdoBvAjac62TVkTBG2lNney8lz4Rdq
         5rcBDg1qxlrJsWd/3IhorfoqNxiDUANC4AIFd9hK8jMqszKy7aNBUnx87VLrm4CKHM0B
         Jf+L/M5HnewgUPvHu434S98JDKOfsf30u7qhhGnwj4DtkqkfxWNSCicaSCJamhvVUWCQ
         smrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SSKJSpxsVwWxMbkBOUhoAnw1WjSpJJeYO6XDL2pKUQk=;
        b=VJbNL+051OxZ+JEthdZyDX2+nv7Ofq/9ozAMUfh8+3K/KnNNseMq+9yTV28hgcOkUx
         zoGZGfSoR4iVEPgfPssSjSYSuwkK0O3eYmTvZhbw9UW/pDzTQKBbKuNeTqSObyz6s6u9
         SN5fwZG/U3n2lBVMdKR5EtBulEmheHlI1VpAnmN2LaLQOFqKKGr7nmNtMLi/ft0wIWu8
         gURJ7A0Us3Ia0ZkGGy5GUgXxBBbMM0JZVMInH/cZyA0n8TLLMkRJKv3LfMP8UNc7uAfu
         yQQ+jm6cc8B0jSAjpzbEGfaPanpQDGSps7TCgd6fknej9WN96BR5K3FJs5xRYgfUeqbE
         6vVA==
X-Gm-Message-State: AOAM530orcSHYCl+lKrYMIW4jsRe+X5TyoBlIKDmtV4umyyHoQzuZQby
        F+vFNjdAsXXShuN54+P9x0DG+A==
X-Google-Smtp-Source: ABdhPJx8qwzmA4UFNrNr1ilDGpNjqNdr64PU6fU1EJcmd1XdNPi7emY2JwPOHcMUdjgC59CyPWzLEQ==
X-Received: by 2002:a05:6830:1e6f:: with SMTP id m15mr18139161otr.253.1606778080201;
        Mon, 30 Nov 2020 15:14:40 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e5sm9218917otl.75.2020.11.30.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:14:39 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:14:37 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com, beanhuo@micron.com,
        cang@codeaurora.org, matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nguyenb@codeaurora.org, kuohong.wang@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com, chaotian.jing@mediatek.com,
        cc.chou@mediatek.com, jiajie.hao@mediatek.com,
        alice.chao@mediatek.com
Subject: Re: [RFC PATCH v1] scsi: ufs: Remove pre-defined initial VCC voltage
 values
Message-ID: <X8V83T+Tx6teNLOR@builder.lan>
References: <20201130091610.2752-1-stanley.chu@mediatek.com>
 <568660cd-80e6-1b8f-d426-4614c9159ff4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568660cd-80e6-1b8f-d426-4614c9159ff4@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Nov 16:51 CST 2020, Asutosh Das (asd) wrote:

> On 11/30/2020 1:16 AM, Stanley Chu wrote:
> > UFS specficication allows different VCC configurations for UFS devices,
> > for example,
> > 	(1). 2.70V - 3.60V (By default)
> > 	(2). 1.70V - 1.95V (Activated if "vcc-supply-1p8" is declared in
> >                            device tree)
> > 	(3). 2.40V - 2.70V (Supported since UFS 3.x)
> > 
> > With the introduction of UFS 3.x products, an issue is happening that
> > UFS driver will use wrong "min_uV/max_uV" configuration to toggle VCC
> > regulator on UFU 3.x products with VCC configuration (3) used.
> > 
> > To solve this issue, we simply remove pre-defined initial VCC voltage
> > values in UFS driver with below reasons,
> > 
> > 1. UFS specifications do not define how to detect the VCC configuration
> >     supported by attached device.
> > 
> > 2. Device tree already supports standard regulator properties.
> > 
> > Therefore VCC voltage shall be defined correctly in device tree, and
> > shall not be changed by UFS driver. What UFS driver needs to do is simply
> > enabling or disabling the VCC regulator only.
> > 
> > This is a RFC conceptional patch. Please help review this and feel
> > free to feedback any ideas. Once this concept is accepted, and then
> > I would post a more completed patch series to fix this issue.
> > 
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > ---
> >   drivers/scsi/ufs/ufshcd-pltfrm.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> > index a6f76399b3ae..3965be03c136 100644
> > --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> > +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> > @@ -133,15 +133,7 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
> >   		vreg->max_uA = 0;
> >   	}
> > -	if (!strcmp(name, "vcc")) {
> > -		if (of_property_read_bool(np, "vcc-supply-1p8")) {
> > -			vreg->min_uV = UFS_VREG_VCC_1P8_MIN_UV;
> > -			vreg->max_uV = UFS_VREG_VCC_1P8_MAX_UV;
> > -		} else {
> > -			vreg->min_uV = UFS_VREG_VCC_MIN_UV;
> > -			vreg->max_uV = UFS_VREG_VCC_MAX_UV;
> > -		}
> > -	} else if (!strcmp(name, "vccq")) {
> > +	if (!strcmp(name, "vccq")) {
> >   		vreg->min_uV = UFS_VREG_VCCQ_MIN_UV;
> >   		vreg->max_uV = UFS_VREG_VCCQ_MAX_UV;
> >   	} else if (!strcmp(name, "vccq2")) {
> > 
> 
> Hi Stanley
> 
> Thanks for the patch. Bao (nguyenb) was also working towards something
> similar.
> Would it be possible for you to take into account the scenario in which the
> same platform supports both 2.x and 3.x UFS devices?
> 
> These've different voltage requirements, 2.4v-3.6v.
> I'm not sure if standard dts regulator properties can support this.
> 

What is the actual voltage requirement for these devices and how does
the software know what voltage to pick in this range?

Regards,
Bjorn

> -asd
> 
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> Linux Foundation Collaborative Project
