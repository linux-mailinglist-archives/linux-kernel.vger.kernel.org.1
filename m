Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6962B18DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKMKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:16:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3C2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:16:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so7598806wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/1V/d+mCH7d2aSt1K1LIKMK1vmtBjVQkTM0yUOzhmmw=;
        b=oIsupVGRz6BNqeOQSPfiBSLKXpnIPUVu4QpSHe6dfCdx/QcOXD8hJMJ+WHb59w0EbD
         bVLIwR+QlUQPnFtIN3IzmAxylGtj80QbqVWEVEnXz3Og1LCR5qfr/85fDtwtjFLrHpzW
         Oo0UThjGciFABDZJDGZkEK9NJ6wf7m0/3tQeUdUe2C+BKnX5bJ12jqJWYWk/2hmqwZTd
         +JmhumRKf6x5GXrz4ZtecetXot4S8POGKxP0hmFLRBNXZrRVTZcEM6UaRoOzHULkBYSX
         C0KHufF1GrmXDnOInY8fsxuooJWuSQIfUj7/DbYrsMf1ISlfYarQo9JaC3jKKn5GNisf
         pk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/1V/d+mCH7d2aSt1K1LIKMK1vmtBjVQkTM0yUOzhmmw=;
        b=SQZlvlclRYFDWFruMhy57kD8PvCssi9Hg2onSGJo/TeySxzT7m9U3uyrKzqSRNme+o
         Md6QygAPmys3+n6e3MCytonayGZspBPzge3zzcprW9bZ+tm0ot5KxDifpMdK9dFe2UgU
         fuIu5/a1OabL2ZJPz8NqN6Z0Dgjl4KHfAieerb+pCDqhxUdHOPrL/dE4nFyXLI1OhYOQ
         BNRqjCw4EeMLmWWWZRoRm5csmbfEbzi+apyNOyX0WPzyjvBDMKn8r2JJNukH65ntRvFB
         UsYdaytZ+8kWEfm+wgSQlxf6v61uHmtzHi3H6G9iSMgom0rojniUasX3wpK8qOe/nSwZ
         a+/w==
X-Gm-Message-State: AOAM533+lYVSwF39V2VNmOf9NCE04cQ0c9UMR1LQRLL9IybrTikSJcsN
        43hIm7fNPyIIiWzyrM2AzsfZogRdqIfYr4kf
X-Google-Smtp-Source: ABdhPJy1kq93un1UpEyTQquSpB8jMGq9xEllYqf3qwln+vBnBXSy/zKuYZ9kJmIt2cajHZTFqO70ZA==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr1698470wml.135.1605262585410;
        Fri, 13 Nov 2020 02:16:25 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id j8sm6990025wrx.11.2020.11.13.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:16:24 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:16:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v2] mfd: kempld-core: Check for DMI definition before ACPI
Message-ID: <20201113101623.GG3718728@dell>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
 <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Michael Brunner wrote:

> Change the detection order to priorize DMI table entries over available
> ACPI entries.
> 
> This makes it more easy for product developers to patch product specific
> handling into the driver.
> Furthermore it allows to simplify the implementation a bit and
> especially to remove the need to force synchronous probing.


> Based on the following commit introduced with v5.10-rc1:
> commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")

This section should also be removed from the change log.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
