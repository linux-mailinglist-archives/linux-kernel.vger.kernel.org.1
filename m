Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F222D800B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgLKUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391814AbgLKUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:32:10 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBB9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:31:29 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w16so7901809pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hT2zG6CB4UvRgVp2IbTFwUn+l/bry/ipSKxWwb+b3ns=;
        b=Oic1QPQjgU2g/fqxeor2skzkpdjzE9SQq9F2LkamHoM1EieAZf9+ljH+rd449lcNj6
         NDzp3oMuGR+rOEzDLuLY1fjxPf2/LA71n1VhdVUEAqX+NliZfmCBh5C+q3DeuE5LXIJT
         0Yq4aUz0W+DF88k7+WydIfhp65BtALc6fQ2PZGwyXIOwsQllMQmzZqzPyMs1/oy69VWL
         FhFW+Shsi0MNF4tsCMr2pPI4wivt/oJh0ux43aQ9fcsKYcn6rDA/W8SCepZAZ9yQUfLh
         nkAzUZYHLkWeAz4BDETjw/ThRxR6gD+V1n97o/EyAPROeMrPlbxnHUc6sw+YPec8lXwh
         UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hT2zG6CB4UvRgVp2IbTFwUn+l/bry/ipSKxWwb+b3ns=;
        b=tUDSLJ64n62BESYcrfBUapW2wdJtznImx42SXT1ZZvrAOfsfoEAAFjAzPjz44RCFgz
         qWtiS3S8Lb96pVA6M54hbTAwdfK422fX+aU1MSH7tzA9/woz2MWb/76xGQGxWguMBkhh
         VsgPj9lZJT52UMZXTBEUx2VGLpPQTCcPQ3xW6b/jt8XF+QFP+tVoZs6YPtuVesMMQ4Yp
         ME7soivCiNYQPEPszAteAtno8Mcid4QApusAPF6h6CSm/vIF+7ujLg06YsapaL905GEr
         H//zMmpjz/x3ap+oTbL9K5ipxJ2RKd1BrkY3UQLozWX9wnuBMCX/+04Pz7dg2iWOdH5/
         F9jQ==
X-Gm-Message-State: AOAM531Q9zBQN2JkMdk+917upIZCd9bocuzOiLpxNEkgVkQe2ttndqYq
        qKD96minzAu0K+b3aOTGfYovSw==
X-Google-Smtp-Source: ABdhPJwNU+uAow8T+7jNNd1YUfOcjMrHuJF1JJUMaDMvPdGBEpl+crSzKXRnjjsyVXa1Dh4J7fK43g==
X-Received: by 2002:a63:7f03:: with SMTP id a3mr13299524pgd.313.1607718689333;
        Fri, 11 Dec 2020 12:31:29 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p185sm8588444pfb.165.2020.12.11.12.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:31:28 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:31:26 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [RFC 09/11] coresight: etm-perf: Disable the path before
 capturing the trace data
Message-ID: <20201211203126.GA1921322@xps15>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
 <2019e06d-65e1-fee8-f75d-bfa5750d2458@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019e06d-65e1-fee8-f75d-bfa5750d2458@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:32:28AM +0000, Suzuki K Poulose wrote:
> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
> > perf handle structure needs to be shared with the TRBE IRQ handler for
> > capturing trace data and restarting the handle. There is a probability
> > of an undefined reference based crash when etm event is being stopped
> > while a TRBE IRQ also getting processed. This happens due the release
> > of perf handle via perf_aux_output_end(). This stops the sinks via the
> > link before releasing the handle, which will ensure that a simultaneous
> > TRBE IRQ could not happen.
> 
> Or in other words :
> 
> We now have :
> 
> 	update_buffer()
> 
> 	perf_aux_output_end(handle)
> 
> 	...
> 	disable_path()
> 
> This is problematic due to various reasons :
> 
> 1) The semantics of update_buffer() is not clear. i.e, whether it
>    should leave the "sink" "stopped" or "disabled" or "active"

I'm a little confused by the above as the modes that apply here are
CS_MODE_DISABLED and CS_MODE_PERF, so I'll go with those.  Let me know if you
meant something else.

So far ->update_buffer() doesn't touch drvdata->mode and as such it is still set
to CS_MODE_PERF when the update has completed. 

> 
> 2) This breaks the recommended trace collection sequence of
>    "flush" and "stop" from source to the sink for trace collection.
>     i.e, we stop the source now. But don't flush the components
>     from source to sink, rather we stop and flush from the sink.
>     And we flush and stop the path after we have collected the
>     trace data at sink, which is pointless.

The above assesment is correct.  Fixing it though has far reaching ramifications
that go far beyond the scope of this patch.   

> 
> 3) For a sink with IRQ handler, if we don't stop the sink with
>    update_buffer(), we could have a situation :
> 
>    update_buffer()
> 
>    perf_aux_outpuf_end(handle) # handle is invalid now
> 
>  -----------------> IRQ    -> irq_handler()
>                                perf_aux_output_end(handle) # Wrong !
> 
> 
>    disable_path()

That's the picture of the issue I had in my head when looking at the code -
I'm glad we came to the same conclusion.

> 
> The sysfs mode is fine, as we defer the trace collection to disable_path().
> 
> The proposed patch is still racy, as we could still hit the problem.
> 
> So, to avoid all of these situations, I think we should defer the the
> update_buffer() to sink_ops->disable(), when we have flushed and stopped
> the all the components upstream and avoid any races with the IRQ
> handler.
> 
> i.e,
> 
> 	source_ops->stop(csdev);
> 
> 	disable_path(handle); // similar to the enable_path
> 
> 
> sink_ops->disable(csdev, handle)
> {
>   /* flush & stop */
> 
>   /* collect trace */
>   perf_aux_output_end(handle, size);
> }

That is one solution.  The advantage here is that it takes care of the
flusing problem you described above.  On the flip side it is moving a lot of
code around, something that is better to do in another set.

Another solution is to disable the TRBE IRQ in ->udpate_buffer().  The ETR does
the same kind of thing with tmc_flush_and_stop().  I don't know how feasible
that is but it would be a simple solution for this set.  Properly flushing the
pipeline could be done later.  I'm fine with either approach.

Thanks,
Mathieu 

> 
> 
> Kind regards
> Suzuki
> 
> 
> 
> > 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This might cause problem with traditional sink devices which can be
> > operated in both sysfs and perf mode. This needs to be addressed
> > correctly. One option would be to move the update_buffer callback
> > into the respective sink devices. e.g, disable().
> > 
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 534e205..1a37991 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -429,7 +429,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >   		size = sink_ops(sink)->update_buffer(sink, handle,
> >   					      event_data->snk_config);
> > +		coresight_disable_path(path);
> >   		perf_aux_output_end(handle, size);
> > +		return;
> >   	}
> >   	/* Disabling the path make its elements available to other sessions */
> > 
> 
