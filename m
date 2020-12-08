Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930A2D2B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgLHMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:36:00 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D71BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:35:19 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so20585722ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5LAaOumgmj7H0J3Z/m25X8UpGdpZrLV0eWk5Fk94bfQ=;
        b=CJgTHfzOcp5RJjWhfr6JEbnKcI2hhv+d+JQc9fozCSunmq5sF1USrM3IggY0hlu3CI
         lBrx2yJhmxGGdhnwFUfgjlxXKufvJ4AXmgK2SchyfHcpmlORB7VBz8N0ma4DYb5o98A/
         6igsTIwYi4ePQclhKF+5EQ1bLdo0x+pGOLjA637VsQaIMSTek6mw/nDP7Ct1ZJ9wqXOv
         I+tadlgkwfkvFl0hu+iXnCQfIlcYXtJjRJObtjz6ygdOyZn8kK7H+f++ZIc/+Anp3DSt
         9JydrZN/YmWE+UXkIRNILlbKbMv2/7vk3+Qcd3+BgbZvBzXN4t2dL9jam0FPL44PrsMl
         rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5LAaOumgmj7H0J3Z/m25X8UpGdpZrLV0eWk5Fk94bfQ=;
        b=XMBotvAenJ9tIsu/ymKVYgxHBWZHkZDZR0kSeW4LHtRnhLZaPJJYlxt691pZlEwrYA
         w6aeKKM4WNW/i0pg4gu5jrudvHNMAJT/R/dz5h43cJ3fn/42a4wJVJ5rm40Uo2hxhaHB
         nrBSMuOxJ4kHMYELk7RR4ngVqDRDzyQGrAS9fz7uAsnfjAzS7uskbc46JhoJcKqC0CBD
         8DG5y+P1BIyAn7/AjmoF+JpdTzAaz84s8b0r2a5XLyeMma/rOBi/I7QAuDCRfF1keH5O
         L9YAIhMJdPblS1JvMhV97oH/6+mL2eWhfjZe/3AfVF/FX/C1AWtM2jjHhFdORneZmnM6
         VQ6w==
X-Gm-Message-State: AOAM533cKFXiL7Wiw0ZwdrlNjEKPFN7PaceFWcrgpP3w1hii5rn81Ujm
        2dUurTVSd0m2SBunCHWmvY0=
X-Google-Smtp-Source: ABdhPJz/CJmt5BjXFPNUP8lNEWlXYhf9FSZRvBR+abs0WYcYjGZqHq1I/ttkxbP/M3INg3sBe4iqVA==
X-Received: by 2002:a17:906:e94c:: with SMTP id jw12mr23283522ejb.56.1607430918220;
        Tue, 08 Dec 2020 04:35:18 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id e12sm16911367edm.48.2020.12.08.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:35:17 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:35:15 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Aswin C <aswinraman2013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Aswin C <realc@protonmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH] net: dsa: sja1105: Remove an unprofessional word from
 the code comments
Message-ID: <20201208123515.wb72g6zwtxlawp34@skbuf>
References: <20201208103332.5095-1-realc@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208103332.5095-1-realc@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswin,

On Tue, Dec 08, 2020 at 04:03:32PM +0530, Aswin C wrote:
> Remove the word 'retarded' from the code comments with a more professional word
> 'erroneous' to make it less profane.
> ---
>  drivers/net/dsa/sja1105/sja1105_dynamic_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
> index b777d3f37..7a76180f3 100644
> --- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
> +++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
> @@ -250,7 +250,7 @@ sja1105pqrs_l2_lookup_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
>  			SJA1105PQRS_SIZE_L2_LOOKUP_ENTRY, op);
>  }
>  
> -/* The switch is so retarded that it makes our command/entry abstraction
> +/* The switch is so erroneous that it makes our command/entry abstraction
>   * crumble apart.
>   *
>   * On P/Q/R/S, the switch tries to say whether a FDB entry
> -- 
> 2.29.2
> 

Thank you for the patch and for what looks like your first contribution
to the kernel. First of all, when you submit a patch, you should follow
the development process at:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst

You should use ./scripts/get_maintainer.pl and send the email to all
maintainers that get listed there, plus the mailing list.

I don't feel that "erroneous" is the right replacement. Maybe "poorly organized".

Although I am not sure that "professional" is something that I was going
for when I wrote this driver.

This makes me curious what exactly motivated you to make the change? Do
you feel offended by the use of profanity when used to describe hardware?
How did you even pick the sja1105 driver. I can think of two possibilities:
- You are working with it. But in this case, I do wonder how you feel by
  the larger amount of profanity in drivers/net/dsa/sja1105/sja1105_tas.c.
  Are you planning further patches for that?
- You just searched the kernel sources for profanity, or, putting it
  differently, you were actively trying to be offended.
