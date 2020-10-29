Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F302E29EAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJ2Loc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:44:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2Loc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:44:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E4313A1;
        Thu, 29 Oct 2020 04:44:30 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A873F66E;
        Thu, 29 Oct 2020 04:44:28 -0700 (PDT)
Date:   Thu, 29 Oct 2020 11:44:18 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan.Cameron@huawei.com, broonie@kernel.org,
        Rob Herring <robh@kernel.org>, satyakim@qti.qualcomm.com,
        f.fainelli@gmail.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v3 1/4] firmware: arm_scmi: Add Voltage Domain Support
Message-ID: <20201029114418.GI20482@e120937-lin>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-2-cristian.marussi@arm.com>
 <CAN5uoS8gOwA4-fttH1=XdKWZWFzX3HXpHAqgHW=jKxAxEq6C1Q@mail.gmail.com>
 <20201028204416.GF20482@e120937-lin>
 <CAN5uoS9LdH1M-sYEcgh-x+N1B_3Dj9g8FGX2nQGaPXH0tP6igA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS9LdH1M-sYEcgh-x+N1B_3Dj9g8FGX2nQGaPXH0tP6igA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:21:56PM +0100, Etienne Carriere wrote:
> On Wed, 28 Oct 2020 at 21:44, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Wed, Oct 28, 2020 at 03:29:57PM +0100, Etienne Carriere wrote:
> > > Hi Cristian,
> > >
> > > Some remaining minor comments see below.
> > > FYI I've successfully tested this series (the 4 patches).
> > >
> >
> > Hi
> >
> > Thanks a lot !
> >
> > Replies inline down below.
> >
> > [snip]
> > > > +struct scmi_msg_cmd_config_set {
> > > > +       __le32 domain_id;
> > > > +       __le32 config;
> > > > +};
> > > > +
> > > > +struct scmi_msg_cmd_level_set {
> > > > +       __le32 domain_id;
> > > > +       __le32 flags;
> > > > +       __le32 voltage_level;
> > > > +};
> > > > +
> > > > +struct voltage_info {
> > > > +       u32 version;
> > > > +       u16 num_domains;
> > >
> > > Could be an unsigned int.
> > >
> >
> > I tend to use fixed size types matching the protocols messages sizing on
> > the internal while exposing non-fixed size types in scmi_protocol.h like
> > in scmi_voltage_info, but these indeed are values exposed directly to
> > the user afterwards. Any other reason to prefer non-fixed size here ?
> 
> I think fixed size should be used where really needed.
> Since in this structure you're quite abstracted from the protocol, a generic
> type is preferred I think.
> 

Ok, I'll fix in V4.

Thanks

Cristian

> Regards,
> Etienne
> 
> >
> > > > +       struct scmi_voltage_info **domains;
> > > > +};
> > > > +
> > > > +static int scmi_protocol_attributes_get(const struct scmi_handle *handle,
> > > > +                                       struct voltage_info *vinfo)
> > > > +{
> > > > +       int ret;
> > > > +       struct scmi_xfer *t;
> > > > +       struct scmi_msg_resp_protocol_attributes *resp;
> > > > +
> > > > +       ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
> > > > +                                SCMI_PROTOCOL_VOLTAGE, 0, sizeof(*resp), &t);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       resp = t->rx.buf;
> > > > +       ret = scmi_do_xfer(handle, t);
> > > > +       if (!ret)
> > > > +               vinfo->num_domains =
> > > > +                       NUM_VOLTAGE_DOMAINS(le32_to_cpu(resp->attr));
> > > > +
> > > > +       scmi_xfer_put(handle, t);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static inline int scmi_init_voltage_levels(struct device *dev,
> > >
> > > Should remove this inline attribute.
> > >
> >
> > Ah right, I removed one and left this. I'll do.
> >
> > > > +                                          struct scmi_voltage_info *v,
> > > > +                                          u32 flags, u32 num_returned,
> > > > +                                          u32 num_remaining)
> >
> > [snip]
> >
> > > > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_VOLTAGE, voltage)
> > > > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > > > index 9cd312a1ff92..181fdebc2793 100644
> > > > --- a/include/linux/scmi_protocol.h
> > > > +++ b/include/linux/scmi_protocol.h
> > > > @@ -209,6 +209,64 @@ struct scmi_reset_ops {
> > > >         int (*deassert)(const struct scmi_handle *handle, u32 domain);
> > > >  };
> > > >
> > > > +/**
> > > > + * struct scmi_voltage_info - describe one available SCMI Voltage Domain
> > > > + *
> > > > + * @id: the domain ID as advertised by the platform
> > > > + * @segmented: defines the layout of the entries of array @levels_uv.
> > > > + *            - when True the entries are to be interpreted as triplets,
> > > > + *              each defining a segment representing a range of equally
> > > > + *              space voltages: <lowest_volts>, <highest_volt>, <step_uV>
> > > > + *            - when False the entries simply represent a single discrete
> > > > + *              supported voltage level
> > > > + * @negative_volts_allowed: True if any of the entries of @levels_uv represent
> > > > + *                         a negative voltage.
> > > > + * @attributes: represents Voltage Domain advertised attributes
> > > > + * @name: name assigned to the Voltage Domain by platform
> > > > + * @num_levels: number of total entries in @levels_uv.
> > > > + * @levels_uv: array of entries describing the available voltage levels for
> > > > + *            this domain.
> > > > + */
> > > > +struct scmi_voltage_info {
> > > > +       unsigned int id;
> > > > +       bool segmented;
> > > > +#define SCMI_VOLTAGE_SEGMENT_LOW       0
> > > > +#define SCMI_VOLTAGE_SEGMENT_HIGH      1
> > > > +#define SCMI_VOLTAGE_SEGMENT_STEP      2
> > >
> > > Maybe move these macros before 'int *level_us;' as these are indices
> > > in that array.
> > >
> >
> > Right, I'll do.
> >
> > Thanks
> >
> > Cristian
> >
> > > > +       bool negative_volts_allowed;
> > > > +       unsigned int attributes;
> > > > +       char name[SCMI_MAX_STR_SIZE];
> > > > +       unsigned int num_levels;
> > > > +       int *levels_uv;
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct scmi_voltage_ops - represents the various operations provided
> > > > + * by SCMI Voltage Protocol
> > > > + *
> > > > + * @num_domains_get: get the count of voltage domains provided by SCMI
> > > > + * @info_get: get the information of the specified domain
> > > > + * @config_set: set the config for the specified domain
> > > > + * @config_get: get the config of the specified domain
> > > > + * @level_set: set the voltage level for the specified domain
> > > > + * @level_get: get the voltage level of the specified domain
> > > > + */
> > > > +struct scmi_voltage_ops {
> > > > +       int (*num_domains_get)(const struct scmi_handle *handle);
> > > > +       const struct scmi_voltage_info __must_check *(*info_get)
> > > > +               (const struct scmi_handle *handle, u32 domain_id);
> > > > +       int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
> > > > +                         u32 config);
> > > > +#define        SCMI_VOLTAGE_ARCH_STATE_OFF             0x0
> > > > +#define        SCMI_VOLTAGE_ARCH_STATE_ON              0x7
> > > > +       int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
> > > > +                         u32 *config);
> > > > +       int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
> > > > +                        u32 flags, s32 volt_uV);
> > > > +       int (*level_get)(const struct scmi_handle *handle, u32 domain_id,
> > > > +                        s32 *volt_uV);
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct scmi_notify_ops  - represents notifications' operations provided by
> > > >   * SCMI core
> > > > @@ -262,6 +320,7 @@ struct scmi_notify_ops {
> > > >   * @clk_ops: pointer to set of clock protocol operations
> > > >   * @sensor_ops: pointer to set of sensor protocol operations
> > > >   * @reset_ops: pointer to set of reset protocol operations
> > > > + * @voltage_ops: pointer to set of voltage protocol operations
> > > >   * @notify_ops: pointer to set of notifications related operations
> > > >   * @perf_priv: pointer to private data structure specific to performance
> > > >   *     protocol(for internal use only)
> > > > @@ -273,6 +332,8 @@ struct scmi_notify_ops {
> > > >   *     protocol(for internal use only)
> > > >   * @reset_priv: pointer to private data structure specific to reset
> > > >   *     protocol(for internal use only)
> > > > + * @voltage_priv: pointer to private data structure specific to voltage
> > > > + *     protocol(for internal use only)
> > > >   * @notify_priv: pointer to private data structure specific to notifications
> > > >   *     (for internal use only)
> > > >   */
> > > > @@ -284,6 +345,7 @@ struct scmi_handle {
> > > >         const struct scmi_power_ops *power_ops;
> > > >         const struct scmi_sensor_ops *sensor_ops;
> > > >         const struct scmi_reset_ops *reset_ops;
> > > > +       const struct scmi_voltage_ops *voltage_ops;
> > > >         const struct scmi_notify_ops *notify_ops;
> > > >         /* for protocol internal use */
> > > >         void *perf_priv;
> > > > @@ -291,6 +353,7 @@ struct scmi_handle {
> > > >         void *power_priv;
> > > >         void *sensor_priv;
> > > >         void *reset_priv;
> > > > +       void *voltage_priv;
> > > >         void *notify_priv;
> > > >         void *system_priv;
> > > >  };
> > > > @@ -303,6 +366,7 @@ enum scmi_std_protocol {
> > > >         SCMI_PROTOCOL_CLOCK = 0x14,
> > > >         SCMI_PROTOCOL_SENSOR = 0x15,
> > > >         SCMI_PROTOCOL_RESET = 0x16,
> > > > +       SCMI_PROTOCOL_VOLTAGE = 0x17,
> > > >  };
> > > >
> > > >  enum scmi_system_events {
> > > > --
> > > > 2.17.1
> > > >
