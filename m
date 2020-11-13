Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343ED2B2554
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKMUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=necTzLb9sYFoxc0q+K6VlpmR/hW224U1Sbo8SlUmuww=;
        b=ROvywgXXh1CDhI+7soDis7YOmPMpG4d0failoujNr2wmmr6MIE+hgkX2XF57Fng6MTY7Ff
        /m0o6stQpoIKkQeMynn1d0CXbKbUrWTNmTQWptzecCALqTJ5RlAdGdy91h71ZBWQ+/0f2+
        2USTmMBlUOT+ffhSV4lpfNCla3kooeI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-S8VqbOx8Pn-zFtyqgPTd7g-1; Fri, 13 Nov 2020 15:25:24 -0500
X-MC-Unique: S8VqbOx8Pn-zFtyqgPTd7g-1
Received: by mail-qv1-f69.google.com with SMTP id q6so6823401qvr.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=necTzLb9sYFoxc0q+K6VlpmR/hW224U1Sbo8SlUmuww=;
        b=FEfo/rENVZQQciuvz2zIgi1qd+Wj7lHqxMt1n1R6i2/p82k2s1Tat9jZvKytxvIreW
         5lCL2zG7eCTpnhCRpbxX8U9b1Jqs0Oe+1evHRcysnQIE31a93KGQkS/tXvoAYrHWqaEL
         htgqlGHROgqCtV5gnxSwFRX0Y3VJtZZ/7n6UMZHHlP0NhlIcvEZDnWl9MbHbMFBRV2Ng
         fet9gWtLhN6x8t7lDYV5tVASqiH/P/nnP6wk4ccrwJH+MxuJYlyIHBuMopXqQ0Q61bLN
         Ebtbr+MlLdZ/0Qrha9+G+Sw6QMjMkofy5I/F8jugMQQ/Iv+l8ckfaoMp4ZwU2tCvKx1s
         34AA==
X-Gm-Message-State: AOAM533Y9nvC3C5VDiIU6z+eNuznzYkMGyeUmcbpH/4OgjaiAuLWtRT0
        GrofsimXkRXSCZLG9FCDGCqeAJacQppq8b5R7MWdZ1yr9D+O/mvDDxjaqFGsOjHs6WtVK2Bv8EL
        F2XBs6JZVCnx6KtEXE6qsDArk
X-Received: by 2002:ad4:4ae4:: with SMTP id cp4mr3963873qvb.21.1605299124277;
        Fri, 13 Nov 2020 12:25:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgQ3IKgA+akf6N6ze870DJdV7l9Rp4BdDzrp4QFHzRYP9k9+MCyCSmj4vEdBSyDJYJ9rXxbg==
X-Received: by 2002:ad4:4ae4:: with SMTP id cp4mr3963846qvb.21.1605299123973;
        Fri, 13 Nov 2020 12:25:23 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f189sm7354421qkb.84.2020.11.13.12.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:25:23 -0800 (PST)
Subject: Re: [PATCHv1 2/4] fpga: of-fpga-region: add authenticate-fpga-config
 property
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-3-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <77c39677-e6cb-92eb-3680-897a3a755e91@redhat.com>
Date:   Fri, 13 Nov 2020 12:25:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-3-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add authenticate-fpga-config property to support FPGA bitstream
> authentication.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/of-fpga-region.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index e405309..c7c6d1c 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -228,6 +228,9 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
>  		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
>  
> +	if (of_property_read_bool(overlay, "authenticate-fpga-config"))
> +		info->flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
> +
>  	if (!of_property_read_string(overlay, "firmware-name",
>  				     &firmware_name)) {
>  		info->firmware_name = devm_kstrdup(dev, firmware_name,

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

