Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA052C60B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgK0IGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgK0IGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:06:23 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B77C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:06:23 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so4598892wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XjNvhlAT0X4fwQhHjKJ4IY2gKaAEdrZ3y9Dm7Go0avk=;
        b=k+GGuacFm8e5g26/pdSPmB/NbjI/pwJvHcfv/rQS38Q608oGz31SVIUFw29jVXZLEh
         BquxwWwo9tzwOIKCuvKbBSJo5SO39Ycj4ycIhLyQtaQirqDRidSxvafUVpy/v4sTPed+
         T2Rdagwth/jU4naP5FWCv6A94oIEhublIdj8RzbVzLRJq7Hbwx+y+Dmt0rq62bKABsys
         nN+IX+B3+DxmgW2LsYUThiD2Tnb2g46pH0VV69/TPsXleezz+BimET1mMMey7oTKkFe2
         3UKNEu8XMLe4iplEs9YSF0J3nBY8BLutE+mmotvR08JJNr0+OAaoxDtDWL6qOPYw9R1f
         +BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XjNvhlAT0X4fwQhHjKJ4IY2gKaAEdrZ3y9Dm7Go0avk=;
        b=agcRcf4QlsYqkIeU2HTO1kMCyz/4NWo6CizxwhHbTynv2hfP7QpggU2OYzZlBiPzHY
         Csm/niX2WCvP8PWEti/exsIs6thLeVPyFw1tADZQhRwF4OhFXiALexCoR7KTONqqzG4Y
         E18xkhl0kipqLBsxH9NvdW1xAYmlSVjtgfGH1Ajv80EXc9PdMWU2wGxJyQh7L5d0hGlg
         sBC7O0HRGDLVsEEV/HPWN2RN/8Fw7SOu9xTFTLWD1gQroMOTff4ZbcnBr3vSLEanx+Fq
         P7+vSInSSlpoi87coDgGtCL8+tYeB0oVGZ/tsipfHcfuWiBOKkSl4r6eAJnhEIg6xCXQ
         Z//Q==
X-Gm-Message-State: AOAM533pVzTYvcfLmKQCj7CLaA4L4OsqxdlZSg1/BkILSYQWENJHcZJM
        rITXxOQSQhA0nZpmis0+3qOiYQ==
X-Google-Smtp-Source: ABdhPJxwfjAAaWVnS19rH5JiT0l70X28e44bwFg7Qvme52gatO0JMef6taJavs8w64tz6Y59w0HETQ==
X-Received: by 2002:a5d:4acf:: with SMTP id y15mr8573356wrs.333.1606464381918;
        Fri, 27 Nov 2020 00:06:21 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id f199sm12465463wme.15.2020.11.27.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 00:06:21 -0800 (PST)
Date:   Fri, 27 Nov 2020 08:06:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id
 table
Message-ID: <20201127080619.GJ2455276@dell>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020, Krzysztof Kozlowski wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
> 
>   drivers/mfd/bcm590xx.c:95:34: warning: ‘bcm590xx_of_match’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/bcm590xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Couple of small points:

- Patch-sets, particularly large ones should have a cover letter.
- Subject lines follow English grammar conventions and should start
  with an uppercase character.

I fixed all of these patches with respect to the above and applied
them all however.

All patches applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
