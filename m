Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79122A9B42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgKFRxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:53:36 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935AEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:53:35 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so1525342pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5TMQVCNljoYFuIcGIa8R0xZ7bhBD1oFyjgSl29C7UwE=;
        b=r843aCJQdIeK6veUamZyT4x8F0NofnZMojaKQ0Ch7uG8gUppCLbvQambLJWmecH5EX
         /04FfcLGF7hnoUbPpOcKMiaG/ITcxBEZSNodVKrBn7Bf2TocGWnLTsIU4LVIpW7CZ8Mj
         ZVN9tnreu774u3TGaZQqrHDJdrWZ3E54LjgMxW7CNqVpz/NcoCyefP2luBzCg7xllyw6
         GHI8WaDiFDksSUzThDgRpBSBDf0JL6qYuwYxRrOn8BOG+chOLFsFJXfvrGqxj0wZdMF3
         s25Dk5dQpKB/mf0uUN/Rt6RrAEw3OyVmrlIk8LgoDPJZkwAc3JLRvkTJfiTzK+1OwiO8
         O04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TMQVCNljoYFuIcGIa8R0xZ7bhBD1oFyjgSl29C7UwE=;
        b=FdXW9vh0cmPVo5gDDik9WlhpF9pbTX7Tob3KV8VdOfv+ooT/N9MoquJqndl66qiU4O
         QkcLrMiUUJwNVVthFz6gjRvUiR8mW4d/B5WbqT9W4JCz2J2dsEp4l7W2BYRLiiiDGU8g
         pfu1gTIOYnlhVr9cOaeEHKNDT901hzpA3BOoywUw5XCLJotzUzArgftRtnjyWtn3oUau
         zwz4PHLLaqURZND+4TRd8c04wWhbhkhNRh1MUXwJxmVoTeWOP3tMKAzpV/H/LTG844j1
         GWh27iQ8F+yR/tHoKvRE1aXNoXY2926y1K7eD1JzTCE9ARS2L4FT5wXPgFAXpojEavHV
         ajNA==
X-Gm-Message-State: AOAM530PTsr1MCqrjpqte1KFlKAlBZuOlWobKSJfT5/IpFJTFGQFqexk
        sTiPktbXSYt+koTfG/XIPZie8A==
X-Google-Smtp-Source: ABdhPJzl06YEHrgQVSuXECQAbWSUXZn/uPA8xvoeuhi0T/5hgG+lKXZ4xbbTIWK0wYu1zHgohEXh+w==
X-Received: by 2002:a63:5509:: with SMTP id j9mr2643913pgb.3.1604685215106;
        Fri, 06 Nov 2020 09:53:35 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l190sm2644522pfl.205.2020.11.06.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:53:34 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:53:32 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] rpmsg: Turn name service into a stand alone driver
Message-ID: <20201106175332.GB3203364@xps15>
References: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
 <20201105225028.3058818-9-mathieu.poirier@linaro.org>
 <20201106131545.GA10889@ubuntu>
 <20201106140028.GB10889@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106140028.GB10889@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:00:28PM +0100, Guennadi Liakhovetski wrote:
> On Fri, Nov 06, 2020 at 02:15:45PM +0100, Guennadi Liakhovetski wrote:
> > Hi Mathieu, Arnaud,
> > 
> > On Thu, Nov 05, 2020 at 03:50:28PM -0700, Mathieu Poirier wrote:
> > > From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > > 
> > > Make the RPMSG name service announcement a stand alone driver so that it
> > > can be reused by other subsystems.  It is also the first step in making the
> > > functionatlity transport independent, i.e that is not tied to virtIO.
> > 
> > Sorry, I just realised that my testing was incomplete. I haven't tested 
> > automatic module loading and indeed it doesn't work. If rpmsg_ns is loaded 
> > it probes and it's working, but if it isn't loaded and instead the rpmsg 
> > bus driver is probed (e.g. virtio_rpmsg_bus), calling 
> > rpmsg_ns_register_device() to create a new rpmsg_ns device doesn't cause 
> > rpmsg_ns to be loaded.
> 
> A simple fix for that is using MODULE_ALIAS("rpmsg:rpmsg_ns"); in rpmsg_ns.c 
> but that alone doesn't fix the problem completely - the module does load then 
> but not quickly enough, the NS announcement from the host / remote arrives 
> before rpmsg_ns has properly registered. I think the best solution would be 
> to link rpmsg_ns.c together with rpmsg_core.c. You'll probably want to keep 
> the module name, so you could rename them to just core.c and ns.c.

I'm pretty sure it is because virtio_device_ready() in rpmsg_probe() is called
before the kernel has finished loading the name space driver.  There has to be
a way to prevent that from happening - I will investigate further.

Thanks for reporting this,
Mathieu

> 
> Thanks
> Guennadi
