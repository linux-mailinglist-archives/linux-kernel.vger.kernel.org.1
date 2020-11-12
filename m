Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597682B0363
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKLLDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:03:48 -0500
Received: from plasma33.jpberlin.de ([80.241.58.43]:58473 "EHLO
        plasma33.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKLLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:03:20 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 06:03:16 EST
Received: from spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122])
        by plasma.jpberlin.de (Postfix) with ESMTP id 81EFB102B78;
        Thu, 12 Nov 2020 11:57:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id O8NoP-JbESnQ; Thu, 12 Nov 2020 11:57:12 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 5FEB8102A23;
        Thu, 12 Nov 2020 11:57:11 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v2 10/10] firmware: arm_scmi: Add virtio transport
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>, <jean-philippe@linaro.org>,
        <mikhail.golubev@opensynergy.com>, <souvik.chakravarty@arm.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <anton.yakovlev@opensynergy.com>, <sudeep.holla@arm.com>,
        <alex.bennee@linaro.org>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
 <20201105212116.411422-11-peter.hilber@opensynergy.com>
 <20201110213237.GH42652@e120937-lin>
Autocrypt: addr=peter.hilber@opensynergy.com; prefer-encrypt=mutual; keydata=
 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
 lbekkuPTQs/m
Message-ID: <acacfdd9-63b0-d8d4-4684-1b2fbb8c5e9c@opensynergy.com>
Date:   Thu, 12 Nov 2020 11:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <20201110213237.GH42652@e120937-lin>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -10.71 / 15.00 / 15.00
X-Rspamd-Queue-Id: 81EFB102B78
X-Rspamd-UID: adc234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.20 22:32, Cristian Marussi wrote:
> Hi Peter/Igor,
> 
> I went through this series while trying to grasp a bit more of all the
> virtio inner workings and needs and I'll leave a few detailed comments
> down below.
> 
> In short at first, I think I can say that there are a couple of places
> where I noticed you had to play all sort of tricks to fit into the current
> SCMI transport layer frameowrk or to avoid adding DT references.
> 
> It's clear that we'll have to somehow extend/fix/abstract the SCMI
> transport layer (in my opinion), because I doubt that some of the tricks
> you played would be well received for upstream ever (...but it's worth
> noting it's not up to me saying the last...)
> 
> So in these days I'm trying to play with this series and the SCMI
> stack to see if I can extend it in a more sensible way to fit some of
> the observations I make down below (now transport core layer is pretty
> much shmem/mailbox oriented)...still nothing to share anyway as of now.

Hi Cristian,

thanks for your review. I agree that some changes to the patch series
are needed to move it beyond RFC state. Please see individual responses
below.

Best regards,

Peter

> 
> 
> On Thu, Nov 05, 2020 at 10:21:16PM +0100, Peter Hilber wrote:
>> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>>
>> This transport enables accessing an SCMI platform as a virtio device.
>>
>> Implement an SCMI virtio driver according to the virtio SCMI device spec
>> patch v5 [1]. Virtio device id 32 has been reserved for the SCMI device
>> [2].
>>
>> The virtio transport has one tx channel (virtio cmdq, A2P channel) and
>> at most one rx channel (virtio eventq, P2A channel).
>>
>> The following feature bit defined in [1] is not implemented:
>> VIRTIO_SCMI_F_SHARED_MEMORY.
>>
>> After the preparatory patches, implement the virtio transport as
>> paraphrased:
>>
>> Only support a single arm-scmi device (which is consistent with the SCMI
>> spec). Call scmi-virtio init from arm-scmi module init. During the
>> arm-scmi probing, link to the first probed scmi-virtio device. Defer
>> arm-scmi probing if no scmi-virtio device is bound yet.
>>
>> Use the scmi_xfer tx/rx buffers for data exchange with the virtio device
>> in order to avoid redundant maintenance of additional buffers. Allocate
>> the buffers in the SCMI transport, and prepend room for a small header
>> used by the virtio transport to the tx/rx buffers.
>>
>> For simplicity, restrict the number of messages which can be pending
>> simultaneously according to the virtqueue capacity. (The virtqueue sizes
>> are negotiated with the virtio device.)
>>
>> As soon as rx channel message buffers are allocated or have been read
>> out by the arm-scmi driver, feed them to the virtio device.
>>
>> Since some virtio devices may not have the short response time exhibited
>> by SCMI platforms using other transports, set a generous response
>> timeout.
>>
>> Limitations:
>>
>> Do not adjust the other SCMI timeouts for delayed response and polling
>> for now, since these timeouts are only relevant in special cases which
>> are not yet deemed relevant for this transport.
>>
>> To do (as discussed in the cover letter):
>>
>> - Avoid re-use of buffers still being used by the virtio device on
>>   timeouts.
>>
>> - Avoid race conditions on receiving messages during/after channel free
>>   on driver probe failure or remove.
>>
>> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
>> [2] https://www.oasis-open.org/committees/ballot.php?id=3496
>>
>> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
>> ---
>>  MAINTAINERS                        |   1 +
>>  drivers/firmware/Kconfig           |  12 +-
>>  drivers/firmware/arm_scmi/Makefile |   1 +
>>  drivers/firmware/arm_scmi/common.h |  14 +
>>  drivers/firmware/arm_scmi/driver.c |  11 +
>>  drivers/firmware/arm_scmi/virtio.c | 493 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_ids.h    |   1 +
>>  include/uapi/linux/virtio_scmi.h   |  41 +++
>>  8 files changed, 573 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/firmware/arm_scmi/virtio.c
>>  create mode 100644 include/uapi/linux/virtio_scmi.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index deaafb617361..8df73d6ddfc1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16772,6 +16772,7 @@ F:    drivers/firmware/arm_scpi.c
>>  F:   drivers/reset/reset-scmi.c
>>  F:   include/linux/sc[mp]i_protocol.h
>>  F:   include/trace/events/scmi.h
>> +F:   include/uapi/linux/virtio_scmi.h
>>
>>  SYSTEM RESET/SHUTDOWN DRIVERS
>>  M:   Sebastian Reichel <sre@kernel.org>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index bdde51adb267..c4bdd84f7405 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -9,7 +9,7 @@ menu "Firmware Drivers"
>>  config ARM_SCMI_PROTOCOL
>>       tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
>>       depends on ARM || ARM64 || COMPILE_TEST
>> -     depends on ARM_SCMI_HAVE_SHMEM
>> +     depends on ARM_SCMI_HAVE_SHMEM || VIRTIO_SCMI
>>       help
>>         ARM System Control and Management Interface (SCMI) protocol is a
>>         set of operating system-independent software interfaces that are
>> @@ -34,6 +34,16 @@ config ARM_SCMI_HAVE_SHMEM
>>         This declares whether a shared memory based transport for SCMI is
>>         available.
>>
>> +config VIRTIO_SCMI
>> +     bool "Virtio transport for SCMI"
>> +     default n
>> +     depends on VIRTIO
>> +     help
>> +       This enables the virtio based transport for SCMI.
>> +
>> +       If you want to use the ARM SCMI protocol between the virtio guest and
>> +       a host providing a virtio SCMI device, answer Y.
>> +
>>  config ARM_SCMI_POWER_DOMAIN
>>       tristate "SCMI power domain driver"
>>       depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>> index 3cc7fa40a464..25caea5e1969 100644
>> --- a/drivers/firmware/arm_scmi/Makefile
>> +++ b/drivers/firmware/arm_scmi/Makefile
>> @@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
>>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>>  scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
>>  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
>> +scmi-transport-$(CONFIG_VIRTIO_SCMI) += virtio.o
>>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
>>  scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
>>                   $(scmi-transport-y)
>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>> index 13c9ac176b23..b46dfe84e78b 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -165,6 +165,17 @@ int scmi_base_protocol_init(struct scmi_handle *h);
>>  int __init scmi_bus_init(void);
>>  void __exit scmi_bus_exit(void);
>>
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +int __init virtio_scmi_init(void);
>> +void __exit virtio_scmi_exit(void);
>> +#else
>> +static inline int __init virtio_scmi_init(void)
>> +{
>> +     return 0;
>> +}
>> +#define virtio_scmi_exit() do { } while (0)
>> +#endif
>> +
>>  #define DECLARE_SCMI_REGISTER_UNREGISTER(func)               \
>>       int __init scmi_##func##_register(void);        \
>>       void __exit scmi_##func##_unregister(void)
>> @@ -263,6 +274,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
>>  #ifdef CONFIG_HAVE_ARM_SMCCC
>>  extern const struct scmi_desc scmi_smc_desc;
>>  #endif
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +extern const struct scmi_desc scmi_virtio_desc;
>> +#endif
>>
>>  int scmi_set_transport_info(struct device *dev, void *transport_info);
>>  void *scmi_get_transport_info(struct device *dev);
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index 244141e45e88..923ba526e829 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -996,6 +996,9 @@ static const struct of_device_id scmi_of_match[] = {
>>  #endif
>>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>>       { .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>> +#endif
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +     { .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>>  #endif
>>       { /* Sentinel */ },
>>  };
>> @@ -1014,8 +1017,14 @@ static struct platform_driver scmi_driver = {
>>
>>  static int __init scmi_driver_init(void)
>>  {
>> +     int ret;
>> +
>>       scmi_bus_init();
>>
>> +     ret = virtio_scmi_init();
>> +     if (ret)
>> +             return ret;
>> +
>>       scmi_clock_register();
>>       scmi_perf_register();
>>       scmi_power_register();
>> @@ -1038,6 +1047,8 @@ static void __exit scmi_driver_exit(void)
>>       scmi_sensors_unregister();
>>       scmi_system_unregister();
>>
>> +     virtio_scmi_exit();
>> +
> 
> These virtio init/exit functions which are called by the platform driver
> init code in fact introduce a very transport specific non-general piece
> of code in the common init path: this is one of the things I'd like to
> abstract better, so that any available transport can just register itself
> with the core in the same way and be initialized if needed in an uniform
> way, without having to extend the core driver init.
> (not saying that now it is not anyway already done for other
> matters....I'd like to remove those too in the future.)

Agree.

> 
> 
>>       platform_driver_unregister(&scmi_driver);
>>  }
>>  module_exit(scmi_driver_exit);
>> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
>> new file mode 100644
>> index 000000000000..f70aa72f34f1
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/virtio.c
>> @@ -0,0 +1,493 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Virtio Transport driver for Arm System Control and Management Interface
>> + * (SCMI).
>> + *
>> + * Copyright (C) 2020 OpenSynergy.
>> + */
>> +
>> +/**
>> + * DOC: Theory of Operation
>> + *
>> + * The scmi-virtio transport implements a driver for the virtio SCMI device
>> + * proposed in virtio spec patch v5[1].
>> + *
>> + * There is one tx channel (virtio cmdq, A2P channel) and at most one rx
>> + * channel (virtio eventq, P2A channel). Each channel is implemented through a
>> + * virtqueue. Access to each virtqueue is protected by a spinlock.
>> + *
>> + * This SCMI transport uses the scmi_xfer tx/rx buffers for data exchange with
>> + * the virtio device to avoid maintenance of additional buffers.
>> + *
>> + * [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <uapi/linux/virtio_ids.h>
>> +#include <uapi/linux/virtio_scmi.h>
>> +
>> +#include "common.h"
>> +
>> +#define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
>> +#define DESCR_PER_TX_MSG 2
>> +
>> +struct scmi_vio_channel {
>> +     spinlock_t lock;
>> +     struct virtqueue *vqueue;
>> +     struct scmi_chan_info *cinfo;
>> +     u8 is_rx;
>> +};
>> +
>> +union virtio_scmi_input {
>> +     __virtio32 hdr;
>> +     struct virtio_scmi_response response;
>> +     struct virtio_scmi_notification notification;
>> +};
>> +
>> +struct scmi_vio_msg {
>> +     struct virtio_scmi_request *request;
>> +     union virtio_scmi_input *input;
>> +     u8 completed;
>> +};
>> +
>> +static int scmi_vio_populate_vq_rx(struct scmi_vio_channel *vioch,
>> +                                struct scmi_xfer *xfer)
>> +{
>> +     struct scatterlist sg_in;
>> +     struct scmi_vio_msg *msg = xfer->extra_data;
>> +     int rc;
>> +
>> +     msg->completed = false;
>> +
>> +     sg_init_one(&sg_in, msg->input,
>> +                 sizeof(*msg->input) + VIRTIO_SCMI_MAX_MSG_SIZE);
>> +
>> +     rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, xfer, GFP_ATOMIC);
>> +     if (rc)
>> +             dev_err(vioch->cinfo->dev, "%s() rc=%d\n", __func__, rc);
>> +     else
>> +             virtqueue_kick(vioch->vqueue);
>> +
>> +     return rc;
>> +}
>> +
>> +static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>> +{
>> +     struct scmi_vio_channel *vioch = vqueue->priv;
>> +     unsigned long iflags;
>> +     unsigned int length;
>> +
>> +     spin_lock_irqsave(&vioch->lock, iflags);
>> +
>> +     do {
>> +             struct scmi_xfer *xfer;
>> +
>> +             virtqueue_disable_cb(vqueue);
>> +
>> +             while ((xfer = virtqueue_get_buf(vqueue, &length))) {
>> +                     struct scmi_vio_msg *msg = xfer->extra_data;
>> +                     u32 msg_hdr =
>> +                             virtio32_to_cpu(vqueue->vdev, msg->input->hdr);
>> +                     u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
>> +
>> +                     if (!vioch->is_rx) { /* tx queue response */
>> +                             msg->completed = true;
>> +                             xfer->rx.len =
>> +                                     length - sizeof(msg->input->response);
>> +                             if (!xfer->hdr.poll_completion)
>> +                                     scmi_rx_callback(vioch->cinfo, msg_hdr);
>> +                             continue;
>> +                     }
>> +
> 
> So this is one of the places where SCMI transport seems not to accomodate so
> well the way virtio works as of now; it seems to me to be down to the fact that
> while virtio returns the message as a single chunk in one shot (since it carries
> the lenght 'out-of-band'), the SCMI transport expects a sort of 2 stage reads
> since the original shmem transport has the message size embedded in its header
> (which so has to be read at first), and so you have to stretch the usage of
> scmi_rx_callback introducing here some of its logic while leaving some other
> callbacks as empty dummies (like notifications callback): I think the transport
> should NOT have any knowledge of the structure/content of the stuff that it
> receives (like down below detecting which MSG_TYPE it is and acting accordingly).
> 
> It clearly cannot work like it is now (so you have to play the tricks), but I
> think the answer is reviewing accordingly the SCMI transport layer, not trying
> to fooli it while polluting the transport layer with knowlegde of SCMI internals
> like message's structure.
> 

I think I should remove the xfer->[tr]x.buf manipulation from the patch.
In my understanding, this is one, or even the, major source of problems.
It would have saved a few kiB of memory and avoided copying between
scmi_xfer buffers and dedicated virtio queue buffers. But we can just
introduce dedicated virtio buffers and copy, in lieu of a better idea.

As for the rest, if you don't like any of the scmi_xfer related logic to
be inside virtio.c, maybe we can move that logic into a new msg.c for
message-based communication, similar to shm.c for shmem-based
communication?

The msg.c logic would then mostly be called from the callback ops, just
like shm.c. I think we should retain some transport private pointer in
scmi_xfer to help with potential concurrent or out-of-order message
processing by the virtio device (access to the private pointer can be
abstracted). Otherwise I'm concerned that in some callback ops it would
be difficult for the virtio transport to determine which message is
being addressed.

If you agree on this, do you think that OpenSynergy could already start
implementing the aforementioned msg.c, or should we better wait for your
refactored interface?

>> +                     /* rx queue - notification or delayed response */
>> +                     switch (msg_type) {
>> +                     case MSG_TYPE_NOTIFICATION:
>> +                             xfer->rx.len = length -
>> +                                            sizeof(msg->input->notification);
>> +                             xfer->rx.buf = msg->input->notification.data;
>> +                             break;
>> +                     case MSG_TYPE_DELAYED_RESP:
>> +                             xfer->rx.len =
>> +                                     length - sizeof(msg->input->response);
>> +                             xfer->rx.buf = msg->input->response.data;
>> +                             break;
>> +                     default:
>> +                             dev_warn_once(vioch->cinfo->dev,
>> +                                           "rx: unknown message_type %d\n",
>> +                                           msg_type);
>> +                             scmi_vio_populate_vq_rx(vioch, xfer);
>> +                             continue;
>> +                     }
>> +
>> +                     scmi_rx_callback(vioch->cinfo, msg_hdr);
>> +                     scmi_vio_populate_vq_rx(vioch, xfer);
>> +             }
>> +
>> +             if (unlikely(virtqueue_is_broken(vqueue)))
>> +                     break;
>> +     } while (!virtqueue_enable_cb(vqueue));
>> +
>> +     spin_unlock_irqrestore(&vioch->lock, iflags);
>> +}
>> +
>> +static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
>> +
>> +static vq_callback_t *scmi_vio_complete_callbacks[] = {
>> +     scmi_vio_complete_cb,
>> +     scmi_vio_complete_cb
>> +};
>> +
>> +static int scmi_vio_match_any_dev(struct device *dev, const void *data)
>> +{
>> +     (void)dev;
>> +     (void)data;
>> +
>> +     return 1;
>> +}
>> +
>> +static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
>> +
>> +static int virtio_link_supplier(struct device *dev)
>> +{
>> +     struct device *vdev = driver_find_device(
>> +             &virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
>> +
>> +     if (!vdev) {
>> +             dev_notice_once(
>> +                     dev,
>> +                     "Deferring probe after not finding a bound scmi-virtio device\n");
>> +             return -EPROBE_DEFER;
>> +     }
>> +
>> +     /*
>> +      * Add plain device link for completeness. It might have no effect
>> +      * beyond sysfs.
>> +      */
>> +     if (!device_link_add(dev, vdev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
>> +             put_device(vdev);
>> +             dev_err(dev, "Adding link to supplier virtio device failed\n");
>> +             return -ECANCELED;
>> +     }
>> +
>> +     put_device(vdev);
>> +     return scmi_set_transport_info(dev, dev_to_virtio(vdev));
>> +}
>> +
> 
> I understand that here the attempt is to grab the virtio device upon
> which we are working and make it known to the core, while handling the
> case in which the MMIO transport is not ready with -EPROBE_DEFER, but I
> don't think such full-scale search with a dummy match function would be
> so well accepted upstream, and I don't understand really what's the
> point of the device_link_add() at the end...but maybe I'm missing
> something.

The point of the device_link_add() is just to make the relation between
the devices apparent in sysfs. It should show up in sysfs as described here:

https://lore.kernel.org/patchwork/patch/1245696/

> 
> Moreover looking at other virtio drivers (not that I'm an expert
> though...) it seems very much to me that this SCMI Virtio driver is
> sort of built/probed/initialized upside-down respect how the other
> virtio drivers are made, and this seems to be down again to some missing
> support in our SCMI transport layer (...plus the need to avoid any
> virtio-related DT addition).
> 
> That's the other thing that would be in my plan to rectify and unify in
> the SCMI transport layer (...at least in my hopes :D)

OK.

> 
>> +static bool virtio_chan_available(struct device *dev, int idx)
>> +{
>> +     struct virtio_device *vdev;
>> +     struct scmi_vio_channel **vioch;
>> +
>> +     /* scmi-virtio doesn't support per-protocol channels */
>> +     if (is_scmi_protocol_device(dev))
>> +             return false;
>> +
>> +     vdev = scmi_get_transport_info(dev);
>> +     if (!vdev)
>> +             return false;
>> +
>> +     vioch = vdev->priv;
>> +     if (!vioch)
>> +             return false;
>> +
>> +     return vioch[idx] && vioch[idx]->vqueue;
>> +}
>> +
>> +static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>> +                          bool tx)
>> +{
>> +     struct virtio_device *vdev;
>> +     struct scmi_vio_channel **vioch;
>> +     int vioch_index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
>> +
>> +     /* scmi-virtio doesn't support per-protocol channels */
>> +     if (is_scmi_protocol_device(dev))
>> +             return -1;
>> +
>> +     vdev = scmi_get_transport_info(dev);
>> +     if (!vdev)
>> +             return -1;
>> +
>> +     vioch = vdev->priv;
>> +     if (!vioch) {
>> +             dev_err(dev, "Data from scmi-virtio probe not found\n");
>> +             return -1;
>> +     }
>> +     cinfo->transport_info = vioch[vioch_index];
>> +     vioch[vioch_index]->cinfo = cinfo;
>> +
>> +     return 0;
>> +}
>> +
> 
> Same goes, from my point of view, for these two channel related
> callbacks that now have to perform some very odd interactions and checks
> with the SCMI core (at least in my opinion).
> 

ATM the SCMI core will not call these callbacks before link_supplier()
was successful, so we could indeed omit the second and third early
return in each of the callbacks. It seemed more robust to leave them in,
though.

In case it doesn't get obsoleted by interface changes, I will add some
additional comments to make clearer what is going on here.

> Does the lack of support for multiple per-protocol channels derive from
> the lack of a way (now that the DT entry has gone) to determine the
> association between a channel and its user ?

In my understanding that association could still be determined.

Per-protocol channels were deliberately omitted, since we saw little
benefit for virtio. In my understanding, it would only help to avoid
that one protocol monopolizes the channel by sending many messages or
causing many notifications.

> 
>> +static int virtio_chan_free(int id, void *p, void *data)
>> +{
>> +     struct scmi_chan_info *cinfo = p;
>> +     struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +
>> +     if (vioch) {
>> +             cinfo->transport_info = NULL;
>> +             kfree(vioch);
>> +     }
>> +
>> +     scmi_free_channel(cinfo, data, id);
>> +     return 0;
>> +}
>> +
>> +static int virtio_get_max_msg(bool tx, struct scmi_chan_info *base_cinfo,
>> +                           int *max_msg)
>> +{
>> +     struct scmi_vio_channel *vioch = base_cinfo->transport_info;
>> +
>> +     *max_msg = virtqueue_get_vring_size(vioch->vqueue);
>> +
>> +     /* Tx messages need multiple descriptors. */
>> +     if (tx)
>> +             *max_msg /= DESCR_PER_TX_MSG;
>> +
>> +     if (*max_msg > MSG_TOKEN_MAX) {
>> +             dev_notice(
>> +                     base_cinfo->dev,
>> +                     "Only %ld messages can be pending simultaneously, while the virtqueue could hold %d\n",
>> +                     MSG_TOKEN_MAX, *max_msg);
>> +             *max_msg = MSG_TOKEN_MAX;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int virtio_xfer_init_buffers(struct scmi_chan_info *cinfo,
>> +                                 struct scmi_xfer *xfer, int max_msg_size)
>> +{
>> +     struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +     struct scmi_vio_msg *msg;
>> +
>> +     msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
>> +     if (!msg)
>> +             return -ENOMEM;
>> +
>> +     xfer->extra_data = msg;
>> +
>> +     if (vioch->is_rx) {
>> +             int rc;
>> +             unsigned long iflags;
>> +
>> +             msg->input = devm_kzalloc(cinfo->dev,
>> +                                       sizeof(*msg->input) + max_msg_size,
>> +                                       GFP_KERNEL);
>> +             if (!msg->input)
>> +                     return -ENOMEM;
>> +
>> +             /*
>> +              * xfer->rx.buf will be set to notification or delayed response
>> +              * specific values in the receive callback, according to the
>> +              * type of the received message.
>> +              */
>> +
>> +             spin_lock_irqsave(&vioch->lock, iflags);
>> +             rc = scmi_vio_populate_vq_rx(vioch, xfer);
>> +             spin_unlock_irqrestore(&vioch->lock, iflags);
>> +             if (rc)
>> +                     return rc;
>> +     } else {
>> +             msg->request =
>> +                     devm_kzalloc(cinfo->dev,
>> +                                  sizeof(*msg->request) + max_msg_size,
>> +                                  GFP_KERNEL);
>> +             if (!msg->request)
>> +                     return -ENOMEM;
>> +
>> +             xfer->tx.buf = msg->request->data;
>> +
>> +             msg->input = devm_kzalloc(
>> +                     cinfo->dev, sizeof(msg->input->response) + max_msg_size,
>> +                     GFP_KERNEL);
>> +             if (!msg->input)
>> +                     return -ENOMEM;
>> +
>> +             xfer->rx.buf = msg->input->response.data;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int scmi_vio_send(struct scmi_vio_channel *vioch, struct scmi_xfer *xfer)
>> +{
>> +     struct scatterlist sg_out;
>> +     struct scatterlist sg_in;
>> +     struct scatterlist *sgs[DESCR_PER_TX_MSG] = { &sg_out, &sg_in };
>> +     struct scmi_vio_msg *msg = xfer->extra_data;
>> +     unsigned long iflags;
>> +     int rc;
>> +
>> +     msg->completed = false;
>> +
>> +     sg_init_one(&sg_out, msg->request,
>> +                 sizeof(*msg->request) + xfer->tx.len);
>> +     sg_init_one(&sg_in, &msg->input->response,
>> +                 sizeof(msg->input->response) + xfer->rx.len);
>> +
>> +     spin_lock_irqsave(&vioch->lock, iflags);
>> +     rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, xfer, GFP_ATOMIC);
>> +     if (rc)
>> +             dev_err(vioch->cinfo->dev, "%s() rc=%d\n", __func__, rc);
>> +     else
>> +             virtqueue_kick(vioch->vqueue);
>> +     spin_unlock_irqrestore(&vioch->lock, iflags);
>> +
>> +     return rc;
>> +}
>> +
>> +static int virtio_send_message(struct scmi_chan_info *cinfo,
>> +                            struct scmi_xfer *xfer)
>> +{
>> +     uint32_t hdr;
>> +     struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +     struct virtio_device *vdev = vioch->vqueue->vdev;
>> +     struct scmi_vio_msg *msg = xfer->extra_data;
>> +
>> +     hdr = pack_scmi_header(&xfer->hdr);
>> +
>> +     msg->request->hdr = cpu_to_virtio32(vdev, hdr);
>> +
>> +     return scmi_vio_send(vioch, xfer);
>> +}
>> +
>> +static void virtio_fetch_response(struct scmi_chan_info *cinfo,
>> +                               struct scmi_xfer *xfer)
>> +{
>> +     struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +     struct scmi_vio_msg *msg = xfer->extra_data;
>> +
>> +     xfer->hdr.status = virtio32_to_cpu(vioch->vqueue->vdev,
>> +                                        msg->input->response.status);
>> +}
>> +
>> +static void dummy_fetch_notification(struct scmi_chan_info *cinfo,
>> +                                  size_t max_len, struct scmi_xfer *xfer)
>> +{
>> +     (void)cinfo;
>> +     (void)max_len;
>> +     (void)xfer;
>> +}
>> +
>> +static void dummy_clear_channel(struct scmi_chan_info *cinfo)
>> +{
>> +     (void)cinfo;
>> +}
>> +
>> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
>> +                          struct scmi_xfer *xfer)
>> +{
>> +     struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +     struct scmi_vio_msg *msg = xfer->extra_data;
>> +     unsigned long iflags;
>> +     bool completed;
>> +
>> +     spin_lock_irqsave(&vioch->lock, iflags);
>> +     completed = msg->completed;
>> +     spin_unlock_irqrestore(&vioch->lock, iflags);
>> +
>> +     return completed;
>> +}
>> +
>> +static const struct scmi_transport_ops scmi_virtio_ops = {
>> +     .link_supplier = virtio_link_supplier,
>> +     .chan_available = virtio_chan_available,
>> +     .chan_setup = virtio_chan_setup,
>> +     .chan_free = virtio_chan_free,
>> +     .get_max_msg = virtio_get_max_msg,
>> +     .send_message = virtio_send_message,
>> +     .fetch_response = virtio_fetch_response,
>> +     .fetch_notification = dummy_fetch_notification,
>> +     .clear_channel = dummy_clear_channel,
>> +     .poll_done = virtio_poll_done,
>> +     .xfer_init_buffers = virtio_xfer_init_buffers,
>> +};
>> +
>> +const struct scmi_desc scmi_virtio_desc = {
>> +     .ops = &scmi_virtio_ops,
>> +     .max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>> +     .max_msg = 0, /* overridden by virtio_get_max_msg() */
>> +     .max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
>> +};
>> +
>> +static int scmi_vio_probe(struct virtio_device *vdev)
>> +{
>> +     struct device *dev = &vdev->dev;
>> +     struct scmi_vio_channel **vioch;
>> +     bool have_vq_rx;
>> +     int vq_cnt;
>> +     int i;
>> +     struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
>> +
>> +     vioch = devm_kcalloc(dev, VIRTIO_SCMI_VQ_MAX_CNT, sizeof(*vioch),
>> +                          GFP_KERNEL);
>> +     if (!vioch)
>> +             return -ENOMEM;
>> +
>> +     have_vq_rx = virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
>> +     vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
>> +
>> +     for (i = 0; i < vq_cnt; i++) {
>> +             vioch[i] = devm_kzalloc(dev, sizeof(**vioch), GFP_KERNEL);
>> +             if (!vioch[i])
>> +                     return -ENOMEM;
>> +     }
>> +
>> +     if (have_vq_rx)
>> +             vioch[VIRTIO_SCMI_VQ_RX]->is_rx = true;
>> +
>> +     if (virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
>> +                         scmi_vio_vqueue_names, NULL)) {
>> +             dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
>> +             return -1;
>> +     }
>> +     dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
>> +
>> +     for (i = 0; i < vq_cnt; i++) {
>> +             spin_lock_init(&vioch[i]->lock);
>> +             vioch[i]->vqueue = vqs[i];
>> +             vioch[i]->vqueue->priv = vioch[i];
>> +     }
>> +
>> +     vdev->priv = vioch;
>> +
> 
> As mentioned before, in other Virtio drivers this is the place where we
> should register somehow this transports/channels with the core (before
> marking the device ready), and may be the place where we can just share
> the core device for this tranport with the SCMI core without then having
> to play the above link_supplier chan_available/setup dance.
> 
> But again I still have to fully tries to change the SCMI transport
> interface at this point.
> 
> I've not really gone into all the details across all series because I
> see the above issues/limitations in the driver/SCMI_transport as sort of
> blocking.

I think some of the patches will no longer be needed in the future. I
would expect at least the following to go away:

[RFC PATCH v2 05/10] firmware: arm_scmi: Add xfer_init_buffers transport op

> 
> I'll let you now when I'll have something sensible on the SCMI core to
> share for better accomodate this transport.
> 
> Thanks
> 
> Cristian
> 
> 
>> +     virtio_device_ready(vdev);
>> +
>> +     return 0;
>> +}
>> +
>> +static unsigned int features[] = {
>> +     VIRTIO_SCMI_F_P2A_CHANNELS,
>> +};
>> +
>> +static const struct virtio_device_id id_table[] = {
>> +     { VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
>> +     { 0 }
>> +};
>> +
>> +static struct virtio_driver virtio_scmi_driver = {
>> +     .driver.name = "scmi-virtio",
>> +     .driver.owner = THIS_MODULE,
>> +     .feature_table = features,
>> +     .feature_table_size = ARRAY_SIZE(features),
>> +     .id_table = id_table,
>> +     .probe = scmi_vio_probe,
>> +};
>> +
>> +int __init virtio_scmi_init(void)
>> +{
>> +     return register_virtio_driver(&virtio_scmi_driver);
>> +}
>> +
>> +void __exit virtio_scmi_exit(void)
>> +{
>> +     unregister_virtio_driver(&virtio_scmi_driver);
>> +}
>> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
>> index b052355ac7a3..57d233c02720 100644
>> --- a/include/uapi/linux/virtio_ids.h
>> +++ b/include/uapi/linux/virtio_ids.h
>> @@ -48,5 +48,6 @@
>>  #define VIRTIO_ID_FS           26 /* virtio filesystem */
>>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>>  #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
>> +#define VIRTIO_ID_SCMI         32 /* virtio SCMI */
>>
>>  #endif /* _LINUX_VIRTIO_IDS_H */
>> diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_scmi.h
>> new file mode 100644
>> index 000000000000..9f21b3dbbfe2
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_scmi.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> +/*
>> + * Copyright (C) 2020 OpenSynergy GmbH
>> + */
>> +
>> +#ifndef _UAPI_LINUX_VIRTIO_SCMI_H
>> +#define _UAPI_LINUX_VIRTIO_SCMI_H
>> +
>> +#include <linux/virtio_types.h>
>> +
>> +/* Feature bits */
>> +
>> +/* Device implements some SCMI notifications, or delayed responses. */
>> +#define VIRTIO_SCMI_F_P2A_CHANNELS 0
>> +
>> +/* Device implements any SCMI statistics shared memory region */
>> +#define VIRTIO_SCMI_F_SHARED_MEMORY 1
>> +
>> +/* Virtqueues */
>> +
>> +#define VIRTIO_SCMI_VQ_TX 0 /* cmdq */
>> +#define VIRTIO_SCMI_VQ_RX 1 /* eventq */
>> +#define VIRTIO_SCMI_VQ_MAX_CNT 2
>> +
>> +struct virtio_scmi_request {
>> +     __virtio32 hdr;
>> +     __u8 data[];
>> +};
>> +
>> +struct virtio_scmi_response {
>> +     __virtio32 hdr;
>> +     __virtio32 status;
>> +     __u8 data[];
>> +};
>> +
>> +struct virtio_scmi_notification {
>> +     __virtio32 hdr;
>> +     __u8 data[];
>> +};
>> +
>> +#endif /* _UAPI_LINUX_VIRTIO_SCMI_H */
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


