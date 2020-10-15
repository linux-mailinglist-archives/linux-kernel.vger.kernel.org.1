Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1C28EF73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgJOJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgJOJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:41:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2762C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 02:41:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so2497858ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddSdR49iH8f9o5qh+eHFHVZPppy9ne/5LIx/jR9kBYg=;
        b=vMwnRj/RnZqARcdWF7hGd1QMftwePwf9If27rUrb10Tc9J0E81TAIePmqTRMdzhF7l
         Scj2WX6PjbYtB/u/rPlMDeBqVhofHDCj+qDd0y9tE7tFcB6UxNAi+J3JxiVxsFhP5SJu
         4WDKJ9poMX7dhMVf4YIzeITRhG24nLzy7hZ50aWpXn+p7mOB/EXrNo883KbNPGNgrB/4
         2xLMruJzlu4H7NpYsZI0o0XUkk/77MVQFfxGHgpE+eAvn9GMRFPKderQKe/33zlTK+O5
         E6PGmKyGPyORTpjiYL6D2kG9nqNRf7BAv0vQUqQtkAOVNul8cuK/V3+hpvr/F+LumitM
         zqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddSdR49iH8f9o5qh+eHFHVZPppy9ne/5LIx/jR9kBYg=;
        b=HtYtYAXCljNLO8eYN8pT4/lTL84+QPoFCWEsbvWLxGO5TwEmT1Qcac6+zenHtpffbG
         i+Kieh+CLfWWkerCqbwegcEPGBvrqBeciRsY9dqt2tiy/M0Em0vVWHHKEo/33Iyoz9zd
         WFbKGwbTohRlfJjDaMFIzCMlHap0ijXwbJiMDDJ1vrT4fRx0rI5vGME5rYUyo6ll7WHC
         sad021O6QlLPs1c1fkX/QxwcnBo7yXxsiXIQhmrSYZEEf/ZsJ/anCB7pLyvQ/WVRGWfN
         +NR0B00VMSeqpjuj7ePtx74MXn7ZoYSEtgrPrqiCoWbsy2IMIDXQXJWPU5Y3K7u+R8Bc
         VqFA==
X-Gm-Message-State: AOAM53198m7dV80nttma78K6CsOkT8EAGMtWoWfIbAwbLWgcP0mTDIH7
        ID0XWfeeG4fZmm/fyvDS64O7PiGQ3RWEEw4igeRO62YPsmGecA==
X-Google-Smtp-Source: ABdhPJwLIAY1fiBth9jy8bR63Xg/HbiBRiPd5W2NGqgjCRYySwHBI1WN933hbfVEKe+hs8ty2ziq+A3/NfPx5/7p1PM=
X-Received: by 2002:a2e:8787:: with SMTP id n7mr987142lji.111.1602754880866;
 Thu, 15 Oct 2020 02:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201014150545.44807-1-cristian.marussi@arm.com> <20201014150545.44807-2-cristian.marussi@arm.com>
In-Reply-To: <20201014150545.44807-2-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 15 Oct 2020 11:41:09 +0200
Message-ID: <CAKfTPtCGQm14JcAn-Lb0o5yTjMrnPA59LcnC+L5WMwX6gTdm5w@mail.gmail.com>
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration interface
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, james.quinlan@broadcom.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        f.fainelli@gmail.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 at 17:06, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Extend common protocol registration routines and provide some new generic
> protocols' init/deinit helpers that tracks protocols' users and automatically
> perform the proper initialization/de-initialization on demand.
>
> Convert all protocols to use new registration schema while modifying only Base
> protocol to use also the new initialization helpers.
>
> All other standard protocols' initialization is still umodified and bound to
> SCMI devices probing.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

[...]

>
> +/**
> + * scmi_get_protocol_instance  - Protocol initialization helper.
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * In case the required protocol has never been requested before for this
> + * instance, allocate and initialize all the needed structures while handling
> + * resource allocation with a dedicated per-protocol devres subgroup.
> + *
> + * Return: A reference to an initialized protocol instance or error on failure.
> + */
> +static struct scmi_protocol_instance * __must_check
> +scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> +{
> +       int ret = -ENOMEM;
> +       void *gid;
> +       struct scmi_protocol_instance *pi;
> +       struct scmi_info *info = handle_to_scmi_info(handle);
> +
> +       mutex_lock(&info->protocols_mtx);
> +       /* Ensure protocols has been updated */
> +       smp_rmb();

Why do you need this smp_rmb and the smp_wmb below ?

Isn't the mutex not enough ?

> +       pi = info->protocols[protocol_id];
> +
> +       if (!pi) {
> +               const struct scmi_protocol *proto;
> +
> +               /* Fail if protocol not registered on bus */
> +               proto = scmi_get_protocol(protocol_id);
> +               if (!proto) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               /* Protocol specific devres group */
> +               gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
> +               if (!gid)
> +                       goto out;
> +
> +               pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
> +               if (!pi)
> +                       goto clean;
> +
> +               pi->gid = gid;
> +               pi->proto = proto;
> +               refcount_set(&pi->users, 1);
> +               /* proto->init is assured NON NULL by scmi_protocol_register */
> +               ret = pi->proto->init(handle);
> +               if (ret)
> +                       goto clean;
> +
> +               info->protocols[protocol_id] = pi;
> +               /* Ensure initialized protocol is visible */
> +               smp_wmb();
> +
> +               devres_close_group(handle->dev, pi->gid);
> +               dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
> +                       protocol_id);
> +       } else {
> +               refcount_inc(&pi->users);
> +       }
> +       mutex_unlock(&info->protocols_mtx);
> +
> +       return pi;
> +
> +clean:
> +       devres_release_group(handle->dev, gid);
> +out:
> +       mutex_unlock(&info->protocols_mtx);
> +       return ERR_PTR(ret);
> +}
> +
> +/**
> + * scmi_acquire_protocol  - Protocol acquire
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * Register a new user for the requested protocol on the specified SCMI
> + * platform instance, possibly triggering its initialization on first user.
> + *
> + * Return: 0 if protocol was acquired successfully.
> + */
> +int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
> +{
> +       return IS_ERR(scmi_get_protocol_instance(handle, protocol_id));
> +}
> +
> +/**
> + * scmi_release_protocol  - Protocol de-initialization helper.
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * Remove one user for the specified protocol and triggers de-initialization
> + * and resources de-allocation once the last user has gone.
> + */
> +void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> +{
> +       struct scmi_info *info = handle_to_scmi_info(handle);
> +       struct scmi_protocol_instance *pi;
> +
> +       mutex_lock(&info->protocols_mtx);
> +       /* Ensure protocols has been updated */
> +       smp_rmb();
> +       pi = info->protocols[protocol_id];
> +       if (WARN_ON(!pi)) {
> +               mutex_unlock(&info->protocols_mtx);
> +               return;
> +       }
> +
> +       if (refcount_dec_and_test(&pi->users)) {
> +               void *gid = pi->gid;
> +
> +               if (pi->proto->deinit)
> +                       pi->proto->deinit(handle);
> +
> +               info->protocols[protocol_id] = NULL;
> +               /* Ensure deinitialized protocol is visible */
> +               smp_wmb();
> +
> +               devres_release_group(handle->dev, gid);
> +               dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> +                       protocol_id);
> +       }
> +       mutex_unlock(&info->protocols_mtx);
> +}
> +
>  void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>                                      u8 *prot_imp)
>  {
> @@ -785,6 +934,7 @@ static int scmi_probe(struct platform_device *pdev)
>         info->dev = dev;
>         info->desc = desc;
>         INIT_LIST_HEAD(&info->node);
> +       mutex_init(&info->protocols_mtx);
>
>         platform_set_drvdata(pdev, info);
>         idr_init(&info->tx_idr);
> @@ -805,10 +955,14 @@ static int scmi_probe(struct platform_device *pdev)
>         if (scmi_notification_init(handle))
>                 dev_err(dev, "SCMI Notifications NOT available.\n");
>
> -       ret = scmi_base_protocol_init(handle);
> -       if (ret) {
> -               dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> -               return ret;
> +       /*
> +        * Trigger SCMI Base protocol initialization.
> +        * It's mandatory and won't be ever released/deinit until the
> +        * SCMI stack is shutdown/unloaded as a whole.
> +        */
> +       if (scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE)) {
> +               dev_err(dev, "unable to communicate with SCMI\n");
> +               return -ENODEV;
>         }
>
>         mutex_lock(&scmi_list_mutex);
> @@ -941,6 +1095,8 @@ static int __init scmi_driver_init(void)
>  {
>         scmi_bus_init();
>
> +       scmi_base_register();
> +
>         scmi_clock_register();
>         scmi_perf_register();
>         scmi_power_register();
> @@ -954,7 +1110,7 @@ subsys_initcall(scmi_driver_init);
>
>  static void __exit scmi_driver_exit(void)
>  {
> -       scmi_bus_exit();
> +       scmi_base_unregister();
>
>         scmi_clock_unregister();
>         scmi_perf_unregister();
> @@ -963,6 +1119,8 @@ static void __exit scmi_driver_exit(void)
>         scmi_sensors_unregister();
>         scmi_system_unregister();
>
> +       scmi_bus_exit();
> +
>         platform_driver_unregister(&scmi_driver);
>  }
>  module_exit(scmi_driver_exit);
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index c24e427dce0d..eae58b2a92cc 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -91,10 +91,9 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>
> +#include "common.h"
>  #include "notify.h"
>
> -#define SCMI_MAX_PROTO         256
> -
>  #define PROTO_ID_MASK          GENMASK(31, 24)
>  #define EVT_ID_MASK            GENMASK(23, 16)
>  #define SRC_ID_MASK            GENMASK(15, 0)
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 82fb3babff72..854460a051c2 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface (SCMI) Performance Protocol
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.
>   */
>
>  #define pr_fmt(fmt) "SCMI Notifications PERF - " fmt
> @@ -892,4 +892,10 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
>         return 0;
>  }
>
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_PERF, perf)
> +static struct scmi_protocol scmi_perf = {
> +       .id = SCMI_PROTOCOL_PERF,
> +       .init = &scmi_perf_protocol_init,
> +       .ops = &perf_ops,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(perf, scmi_perf)
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 1f37258e9bee..42c9c88da07c 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface (SCMI) Power Protocol
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.
>   */
>
>  #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
> @@ -301,4 +301,10 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
>         return 0;
>  }
>
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_POWER, power)
> +static struct scmi_protocol scmi_power = {
> +       .id = SCMI_PROTOCOL_POWER,
> +       .init = &scmi_power_protocol_init,
> +       .ops = &power_ops,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(power, scmi_power)
> diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> index a981a22cfe89..2caf0bdb6fdc 100644
> --- a/drivers/firmware/arm_scmi/reset.c
> +++ b/drivers/firmware/arm_scmi/reset.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface (SCMI) Reset Protocol
>   *
> - * Copyright (C) 2019 ARM Ltd.
> + * Copyright (C) 2019-2020 ARM Ltd.
>   */
>
>  #define pr_fmt(fmt) "SCMI Notifications RESET - " fmt
> @@ -311,4 +311,10 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
>         return 0;
>  }
>
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_RESET, reset)
> +static struct scmi_protocol scmi_reset = {
> +       .id = SCMI_PROTOCOL_RESET,
> +       .init = &scmi_reset_protocol_init,
> +       .ops = &reset_ops,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(reset, scmi_reset)
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index b4232d611033..dfe3076d2093 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface (SCMI) Sensor Protocol
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.
>   */
>
>  #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
> @@ -367,4 +367,10 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
>         return 0;
>  }
>
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SENSOR, sensors)
> +static struct scmi_protocol scmi_sensors = {
> +       .id = SCMI_PROTOCOL_SENSOR,
> +       .init = &scmi_sensors_protocol_init,
> +       .ops = &sensor_ops,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(sensors, scmi_sensors)
> diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
> index 283e12d5f24b..bcea18bf54ab 100644
> --- a/drivers/firmware/arm_scmi/system.c
> +++ b/drivers/firmware/arm_scmi/system.c
> @@ -128,4 +128,10 @@ static int scmi_system_protocol_init(struct scmi_handle *handle)
>         return 0;
>  }
>
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SYSTEM, system)
> +static struct scmi_protocol scmi_system = {
> +       .id = SCMI_PROTOCOL_SYSTEM,
> +       .init = &scmi_system_protocol_init,
> +       .ops = NULL,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(system, scmi_system)
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 9cd312a1ff92..ca23d682941e 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -376,9 +376,9 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
>  #define module_scmi_driver(__scmi_driver)      \
>         module_driver(__scmi_driver, scmi_register, scmi_unregister)
>
> -typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
> -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
> -void scmi_protocol_unregister(int protocol_id);
> +struct scmi_protocol;
> +int scmi_protocol_register(struct scmi_protocol *proto);
> +void scmi_protocol_unregister(const struct scmi_protocol *proto);
>
>  /* SCMI Notification API - Custom Event Reports */
>  enum scmi_notification_events {
> --
> 2.17.1
>
