Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC525EF39
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIFRGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 13:06:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgIFRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599411976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5pi6kmTJtxrXnrQ1o1+D6zOwv348s2nRgWp9tupDkI=;
        b=Yqc3q4ySWvhIgNg8iRsQDG4d+mbqCWUPSeOzg6ys45RyzLG2zOxsXoqnwNSe1uGYL3ggnr
        /u+RS64TsFx+KxvMrUJMyb4xI0WHpsMxdCt6Qjy4CfkCpQSoEwcxTQeXS+dvx6ndE1NQLG
        QlH8ypIK6G/58oK3/aMc4TmsNdJsRjI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-d8kBFekrMiKyPtvILru8_w-1; Sun, 06 Sep 2020 13:06:14 -0400
X-MC-Unique: d8kBFekrMiKyPtvILru8_w-1
Received: by mail-qk1-f197.google.com with SMTP id u23so6476954qku.17
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 10:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T5pi6kmTJtxrXnrQ1o1+D6zOwv348s2nRgWp9tupDkI=;
        b=J1Ty6A8FMoxNG4a4DZVhdJ31pMqFyricbtgRqbZgeI7YrX4TrQjPCpoagx1uxGL4hN
         T+s+OM7T2vywZqbqHekSZ8gFNGwCdzPu1V1ptNn2TY5Pdww0TqXoXBfBD0T99wSR+23N
         L21mPqo1MFHO4KHQt/qdkzDJRjxry1D5nGB9cnwlID933bAAop+/FJGxQvMIEPX1oVni
         pwqjR4n5YKCk3XPr4PJ9Ykjz4PpK7OFJ/CmwiiD28AzJo0GhLOZMYxvtYy/MvMybd2KI
         /YA3g2kysbti9wbxLFGr5lK2xBVNEgGGjooKvIig5cnVNXDwmm9C/MrJzQ441bREJOcP
         6+yw==
X-Gm-Message-State: AOAM530aLjpfj6VnJWI6uE6EnLUQdGtsnCG4lR0+2b9o0d4wHGFJsxpa
        o5w2LKQiTEqF81mgYx4jYQIzica/zoZ98BZ5kyWbvhM0YfNK3HhRsn6oCwUqEhMK7nt0t9WX6iw
        cmSx9j7Uz6kielBlX58+uwSQS
X-Received: by 2002:ac8:100c:: with SMTP id z12mr17095452qti.81.1599411973916;
        Sun, 06 Sep 2020 10:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo748fLBdA5RyKGQNX2aeM+TJI+XXQQaO6Zso/HBz7x5qVE4vXAIL+HZQE97QTNo1oBVMwNQ==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr17095428qti.81.1599411973625;
        Sun, 06 Sep 2020 10:06:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g19sm2702267qka.84.2020.09.06.10.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:06:12 -0700 (PDT)
Subject: Re: [PATCH v1 11/12] fpga: expose hardware error info in sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-12-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <35c1452d-9a26-802a-a340-41f1482ef975@redhat.com>
Date:   Sun, 6 Sep 2020 10:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-12-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an optional update/hw_errinfo sysfs node that can be used
> to retrieve 64 bits of device specific error information
> following a secure update failure.
>
> The underlying driver must provide a get_hw_errinfo() callback
> function to enable this feature. This data is treated as
> opaque by the class driver. It is left to user-space software
> or support personnel to interpret this data.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 14 +++++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 38 +++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  5 +++
>  3 files changed, 57 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 762a7dee9453..20bde1abb5e4 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -135,3 +135,17 @@ Description:	Read-only. Returns a string describing the failure
>  		idle state. If this file is read while a secure
>  		update is in progress, then the read will fail with
>  		EBUSY.
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/hw_errinfo
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a 64 bit error value providing
> +		hardware specific information that may be useful in
> +		debugging errors that occur during FPGA image updates.
> +		This file is only visible if the underlying device
> +		supports it. The hw_errinfo value is only accessible
> +		when the secure update engine is in the idle state.
> +		If this file is read while a secure update is in
> +		progress, then the read will fail with EBUSY.
> +		Format: "0x%llx".
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index afd97c135ebe..6944396eff80 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -152,10 +152,17 @@ static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
>  	imgr->err_code = err_code;
>  }
>  
> +static void set_hw_errinfo(struct ifpga_sec_mgr *imgr)
> +{
> +	if (imgr->iops->get_hw_errinfo)
> +		imgr->hw_errinfo = imgr->iops->get_hw_errinfo(imgr);
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
>  	set_error(imgr, err_code);
> +	set_hw_errinfo(imgr);
>  	imgr->iops->cancel(imgr);
>  }
>  
> @@ -348,6 +355,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t
> +hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +	int ret;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->progress != IFPGA_SEC_PROG_IDLE)
> +		ret = -EBUSY;
> +	else
> +		ret = sprintf(buf, "0x%llx\n", imgr->hw_errinfo);
> +	mutex_unlock(&imgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(hw_errinfo);
> +
>  static ssize_t remaining_size_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -382,6 +406,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  		imgr->filename[strlen(imgr->filename) - 1] = '\0';
>  
>  	imgr->err_code = IFPGA_SEC_ERR_NONE;
> +	imgr->hw_errinfo = 0;
>  	imgr->request_cancel = false;
>  	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
>  	reinit_completion(&imgr->update_done);
> @@ -416,18 +441,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(cancel);
>  
> +static umode_t
> +sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_hw_errinfo.attr && !imgr->iops->get_hw_errinfo)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_cancel.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
>  	&dev_attr_remaining_size.attr,
> +	&dev_attr_hw_errinfo.attr,
>  	NULL,
>  };
>  
>  static struct attribute_group sec_mgr_update_attr_group = {
>  	.name = "update",
>  	.attrs = sec_mgr_update_attrs,
> +	.is_visible = sec_mgr_update_visible,
>  };
>  
>  static ssize_t name_show(struct device *dev,
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> index f51ed663a723..3be8d8da078a 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -135,6 +135,9 @@ enum ifpga_sec_err {
>   *			    function and is called at the completion
>   *			    of the update, whether success or failure,
>   *			    if the prepare function succeeded.
> + * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
> + *			    The software err_code may used to determine
> + *			    whether the hw error info is applicable.
>   */
>  struct ifpga_sec_mgr_ops {
>  	sysfs_cnt_hndlr_t user_flash_count;
> @@ -158,6 +161,7 @@ struct ifpga_sec_mgr_ops {
>  	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
>  	void (*cleanup)(struct ifpga_sec_mgr *imgr);
>  	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
> +	u64 (*get_hw_errinfo)(struct ifpga_sec_mgr *imgr);
>  };
>  
>  /* Update progress codes */
> @@ -183,6 +187,7 @@ struct ifpga_sec_mgr {
>  	enum ifpga_sec_prog progress;
>  	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum ifpga_sec_err err_code;	/* security manager error code */
> +	u64 hw_errinfo;			/* 64 bits of HW specific error info */
>  	bool request_cancel;
>  	bool driver_unload;
>  	void *priv;

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

