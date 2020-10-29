Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5029EEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgJ2OtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2OtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:49:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:49:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h22so136554wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7LxGB+4TzxSwVyjXFI/dxQ/ots0EBgGdDrOnwPOGE50=;
        b=fI5v++3aJrQpBna2g71POK+3xT5hPm1jtuBc4x9ThYPVLzaN0VXW82bFNANs0sPxMT
         0dNv9+ucEb1qTo8b7TZItQFbMkMmXbSQvdL4z02kcIfUvzQqNahsMlOkKzJ+MJByLg2A
         uH5m6FSlyNFRCCT0+2Pkuvs0Tx9OE97Mntzk6tTPbBl/Kdf4C7Qm5Z3poNf9YETwlabv
         r5K2mn3KshSbZJJH7OWbjTTMifIcWz3l/rnvI1DfraelzxxSSN7UsipSWPWsrwuWCRet
         Gi74qF5sUsTZPcFb51Xy3HAt6s7JV2/2QAJlleJivMWjgbV4JmFSzy8yAmksY+DkEEWl
         nhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7LxGB+4TzxSwVyjXFI/dxQ/ots0EBgGdDrOnwPOGE50=;
        b=sAtAlOXbG3MqYl5EOwkl6f/RALCIE5tXjRCjBOAIaxxQHbh+WGSJqz/+JtRPWVIA1V
         sZuMg9cUXIrLk88LuAg/lxzlXNtwgV6bj5/jTtLn0pRFqLWwXEQizp/J7WZCke3O72Hh
         EZrhuuIZUv1Ilh6wUvNTfYgtu+zFG7tlxhzD4VE/y4RthuSZsTCuS7HpHm/rVpyaBjt2
         /quYYOVT1TDg6V+LRCucNMtqXG/WTZQwyXnT5wYa1s+zqA7ijbTWu6rjr1yNFcopMAo6
         RRSDxzw2T38rz9VImy2tiDSz+SVRBB3hJl03ADyxFX7/aIM2FpwafsN3wMdwG3Yc0lJ2
         s6bA==
X-Gm-Message-State: AOAM530y8z5spT0FdEFSYGE3hbE+fXgC1BLnNCp3EAuRKTo1eUWs7GTc
        vlhpj87jGj/pWHpgrqi4lSQ=
X-Google-Smtp-Source: ABdhPJz1xOk6azYMfY85T03vlOEwaB8b531sFm7G47+zg/TrDlsfj79wbQgWg1vlYCn8rTU2SMAoYQ==
X-Received: by 2002:a1c:9cc1:: with SMTP id f184mr174039wme.5.1603982946602;
        Thu, 29 Oct 2020 07:49:06 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id l11sm4995833wro.89.2020.10.29.07.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:49:05 -0700 (PDT)
Subject: Re: [PATCH v3 05/16] soc: mediatek: pm_domains: Make bus protection
 generic
To:     Fabien Parent <fparent@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, drinkcat@chromium.org,
        hsinyi@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-6-enric.balletbo@collabora.com>
 <CAOwMV_xJez8WB=XjBSWfRmQ7x6265+2iJ+nLN4BR5YjoQzingQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <57c0aaf5-9650-a0ad-1cbe-8e89c2d9a669@gmail.com>
Date:   Thu, 29 Oct 2020 15:49:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOwMV_xJez8WB=XjBSWfRmQ7x6265+2iJ+nLN4BR5YjoQzingQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2020 13:57, Fabien Parent wrote:
>> -               ret = mtk_infracfg_set_bus_protection(pd->infracfg,
>> -                                                     bpd[i].bus_prot_mask,
>> -                                                     bpd[i].bus_prot_reg_update);
> 
> [snip]
> 
>> -               ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
>> -                                                       bpd[i].bus_prot_mask,
>> -                                                       bpd[i].bus_prot_reg_update);
> 
> Since you got rid of all the dependencies to mtk-infracfg.c, maybe you
> can also remove the "depends on MTK_INFRACFG" in the Kconfig.
> 

We still need that file for the old driver.

Regards,
Matthias
