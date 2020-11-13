Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43EC2B18D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKMKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:14:58 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:14:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so1925977wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lPwX4KhpzNCXai8Ockag9i6UQPlNHUWTUTdeI3sp8BM=;
        b=makBkJDwS1XqB+QR2XXJFQ/qQ/IRhYlwJ/o4F68LYeMqHW4goG6yVLUvDJqvkb0KxY
         QQRvNBsVTPD54ibEFwSAKJDUS3MlHqExjX0/0kfc1RiWlYQETBbsXESs2rY2C75BxcAt
         FJaprSUAvujrsHTpJ9A9KHfxu12Z9FhoKpSxU9lQ3wSbO/DpkXLdaFHowSrwefS+0oOP
         /P8ueY9EZYOxcSB6Y7dhC3xzLYGqljcj+vR+pZOYfUrxUSJSZ9sV2jiObdjs8vStOHyl
         N90gbhrPdnVPYsfJg2dcjJN1kAzVCcj8IctM4KWKHFITsCpGaB3Dv1PrG2hT9rViJc+n
         gljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lPwX4KhpzNCXai8Ockag9i6UQPlNHUWTUTdeI3sp8BM=;
        b=CDVZ0HUYOhOT7fbheBqQkVdGGYlPuWokPXqipdAXZBkpU+OazbdcXQUe5L7RXOKD21
         c/Y5vYy1z1ICslDsvc21irA5hhTDwtIWDzteEY9Vu1qRzwPHtQQSFJJpQfljJ6yQr37/
         vJT0emsmR+s8y/B+RfH1TCGNchE1ti65YLCRkFKWhidNd/stSJQ4KnHangDbpcns/zpU
         i+80GHgfzytkpUMSowRsrsVAREdlS/wtwX4icBYP71lkkeTkYgXqxDjahSRADuCqjm+l
         R7Ep1KCDQg6l958yXQKsHZj7aTysDi3jZ2pCW45xWpTg84YdT3L+GGEWUVEEITjJ4XQD
         gTtg==
X-Gm-Message-State: AOAM532twF5fK8DHqHfzJdVq0ZKIeqMvvIk8PK6OhXc63phOPsspNazo
        p4LywJCuveqTES1myuSTllHIBA==
X-Google-Smtp-Source: ABdhPJzOjrgNKGSimKiyC4WJC509yx5Vd/eQx3pmMYwdFjx1IigZuAnMyo0I+AnrzhpXOBlGdNxzrA==
X-Received: by 2002:adf:fc41:: with SMTP id e1mr2470991wrs.406.1605262481066;
        Fri, 13 Nov 2020 02:14:41 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id g138sm9738203wme.39.2020.11.13.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:14:40 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:14:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Brunner <Michael.Brunner@kontron.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v2] mfd: kempld-core: Check for DMI definition before ACPI
Message-ID: <20201113101438.GF3718728@dell>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
 <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
 <20201110161118.GE17288@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110161118.GE17288@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Guenter Roeck wrote:

> On Tue, Nov 10, 2020 at 03:23:21PM +0000, Michael Brunner wrote:
> > Change the detection order to priorize DMI table entries over available
> > ACPI entries.
> > 
> > This makes it more easy for product developers to patch product specific
> > handling into the driver.
> > Furthermore it allows to simplify the implementation a bit and
> > especially to remove the need to force synchronous probing.
> > 
> > Based on the following commit introduced with v5.10-rc1:
> > commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")
> > 
> > v2: Fixed coding style as suggested by Guenther Roeck
> > 
> 
> Nit: change logs should be after '---'.

Right.  Please submit a v3 fixing this.

> Other than that,
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
