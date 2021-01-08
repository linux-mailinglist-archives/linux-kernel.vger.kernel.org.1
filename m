Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512D2EF34E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhAHNnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAHNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:43:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F497C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:42:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx16so14505556ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1HfHbnoTXEvto44TJ+NV5nVsDQyjLU2RnrupzKSPCY=;
        b=OZg4r2AVQLRWq8dhRRtiFf84i586cRAAz61lbYQKQj2xxQH09L+qlXCzNja8aRnMqR
         cC1V8s4ORIiw0lit/qOVKGBhPRhUfT86XIPFvEoWUzv5X5hQGo9Sj2Dm7mYWQRqEDaEO
         ETK9HqzoWarJhBjkUaOjTUHxiEMSSUFzALlxrITL2r/gfdkVDjvC+q+RYrRxaxtVxBjt
         qnovT0MjgRSag1Cslq+Pz+VSOj5JeozIAsbg7Fcc6CZgQ1dodNTT5vbGPAjfGxvby4Ve
         OEhrFonfoe/42RDe7cXdps2HFIFDewh65TR29l2zJk3c9eUvFR7me75rDRIegqOxn1zP
         7WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1HfHbnoTXEvto44TJ+NV5nVsDQyjLU2RnrupzKSPCY=;
        b=ZYmjCCIIRxjfLwjLQR0ZuZKJ3KFuEUvPQSx+g8IUrzNvBF01GrKArqcbgpnHsILt1f
         gwUj5tya/Dy+Xz3Z/4Cs1Wqz13WVoHarDUCtLLptmMkEf8nnDUR1xGI9jmrjjzLjUYqf
         j92alPckfI1cZbdOlfL0WARND8vlSwJ+tS8YYyGudBLZJG0QjuAbm1MKuzHTIKFYGTIc
         5MIw1RsCdv7LeJSIEwBeSkAXf2bid9oNG5ewJg/TXrYt4U6vfYwNnFCT5DcGgjpwrTi3
         8TvjUUjlg98Oh2CCfyv9E6mA/pDzhz44ecQODXCXgoa8zHEnwEtj5cxDVFhUUTUD3gFU
         oFjQ==
X-Gm-Message-State: AOAM531D/4BFzzJCrPZiYiGeYpn5Q+vuxvJIM/TM08vyRmiWkWjOaASw
        eI9LNp03S6MOSuucbmP8S4u2elFbyd5zRxMEU/u39Q==
X-Google-Smtp-Source: ABdhPJxD6kbka6SEbcvBzqi05Q9qS2pyG2g5yEr7EtCfQ2nfUpWlACXkD5OHDQnet9orqBUYdGf76ofXlLUooTTmsAM=
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr2682947ejd.154.1610113338646;
 Fri, 08 Jan 2021 05:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-4-cristian.marussi@arm.com> <e817b8a6-6e67-9f1e-8541-5e0b15d7a562@linaro.org>
 <20210108122439.GC9138@e120937-lin>
In-Reply-To: <20210108122439.GC9138@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 8 Jan 2021 14:42:07 +0100
Message-ID: <CAN5uoS9aHvuZS4otfvdnz=5PBjJqCYKWpJ2J5WLgdyv1kxYdMw@mail.gmail.com>
Subject: Re: [PATCH v4 03/37] firmware: arm_scmi: introduce devres get/put
 protocols operations
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 13:24, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:28:37AM -0500, Thara Gopinath wrote:
> >
> >
> > On 1/6/21 3:15 PM, Cristian Marussi wrote:
> > > Expose to the SCMI drivers a new devres managed common protocols API based
> > > on generic get/put methods and protocol handles.
> > >
> > > All drivers still keep using the old API, no functional change.
> > >
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >   drivers/firmware/arm_scmi/driver.c | 92 ++++++++++++++++++++++++++++++
> > >   include/linux/scmi_protocol.h      | 11 ++++
> > >   2 files changed, 103 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > index 10fe9aacae1b..fbc3ba1b69f6 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -15,6 +15,7 @@
> > >    */
> > >   #include <linux/bitmap.h>
> > > +#include <linux/device.h>
> > >   #include <linux/export.h>
> > >   #include <linux/idr.h>
> > >   #include <linux/io.h>
> > > @@ -732,6 +733,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
> > >     return false;
> > >   }
> > > +struct scmi_protocol_devres {
> > > +   struct scmi_handle *handle;
> > > +   u8 protocol_id;
> > > +};
> > > +
> > > +static void scmi_devm_release_protocol(struct device *dev, void *res)
> > > +{
> > > +   struct scmi_protocol_devres *dres = res;
> > > +
> > > +   scmi_release_protocol(dres->handle, dres->protocol_id);
> > > +}
> > > +
> > > +/**
> > > + * scmi_devm_get_protocol_ops  - Devres managed get protocol operations
> > > + * @sdev: A reference to an scmi_device whose embedded struct device is to
> > > + *   be used for devres accounting.
> > > + * @protocol_id: The protocol being requested.
> > > + * @ph: A pointer reference used to pass back the associated protocol handle.
> > > + *
> > > + * Get hold of a protocol accounting for its usage, eventually triggering its
> > > + * initialization, and returning the protocol specific operations and related
> > > + * protocol handle which will be used as first argument in most of the
> > > + * protocols operations methods.
> > > + * Being a devres based managed method, protocol hold will be automatically
> > > + * released, and possibly de-initialized on last user, once the SCMI driver
> > > + * owning the scmi_device is unbound from it.
> > > + *
> > > + * Return: A reference to the requested protocol operations or error.
> > > + *    Must be checked for errors by caller.
> > > + */
> > > +static const void __must_check *
> > > +scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
> > > +                      struct scmi_protocol_handle **ph)
> > > +{
> > > +   struct scmi_protocol_instance *pi;
> > > +   struct scmi_protocol_devres *dres;
> > > +   struct scmi_handle *handle = sdev->handle;
> > > +
> > > +   if (!ph)
> > > +           return ERR_PTR(-EINVAL);
> > > +
> > > +   dres = devres_alloc(scmi_devm_release_protocol,
> > > +                       sizeof(*dres), GFP_KERNEL);
> > > +   if (!dres)
> > > +           return ERR_PTR(-ENOMEM);
> > > +
> > > +   pi = scmi_get_protocol_instance(handle, protocol_id);
> > > +   if (IS_ERR(pi)) {
> > > +           devres_free(dres);
> > > +           return pi;
> > > +   }
> > > +
> > > +   dres->handle = handle;
> > > +   dres->protocol_id = protocol_id;
> > > +   devres_add(&sdev->dev, dres);
> > > +
> > > +   *ph = &pi->ph;
> > > +
> > > +   return pi->proto->ops;
> > > +}
> > > +
> > > +static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
> > > +{
> > > +   struct scmi_protocol_devres *dres = res;
> > > +
> > > +   if (WARN_ON(!dres || !data))
> > > +           return 0;
> > > +
> > > +   return dres->protocol_id == *((u8 *)data);
> > > +}
> > > +
> > > +/**
> > > + * scmi_devm_put_protocol_ops  - Devres managed put protocol operations
> > > + * @sdev: A reference to an scmi_device whose embedded struct device is to
> > > + *   be used for devres accounting.
> > > + * @protocol_id: The protocol being requested.
> > > + *
> > > + * Explicitly release a protocol hold previously obtained calling the above
> > > + * @scmi_devm_get_protocol_ops.
> > > + */
> > > +static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
> > > +                        scmi_devm_protocol_match, &protocol_id);
> > > +   WARN_ON(ret);
> > > +}
> > > +
> > >   /**
> > >    * scmi_handle_get() - Get the SCMI handle for a device
> > >    *
> > > @@ -986,6 +1076,8 @@ static int scmi_probe(struct platform_device *pdev)
> > >     handle = &info->handle;
> > >     handle->dev = info->dev;
> > >     handle->version = &info->version;
> > > +   handle->devm_get_ops = scmi_devm_get_protocol_ops;
> > > +   handle->devm_put_ops = scmi_devm_put_protocol_ops;
> > >     ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> > >     if (ret)
> > > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > > index 757a826e3cef..2fd2fffb4024 100644
> > > --- a/include/linux/scmi_protocol.h
> > > +++ b/include/linux/scmi_protocol.h
> > > @@ -57,6 +57,8 @@ struct scmi_clock_info {
> > >   };
> > >   struct scmi_handle;
> > > +struct scmi_device;
> > > +struct scmi_protocol_handle;
> > >   /**
> > >    * struct scmi_clk_ops - represents the various operations provided
> > > @@ -593,6 +595,9 @@ struct scmi_notify_ops {
> > >    * @sensor_ops: pointer to set of sensor protocol operations
> > >    * @reset_ops: pointer to set of reset protocol operations
> > >    * @voltage_ops: pointer to set of voltage protocol operations
> > > + * @devm_get_ops: devres managed method to acquire a protocol and get specific
> > > + *           operations and a dedicated protocol handler
> > > + * @devm_put_ops: devres managed method to release a protocol
> > >    * @notify_ops: pointer to set of notifications related operations
> > >    * @perf_priv: pointer to private data structure specific to performance
> > >    *        protocol(for internal use only)
> > > @@ -618,6 +623,12 @@ struct scmi_handle {
> > >     const struct scmi_sensor_ops *sensor_ops;
> > >     const struct scmi_reset_ops *reset_ops;
> > >     const struct scmi_voltage_ops *voltage_ops;
> > > +
> > > +   const void __must_check *
> > > +           (*devm_get_ops)(struct scmi_device *sdev, u8 proto,
> > > +                           struct scmi_protocol_handle **ph);
> > > +   void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
> >
> > These names are misleading. The devm_get_ops does two things. One populate
> > the scmi_protocol_handle, second return the protocol ops. Either split this
> > into two separate functions or rename it into something like
> > devm_get_protocol (or something better). Similar comment for devm_put_ops as
> > there is no releasing of ops happening here per say.
>
> Yes I agree, now that you really get ops and a hold on the protocol in
> fact it'd be better _get_protocol/_put_protocol or similar; I'd prefer
> not to split retrieving the ops from the protocol_handle since they
> need each other to work. I'll fix in V5.
>
> > Also I am still not convinced that protocol_instance should be hidden from
> > the client drivers. But if everyone else is aligned towards this approach, I
> > am fine.
>
> Do you mean passing the protocol_handle around instead of the handle, so
> that protocols impementation are restricted to their own protocol number
> and SCMI drivers cannot access anything at the protocol layer ?
> It seems reasonable to me but I'm happy to discuss your concerns, also
> because up until now you are my main and only feedback about this :D
>

Hello all,

Sorry for not giving much feedback on your series. Big changes but I agree with.
BTW Cristian i've successfully tested your series, FWIW.

I'm not sure to understand what you mean by hiding the protocol to the client.
Each client obviously knows the protocol it's using (it's stated in
struct scmi_device_id).
Whatever, I think here get_ops()/put_ops() simply don't need the
protocol_id argument.
scmi_device instance is already specific to a protocol (field
protocol_id in struct scmi_device).

Best regards,
Etienne

> Thanks
>
> Cristian
>
> >
> > > +
> > >     const struct scmi_notify_ops *notify_ops;
> > >     /* for protocol internal use */
> > >     void *perf_priv;
> > >
> >
> > --
> > Warm Regards
> > Thara
