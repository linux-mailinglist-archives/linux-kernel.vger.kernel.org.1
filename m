Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF829EA62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgJ2LWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ2LWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:22:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A286CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:22:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so3224056ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akJjnKgChtPHn1VCP5nrwISfhAo3fx3GZVYJ2WPzINs=;
        b=ewWaIJjHFKGKqvgL41q2OvIkXN5pl2CbAbCb9VHcHnDUoKfDL5DKjW7tJwd+Pzgudq
         JSY/5U2MG37fJJxK+Gbh1T3Ta/6M623C4OdWDYh19qJSwmLPxC9FdU6t8QV4SSRXsChi
         w/ws8P+EtYnRcar53HIKjW1kbaZ4uOhxvqJiX6PE1arlTdIJGaI3xZvamj5NjCyk0n+f
         Wf8UZsADEYi2bMqP6rlLAoBEP2+tcGK1478dED60HioNhzUK8xW/S+T8xaO/BCv6Kb09
         HJplxo+o+jLyIYhpATottuzMwswu+RLfiJtKgw4K8xdlw0s7aJ98WUO+Mkr3eUh2q64Q
         +1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akJjnKgChtPHn1VCP5nrwISfhAo3fx3GZVYJ2WPzINs=;
        b=MYlDDrAvjjVq8qRgw4zYfWx8/9qfD3iigr4S8ukU3OwDiBMA84Ig5D/QSenMQCqsKo
         imqvnVT+kZZk9bd5WGPDByWX9CK+bRIM3uOZ1weocYPM7nMdQ29laJ0FtWXZp9vIc5Gs
         q0H/BeUeufdn0Hc0NpSojC6gybM5TCo/E6XhCqSHDcK4cgpVaxr6wpQsX5fSyMbZ5Ver
         gkM28KGYOz13kGflEmkKLrbxuIIdagvsFsg7q3NETGh9M/iEKNIRlpiOkB1c/EztE/QC
         K2UHGfxuouzVkBTnqrDUDnVLnq4Og9UYMugUM4woy1suwZ/CDEr7LYryEAoazBbCAtvW
         65Bg==
X-Gm-Message-State: AOAM531fTChrzHTJICsA30h40DVgaCPQ3Lj0YEvVm8Zb94RHTfLD8+oD
        uSdMYv6iNctwtutyiPWZ+4st967VHB2zAuFYzWO2Lw==
X-Google-Smtp-Source: ABdhPJxfynR3WZQ8nDRdJcpZ8gDIlyB6mDrTNbRz5lR0hK3xPzjfX0mghrYrRkIDeKgYjOEzDHclXIp+o6ifBwzYWTc=
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr3727806eju.44.1603970528162;
 Thu, 29 Oct 2020 04:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-2-cristian.marussi@arm.com> <CAN5uoS8gOwA4-fttH1=XdKWZWFzX3HXpHAqgHW=jKxAxEq6C1Q@mail.gmail.com>
 <20201028204416.GF20482@e120937-lin>
In-Reply-To: <20201028204416.GF20482@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 29 Oct 2020 12:21:56 +0100
Message-ID: <CAN5uoS9LdH1M-sYEcgh-x+N1B_3Dj9g8FGX2nQGaPXH0tP6igA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] firmware: arm_scmi: Add Voltage Domain Support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan.Cameron@huawei.com, broonie@kernel.org,
        Rob Herring <robh@kernel.org>, satyakim@qti.qualcomm.com,
        f.fainelli@gmail.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 at 21:44, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Wed, Oct 28, 2020 at 03:29:57PM +0100, Etienne Carriere wrote:
> > Hi Cristian,
> >
> > Some remaining minor comments see below.
> > FYI I've successfully tested this series (the 4 patches).
> >
>
> Hi
>
> Thanks a lot !
>
> Replies inline down below.
>
> [snip]
> > > +struct scmi_msg_cmd_config_set {
> > > +       __le32 domain_id;
> > > +       __le32 config;
> > > +};
> > > +
> > > +struct scmi_msg_cmd_level_set {
> > > +       __le32 domain_id;
> > > +       __le32 flags;
> > > +       __le32 voltage_level;
> > > +};
> > > +
> > > +struct voltage_info {
> > > +       u32 version;
> > > +       u16 num_domains;
> >
> > Could be an unsigned int.
> >
>
> I tend to use fixed size types matching the protocols messages sizing on
> the internal while exposing non-fixed size types in scmi_protocol.h like
> in scmi_voltage_info, but these indeed are values exposed directly to
> the user afterwards. Any other reason to prefer non-fixed size here ?

I think fixed size should be used where really needed.
Since in this structure you're quite abstracted from the protocol, a generic
type is preferred I think.

Regards,
Etienne

>
> > > +       struct scmi_voltage_info **domains;
> > > +};
> > > +
> > > +static int scmi_protocol_attributes_get(const struct scmi_handle *handle,
> > > +                                       struct voltage_info *vinfo)
> > > +{
> > > +       int ret;
> > > +       struct scmi_xfer *t;
> > > +       struct scmi_msg_resp_protocol_attributes *resp;
> > > +
> > > +       ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
> > > +                                SCMI_PROTOCOL_VOLTAGE, 0, sizeof(*resp), &t);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       resp = t->rx.buf;
> > > +       ret = scmi_do_xfer(handle, t);
> > > +       if (!ret)
> > > +               vinfo->num_domains =
> > > +                       NUM_VOLTAGE_DOMAINS(le32_to_cpu(resp->attr));
> > > +
> > > +       scmi_xfer_put(handle, t);
> > > +       return ret;
> > > +}
> > > +
> > > +static inline int scmi_init_voltage_levels(struct device *dev,
> >
> > Should remove this inline attribute.
> >
>
> Ah right, I removed one and left this. I'll do.
>
> > > +                                          struct scmi_voltage_info *v,
> > > +                                          u32 flags, u32 num_returned,
> > > +                                          u32 num_remaining)
>
> [snip]
>
> > > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_VOLTAGE, voltage)
> > > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > > index 9cd312a1ff92..181fdebc2793 100644
> > > --- a/include/linux/scmi_protocol.h
> > > +++ b/include/linux/scmi_protocol.h
> > > @@ -209,6 +209,64 @@ struct scmi_reset_ops {
> > >         int (*deassert)(const struct scmi_handle *handle, u32 domain);
> > >  };
> > >
> > > +/**
> > > + * struct scmi_voltage_info - describe one available SCMI Voltage Domain
> > > + *
> > > + * @id: the domain ID as advertised by the platform
> > > + * @segmented: defines the layout of the entries of array @levels_uv.
> > > + *            - when True the entries are to be interpreted as triplets,
> > > + *              each defining a segment representing a range of equally
> > > + *              space voltages: <lowest_volts>, <highest_volt>, <step_uV>
> > > + *            - when False the entries simply represent a single discrete
> > > + *              supported voltage level
> > > + * @negative_volts_allowed: True if any of the entries of @levels_uv represent
> > > + *                         a negative voltage.
> > > + * @attributes: represents Voltage Domain advertised attributes
> > > + * @name: name assigned to the Voltage Domain by platform
> > > + * @num_levels: number of total entries in @levels_uv.
> > > + * @levels_uv: array of entries describing the available voltage levels for
> > > + *            this domain.
> > > + */
> > > +struct scmi_voltage_info {
> > > +       unsigned int id;
> > > +       bool segmented;
> > > +#define SCMI_VOLTAGE_SEGMENT_LOW       0
> > > +#define SCMI_VOLTAGE_SEGMENT_HIGH      1
> > > +#define SCMI_VOLTAGE_SEGMENT_STEP      2
> >
> > Maybe move these macros before 'int *level_us;' as these are indices
> > in that array.
> >
>
> Right, I'll do.
>
> Thanks
>
> Cristian
>
> > > +       bool negative_volts_allowed;
> > > +       unsigned int attributes;
> > > +       char name[SCMI_MAX_STR_SIZE];
> > > +       unsigned int num_levels;
> > > +       int *levels_uv;
> > > +};
> > > +
> > > +/**
> > > + * struct scmi_voltage_ops - represents the various operations provided
> > > + * by SCMI Voltage Protocol
> > > + *
> > > + * @num_domains_get: get the count of voltage domains provided by SCMI
> > > + * @info_get: get the information of the specified domain
> > > + * @config_set: set the config for the specified domain
> > > + * @config_get: get the config of the specified domain
> > > + * @level_set: set the voltage level for the specified domain
> > > + * @level_get: get the voltage level of the specified domain
> > > + */
> > > +struct scmi_voltage_ops {
> > > +       int (*num_domains_get)(const struct scmi_handle *handle);
> > > +       const struct scmi_voltage_info __must_check *(*info_get)
> > > +               (const struct scmi_handle *handle, u32 domain_id);
> > > +       int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
> > > +                         u32 config);
> > > +#define        SCMI_VOLTAGE_ARCH_STATE_OFF             0x0
> > > +#define        SCMI_VOLTAGE_ARCH_STATE_ON              0x7
> > > +       int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
> > > +                         u32 *config);
> > > +       int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
> > > +                        u32 flags, s32 volt_uV);
> > > +       int (*level_get)(const struct scmi_handle *handle, u32 domain_id,
> > > +                        s32 *volt_uV);
> > > +};
> > > +
> > >  /**
> > >   * struct scmi_notify_ops  - represents notifications' operations provided by
> > >   * SCMI core
> > > @@ -262,6 +320,7 @@ struct scmi_notify_ops {
> > >   * @clk_ops: pointer to set of clock protocol operations
> > >   * @sensor_ops: pointer to set of sensor protocol operations
> > >   * @reset_ops: pointer to set of reset protocol operations
> > > + * @voltage_ops: pointer to set of voltage protocol operations
> > >   * @notify_ops: pointer to set of notifications related operations
> > >   * @perf_priv: pointer to private data structure specific to performance
> > >   *     protocol(for internal use only)
> > > @@ -273,6 +332,8 @@ struct scmi_notify_ops {
> > >   *     protocol(for internal use only)
> > >   * @reset_priv: pointer to private data structure specific to reset
> > >   *     protocol(for internal use only)
> > > + * @voltage_priv: pointer to private data structure specific to voltage
> > > + *     protocol(for internal use only)
> > >   * @notify_priv: pointer to private data structure specific to notifications
> > >   *     (for internal use only)
> > >   */
> > > @@ -284,6 +345,7 @@ struct scmi_handle {
> > >         const struct scmi_power_ops *power_ops;
> > >         const struct scmi_sensor_ops *sensor_ops;
> > >         const struct scmi_reset_ops *reset_ops;
> > > +       const struct scmi_voltage_ops *voltage_ops;
> > >         const struct scmi_notify_ops *notify_ops;
> > >         /* for protocol internal use */
> > >         void *perf_priv;
> > > @@ -291,6 +353,7 @@ struct scmi_handle {
> > >         void *power_priv;
> > >         void *sensor_priv;
> > >         void *reset_priv;
> > > +       void *voltage_priv;
> > >         void *notify_priv;
> > >         void *system_priv;
> > >  };
> > > @@ -303,6 +366,7 @@ enum scmi_std_protocol {
> > >         SCMI_PROTOCOL_CLOCK = 0x14,
> > >         SCMI_PROTOCOL_SENSOR = 0x15,
> > >         SCMI_PROTOCOL_RESET = 0x16,
> > > +       SCMI_PROTOCOL_VOLTAGE = 0x17,
> > >  };
> > >
> > >  enum scmi_system_events {
> > > --
> > > 2.17.1
> > >
