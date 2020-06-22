Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05E3203CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgFVQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgFVQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:36:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:36:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so17356145wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7qnGp8eXWyKDR94OzmgxJ4xkgDrlETWZved9OLJ9b0=;
        b=NNrUMfRcL/bjFmEj8CIkfaerDCm4gAZ1IT554W0OffUTMy/qhBgOB40YJPLijR/4Sy
         fKKiLDQuiwYNhILJlr+S41qYNa/Vi4U9sGXqznJ0V8QrPgG2RE8XnULpnvhWf5Ayhogd
         BSFbuPcbe2jxPx37C0Qn9EaAMJ+yyCr1J2O5UBf3fXopTm0OWpVsrTUgP8wU8EvEXL7i
         0/v6ij7ZKc7JX/I6RKJJWC4NLdJi9fFtIWolNir/9lNUik3FhGwS4wHRb2q31a6y8r+l
         usYd2YMK1f4QeDx0B4fIk5zuoDScXYsjnhBOrgNFG6bFeIBDyK3uVyRiIZzY7Yw8M01b
         dgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7qnGp8eXWyKDR94OzmgxJ4xkgDrlETWZved9OLJ9b0=;
        b=aY1XH6KGgJy1pTr6rRjKdf/eIVLULaVmknc962aAe/8MLK742ZuL6SoK+Ci/vG+SuR
         n70O6Dez/t5Kd8scYZz9TENCEZpi44mM4CEMuJmnuIAl9KFKIR2uhrwCYiHeXzPlK1Z4
         XS/U91ZA0Tt1Xpq5D7D2NpXXLTr/XzBkjwvBDc2M+Uaveb5dlUrVf1JjkdVSHBaPRJkf
         56mfFJrkKQTDZbqW+VRfGBDZM/foXHSfr4ryH5wcWBCR7yjfJLc6AeLPts+B0fy5ig0X
         NH7KBJc7Z+wZS1Ro9AygFwYqzhn7PW3mHwC8Pn318B14rsNXFTilJjo6v4wUnDWVJmPG
         eLAQ==
X-Gm-Message-State: AOAM531csqgIRhnd9MzxNiyN7SO0sKnqBumZZums1Cn+zdnkNs6Vk5Gg
        xPlr76qSapplJ7JoJBqQFZjeTQ==
X-Google-Smtp-Source: ABdhPJxiPaB2rOcPGD2Hn5ZfNLYvxtnEYvt39GYXaCE/xoEbkf8epVMP/fFWmoGVYuwco4Dg+SrpMw==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr17458044wrq.407.1592843784283;
        Mon, 22 Jun 2020 09:36:24 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z12sm20524905wrg.9.2020.06.22.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:36:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:36:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jason.wessel@windriver.com,
        dianders@chromium.org, jslaby@suse.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] serial: kgdb_nmi: Add support for interrupt based
 fallback
Message-ID: <20200622163621.s2322lmlv674bsds@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592835984-28613-5-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:56:21PM +0530, Sumit Garg wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Add a generic NMI fallback to support kgdb NMI console feature which can
> be overridden by arch specific implementation.

arch_kgdb_ops.enable_nmi should probably be killed off. Given we now
have request_nmi() I'm dubious there are any good reasons to use this
API.


Daniel.


> This common fallback mechanism utilizes kgdb IO based interrupt in order
> to support entry into kgdb if a user types in kgdb_nmi_magic sequence. So
> during NMI console init, NMI handler is installed corresponding to kgdb
> IO based NMI which is invoked when a character is pending and that can be
> cleared by calling @read_char until it returns NO_POLL_CHAR.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/kgdb_nmi.c | 47 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> index b32c6b1..2580f39 100644
> --- a/drivers/tty/serial/kgdb_nmi.c
> +++ b/drivers/tty/serial/kgdb_nmi.c
> @@ -42,9 +42,46 @@ MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
>  static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
>  static struct console *orig_dbg_cons;
>  
> +static int kgdb_nmi_poll_one_knock(void);
> +
> +static irqreturn_t kgdb_handle_nmi(int irq, void *dev_id)
> +{
> +	int ret;
> +
> +	if (kgdb_nmi_knock < 0) {
> +		kgdb_breakpoint();
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = kgdb_nmi_poll_one_knock();
> +	if (ret == NO_POLL_CHAR)
> +		return IRQ_NONE;
> +
> +	while (ret != 1) {
> +		ret = kgdb_nmi_poll_one_knock();
> +		if (ret == NO_POLL_CHAR)
> +			return IRQ_HANDLED;
> +	}
> +
> +	kgdb_breakpoint();
> +	return IRQ_HANDLED;
> +}
> +
>  static int kgdb_nmi_console_setup(struct console *co, char *options)
>  {
> -	arch_kgdb_ops.enable_nmi(1);
> +	int res;
> +
> +	if (arch_kgdb_ops.enable_nmi) {
> +		arch_kgdb_ops.enable_nmi(1);
> +	} else if (dbg_io_ops->request_nmi) {
> +		res = dbg_io_ops->request_nmi(kgdb_handle_nmi, co);
> +		if (res) {
> +			pr_err("ttyNMI0: Cannot request nmi/irq\n");
> +			return res;
> +		}
> +	} else {
> +		return -ENODEV;
> +	}
>  
>  	/* The NMI console uses the dbg_io_ops to issue console messages. To
>  	 * avoid duplicate messages during kdb sessions we must inform kdb's
> @@ -328,9 +365,6 @@ int kgdb_register_nmi_console(void)
>  {
>  	int ret;
>  
> -	if (!arch_kgdb_ops.enable_nmi)
> -		return 0;
> -
>  	kgdb_nmi_tty_driver = alloc_tty_driver(1);
>  	if (!kgdb_nmi_tty_driver) {
>  		pr_err("%s: cannot allocate tty\n", __func__);
> @@ -380,9 +414,8 @@ int kgdb_unregister_nmi_console(void)
>  {
>  	int ret;
>  
> -	if (!arch_kgdb_ops.enable_nmi)
> -		return 0;
> -	arch_kgdb_ops.enable_nmi(0);
> +	if (arch_kgdb_ops.enable_nmi)
> +		arch_kgdb_ops.enable_nmi(0);
>  
>  	ret = unregister_console(&kgdb_nmi_console);
>  	if (ret)
> -- 
> 2.7.4
> 
