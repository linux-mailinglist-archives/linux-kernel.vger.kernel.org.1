Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0128FA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392230AbgJOUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392221AbgJOUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:19:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:19:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so2236562pld.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HmOjOIj7MfIbWdL1m8nchCrbTWaq2wNj8B9RxRQ6T34=;
        b=YwX2lY6QAgxS/PPnej7P4z+eshHpog5T4n32UEQDDLMhF6+Qo32iO2mhpoeTkItzp9
         2kpWWULY1FkDnWR0GLYWGH8ijFY0xChl+w9q03DJnMsCT/dX3hv7X0Vxfgx3UMhgAJrI
         aAVcEc+W5uDQqFd8SgmhETWA0jSfnd0Rx7fGgm4AFNmxKq+m9jOTx8iX93ossSXkLawL
         Y5NjSx4OaRgAH/bcirjqq4SlT+3BvDhQlSavbduhTl+Rn6YTMcqlg50Vb7E5QRwipa2A
         jVohv+M0VGiAWbl6JzquGJc4gYqYctnyZ4dbLRBiqndn8xsrBOMmaYlL7h5HKkYvtbai
         traQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmOjOIj7MfIbWdL1m8nchCrbTWaq2wNj8B9RxRQ6T34=;
        b=lsPAgRNShiMwK/V9BZ9QK5MDoCu4GY9/GC1fp2ygRJv0sHp3Mt7QKW49LZcsH3Ntw3
         hK8Yv5sykWh6MyyeI2HjooOIBjZtrFGwj9RUzt2Jk7RUmMDVWeDaD6J6btgZz5sdWrRT
         POH6PVWa3LG7P2RUGhn/BYPo8cdnfU2bFBsJCfpwv7TxK+iv6L/vLFp3LsZqDnL0PDwO
         zBNTwoqskkKJkRRqGwv8jjzJGqpR9DYZnn4wfKnJLxyv02dhU4AByZP1/30EWqJVfJ9S
         zrttkjsa86L8xHunU+XfBXlnqaHyWld2kbSzg3cuT+VM93u46vPKsO339sN6ADiy4MbC
         gQRg==
X-Gm-Message-State: AOAM532n7YyT70sz9YVToUypB+Op0STTrA6aw73jJJWLnN1iHpIFhQOR
        wOzzY0sedO7uiPalmDywfLZOdQ==
X-Google-Smtp-Source: ABdhPJxJx6wLkKfrqvD/w6W0mtoyISJERZ9JNl0OWBhKu1yzE1c8xwRoT2YqXfsFZ0ZhzPBQhwa8dw==
X-Received: by 2002:a17:902:e782:b029:d2:ac14:2a8d with SMTP id cp2-20020a170902e782b02900d2ac142a8dmr426366plb.82.1602793169155;
        Thu, 15 Oct 2020 13:19:29 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 14sm96842pfy.192.2020.10.15.13.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:19:28 -0700 (PDT)
Date:   Thu, 15 Oct 2020 14:19:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] rpmsg: Move rpmsg_hr and rpmsg_ns_msg to header
 file
Message-ID: <20201015201926.GF1450102@xps15>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
 <20201013232519.1367542-5-mathieu.poirier@linaro.org>
 <61c25983-a339-e5de-eaf7-d608a9b9771b@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c25983-a339-e5de-eaf7-d608a9b9771b@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:33:25AM +0200, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 10/14/20 1:25 AM, Mathieu Poirier wrote:
> > Move structures rpmsg_hdr and rpmsg_ns_msg to their own header file
> > so that they can be used by other entities.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 58 ++----------------------------
> >  include/linux/rpmsg_ns.h         | 62 ++++++++++++++++++++++++++++++++
> >  include/uapi/linux/rpmsg.h       |  3 ++
> >  3 files changed, 67 insertions(+), 56 deletions(-)
> >  create mode 100644 include/linux/rpmsg_ns.h
> > 
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 793fe924671f..85f2acc4ed9f 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -19,7 +19,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/of_device.h>
> >  #include <linux/rpmsg.h>
> > -#include <linux/rpmsg_byteorder.h>
> > +#include <linux/rpmsg_ns.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> > @@ -27,6 +27,7 @@
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> >  #include <linux/wait.h>
> > +#include <uapi/linux/rpmsg.h>
> >  
> >  #include "rpmsg_internal.h"
> >  
> > @@ -70,58 +71,6 @@ struct virtproc_info {
> >  	struct rpmsg_endpoint *ns_ept;
> >  };
> >  
> > -/* The feature bitmap for virtio rpmsg */
> > -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> > -
> > -/**
> > - * struct rpmsg_hdr - common header for all rpmsg messages
> > - * @src: source address
> > - * @dst: destination address
> > - * @reserved: reserved for future use
> > - * @len: length of payload (in bytes)
> > - * @flags: message flags
> > - * @data: @len bytes of message payload data
> > - *
> > - * Every message sent(/received) on the rpmsg bus begins with this header.
> > - */
> > -struct rpmsg_hdr {
> > -	__rpmsg32 src;
> > -	__rpmsg32 dst;
> > -	__rpmsg32 reserved;
> > -	__rpmsg16 len;
> > -	__rpmsg16 flags;
> > -	u8 data[];
> > -} __packed;
> > -
> > -/**
> > - * struct rpmsg_ns_msg - dynamic name service announcement message
> > - * @name: name of remote service that is published
> > - * @addr: address of remote service that is published
> > - * @flags: indicates whether service is created or destroyed
> > - *
> > - * This message is sent across to publish a new service, or announce
> > - * about its removal. When we receive these messages, an appropriate
> > - * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> > - * or ->remove() handler of the appropriate rpmsg driver will be invoked
> > - * (if/as-soon-as one is registered).
> > - */
> > -struct rpmsg_ns_msg {
> > -	char name[RPMSG_NAME_SIZE];
> > -	__rpmsg32 addr;
> > -	__rpmsg32 flags;
> > -} __packed;
> > -
> > -/**
> > - * enum rpmsg_ns_flags - dynamic name service announcement flags
> > - *
> > - * @RPMSG_NS_CREATE: a new remote service was just created
> > - * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> > - */
> > -enum rpmsg_ns_flags {
> > -	RPMSG_NS_CREATE		= 0,
> > -	RPMSG_NS_DESTROY	= 1,
> > -};
> > -
> >  /**
> >   * @vrp: the remote processor this channel belongs to
> >   */
> > @@ -162,9 +111,6 @@ struct virtio_rpmsg_channel {
> >   */
> >  #define RPMSG_RESERVED_ADDRESSES	(1024)
> >  
> > -/* Address 53 is reserved for advertising remote services */
> > -#define RPMSG_NS_ADDR			(53)
> > -
> >  static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
> >  static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
> >  static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
> > diff --git a/include/linux/rpmsg_ns.h b/include/linux/rpmsg_ns.h
> > new file mode 100644
> > index 000000000000..3d836b8580b2
> > --- /dev/null
> > +++ b/include/linux/rpmsg_ns.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_RPMSG_NS_H
> > +#define _LINUX_RPMSG_NS_H
> > +
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/types.h>
> > +#include <linux/rpmsg_byteorder.h>
> > +
> > +/**
> > + * struct rpmsg_hdr - common header for all rpmsg messages
> > + * @src: source address
> > + * @dst: destination address
> > + * @reserved: reserved for future use
> > + * @len: length of payload (in bytes)
> > + * @flags: message flags
> > + * @data: @len bytes of message payload data
> > + *
> > + * Every message sent(/received) on the rpmsg bus begins with this header.
> > + */
> > +struct rpmsg_hdr {
> > +	__rpmsg32 src;
> > +	__rpmsg32 dst;
> > +	__rpmsg32 reserved;
> > +	__rpmsg16 len;
> > +	__rpmsg16 flags;
> > +	u8 data[];
> > +} __packed;
> 
> This structure is not related to the rpmsg ns service but to the rpmsg bus.
> If this structure has to be exposed to rpmsg client should be in rpmsg.h, but 
> Is there a need to expose it for now?
> I suppose that it is for vhost...As the need will depends on the implementation, 
> I would suggest leaving it internally and expose only if needed, in the
> related series.
>

I also thought about moving rpmsg_hdr to rpmsg.h but decided against because in
most cases using the name space service usually means that a message header will
be required.  I also thought it would be easier to use, i.e include one header
rather than two.  That too is a little thin because anyone using a name service
will also need to get access to rpmsg_device, which is in rpmsg.h.

I'm definitely not strongly opinionated on where it should go, or I can leave it
in virtio_rpmsg_bus.c too...  
 
> > +
> > +/**
> > + * struct rpmsg_ns_msg - dynamic name service announcement message
> > + * @name: name of remote service that is published
> > + * @addr: address of remote service that is published
> > + * @flags: indicates whether service is created or destroyed
> > + *
> > + * This message is sent across to publish a new service, or announce
> > + * about its removal. When we receive these messages, an appropriate
> > + * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> > + * or ->remove() handler of the appropriate rpmsg driver will be invoked
> > + * (if/as-soon-as one is registered).
> > + */
> > +struct rpmsg_ns_msg {
> > +	char name[RPMSG_NAME_SIZE];
> > +	__rpmsg32 addr;
> > +	__rpmsg32 flags;
> > +} __packed;
> > +
> > +/**
> > + * enum rpmsg_ns_flags - dynamic name service announcement flags
> > + *
> > + * @RPMSG_NS_CREATE: a new remote service was just created
> > + * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> > + */
> > +enum rpmsg_ns_flags {
> > +	RPMSG_NS_CREATE		= 0,
> > +	RPMSG_NS_DESTROY	= 1,
> > +};
> > +
> > +/* Address 53 is reserved for advertising remote services */
> > +#define RPMSG_NS_ADDR			(53)
> 
> What about my proposal [1] to put this in rpmsg.h, to create a list of
> reserved Address

That too is a grey area... Moving RPMSG_NS_ADDR to rpmsg.h means we have a name
service #define in rpmsg.h.  I think that one should stay in rpmsg_ns.h. 

> 
> [1] https://lkml.org/lkml/2020/7/31/442
> 
> > +
> > +#endif
> > diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> > index e14c6dab4223..d669c04ef289 100644
> > --- a/include/uapi/linux/rpmsg.h
> > +++ b/include/uapi/linux/rpmsg.h
> > @@ -24,4 +24,7 @@ struct rpmsg_endpoint_info {
> >  #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
> >  #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
> >  
> > +/* The feature bitmap for virtio rpmsg */
> > +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> > +
> 
> Same suggestion here,i would drop this from this series

Will do.

Thanks for the feedback,
Mathieu

> 
> Thanks,
> Arnaud
> 
> >  #endif
> > 
