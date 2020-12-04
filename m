Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D062CE70F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLDEmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:42:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57978 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLDEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:42:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC6BD103E2E;
        Thu,  3 Dec 2020 23:42:06 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=L/O62gQN7CGhqxHxvnU12bfvozc=; b=acy7MK
        OUFByGsiSbTjnYlRN2ZmaLixRx/rCDqK7FvRaUiPbEPFCEAnf2XCTIrtOhOapQPx
        gciOgCTg3r1Hc51EunIQw1AsQSOtxIEt1oJf+6iQhIQvnPS+H04K6v5MR077GAge
        7bLyXHFJiq96pYMhoH+anWO2K/VDU4Um3ouv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4F14103E2D;
        Thu,  3 Dec 2020 23:42:06 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=7JgJuVjwh3CFtZR8kqIaiFoY87sTzfmcyvs0jSlA37k=; b=ynpY5QYBsvgC29Wfo0+4B33kMrfMWPENKFtwqYv3ETdGAni4wn8ccsn6J35RgLMANtO8qW7Yy7Z73WtvLppm3IIQPXVHAlMZe7ZV8XbTnLcrvkUpxGNx98IeMQBGKscfcoHn550J4IDRQYb/EJq8wjKc+CUqBe3KCM3xBq9mSuI=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A5D2103E29;
        Thu,  3 Dec 2020 23:42:03 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id D734D2DA0639;
        Thu,  3 Dec 2020 23:42:01 -0500 (EST)
Date:   Thu, 3 Dec 2020 23:42:01 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Parshuram Thombare <pthombar@cadence.com>
cc:     alexandre.belloni@bootlin.com, slongerbeam@gmail.com,
        vitor.soares@synopsys.com, praneeth@ti.com, mparab@cadence.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/7] i3c: master: add i3c_secondary_master_register
In-Reply-To: <1606717090-3847-1-git-send-email-pthombar@cadence.com>
Message-ID: <sq1q9262-8q61-7qop-9ps2-q5o6qo5q3p63@syhkavp.arg>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com> <1606717090-3847-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 0E257364-35EB-11EB-ACCB-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Parshuram Thombare wrote:

> add i3c_secondary_master_register which is used
> to register secondary masters.

I'm not sure about the logic here. Why would the secondary master 
initialize the bus? If you make a distinction between primary and 
secondary, then the primary should be the owner of the bus and it should 
have enumerated it already. You should populate the bus structure with 
info provided by the primary master not from DT?


> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c       |  154 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/i3c/master.h |    3 +
>  2 files changed, 156 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 56e8fe4..af0630a 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1797,6 +1797,90 @@ static int i3c_primary_master_bus_init(struct i3c_master_controller *master)
>  	return ret;
>  }
>  
> +/**
> + * i3c_secondary_master_bus_init() - initialize an I3C bus for secondary
> + * master
> + * @master: secondary master initializing the bus
> + *
> + * This function does
> + *
> + * 1. Attach I2C devs to the master
> + *
> + * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
> + *    the master controller. That's usually where the bus mode is selected
> + *    (pure bus or mixed fast/slow bus)
> + *
> + * Once this is done, I2C devices should be usable.
> + *
> + * Return: a 0 in case of success, an negative error code otherwise.
> + */
> +static int i3c_secondary_master_bus_init(struct i3c_master_controller *master)
> +{
> +	enum i3c_addr_slot_status status;
> +	struct i2c_dev_boardinfo *i2cboardinfo;
> +	struct i2c_dev_desc *i2cdev;
> +	int ret;
> +
> +	/*
> +	 * First attach all devices with static definitions provided by the
> +	 * FW.
> +	 */
> +	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
> +		status = i3c_bus_get_addr_slot_status(&master->bus,
> +						      i2cboardinfo->base.addr);
> +		if (status != I3C_ADDR_SLOT_FREE) {
> +			ret = -EBUSY;
> +			goto err_detach_devs;
> +		}
> +
> +		i3c_bus_set_addr_slot_status(&master->bus,
> +					     i2cboardinfo->base.addr,
> +					     I3C_ADDR_SLOT_I2C_DEV);
> +
> +		i2cdev = i3c_master_alloc_i2c_dev(master, i2cboardinfo);
> +		if (IS_ERR(i2cdev)) {
> +			ret = PTR_ERR(i2cdev);
> +			goto err_detach_devs;
> +		}
> +
> +		ret = i3c_master_attach_i2c_dev(master, i2cdev);
> +		if (ret) {
> +			i3c_master_free_i2c_dev(i2cdev);
> +			goto err_detach_devs;
> +		}
> +	}
> +
> +	/*
> +	 * Now execute the controller specific ->bus_init() routine, which
> +	 * might configure its internal logic to match the bus limitations.
> +	 */
> +	ret = master->ops->bus_init(master);
> +	if (ret)
> +		goto err_detach_devs;
> +
> +	/*
> +	 * The master device should have been instantiated in ->bus_init(),
> +	 * complain if this was not the case.
> +	 */
> +	if (!master->this) {
> +		dev_err(&master->dev,
> +			"master_set_info() was not called in ->bus_init()\n");
> +		ret = -EINVAL;
> +		goto err_bus_cleanup;
> +	}
> +
> +	return 0;
> +
> +err_bus_cleanup:
> +	if (master->ops->bus_cleanup)
> +		master->ops->bus_cleanup(master);
> +
> +err_detach_devs:
> +	i3c_master_detach_free_devs(master);
> +
> +	return ret;
> +}
> +
>  static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
>  {
>  	if (master->ops->bus_cleanup)
> @@ -2514,7 +2598,10 @@ static int i3c_master_init(struct i3c_master_controller *master,
>  		goto err_put_dev;
>  	}
>  
> -	ret = i3c_primary_master_bus_init(master);
> +	if (secondary)
> +		ret = i3c_secondary_master_bus_init(master);
> +	else
> +		ret = i3c_primary_master_bus_init(master);
>  	if (ret)
>  		goto err_destroy_wq;
>  
> @@ -2595,6 +2682,71 @@ int i3c_primary_master_register(struct i3c_master_controller *master,
>  EXPORT_SYMBOL_GPL(i3c_primary_master_register);
>  
>  /**
> + * i3c_secondary_master_register() - register an I3C secondary master
> + * @master: master used to send frames on the bus
> + * @parent: the parent device (the one that provides this I3C master
> + *	    controller)
> + * @ops: the master controller operations
> + *
> + * This function does minimal required initialization for secondary
> + * master, rest functionality like creating and registering I2C
> + * and I3C devices is done in defslvs processing.
> + *
> + *  i3c_secondary_master_register() does following things -
> + * - creates and initializes the I3C bus
> + * - populates the bus with static I2C devs if @parent->of_node is not
> + *   NULL
> + *   initialization
> + * - allocate memory for defslvs_data.devs, which is used to receive
> + *   defslvs list
> + * - create I3C device representing this master
> + * - registers the I2C adapter and all I2C devices
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int i3c_secondary_master_register(struct i3c_master_controller *master,
> +				  struct device *parent,
> +				  const struct i3c_master_controller_ops *ops)
> +{
> +	int ret;
> +
> +	ret = i3c_master_init(master, parent, ops, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_add(&master->dev);
> +	if (ret)
> +		goto err_cleanup_bus;
> +
> +	/*
> +	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
> +	 * through the I2C subsystem.
> +	 */
> +	ret = i3c_master_i2c_adapter_init(master);
> +	if (ret)
> +		goto err_del_dev;
> +
> +	/*
> +	 * We're done initializing the bus and the controller, we can now
> +	 * register I3C devices from defslvs list.
> +	 */
> +	master->init_done = true;
> +
> +	return 0;
> +
> +err_del_dev:
> +	device_del(&master->dev);
> +
> +err_cleanup_bus:
> +	i3c_master_bus_cleanup(master);
> +
> +	put_device(&master->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
> +
> +/**
>   * i3c_master_unregister() - unregister an I3C master
>   * @master: master used to send frames on the bus
>   *
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index e543f68..e186d53 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -541,6 +541,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  int i3c_primary_master_register(struct i3c_master_controller *master,
>  				struct device *parent,
>  				const struct i3c_master_controller_ops *ops);
> +int i3c_secondary_master_register(struct i3c_master_controller *master,
> +				  struct device *parent,
> +				  const struct i3c_master_controller_ops *ops);
>  int i3c_master_unregister(struct i3c_master_controller *master);
>  
>  /**
> -- 
> 1.7.1
> 
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c
> 
