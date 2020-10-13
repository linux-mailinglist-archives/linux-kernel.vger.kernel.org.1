Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDF28D28F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgJMQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgJMQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:48:12 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3BC0613D0;
        Tue, 13 Oct 2020 09:48:12 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e20so605152otj.11;
        Tue, 13 Oct 2020 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwnERbtjK98BZDP38JfMSXq7lY/lqD1s9bTHt/VKNxQ=;
        b=fnalsexwDtPHpXytFFMOxK18SuNkOWOo02GQmlvY01PwtDLnTbA3h9ze1J7gEWwB3s
         nw2/A0BN+SXD4CYfqPFASW4qQ4keOuWRd630K+1CRSqH2NvPp23epNXnBOPLbyDwdFMK
         0cFt9yNU6D6shDJS4odwIy2FThFKTFmCQh9hW6CoGIufme+rr7bZe0qwi+RipUDwX4TV
         jokEF9o79sLfmtlEiUS3jMe9vRi+yJvy8hNpczEx4t3G2SqJ16SMo8vOVc7OhmKNfHFF
         nIqAzqbJ/ieJGe+PateKL3v5kNCPAR2dIVuPcVlmZrQWJFurjuahvUu5xgvw/XWlc0LH
         e1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwnERbtjK98BZDP38JfMSXq7lY/lqD1s9bTHt/VKNxQ=;
        b=FZNLCtIyuXbjuyXQWMg3hPitLU26hU5IuRfe2e4e7C/x5qSCy4vRxk0q/0PNW7mtES
         wfD+bd7Ya3WkD2v1wUIGjuTI3j2N3j7tZrtSBosWIVcZEvt6XOLlKcmQg82UHZclxGU/
         GDPdK/g/UL6P4KCwzd2ex6dgQdXgSh+6bObc1M0X/ePm265AwfQAAsQx71I8zTzzGCCX
         yEgF3tMQQzXIOTSvxXLAcnzKFRzwNdeBlUZUIFIKU+helxE+TsctoXECil23JXPZabWX
         Jy6zFv86VFrU4lzGl8Azx+usYYGgJ75qlhTZyDzRh1lUVOWC+KtbKgbU8KPXgF51DLLf
         +m2w==
X-Gm-Message-State: AOAM5302MJKTgjeUZVDHTWtDCu6/8FPWkakEMfRVNnYRgh/SsTbKfEez
        sLr0bvDEo9Tiin/5B2iHoa0jqGocCxI=
X-Google-Smtp-Source: ABdhPJwVNPqv0PLgz8GYgWA3Yh2rTf52Fn1fi8rKTfwQzDltDeMJYbF2sP3DH4wXdgSErY/UEIPutg==
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr356425ota.263.1602607691597;
        Tue, 13 Oct 2020 09:48:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm96645oia.42.2020.10.13.09.48.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Oct 2020 09:48:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Oct 2020 09:48:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/24] docs: hwmon: adm1266.rst: fix a broken reference
Message-ID: <20201013164809.GH251780@roeck-us.net>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <240216628f613d85fd1191b56debda611e8f659e.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240216628f613d85fd1191b56debda611e8f659e.1602590106.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:28PM +0200, Mauro Carvalho Chehab wrote:
> The reference was missing the extension, causing the
> check script to complain.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/hwmon/adm1266.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
> index 9257f8a48650..2b877011cfdf 100644
> --- a/Documentation/hwmon/adm1266.rst
> +++ b/Documentation/hwmon/adm1266.rst
> @@ -20,7 +20,7 @@ ADM1266 is a sequencer that features voltage readback from 17 channels via an
>  integrated 12 bit SAR ADC, accessed using a PMBus interface.
>  
>  The driver is a client driver to the core PMBus driver. Please see
> -Documentation/hwmon/pmbus for details on PMBus client drivers.
> +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
>  
>  
>  Sysfs entries
> -- 
> 2.26.2
> 
