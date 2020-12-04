Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48A92CE700
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgLDEYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:24:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61229 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgLDEYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:24:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ED61111CA9;
        Thu,  3 Dec 2020 23:24:10 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=3PN7+dhj56TpvZ/QEmMRDjeq+70=; b=m0is3n
        lruKj+Mxrr/Ats9nNhNbId/4G3c7o7OhzbO4GO80amr33WkTNd3QewIw09HcRYqi
        dmFrAXQ34iCyu4gBw/KKD1voM4ynH2ot8KF/kwVMuemR4jTnglXk0xMpbKqARAYb
        onWn2VQsZehT0bTW3OQHSuNlwwiiHBEkKEzSk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87245111CA8;
        Thu,  3 Dec 2020 23:24:10 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=wYsG55wCwVlnNuBZDyuyP9nA7lynkKBaXTgh1MoGBCI=; b=aFsxI2/INdj5cIUuXWogCLdJzLhU0oioyHZ+MFEWed4sdGZzUsq4RgR1P+ijrntXMY8fpDG845udCAnI6oQhf3pV0P0yXhn+OVnr01oaYm3G77W/9SnQvX80kjgEibf+lhGGRID1HQ6wQcrw1aSHqJUPSH5e9I5tptJ3AY8Bpms=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65654111CA7;
        Thu,  3 Dec 2020 23:24:07 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 9844F2DA0639;
        Thu,  3 Dec 2020 23:24:05 -0500 (EST)
Date:   Thu, 3 Dec 2020 23:24:05 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Parshuram Thombare <pthombar@cadence.com>
cc:     alexandre.belloni@bootlin.com, slongerbeam@gmail.com,
        vitor.soares@synopsys.com, praneeth@ti.com, mparab@cadence.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
In-Reply-To: <1606717066-3785-1-git-send-email-pthombar@cadence.com>
Message-ID: <2s3n7419-1nr9-8885-882o-7qrsos6qq6q@syhkavp.arg>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com> <1606717066-3785-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8CB4D5B0-35E8-11EB-87AA-D609E328BF65-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Parshuram Thombare wrote:

> Removed last argument 'secondary' and restructured i3c_master_register
> to move code that can be common to i3c_secondary_master_register
> to separate function i3c_master_init.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>

[...]

> +static int i3c_master_init(struct i3c_master_controller *master,
> +			   struct device *parent,
> +			   const struct i3c_master_controller_ops *ops,
> +			   bool secondary)
>  {
>  	unsigned long i2c_scl_rate = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
>  	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
> @@ -2535,10 +2514,49 @@ int i3c_master_register(struct i3c_master_controller *master,
>  		goto err_put_dev;
>  	}
>  
> -	ret = i3c_master_bus_init(master);
> +	ret = i3c_primary_master_bus_init(master);
>  	if (ret)
>  		goto err_destroy_wq;
>  
> +	return 0;
> +
> +err_destroy_wq:
> +	destroy_workqueue(master->wq);
> +
> +err_put_dev:
> +	put_device(&master->dev);
> +
> +	return ret;
> +}

[...]

> +int i3c_primary_master_register(struct i3c_master_controller *master,
> +				struct device *parent,
> +				const struct i3c_master_controller_ops *ops)
> +{
> +	int ret;
> +
> +	ret = i3c_master_init(master, parent, ops, false);
> +	if (ret)
> +		return ret;
> +
>  	ret = device_add(&master->dev);
>  	if (ret)
>  		goto err_cleanup_bus;
> @@ -2568,15 +2586,13 @@ int i3c_master_register(struct i3c_master_controller *master,
>  err_cleanup_bus:
>  	i3c_master_bus_cleanup(master);
>  
> -err_destroy_wq:
>  	destroy_workqueue(master->wq);
>  
> -err_put_dev:
>  	put_device(&master->dev);
>  
>  	return ret;
>  }

This looks a bit confusing. Here you're rolling back detailss in 
i3c_primary_master_register() that were factored out in 
i3c_master_init(). If i3c_master_init() is successful, then you 
shouldn't be undoing its things openly in i3c_primary_master_register(). 
Instead, there should be another function that does the reverse of 
i3c_master_init() here.


Nicolas
