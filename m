Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0846B2C2A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbgKXOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbgKXOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:54:28 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A3C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:54:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id a130so15950579oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTLYfHQ3adQcV4KjcA9rD6YOe5HNylv70ACdoFyWIC0=;
        b=AC67j6pWCnRWVE6CNlp9qvz+y5K/eMMP7hyKsUuanepA4UBoakN2W2NlOSM308ubVM
         r0CXUhI4Ua8SWWdTakZF1E7VQAyRARrzwBEi3x6lCVDoE3CVYpg3iacRwEFhWPKMGXov
         Pcygn5W5Q+5zfKqFzJdhql91a05RbGtWK+0YFzkPyoQ0CI/8pWjurNX/fSeOJHgQ7rwq
         iS/UPJedDxwahCWq2nAoG5eNnqSemQkL22BMftQ5ImqvQ+afqJMjrVsaVFh0oQ6+N4+s
         LEUdypQ8fC4AdHT4+ueoXAo3FF9a/bvX3EjJjLdhfr+X5X3weyUXIkmoG1UGTQzjMaok
         OVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTLYfHQ3adQcV4KjcA9rD6YOe5HNylv70ACdoFyWIC0=;
        b=LUpGF2+kk8qvj6X7x3tk0EaTkfZiBVJ52sI2SQuNf5Zwy+ICtrtVSV0bvpI6GwyuFY
         wTcavZWFdBqII0vO/hErdzlIz6BFSwvcjtCC+JKIUFIJyDuWtDLDdVHKnN/+2h9EqhBm
         h3k+HF3B/NPwBo6AhyJg/L/clsSbWhKpJWn9fSRIu9l1qdZ/A81SYsukExBwpc7xhwV2
         Xl0zI/SZx0zgnMSyVWk8Ixct7uP5nITP4loc/rMOt4jet8fp9RCV7fs3lq0rsD9s8AlJ
         AjywlUYkaRxnUrHFqZmhCwRdE0IBeST93kaJ+bwuYIF6WgzkhMCKciKi8A0NS6XVoMFr
         1HWg==
X-Gm-Message-State: AOAM533/M4GjnMulPK9RJdToeYdEOrE5nkcMYsnDIz4sw/DgLIaA21bP
        WsrfX3nMDhJ1RKKgyrxMvWm26w==
X-Google-Smtp-Source: ABdhPJwHjNBkrou/i3d+PogOla6WN88GeTKRh2ASE52pzmj97XKIXoX+HQLCc52LF9BYP6zwjAe+eA==
X-Received: by 2002:aca:90c:: with SMTP id 12mr2956002oij.15.1606229668154;
        Tue, 24 Nov 2020 06:54:28 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q10sm9261116oih.56.2020.11.24.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:54:27 -0800 (PST)
Date:   Tue, 24 Nov 2020 08:54:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201124145425.GB185852@builder.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201122051900.GH807@yoga>
 <20201123191712.72484b19@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123191712.72484b19@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Nov 12:17 CST 2020, Wilken Gottwalt wrote:

> On Sat, 21 Nov 2020 23:19:00 -0600
> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > > +static int hwlocks_inuse_show(struct seq_file *seqf, void *unused)
> > > +{
> > > +	struct sunxi_hwspinlock_data *priv = seqf->private;
> > > +	int inuse;
> > > +
> > > +	/* getting the status of only the main 32 spinlocks is supported */
> > > +	inuse = hweight32(readl(priv->io_base + SPINLOCK_STATUS_REG));
> > 
> > So this returns how many of the locks are taken? How is that useful?
> 
> It is a way to see if locks were taken from linux or the arisc core without
> touching the actual hwspinlock abi or the locks. So it is a nice way to debug
> hwspinlocks, hence it is part of debugfs.
> 

So in a scenario where two remote processors ping-pong the lock between
them, this will always read 1 and you won't know why?

> > > +	seq_printf(seqf, "%d\n", inuse);
[..]
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id sunxi_hwspinlock_ids[] = {
> > > +	{ .compatible = "allwinner,sun8i-hwspinlock", },
> > > +	{ .compatible = "allwinner,sun50i-hwspinlock", },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sunxi_hwspinlock_ids);
> > > +
> > > +static struct platform_driver sunxi_hwspinlock_driver = {
> > > +	.probe	= sunxi_hwspinlock_probe,
> > > +	.remove	= sunxi_hwspinlock_remove,
> > > +	.driver	= {
> > > +		.name		= DRIVER_NAME,
> > > +		.of_match_table	= of_match_ptr(sunxi_hwspinlock_ids),
> > 
> > Please avoid of_match_ptr, as this will cause warnings about unused
> > variables when COMPILE_TEST without OF.
> 
> So did you mean to leave it out completely?
> 

Yes, "worst case" is that you include the reference to
sunxi_hwspinlock_ids on a build without CONFIG_OF and wasting a little
bit of memory.

Using of_match_ptr() with CONFIG_OF=n will result in NULL and as such
we'll get a compile warning that nothing references sunxi_hwspinlock_ids
- so then that will have to be marked __maybe_unused, or wrapped in an
#if...

So better just leave it as:
	.of_match_table = sunxi_hwspinlock_ids,

Regards,
Bjorn
