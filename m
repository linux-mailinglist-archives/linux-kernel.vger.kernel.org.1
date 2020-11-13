Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11502B258A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKMUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGTo69/0mWRMDWXMWSWzbSRGi0q3hDqTGf9uzqWEojg=;
        b=KB45rRZITOvf70psGz6q0HGnlC6kariGthdRz1mqLpK9VMv5knv9jrNzAQYMsN+EWDJhB5
        frnbO9v7vy66R+aotHuc0hISYmTwQprcoZMVL99/Wgvf+Udp1Q5Ip2OZN8aQRPaS0S/ZtC
        F9jzcB/UuSUyaY/ZvhSdCY4B8ZNK8JA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-dHEd2tvlNIqbhbOcGgdKzw-1; Fri, 13 Nov 2020 15:31:12 -0500
X-MC-Unique: dHEd2tvlNIqbhbOcGgdKzw-1
Received: by mail-qt1-f199.google.com with SMTP id g12so6477788qtc.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wGTo69/0mWRMDWXMWSWzbSRGi0q3hDqTGf9uzqWEojg=;
        b=X/focdcHS+t5hWnZwBab0xCBPXBi97A6Yscn2uAK2ZYmsgp3Qql5D4SDat8XH20OT3
         2ga+3vahKDhpBhrKlnv1cjPD7aYKe5KYnxNxFHS7VoeAGe/tnNoGzzPTYgZipvwRu6GS
         Gl5cWlgsp0Qg8nrcTbdVq3jez8PZqjRYkjpJmU/mQW4yn2JBq70ecGC5CNAu/MZWcIXS
         vsmR5m8EQbf/+8YCKylKptm7rgQFH84xnv8UfdSNmjUI+kNkonSoUsOSS33Isax7keZr
         teAEU684WjHe9qvEDWNWnvOGc0EeG8XM93P1mpFGeqMUhq2XDVjFp9UYmhtBjUGvnM4m
         HcSA==
X-Gm-Message-State: AOAM533nmf9mOR7ADsdqoTYctexTT2YWYrHfAXWwXlDvm8cRUdlaF/5U
        uid0avEB1J2y8k/WNk4xt3E2/4xCFZFAdqLlMbGVNhlRPt50CA1NUeDk244XmAfzWfsBAAMIier
        3OBFSuDTqfyeGLOMRrch4DxuV
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr3618348qtw.94.1605299470060;
        Fri, 13 Nov 2020 12:31:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHktaMELEzOh9EV+QZwFcVtJpVhVcOYIuaHXM/+0JGc7AoYXCvSIy5WHD3KKq346ubgSIazQ==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr3618317qtw.94.1605299469765;
        Fri, 13 Nov 2020 12:31:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o125sm7363969qke.56.2020.11.13.12.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:31:09 -0800 (PST)
Subject: Re: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream
 authentication
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9bb29416-65fe-85e8-b960-23abc49352f2@redhat.com>
Date:   Fri, 13 Nov 2020 12:31:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Exten FPGA manager driver to support FPGA bitstream authentication on
> Intel SocFPGA platforms.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c..8a59365 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;

The change does not match the commit log.

Add some comment like..

'Cleanup setting of partial reconfig flag'

to cover the change.

Tom

> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
> +		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
>  	}

