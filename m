Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6742A798C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgKEIjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgKEIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:39:36 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD62C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:39:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v5so709127wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EuWZSrVi9knNvYJnSN3RychJR53ENGdBNfnOyxgGxcg=;
        b=Hz1iWtTMlWRAwjHOfszeYpxfuoK4vHOgzZKs90QMyIu2h2rXdHDhQ6fX3TrFCeJrfD
         NFFrri7HD19a9x9cjXmOr2peByCKUvB9exU2TwjTkvG+lQa+WlUVMaryeRDhQyy5UKmc
         2dOJgTdbWIxlLpepbWxa+tNdlXkunBy09UheLimiN1v00Q96B2nVJyPWI5U6eSqrcssN
         5z9FmbFKDQpJW3CzJthejpixX9cLE4WhpmCN6FbbqLbhdmvqJNhxloygE3lVsOiJkXLm
         QS5aAbgq1+i1JzkOGNUT4GN4KBce3FTF3i7jxo3fWlqYQUH0Pk2UnLoEet8Xyr6cmBTF
         6SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EuWZSrVi9knNvYJnSN3RychJR53ENGdBNfnOyxgGxcg=;
        b=eXuHOGhUD8wo2pZ9MR1i6/qIuE/Knac1dDrG2OdRLBPKOgqG9m2zRl5WREcGpl4u7t
         /SGNYTPpjml0DI6Die6GOVJ8ZS1i6OEXlts+AI/3kTOX3yGFxVyEmbbANG/vo10oGi4C
         yuhpjplG1hE6p2SrH/2yYbzfEuheYk2swjdA42KIowtK5v4jBZeXX2yVPa/8FQEm+gcE
         FScc9UbqYbjK6/KBRkgRSN2YSTi/szrBe2qsp1/ue3RTec1pcqg/FBRs2R9xDsfUVI2V
         FsHbA2Fv88scBprhSYAHx2VnD/sClsGtb+i6dyo61zLSM2t2qWUgX1Lt56pgrzJ+3yVm
         X9hg==
X-Gm-Message-State: AOAM531MvL7SyGjtR0fi7Xp2rXQh4k2RHLBrQAVdSTtKNmYuPfrIO5dV
        zrPa911TfOvcH2O1ucWn3clKB4W3aujSw3vQ
X-Google-Smtp-Source: ABdhPJzigf5oR8A5V2hobQV1yIWRpdACLg0Wp9kbmXTqvZc9e+xjEZU6Pg5BjWZiblA0wS+bMv+aVQ==
X-Received: by 2002:a1c:2e0d:: with SMTP id u13mr1414382wmu.179.1604565575083;
        Thu, 05 Nov 2020 00:39:35 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id z15sm1425758wrq.24.2020.11.05.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:39:34 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:39:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 31/36] powerpc: asm: hvconsole: Move
 'hvc_vio_init_early's prototype to shared location
Message-ID: <20201105083932.GY4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-32-lee.jones@linaro.org>
 <87r1p8u230.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1p8u230.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Michael Ellerman wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
> >  385 | void __init hvc_vio_init_early(void)
> >  | ^~~~~~~~~~~~~~~~~~
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/powerpc/include/asm/hvconsole.h     | 3 +++
> >  arch/powerpc/platforms/pseries/pseries.h | 3 ---
> >  arch/powerpc/platforms/pseries/setup.c   | 1 +
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

> > diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
> > index 999ed5ac90531..936a1ee1ac786 100644
> > --- a/arch/powerpc/include/asm/hvconsole.h
> > +++ b/arch/powerpc/include/asm/hvconsole.h
> > @@ -24,5 +24,8 @@
> >  extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
> >  extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
> >  
> > +/* Provided by HVC VIO */
> > +extern void hvc_vio_init_early(void);
> 
> extern isn't needed, but don't feel you need to respin just to drop it.

That's fine.  I don't mind re-spinning.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
