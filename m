Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE82C2E80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbgKXR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390735AbgKXR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:26:58 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC944C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:26:58 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 92so17013048otd.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvzMD1d8zL0Ev220UgcR78qSy+uHcGngPYlKwq7QVM8=;
        b=WrN5SG/yopNVcrS6rVR09Cz/OngrmkzkFdBj2zOBdl+d8/P+9wLuOccNIXCh4VLCbl
         5oQ6/sak38CLbnO8W8SU+/jskKgcyESCtBpwFswiyz09ymcScFLIFmlAJwhLhYYa398Q
         ueETRR14XU2TQs4T73oA5RT21IM7zOvoKbECx5d1tQ9VnAswmYAn8g1obgnCHwKkr5+a
         wjxcpWJU8HBm9nk/jxLLPJRTGw+FQOj0jWNmg5Okd7rao0eH7bdxtfOH2Dneea/c9Y77
         4dBkD08eIcX68slYi3Ax+GW0yTHvDVljhqb/vra7X9P7wIy28RLfUzlXODQWOxfM5Hvx
         6jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvzMD1d8zL0Ev220UgcR78qSy+uHcGngPYlKwq7QVM8=;
        b=FxwNrIG5FaniHbE9domQjHVyIHtpoY9IWnp6ytpMvf8EWet8u+0ycQu9kI3QP0kJPu
         C5KGC76gwlel5yfLC2fNq4p0eFgL/wXCiIGMoWKBGnYMVTE845dogCpxS++qnfo81Gat
         7LL1D38aktodR+kQS+Heexb8dT0pX0UIHIkmfWLpiXalYu9e8cJylkuES+UJDw5bvS2F
         cQXfC/0iJsRQmSB5tX1yAdGkatE54YjSktDrPxkm89hPYxTXdLrv8+1xnsBNHQUWCfW5
         uHhRanGEOs/rO5Q4Nmj1+69ykgwRG5Bi1L1l/1Uso7botToy/Q2Z6knvrY1E0YNchpA0
         Z2gg==
X-Gm-Message-State: AOAM530XcJ3c8Kuwf7lf2k1G9mTXmfOKRnnoYTZrmH4Q7TnpkrBVQNnI
        L24sbmm7LX5bRBGPQpNJE+eNpQ==
X-Google-Smtp-Source: ABdhPJx6JyaMFm1DSM36Zn/2z2pQ5nau/8PX/gMG4OjWAL/vMAIhEu+bHyDv090g853HS1V7357RMA==
X-Received: by 2002:a05:6830:1518:: with SMTP id k24mr4026491otp.366.1606238817982;
        Tue, 24 Nov 2020 09:26:57 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t19sm8975817otp.51.2020.11.24.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:26:57 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:26:55 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, elder@linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: Introduce debugfs interface to smem
Message-ID: <20201124172655.GO95182@builder.lan>
References: <20201123052119.157551-1-bjorn.andersson@linaro.org>
 <20201124153422.GO8403@vkoul-mobl>
 <20201124163925.GN95182@builder.lan>
 <20201124170417.GP8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124170417.GP8403@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Nov 11:04 CST 2020, Vinod Koul wrote:

> On 24-11-20, 10:39, Bjorn Andersson wrote:
> > On Tue 24 Nov 09:34 CST 2020, Vinod Koul wrote:
> > 
> > > On 22-11-20, 23:21, Bjorn Andersson wrote:
> > > > Every now and then it's convenient to be able to inspect the content of
> > > > SMEM items. Rather than carrying some hack locally let's upstream a
> > > > driver that when inserted exposes a debugfs interface for dumping
> > > > available items.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  drivers/soc/qcom/Kconfig        |   7 +++
> > > >  drivers/soc/qcom/Makefile       |   1 +
> > > >  drivers/soc/qcom/smem_debugfs.c | 102 ++++++++++++++++++++++++++++++++
> > > >  3 files changed, 110 insertions(+)
> > > >  create mode 100644 drivers/soc/qcom/smem_debugfs.c
> > > > 
> > > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > > index 3dc3e3d61ea3..7e1dd6b3f33a 100644
> > > > --- a/drivers/soc/qcom/Kconfig
> > > > +++ b/drivers/soc/qcom/Kconfig
> > > > @@ -128,6 +128,13 @@ config QCOM_SMEM
> > > >  	  The driver provides an interface to items in a heap shared among all
> > > >  	  processors in a Qualcomm platform.
> > > >  
> > > > +config QCOM_SMEM_DEBUGFS
> > > > +	tristate "Qualcomm Shared Memory Manager (SMEM) DebugFS interface"
> > > > +	depends on QCOM_SMEM
> > > > +	depends on DEBUG_FS
> > > > +	help
> > > > +	  Provides a debugfs interface for inspecting SMEM.
> > > 
> > > Do we need additional debugfs entry, maybe better to depend on DEBUG_FS
> > > being enabled and this file part of QCOM_SMEM?
> > > 
> > 
> > We don't need this in any form of production system, so rather than
> > tainting qcom_smem.c I put it in a separate driver that isn't even
> > automatically loaded.
> 
> Debugfs in production :D
> 
> I would leave it to you to decide.. lazy me needs to select another
> option!
> 

We can still leave it =m in defconfig, lazy you would have to type
"modprobe qcom_smem_debugfs" when you want this thing.

In all other cases I will waste a little bit of disk, but none of your
ram or cpu cycles.

Regards,
Bjorn

> > > > +static int smem_debugfs_rescan(struct seq_file *seq, void *p)
> > > > +{
> > > > +	struct dentry *root = seq->private;
> > > > +	unsigned long item;
> > > > +	unsigned long host;
> > > > +	unsigned long data;
> > > > +	char name[10];
> > > > +	char *ptr;
> > > > +
> > > > +	for (host = 0; host < 10; host++) {
> > > > +		for (item = 0; item < 512; item++) {
> > > > +			ptr = qcom_smem_get(host, item, NULL);
> > > > +			if (IS_ERR(ptr))
> > > > +				continue;
> > > > +
> > > > +			sprintf(name, "%ld-%ld", host, item);
> > > > +
> > > > +			data = host << 16 | item;
> > > > +			debugfs_create_file(name, 0400, root,
> > > > +					    (void *)data, &smem_debugfs_item_ops);
> > > 
> > > So IIUC user invokes scan file which creates additional files, right?
> > > Additional invoke will do that as well..?
> > > 
> > 
> > Yes, so if you run it a second time debugfs_create_file() will fail for
> > any items that was present during the last invocation.
> > 
> > I did consider adding some logic to keep track of what items we have
> > already registered, but it is just debugging code and given that after a
> > few second of operations the set of items has stabilized you typically
> > don't run this repeatedly.
> > 
> > So I don't think it's worth the memory occupied by an idr or 5000+ bits
> > in a map.
> 
> Okay sounds good to me
> 
> -- 
> ~Vinod
