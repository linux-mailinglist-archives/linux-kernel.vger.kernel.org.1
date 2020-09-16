Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883A26CC19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgIPUjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgIPRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:07:53 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E36C0073ED
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:01:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u25so6763228otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdS5nQ5v/xeh8lWTIsK7FEhg6EkIDhCz0UEb2qA1xTo=;
        b=P2faPbCd45c1ANCgbYMRhk8ZIX4JIOUt1ohimg7dJAeIRu/AZ4pynXdrz37ESN+r0N
         gJA9h3pTOG6wj6o7/V/YOAMBg/gFpUJBVozZtMgbwWi5Jn7c7CMryfnJjy+lTzU0UyWA
         NaZPgCaK3re6VrrvDdYjP4u3M3Tgs3vryVmF8gkA5RllFYWWI93FxL394j6NcNFQ4o5P
         pyFYjGQl/5Sx5cLG1b4hzdklVdb8txl1GT3r9Kf6wAgrtMo+lzHEjvZ9VlnV965S559S
         bZ2ipiOA8dDIBWd5g7KLb0HI4JUXrCM5d40ln+MaGraEALUy+BOa8ZofMgegwZac08ZI
         vfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=EdS5nQ5v/xeh8lWTIsK7FEhg6EkIDhCz0UEb2qA1xTo=;
        b=tT/F5DlHn3n/XkQFXEOQykVD0oBz0mz+CVoTbsmFD0IGP3c8+NrZbKVf5PUoto7SbC
         K1egYhFvEcHgmBBO4s2LrIrxd0n5ONFnzITXwYWkNX8ccqbVEugFpepo71jmO/+DeIHC
         z+btwIQyR+tZN4bN/iExz3EhZxQUjca859emVay518jr+utawU+QkuQBZm1vFxMlvSSL
         H9wYdybE1iSrxZcDGpyH1kTAph5o6IzchmY9tgmw5ut0fi6vY/9P35IofczMtPEWQeWr
         yhgsq2AJ4RHEL+1K+yStb6OfStNMokSatnJyoIBlgg6uXEPPGXc60tlSZA8zQ4rM5ruS
         p/YQ==
X-Gm-Message-State: AOAM530Z6F9VpofUR39/S+CMFNAHhBAq6ZToEPQ2Llx1a6vaUZPgUuTW
        R52s7XGaT3D76Qe380SjeoMJ5+CzLw==
X-Google-Smtp-Source: ABdhPJw8Abo9MErveklySPwOJUzlHTs3vYIAvUy96hCIMl24MK4msxSt++HevLQAhCUvuFiiQSvnSA==
X-Received: by 2002:a9d:6491:: with SMTP id g17mr15551738otl.326.1600264890279;
        Wed, 16 Sep 2020 07:01:30 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id z16sm8149785oth.43.2020.09.16.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:01:29 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ac90:c835:eb77:dac0])
        by serve.minyard.net (Postfix) with ESMTPSA id A7B2E181C2F;
        Wed, 16 Sep 2020 14:01:27 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:01:26 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: add retry in try_get_dev_id()
Message-ID: <20200916140126.GE3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200916062129.26129-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062129.26129-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:21:29PM +0800, Xianting Tian wrote:
> Use retry machanism to give device more opportunitys to correctly response
> kernel when we received specific completion codes.
> 
> This is similar to what we done in __get_device_id().

Thanks.  I moved GET_DEVICE_ID_MAX_RETRY to include/linux/ipmi.h since
uapi is for things exported to userspace.  But this is good, it's in my
next tree.

-corey

> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c |  2 --
>  drivers/char/ipmi/ipmi_si_intf.c    | 17 +++++++++++++++++
>  include/uapi/linux/ipmi.h           |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index b9685093e..75cb7e062 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -62,8 +62,6 @@ enum ipmi_panic_event_op {
>  #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_NONE
>  #endif
>  
> -#define GET_DEVICE_ID_MAX_RETRY	5
> -
>  static enum ipmi_panic_event_op ipmi_send_panic_event = IPMI_PANIC_DEFAULT;
>  
>  static int panic_op_write_handler(const char *val,
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 77b8d551a..beeb705f1 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1316,6 +1316,7 @@ static int try_get_dev_id(struct smi_info *smi_info)
>  	unsigned char         *resp;
>  	unsigned long         resp_len;
>  	int                   rv = 0;
> +	unsigned int          retry_count = 0;
>  
>  	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
>  	if (!resp)
> @@ -1327,6 +1328,8 @@ static int try_get_dev_id(struct smi_info *smi_info)
>  	 */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_DEVICE_ID_CMD;
> +
> +retry:
>  	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 2);
>  
>  	rv = wait_for_msg_done(smi_info);
> @@ -1339,6 +1342,20 @@ static int try_get_dev_id(struct smi_info *smi_info)
>  	/* Check and record info from the get device id, in case we need it. */
>  	rv = ipmi_demangle_device_id(resp[0] >> 2, resp[1],
>  			resp + 2, resp_len - 2, &smi_info->device_id);
> +	if (rv) {
> +		/* record completion code */
> +		char cc = *(resp + 2);
> +
> +		if ((cc == IPMI_DEVICE_IN_FW_UPDATE_ERR
> +		    || cc == IPMI_DEVICE_IN_INIT_ERR
> +		    || cc == IPMI_NOT_IN_MY_STATE_ERR)
> +		    && ++retry_count <= GET_DEVICE_ID_MAX_RETRY) {
> +			dev_warn(smi_info->io.dev,
> +				"retry to get device id as completion code 0x%x\n",
> +				 cc);
> +			goto retry;
> +		}
> +	}
>  
>  out:
>  	kfree(resp);
> diff --git a/include/uapi/linux/ipmi.h b/include/uapi/linux/ipmi.h
> index 32d148309..bc57f07e3 100644
> --- a/include/uapi/linux/ipmi.h
> +++ b/include/uapi/linux/ipmi.h
> @@ -426,4 +426,6 @@ struct ipmi_timing_parms {
>  #define IPMICTL_GET_MAINTENANCE_MODE_CMD	_IOR(IPMI_IOC_MAGIC, 30, int)
>  #define IPMICTL_SET_MAINTENANCE_MODE_CMD	_IOW(IPMI_IOC_MAGIC, 31, int)
>  
> +#define GET_DEVICE_ID_MAX_RETRY		5
> +
>  #endif /* _UAPI__LINUX_IPMI_H */
> -- 
> 2.17.1
> 
