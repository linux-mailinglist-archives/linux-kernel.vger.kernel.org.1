Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE52AE7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgKKFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKFUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:20:43 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:20:41 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id r11so152311oos.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8JvIuVhwuPNGMkVQ4guxsEUL9YFtE5AZrTL23JMuJU=;
        b=lRBauYDaR4Ik4GXYuf38bavNI7EWI2gLFj8p1qDEuI2tZpRsYCOkIQ2q0Pl0xTnsew
         d1vfUbekQ5ganCOMx/LloZec9K58Poc0pSV3aOgPS2jq3C/pfEdjzruV1ZPV2KnVuiEI
         k+vVNdReFibS7Q24AkT9KD21JuW5te1S6lI0OLLvO6NjIIIIXzHReqVbWFEoxTqAl4fu
         wzgA8uvR74Ue1Rw4iBsm7CB9FnVBSacLgGTszR3mBVFGIt8oeTvkS1Cz2ZqhsSzb6LzA
         nVLKKwFfSNirps9FIDBOI8k+N3hRoYNF/idwgZy1+FdmuwjtdZ5syjZ1Y8LrET1+ve7J
         trzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8JvIuVhwuPNGMkVQ4guxsEUL9YFtE5AZrTL23JMuJU=;
        b=OjnmNSETCjDlQUi2Iq2rLtAzhDvgXhjDGY9zZapRnVVpJWfoZumyhOLgU4r0Qro9gc
         Dg5XCH201DV+XIvzIVvrlazLaDYorwb9AprRgeaB5oe6Vnhojhb+KMgPld2fiVLoc0lQ
         UjQl/7Ht025viGJdC9j3/RmP+7eorRCYPBlyX8gVEN944/alJQSdh0FEKEW7Q4QGUvOA
         baPkWcrXM3qTQw0y47sPj/NoEUoFqsGyY+XPPILX202TPqMjmBAUidZMpcO6F0fjcjy+
         Kb4/0PkG+19mDKoVz7woHl2MHhkKgE8gsT24V8ApAj4kKsK+WeIGX1BY9L7gqUM/oMnn
         QJbQ==
X-Gm-Message-State: AOAM532hK1/wyBhMO7DaQNCEVoyRy1YFrUbRvhgf+fSX0CUPjFb2WfVK
        QMNNG7hZsV5M+vz65286TDtYUMsV4T9CmQ==
X-Google-Smtp-Source: ABdhPJzHvWdZyv3gQOh+mqqPrQU15IMjBhkr35b3v2Dgop+sJwQ0J9xwxHW1eXvWMkEB3YNl6F/jag==
X-Received: by 2002:a4a:9607:: with SMTP id q7mr16079277ooi.79.1605072041371;
        Tue, 10 Nov 2020 21:20:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k27sm319019ool.7.2020.11.10.21.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 21:20:40 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 19/25] soc: qcom: smp2p: Remove unused struct attribute
 provide another
Message-ID: <20201111052038.GG173948@builder.lan>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-20-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103152838.1290217-20-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 Nov 09:28 CST 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/qcom/smp2p.c:74: warning: Function parameter or member 'flags' not described in 'smp2p_smem_item'
>  drivers/soc/qcom/smp2p.c:149: warning: Function parameter or member 'out' not described in 'qcom_smp2p'
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/qcom/smp2p.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index a9709aae54abb..43df63419c327 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -52,7 +52,6 @@
>   * @remote_pid:		processor id of receiving end
>   * @total_entries:	number of entries - always SMP2P_MAX_ENTRY
>   * @valid_entries:	number of allocated entries
> - * @flags:
>   * @entries:		individual communication entries
>   *     @name:		name of the entry
>   *     @value:		content of the entry
> @@ -65,7 +64,6 @@ struct smp2p_smem_item {
>  	u16 remote_pid;
>  	u16 total_entries;
>  	u16 valid_entries;
> -	u32 flags;

This struct describes the data shared between processors in the SoC and
as such these 32 bits are significant. I believe we have an incoming
patch that adds handling of some flag, so let's document it properly
at that time.

I've applied the second half of the patch for now.

Regards,
Bjorn

>  
>  	struct {
>  		u8 name[SMP2P_MAX_ENTRY_NAME];
> @@ -112,6 +110,7 @@ struct smp2p_entry {
>   * struct qcom_smp2p - device driver context
>   * @dev:	device driver handle
>   * @in:		pointer to the inbound smem item
> + * @out:	pointer to the outbound smem item
>   * @smem_items:	ids of the two smem items
>   * @valid_entries: already scanned inbound entries
>   * @local_pid:	processor id of the inbound edge
> -- 
> 2.25.1
> 
