Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E117F2A798A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgKEIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:38:48 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52611C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:38:48 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x12so710545wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=otFckZIXS18ZjK9MEqOur4ngqmLv0/zND2eNmr8zaUU=;
        b=UV5ABRhpQmAOptW3q1HYavNDWUwFaOf0baHBw+piJrIQg6p8VaXGRwzK5j/6sU5U8X
         x61Wh6IPT1RBrtmP2cFfZhtbUxG2tLh/v5W+WDLlkbFg49OEY78P1+VONAsJp0SBfjD1
         6TGpBEyJuLkqoOwETI9ONmtRjINrlM0zqgwH1h1ILZL0xKW3l2vlrKKaAhwJLeHEBSWm
         re5Vy8ilPX8FGyBup2ufBo6ROWI6OZAwRk6DYIaVW27nq3npXGpbFWyout+PukZTGD8z
         7wTzcRtpKdxrToRCO0t5CMsfKcnFHfdogfVzfKCjjZ4V6aaOYDYkX07w/bYPd2WwXDu4
         9rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=otFckZIXS18ZjK9MEqOur4ngqmLv0/zND2eNmr8zaUU=;
        b=WjlKzVPbCDujyIrd3duZshXyi9RIcvLO8s3f7IN3qP19BjfgOqLxTfK9A3FYoW1Llu
         AAjKohpO9s3M87xDevooxdAskfDlN3jX9pdqQuPRErnoe2ldnENuigpfNZQdwKlUbjIR
         jUBR4Vn9paFhrQcKTZNTcY2yNj36b2FYkwLaCVsWDuMF9QLLzJgQuhQ43Z+5+gtxOZlP
         SKuwfoSGlyhqgGDgT2XGgNM/NC7tnH5KLRHAvHvj5zElVoOJPCvTgLIaqwwb8V9RtZq0
         Z5QTg8mVwNvNFI5GbH31lqVFxSZQ4yKHG0kDLc7wO6oPujBTi5xR8KzqksaC7TVCefIT
         mxuQ==
X-Gm-Message-State: AOAM5313oAePBUXoW6eqxD6SlacnXrdubWP+OhCBbJYbAteR6GuidZkg
        CYT1E8xm1YVNDX73byKymlnY9A==
X-Google-Smtp-Source: ABdhPJzc8axgaXbSHS8yEQMM9YXbzH0DsVHt+cad6dLb8q767w0vWXu9gnWs76g72ZA2+oybyEMB9w==
X-Received: by 2002:adf:e443:: with SMTP id t3mr1544244wrm.14.1604565527069;
        Thu, 05 Nov 2020 00:38:47 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id w1sm1485228wro.44.2020.11.05.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:38:46 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:38:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/36] powerpc: asm: hvconsole: Move
 'hvc_vio_init_early's prototype to shared location
Message-ID: <20201105083844.GX4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-32-lee.jones@linaro.org>
 <d2a23842-631e-cd5e-84ec-48485328ba52@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2a23842-631e-cd5e-84ec-48485328ba52@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Christophe Leroy wrote:

> 
> 
> Le 04/11/2020 à 20:35, Lee Jones a écrit :
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
> >   385 | void __init hvc_vio_init_early(void)
> >   | ^~~~~~~~~~~~~~~~~~
> > 
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   arch/powerpc/include/asm/hvconsole.h     | 3 +++
> >   arch/powerpc/platforms/pseries/pseries.h | 3 ---
> >   arch/powerpc/platforms/pseries/setup.c   | 1 +
> >   3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
> > index 999ed5ac90531..936a1ee1ac786 100644
> > --- a/arch/powerpc/include/asm/hvconsole.h
> > +++ b/arch/powerpc/include/asm/hvconsole.h
> > @@ -24,5 +24,8 @@
> >   extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
> >   extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
> > +/* Provided by HVC VIO */
> > +extern void hvc_vio_init_early(void);
> > +
> 
> Declaring a prototype 'extern' is pointless. Don't add new misuse of 'extern' keyword.

No new code (misuse or otherwise) is being added in this patch.

It's just moved from one place to another.

I can also strip out 'extern' if it's preferred.

> >   #endif /* __KERNEL__ */
> >   #endif /* _PPC64_HVCONSOLE_H */
> > diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> > index 13fa370a87e4e..7be5b054dfc36 100644
> > --- a/arch/powerpc/platforms/pseries/pseries.h
> > +++ b/arch/powerpc/platforms/pseries/pseries.h
> > @@ -43,9 +43,6 @@ extern void pSeries_final_fixup(void);
> >   /* Poweron flag used for enabling auto ups restart */
> >   extern unsigned long rtas_poweron_auto;
> > -/* Provided by HVC VIO */
> > -extern void hvc_vio_init_early(void);
> > -
> >   /* Dynamic logical Partitioning/Mobility */
> >   extern void dlpar_free_cc_nodes(struct device_node *);
> >   extern void dlpar_free_cc_property(struct property *);
> > diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> > index 633c45ec406da..6999b83f06612 100644
> > --- a/arch/powerpc/platforms/pseries/setup.c
> > +++ b/arch/powerpc/platforms/pseries/setup.c
> > @@ -71,6 +71,7 @@
> >   #include <asm/swiotlb.h>
> >   #include <asm/svm.h>
> >   #include <asm/dtl.h>
> > +#include <asm/hvconsole.h>
> >   #include "pseries.h"
> >   #include "../../../../drivers/pci/pci.h"
> > 
> 
> Christophe

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
