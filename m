Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7317E2C710F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403750AbgK1Vwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbgK1TC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:02:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF58C094274
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:34:55 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so3776503pgj.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/F0jxA+pSoDHJSMxMBjV5hUnIDyxJBJ/lwrOxsK2ro=;
        b=ki9hdLXratA+zRAnU29eIevEXhKz0yDt37daoUY8VeEAGk2vR6zuSIsGk0cOXAdtbM
         9OMivaCtTPXvOr74G6yXnW356KWsgQpnGlq0WfG8s+AdJBunKV/STbKaCLnAaiPWIXME
         NzQvWuy/nuufnO8c4C2jrW8SIvhx0Dt8TBYiqP8xneoL2urByCrBNuH4+vVv3L7evm/P
         fKPQ+LqayBEoBU+LijW9tUoLEbPVWKyrrKOecrLsu4ImK76W4bxjGgV/ndTxD4bXZQxc
         V3ZxglojdzaktIBr1WPH5H6VNFoYX4KPblEICXfAgFrsBCn2FB+UK8LHjn4IaHmYQab3
         Geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/F0jxA+pSoDHJSMxMBjV5hUnIDyxJBJ/lwrOxsK2ro=;
        b=UMrmeF5OksxPdobkX+ZJIb3Haqe/N7A+P3IzrAmawlx1m1US1zxonReUUoOXgNROj8
         HGZkGWBEokexQaMDBv6b8APnP7KKi9tqsBtVHjHGapoKOlL0I3ehGVGTmdZG9zE6eba5
         eBW+HX5/0u7DdCqaKIbaHUIoUaqHMnUIaJeuZUlS2COAXFlcd+Mhtjtg06aF6MjLCSUm
         cUlRE+pGoTemW4O0uYyAsSifhjEC3bH3/WyYtG/DZPMYaF00cKQhsfVgY62JFgyRRg8n
         NhT9HmfQW2QwzOktCOHQyuH33UFj423Aq/msXdYIYi0TuubvAyXeLW/1uIP693B6jhLJ
         XwWQ==
X-Gm-Message-State: AOAM530TnDDK1g9iVOiR7kE/YL4r/6cKtNE5JofmOr3YO7Jrw9LXtUgN
        dIvaQvHY2/Qx+seRCTeXSCc8Z0bL2Zf0
X-Google-Smtp-Source: ABdhPJwt6OaYYxResPuZzD/jpIA08iU0iT33J+AJV62IVT7x8N2NKTRf/gkLav7OhkZUkyRw3c5Q0g==
X-Received: by 2002:a63:385b:: with SMTP id h27mr9713420pgn.136.1606548894973;
        Fri, 27 Nov 2020 23:34:54 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id l10sm13569209pjz.14.2020.11.27.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:34:54 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:04:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 12/18] i2c: owl: Add compatible for the Actions Semi
 S500 I2C controller
Message-ID: <20201128073444.GY3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <7622fae80d12d7f423fc25190159af494c359200.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7622fae80d12d7f423fc25190159af494c359200.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:06AM +0200, Cristian Ciocaltea wrote:
> Add S500 variant to the list of devices supported by the Actions Semi
> Owl I2C driver.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 5cf5a119a6ad..98882fe4e965 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -508,6 +508,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id owl_i2c_of_match[] = {
> +	{ .compatible = "actions,s500-i2c" },
>  	{ .compatible = "actions,s700-i2c" },
>  	{ .compatible = "actions,s900-i2c" },
>  	{ /* sentinel */ }
> -- 
> 2.29.2
> 
