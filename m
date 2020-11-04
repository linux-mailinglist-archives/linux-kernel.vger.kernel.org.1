Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BD12A6B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgKDQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgKDQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:59:13 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D8C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:59:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so23706408ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mftyifZnpKdOWk/376HIkq1y1NvCM2FOrXcQ+8nmIn8=;
        b=ss9RFghQAWMqQE6K4urNU3V+2EH21WonPbe5aZD3EPuXhNudjJB0iMvpU6IbWcMPkd
         ql7HVJDn295nAcNWs05cD+1KFzRNaKqADXVB8DO6ivTnY1woTImI6ecJ/13gkrW09gUx
         m0bj2aVrj2v3TWAfNr6CX6CTzlmb76aK1EfyuEy3B7lOajOOVr8ul9qJC2LWM8z7cdTm
         od6tS9cpS996CnTG6y719pj9iJATgUFXMF1ZPCnRagvgUsKd38a0n5VkuP516H0ynyDB
         NlInsnF9F5KqDo7uG6BnKLmYTNyHb9jSlbxeaqDRHZpA3oMcQPDtcsKUBLOFulMd/leV
         KMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mftyifZnpKdOWk/376HIkq1y1NvCM2FOrXcQ+8nmIn8=;
        b=FzjbeD9bBGCT9zJlVXcfcSoCUbQflp7LeUikzbG8pxBZUJwx2F6Xcmy8AErFABJyWU
         qdD1qp7SD9cIXb+9jJ6V1izUziQUUziazON3gakrDlTRTokdsQNB3WXLW/pJd/uIQP8k
         8TyboYzC33aJBVsJjpRfY8awixHpgE9WulL6W/qjYg3bZolumone2xSESdpLEzf0LdOZ
         MwM/aCXPFhxpOJqyW2POOb2lIQ4lOMrHdYqu6KUjBiFwdogl3PQyupo952Gu+ENrry2+
         Tei9sEWeiOpLK8pmvHkUP0SDBtpj6D9AE+NEhyL2XEoHXa8aBdrkeyCZDnxqZD0U0+Js
         wOnQ==
X-Gm-Message-State: AOAM533x4cSvYFRN4lv+lQ7gRBkUjuYuo0ERRfyg4PgQFDiQpSKSTGYA
        vebQYQliO4O9xYMKefzv3G6rLyCWF/vS9YWo9Nt8oVpatSbXwgEe
X-Google-Smtp-Source: ABdhPJzoMQXnKkMC1tfe37liPvXP3GxKFDy0thOvWxtXHZi1KTwOcipacu9/QWbfjYab8zikz0mWelassp75RvctEnc=
X-Received: by 2002:a17:906:f1d8:: with SMTP id gx24mr13979222ejb.73.1604509150766;
 Wed, 04 Nov 2020 08:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-3-cristian.marussi@arm.com> <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
In-Reply-To: <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 4 Nov 2020 17:58:59 +0100
Message-ID: <CAN5uoS8O9B1siykCFrnj=B+TZwmDBqPW5gOr1CkXk0wGmmwjjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
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

Hello Thara,

On Wed, 4 Nov 2020 at 17:16, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
>
> Hi Cristian,
>
> On 10/28/20 4:29 PM, Cristian Marussi wrote:
> > Add basic protocol handles definitions and helpers support.
> > All protocols initialization code and SCMI drivers probing is still
> > performed using the handle based interface.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
> >   drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
> >   2 files changed, 125 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index b08a8ddbc22a..f0678be02a09 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> >                      size_t tx_size, size_t rx_size, struct scmi_xfer **p);
> >   void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
> >                           struct scmi_xfer *xfer);
> > +
> > +struct scmi_xfer_ops;
> > +
> > +/**
> > + * struct scmi_protocol_handle  - Reference to an initialized protocol instance
> > + *
> > + * @dev: A reference to the associated SCMI instance device (handle->dev).
> > + * @xops: A reference to a struct holding refs to the core xfer operations that
> > + *     can be used by the protocol implementation to generate SCMI messages.
> > + * @set_priv: A method to set protocol private data for this instance.
> > + * @get_priv: A method to get protocol private data previously set.
> > + *
> > + * This structure represents a protocol initialized against specific SCMI
> > + * instance and it will be used as follows:
> > + * - as a parameter fed from the core to the protocol initialization code so
> > + *   that it can access the core xfer operations to build and generate SCMI
> > + *   messages exclusively for the specific underlying protocol instance.
> > + * - as an opaque handle fed by an SCMI driver user when it tries to access
> > + *   this protocol through its own protocol operations.
> > + *   In this case this handle will be returned as an opaque object together
> > + *   with the related protocol operations when the SCMI driver tries to access
> > + *   the protocol.
> > + */
> > +struct scmi_protocol_handle {
> > +     struct device *dev;
> > +     const struct scmi_xfer_ops *xops;
> > +     int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
> > +     void *(*get_priv)(const struct scmi_protocol_handle *ph);
> > +};
>
> So scmi_xfer_ops are the ops that actually talks with the scmi firmware
> on the other end , right ? IIUC, these ops are the same for all the
> protocols of a scmi instance. Imho, this struct is not the right place
> for these ops to reside.You are inadvertently exposing scmi internal
> details to the client drivers. There is no reason why this should be
> part of scmi_handle. The protocols can extract it from the handle during
> protocol_reigster, right?
>
> So, now to the second part, why do you need a scmi_protocol_handle?
> Again IIUC, if you have set_priv and get_priv hooks and get_ops and
> put_ops hooks, there is nothing that scmi_protocol_handle is providing
> extra, right? As mentioned in the comments for last patch any reason all
> of this cannot be rolled into scmi_protocol?
>
> As long as you are not supporting multiple scmi_protocol_instance and
> scmi_protocol_handle for a protocol, I don't think having separate
> structs make sense.

This is a scenario SCMI can face. Consider system with several
contained firmwares
(multi-coprocs) each can expose SCMI services hence multi protocol instances.
I.e 2 coproc each exposing some of their clocks to Linux that registers them.

Regards,
Etienne

> And you need to do this only if you think there can
> be multiple versions/instances of a protocol in the same scmi instance.
> Or am I missing something here ?
>
> > +
> > +/**
> > + * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
> > + * @version_get: Get this version protocol.
> > + * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
> > + * @reset_rx_to_maxsz: Reset rx size to max transport size.
> > + * @do_xfer: Do the SCMI transfer.
> > + * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
> > + * @xfer_put: Free the xfer slot.
> > + *
> > + * Note that all this operations expect a protocol handle as first parameter;
> > + * they then internally use it to infer the underlying protocol number: this
> > + * way is not possible for a protocol implementation to forge messages for
> > + * another protocol.
> > + */
> > +struct scmi_xfer_ops {
> > +     int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
> > +     int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
> > +                          size_t tx_size, size_t rx_size,
> > +                          struct scmi_xfer **p);
> > +     void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
> > +                               struct scmi_xfer *xfer);
> > +     int (*do_xfer)(const struct scmi_protocol_handle *ph,
> > +                    struct scmi_xfer *xfer);
> > +     int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
> > +                                  struct scmi_xfer *xfer);
> > +     void (*xfer_put)(const struct scmi_protocol_handle *ph,
> > +                      struct scmi_xfer *xfer);
> > +};
> > +
> > +struct scmi_revision_info *
> > +scmi_get_revision_area(const struct scmi_protocol_handle *ph);
> >   int scmi_handle_put(const struct scmi_handle *handle);
> >   struct scmi_handle *scmi_handle_get(struct device *dev);
> >   void scmi_set_handle(struct scmi_device *scmi_dev);
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index beae8991422d..8ca04acb6abb 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -72,19 +72,28 @@ struct scmi_xfers_info {
> >
> >   /**
> >    * struct scmi_protocol_instance  - Describe an initialized protocol instance.
> > + * @handle: Reference to the SCMI handle associated to this protocol instance.
> >    * @proto: A reference to the protocol descriptor.
> >    * @gid: A reference for per-protocol devres management.
> >    * @users: A refcount to track effective users of this protocol.
> > + * @priv: Reference for optional protocol private data.
> > + * @ph: An embedded protocol handle that will be passed down to protocol
> > + *   initialization code to identify this instance.
> >    *
> >    * Each protocol is initialized independently once for each SCMI platform in
> >    * which is defined by DT and implemented by the SCMI server fw.
> >    */
> >   struct scmi_protocol_instance {
> > +     const struct scmi_handle        *handle;
> >       const struct scmi_protocol      *proto;
> >       void                            *gid;
> >       refcount_t                      users;
> > +     void                            *priv;
> > +     struct scmi_protocol_handle     ph;
> >   };
> >
> > +#define ph_to_pi(h)  container_of(h, struct scmi_protocol_instance, ph)
> > +
> >   /**
> >    * struct scmi_info - Structure representing a SCMI instance
> >    *
> > @@ -543,6 +552,57 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
> >       return ret;
> >   }
> >
> > +/**
> > + * scmi_set_protocol_priv  - Set protocol specific data at init time
> > + *
> > + * @ph: A reference to the protocol handle.
> > + * @priv: The private data to set.
> > + *
> > + * Return: 0 on Success
> > + */
> > +static int scmi_set_protocol_priv(const struct scmi_protocol_handle *ph,
> > +                               void *priv)
> > +{
> > +     struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +     pi->priv = priv;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * scmi_get_protocol_priv  - Set protocol specific data at init time
> > + *
> > + * @ph: A reference to the protocol handle.
> > + *
> > + * Return: Protocol private data if any was set.
> > + */
> > +static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
> > +{
> > +     const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +     return pi->priv;
> > +}
> > +
> > +/**
> > + * scmi_get_revision_area  - Retrieve version memory area.
> > + *
> > + * @ph: A reference to the protocol handle.
> > + *
> > + * A helper to grab the version memory area reference during SCMI Base protocol
> > + * initialization.
> > + *
> > + * Return: A reference to the version memory area associated to the SCMI
> > + *      instance underlying this protocol handle.
> > + */
> > +struct scmi_revision_info *
> > +scmi_get_revision_area(const struct scmi_protocol_handle *ph)
> > +{
> > +     const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +     return pi->handle->version;
> > +}
> > +
> >   /**
> >    * scmi_get_protocol_instance  - Protocol initialization helper.
> >    * @handle: A reference to the SCMI platform instance.
> > @@ -588,6 +648,10 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> >
> >               pi->gid = gid;
> >               pi->proto = proto;
> > +             pi->handle = handle;
> > +             pi->ph.dev = handle->dev;
> > +             pi->ph.set_priv = scmi_set_protocol_priv;
> > +             pi->ph.get_priv = scmi_get_protocol_priv;
> >               refcount_set(&pi->users, 1);
> >               /* proto->init is assured NON NULL by scmi_protocol_register */
> >               ret = pi->proto->init(handle);
> >
>
> --
> Warm Regards
> Thara
