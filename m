Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753BE2A090F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJ3PEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgJ3PEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:04:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F06C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:04:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so3093409plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKh1gww6LqRAEgf9eBUACjdeNH/81Jlt6VPrqpP9HjY=;
        b=OxvudRJgIRIEEE/kopiv2wGC9KQul3KWIc59iINcgjgEcQO8qfQgK8xCsvR6bU+eU6
         FDQ1qaBXWySGwMUYEsNEsDv0aTIGv5YQaFZm5lXPjeB2wFlAXLWEhTMyK4oAp0PoqL+F
         iuABlXhO0J/WJ1ufpzjcUec4SA4o0YYcsaSu8xG+OYXxD7BtwIJ9dV7tXa9mXZRPr+vT
         UUiEEZXtOLTd4vzqssygE6Oa63FI3uxWTQEyUwcywZ29vuLuIWc9QOlZjyjXoeUkHa9h
         hNTW8ftmJLgA1FECCCSdjcjedOdB+RPZii6KXMkFLuRElNHntKWZNEiKf9SVIZssfYr4
         yx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKh1gww6LqRAEgf9eBUACjdeNH/81Jlt6VPrqpP9HjY=;
        b=mKMYpijYrs9dM87URZlhXNUfyq+2COHesPWH1d4zYHBOBv6DaIcX7HYCqlVn6AhRRS
         x+9M+sbC217WnMXznObjXNxksmUmpy55cJK9Pq25JygmCCI0JNUKRq7IHCiS7vpFleHD
         ado9ENBivZMUIT6zp99pQkiOpnIsvuIJmQXRQbjIWM//rPK1gL52+LgIO7jA4BOxP0RN
         GzHY4tiIGJ2F6VQ0kl58H36wBOvriCkXV/8OhEIXul5eHoWPWNyNbTq5360YnMT5iWgi
         FyDwfZwmZXw/cQW9kvH9ZWe4p3Qsf4vJghv8I34j86oHL+jHuHzgzHgpA88egGjtCMjl
         rKLQ==
X-Gm-Message-State: AOAM533Ra+L99poc9arpTsMQ1H4B9GJJF+HC++MuBM1aFTAESxu6JpVd
        mh1/9+q8jpi87U7cuHHGjxdmjDdlECBw8A==
X-Google-Smtp-Source: ABdhPJzP0hrIb7ygkUfGzrbXaNTTe638OLEyXudJh20SphijYKQVMD6quFCnALW7JPRcfJXLPc0m2Q==
X-Received: by 2002:a17:902:c084:b029:d6:b04a:b091 with SMTP id j4-20020a170902c084b02900d6b04ab091mr675658pld.14.1604070261958;
        Fri, 30 Oct 2020 08:04:21 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a19sm3685615pjq.29.2020.10.30.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:04:20 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:04:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: cti: Initialize dynamic sysfs attributes
Message-ID: <20201030150418.GA1298977@xps15>
References: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
 <20201029164559.1268531-2-mathieu.poirier@linaro.org>
 <20201029191011.GA826513@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029191011.GA826513@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:10:11PM +0100, Greg KH wrote:
> On Thu, Oct 29, 2020 at 10:45:58AM -0600, Mathieu Poirier wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > With LOCKDEP enabled, CTI driver triggers the following splat due
> > to uninitialized lock class for dynamically allocated attribute
> > objects.
> > 
> > [    5.372901] coresight etm0: CPU0: ETM v4.0 initialized
> > [    5.376694] coresight etm1: CPU1: ETM v4.0 initialized
> > [    5.380785] coresight etm2: CPU2: ETM v4.0 initialized
> > [    5.385851] coresight etm3: CPU3: ETM v4.0 initialized
> > [    5.389808] BUG: key ffff00000564a798 has not been registered!
> > [    5.392456] ------------[ cut here ]------------
> > [    5.398195] DEBUG_LOCKS_WARN_ON(1)
> > [    5.398233] WARNING: CPU: 1 PID: 32 at kernel/locking/lockdep.c:4623 lockdep_init_map_waits+0x14c/0x260
> > [    5.406149] Modules linked in:
> > [    5.415411] CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.9.0-12034-gbbe85027ce80 #51
> > [    5.418553] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    5.426453] Workqueue: events amba_deferred_retry_func
> > [    5.433299] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> > [    5.438252] pc : lockdep_init_map_waits+0x14c/0x260
> > [    5.444410] lr : lockdep_init_map_waits+0x14c/0x260
> > [    5.449007] sp : ffff800012bbb720
> > ...
> > 
> > [    5.531561] Call trace:
> > [    5.536847]  lockdep_init_map_waits+0x14c/0x260
> > [    5.539027]  __kernfs_create_file+0xa8/0x1c8
> > [    5.543539]  sysfs_add_file_mode_ns+0xd0/0x208
> > [    5.548054]  internal_create_group+0x118/0x3c8
> > [    5.552307]  internal_create_groups+0x58/0xb8
> > [    5.556733]  sysfs_create_groups+0x2c/0x38
> > [    5.561160]  device_add+0x2d8/0x768
> > [    5.565148]  device_register+0x28/0x38
> > [    5.568537]  coresight_register+0xf8/0x320
> > [    5.572358]  cti_probe+0x1b0/0x3f0
> > 
> > ...
> > 
> > Fix this by initializing the attributes when they are allocated.
> > 
> > Fixes: 3c5597e39812 ("coresight: cti: Add connection information to sysfs")
> > Reported-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > index 392757f3a019..7ff7e7780bbf 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > @@ -1065,6 +1065,13 @@ static int cti_create_con_sysfs_attr(struct device *dev,
> >  	}
> >  	eattr->var = con;
> >  	con->con_attrs[attr_idx] = &eattr->attr.attr;
> > +	/*
> > +	 * Initialize the dynamically allocated attribute
> > +	 * to avoid LOCKDEP splat. See include/linux/sysfs.h
> > +	 * for more details.
> > +	 */
> > +	sysfs_attr_init(con->con_attrs[attr_idx]);
> > +
> >  	return 0;
> >  }
> 
> Should go to stable kernels too, as the patch this fixes is in 5.7.
> I'll add the stable tag here, but feel free to do it yourself next time
> :)

Oh - I (wrongly) assumed all patches with a "Fixes" tag were going to stable. 

> 
> thanks,
> 
> greg k-h
