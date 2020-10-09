Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D52888E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgJIMgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:36:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJIMgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:36:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A698111B3;
        Fri,  9 Oct 2020 05:36:31 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4082F3F70D;
        Fri,  9 Oct 2020 05:36:30 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:37:53 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan.Cameron@huawei.com, broonie@kernel.org,
        Rob Herring <robh@kernel.org>, satyakim@qti.qualcomm.com
Subject: Re: [PATCH 1/4] firmware: arm_scmi: Add Voltage Domain Support
Message-ID: <20201009123753.GA32363@e119603-lin.cambridge.arm.com>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <20201005222623.1123-2-cristian.marussi@arm.com>
 <CAN5uoS9CVCwSQS_=R0JQ4j5bibW2pRF83oz5dhCV3aVjqzVdMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS9CVCwSQS_=R0JQ4j5bibW2pRF83oz5dhCV3aVjqzVdMQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:10:25PM +0200, Etienne Carriere wrote:
> Hello Christian,
> 
> I faced an issue with this change, see below.
> 

Hi Etienne,

thanks for the review.

[snip]
> > +
> > +static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
> > +                                       struct voltage_info *vinfo)
> > +{
> > +       int ret, dom;
> > +       struct scmi_xfer *td, *tl;
> > +       struct device *dev = handle->dev;
> > +       struct scmi_msg_resp_domain_attributes *resp_dom;
> > +       struct scmi_msg_resp_describe_levels *resp_levels;
> > +
> > +       ret = scmi_xfer_get_init(handle, VOLTAGE_DOMAIN_ATTRIBUTES,
> > +                                SCMI_PROTOCOL_VOLTAGE, sizeof(__le32),
> > +                                sizeof(*resp_dom), &td);
> > +       if (ret)
> > +               return ret;
> > +       resp_dom = td->rx.buf;
> > +
> > +       ret = scmi_xfer_get_init(handle, VOLTAGE_DESCRIBE_LEVELS,
> > +                                SCMI_PROTOCOL_VOLTAGE, sizeof(__le64), 0, &tl);
> > +       if (ret)
> > +               goto outd;
> > +       resp_levels = tl->rx.buf;
> > +
> > +       for (dom = 0; dom < vinfo->num_domains; dom++) {
> > +               u32 desc_index = 0;
> > +               u16 num_returned = 0, num_remaining = 0;
> > +               struct scmi_msg_cmd_describe_levels *cmd;
> > +               struct scmi_voltage_info *v;
> > +
> > +               /* Retrieve domain attributes at first ... */
> > +               put_unaligned_le32(dom, td->tx.buf);
> > +               ret = scmi_do_xfer(handle, td);
> > +               if (ret)
> > +                       continue;
> > +
> > +               v = devm_kzalloc(dev, sizeof(*v), GFP_KERNEL);
> > +               if (!v) {
> > +                       ret = -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               v->id = dom;
> > +               v->attributes = le32_to_cpu(resp_dom->attr);
> > +               strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
> > +
> > +               cmd = tl->tx.buf;
> > +               cmd->domain_id = cpu_to_le32(v->id);
> > +               /* ...then retrieve domain levels descriptions */
> > +               do {
> > +                       u32 flags;
> > +                       int cnt;
> > +
> 
> Here domain_id must be reloaded in the message payload.
> 
> +               cmd->domain_id = cpu_to_le32(v->id);
> 
> When the SCMI shared memory is used as a unique buffer for
> tx and rx messages, cmd refers to the memory storing previous
> message sent on the SCMI channel.
> In the loop we're in, the previous response has scratched
> previous outgoing message including domain_id value hence
> the full message sent to the SCMI server should be reloaded
> before scmi_do_xfer() is called.
> 

Ah right.. I forgot you already pointed out this on another thread.
My bad, I'll fix in v2.

Thanks

Cristian

> Regards,
> etienne
> 
> > +                       cmd->level_index = desc_index;
> > +                       ret = scmi_do_xfer(handle, tl);
> > +                       if (ret)
> > +                               break;
> > +
> > +                       flags = le32_to_cpu(resp_levels->flags);
> > +                       num_returned = NUM_RETURNED_LEVELS(flags);
> > +                       num_remaining = NUM_REMAINING_LEVELS(flags);
> > +
> > +                       /* Allocate space for num_levels if not already done */
> > +                       if (!v->num_levels) {
> > +                               ret = scmi_init_voltage_levels(dev, v, flags,
> > +                                                              num_returned +
> > +                                                              num_remaining);
> > +                               if (ret)
> > +                                       break;
> > +                       }
> > +
> > +                       if (desc_index + num_returned > v->num_levels) {
> > +                               dev_err(handle->dev,
> > +                                       "No. of voltage levels can't exceed %d",
> > +                                       v->num_levels);
> > +                               ret = -EINVAL;
> > +                               break;
> > +                       }
> > +
> > +                       for (cnt = 0; cnt < num_returned; cnt++) {
> > +                               s32 val;
> > +
> > +                               val =
> > +                                   (s32)le32_to_cpu(resp_levels->voltage[cnt]);
> > +                               v->levels_uv[desc_index + cnt] = val;
> > +                               if (!v->negative_volts_allowed && val < 0)
> > +                                       v->negative_volts_allowed = true;
> > +                       }
> > +
> > +                       desc_index += num_returned;
> > +                       /* check both to avoid infinite loop due to buggy fw */
> > +               } while (num_returned && num_remaining);
> > +
> > +               /*
> > +                * Bail out on memory errors, just skip domain on any
> > +                * other error.
> > +                */
> > +               if (!ret)
> > +                       vinfo->domains[dom] = v;
> > +               else if (ret == -ENOMEM)
> > +                       break;
> > +       }
> > +
> > +       scmi_xfer_put(handle, tl);
> > +outd:
> > +       scmi_xfer_put(handle, td);
> > +
> > +       return ret;
> > +}
> > +
> > +static inline int __scmi_voltage_get_u32(const struct scmi_handle *handle,
> > +                                        u8 cmd_id, u32 domain_id, u32 *value)
> > +{
> > +       int ret;
> > +       struct scmi_xfer *t;
> > +       struct voltage_info *vinfo = handle->voltage_priv;
> > +
> > +       if (domain_id >= vinfo->num_domains)
> > +               return -EINVAL;
> > +
> > +       ret = scmi_xfer_get_init(handle, cmd_id,
> > +                                SCMI_PROTOCOL_VOLTAGE,
> > +                                sizeof(__le32), 0, &t);
> > +       if (ret)
> > +               return ret;
> > +
> > +       put_unaligned_le32(domain_id, t->tx.buf);
> > +       ret = scmi_do_xfer(handle, t);
> > +       if (!ret)
> > +               *value = get_unaligned_le32(t->rx.buf);
> > +
> > +       scmi_xfer_put(handle, t);
> > +       return ret;
> > +}
> > +
> > +static int scmi_voltage_config_set(const struct scmi_handle *handle,
> > +                                  u32 domain_id, u32 config)
> > +{
> > +       int ret;
> > +       struct scmi_xfer *t;
> > +       struct voltage_info *vinfo = handle->voltage_priv;
> > +       struct scmi_msg_cmd_config_set *cmd;
> > +
> > +       if (domain_id >= vinfo->num_domains)
> > +               return -EINVAL;
> > +
> > +       ret = scmi_xfer_get_init(handle, VOLTAGE_CONFIG_SET,
> > +                                SCMI_PROTOCOL_VOLTAGE,
> > +                                sizeof(*cmd), 0, &t);
> > +       if (ret)
> > +               return ret;
> > +
> > +       cmd = t->tx.buf;
> > +       cmd->domain_id = cpu_to_le32(domain_id);
> > +       cmd->config = cpu_to_le32(config & GENMASK(3, 0));
> > +
> > +       ret = scmi_do_xfer(handle, t);
> > +
> > +       scmi_xfer_put(handle, t);
> > +       return ret;
> > +}
> > +
> > +static int scmi_voltage_config_get(const struct scmi_handle *handle,
> > +                                  u32 domain_id, u32 *config)
> > +{
> > +       return __scmi_voltage_get_u32(handle, VOLTAGE_CONFIG_GET,
> > +                                     domain_id, config);
> > +}
> > +
> > +static int scmi_voltage_level_set(const struct scmi_handle *handle,
> > +                                 u32 domain_id, u32 flags, s32 volt_uV)
> > +{
> > +       int ret;
> > +       struct scmi_xfer *t;
> > +       struct voltage_info *vinfo = handle->voltage_priv;
> > +       struct scmi_msg_cmd_level_set *cmd;
> > +
> > +       if (domain_id >= vinfo->num_domains)
> > +               return -EINVAL;
> > +
> > +       ret = scmi_xfer_get_init(handle, VOLTAGE_LEVEL_SET,
> > +                                SCMI_PROTOCOL_VOLTAGE,
> > +                                sizeof(*cmd), 0, &t);
> > +       if (ret)
> > +               return ret;
> > +
> > +       cmd = t->tx.buf;
> > +       cmd->domain_id = cpu_to_le32(domain_id);
> > +       cmd->flags = cpu_to_le32(flags);
> > +       cmd->voltage_level = cpu_to_le32(volt_uV);
> > +
> > +       ret = scmi_do_xfer(handle, t);
> > +
> > +       scmi_xfer_put(handle, t);
> > +       return ret;
> > +}
> > +
> > +static int scmi_voltage_level_get(const struct scmi_handle *handle,
> > +                                 u32 domain_id, s32 *volt_uV)
> > +{
> > +       return __scmi_voltage_get_u32(handle, VOLTAGE_LEVEL_GET,
> > +                                     domain_id, (u32 *)volt_uV);
> > +}
> > +
> > +static const struct scmi_voltage_info *
> > +scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
> > +{
> > +       struct voltage_info *vinfo = handle->voltage_priv;
> > +
> > +       if (domain_id >= vinfo->num_domains)
> > +               return NULL;
> > +
> > +       return vinfo->domains[domain_id];
> > +}
> > +
> > +static int scmi_voltage_domains_num_get(const struct scmi_handle *handle)
> > +{
> > +       struct voltage_info *vinfo = handle->voltage_priv;
> > +
> > +       return vinfo->num_domains;
> > +}
> > +
> > +static struct scmi_voltage_ops voltage_ops = {
> > +       .num_domains_get = scmi_voltage_domains_num_get,
> > +       .info_get = scmi_voltage_info_get,
> > +       .config_set = scmi_voltage_config_set,
> > +       .config_get = scmi_voltage_config_get,
> > +       .level_set = scmi_voltage_level_set,
> > +       .level_get = scmi_voltage_level_get,
> > +};
> > +
> > +static int scmi_voltage_protocol_init(struct scmi_handle *handle)
> > +{
> > +       int ret;
> > +       u32 version;
> > +       struct voltage_info *vinfo;
> > +
> > +       ret = scmi_version_get(handle, SCMI_PROTOCOL_VOLTAGE, &version);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dev_dbg(handle->dev, "Voltage Version %d.%d\n",
> > +               PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> > +
> > +       vinfo = devm_kzalloc(handle->dev, sizeof(*vinfo), GFP_KERNEL);
> > +       if (!vinfo)
> > +               return -ENOMEM;
> > +       vinfo->version = version;
> > +
> > +       ret = scmi_protocol_attributes_get(handle, vinfo);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (vinfo->num_domains) {
> > +               vinfo->domains = devm_kcalloc(handle->dev, vinfo->num_domains,
> > +                                             sizeof(vinfo->domains),
> > +                                             GFP_KERNEL);
> > +               if (!vinfo->domains)
> > +                       return -ENOMEM;
> > +               ret = scmi_voltage_descriptors_get(handle, vinfo);
> > +               if (ret)
> > +                       return ret;
> > +       } else {
> > +               dev_warn(handle->dev, "No Voltage domains found.\n");
> > +       }
> > +
> > +       handle->voltage_ops = &voltage_ops;
> > +       handle->voltage_priv = vinfo;
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_VOLTAGE, voltage)
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index 9cd312a1ff92..032ad9bb2a53 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -209,6 +209,64 @@ struct scmi_reset_ops {
> >         int (*deassert)(const struct scmi_handle *handle, u32 domain);
> >  };
> >
> > +/**
> > + * struct scmi_voltage_info - describe one available SCMI Voltage Domain
> > + *
> > + * @id: the domain ID as advertised by the platform
> > + * @segmented: defines the layout of the entries of array @levels_uv.
> > + *            - when True the entries are to be interpreted as triplets,
> > + *              each defining a segment representing a range of equally
> > + *              space voltages: <lowest_volts>, <highest_volt>, <step_uV>
> > + *            - when False the entries simply represent a single discrete
> > + *              supported voltage level
> > + * @negative_volts_allowed: True if any of the entries of @levels_uv represent
> > + *                         a negative voltage.
> > + * @attributes: represents Voltage Domain advertised attributes
> > + * @name: name assigned to the Voltage Domain by platform
> > + * @num_levels: number of total entries in @levels_uv.
> > + * @levels_uv: array of entries describing the available voltage levels for
> > + *            this domain.
> > + */
> > +struct scmi_voltage_info {
> > +       u32 id;
> > +       bool segmented;
> > +#define SCMI_VOLTAGE_SEGMENT_LOW       0
> > +#define SCMI_VOLTAGE_SEGMENT_HIGH      1
> > +#define SCMI_VOLTAGE_SEGMENT_STEP      2
> > +       bool negative_volts_allowed;
> > +       u32 attributes;
> > +       char name[SCMI_MAX_STR_SIZE];
> > +       u16 num_levels;
> > +       s32 *levels_uv;
> > +};
> > +
> > +/**
> > + * struct scmi_voltage_ops - represents the various operations provided
> > + * by SCMI Voltage Protocol
> > + *
> > + * @num_domains_get: get the count of voltage domains provided by SCMI
> > + * @info_get: get the information of the specified domain
> > + * @config_set: set the config for the specified domain
> > + * @config_get: get the config of the specified domain
> > + * @level_set: set the voltage level for the specified domain
> > + * @level_get: get the voltage level of the specified domain
> > + */
> > +struct scmi_voltage_ops {
> > +       int (*num_domains_get)(const struct scmi_handle *handle);
> > +       const struct scmi_voltage_info *(*info_get)
> > +               (const struct scmi_handle *handle, u32 domain_id);
> > +       int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
> > +                         u32 config);
> > +#define        SCMI_VOLTAGE_ARCH_STATE_OFF             0x0
> > +#define        SCMI_VOLTAGE_ARCH_STATE_ON              0x7
> > +       int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
> > +                         u32 *config);
> > +       int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
> > +                        u32 flags, s32 volt_uV);
> > +       int (*level_get)(const struct scmi_handle *handle, u32 domain_id,
> > +                        s32 *volt_uV);
> > +};
> > +
> >  /**
> >   * struct scmi_notify_ops  - represents notifications' operations provided by
> >   * SCMI core
> > @@ -262,6 +320,7 @@ struct scmi_notify_ops {
> >   * @clk_ops: pointer to set of clock protocol operations
> >   * @sensor_ops: pointer to set of sensor protocol operations
> >   * @reset_ops: pointer to set of reset protocol operations
> > + * @voltage_ops: pointer to set of voltage protocol operations
> >   * @notify_ops: pointer to set of notifications related operations
> >   * @perf_priv: pointer to private data structure specific to performance
> >   *     protocol(for internal use only)
> > @@ -273,6 +332,8 @@ struct scmi_notify_ops {
> >   *     protocol(for internal use only)
> >   * @reset_priv: pointer to private data structure specific to reset
> >   *     protocol(for internal use only)
> > + * @voltage_priv: pointer to private data structure specific to voltage
> > + *     protocol(for internal use only)
> >   * @notify_priv: pointer to private data structure specific to notifications
> >   *     (for internal use only)
> >   */
> > @@ -284,6 +345,7 @@ struct scmi_handle {
> >         const struct scmi_power_ops *power_ops;
> >         const struct scmi_sensor_ops *sensor_ops;
> >         const struct scmi_reset_ops *reset_ops;
> > +       const struct scmi_voltage_ops *voltage_ops;
> >         const struct scmi_notify_ops *notify_ops;
> >         /* for protocol internal use */
> >         void *perf_priv;
> > @@ -291,6 +353,7 @@ struct scmi_handle {
> >         void *power_priv;
> >         void *sensor_priv;
> >         void *reset_priv;
> > +       void *voltage_priv;
> >         void *notify_priv;
> >         void *system_priv;
> >  };
> > @@ -303,6 +366,7 @@ enum scmi_std_protocol {
> >         SCMI_PROTOCOL_CLOCK = 0x14,
> >         SCMI_PROTOCOL_SENSOR = 0x15,
> >         SCMI_PROTOCOL_RESET = 0x16,
> > +       SCMI_PROTOCOL_VOLTAGE = 0x17,
> >  };
> >
> >  enum scmi_system_events {
> > --
> > 2.17.1
> >
