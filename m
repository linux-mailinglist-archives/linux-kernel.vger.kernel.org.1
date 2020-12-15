Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87E82DB550
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgLOUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgLOUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:39:48 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31844C06179C;
        Tue, 15 Dec 2020 12:39:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so42838139lfd.5;
        Tue, 15 Dec 2020 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AS0Zs8YSOhhb3ZWY+G0dWzbQ3vHgc5+yY4J4G8oSi4I=;
        b=sEro0g+ZjHeQTgcln2MpCwYbPn9CPqt+HwqRjaFsZt9FLPMHGGeY9ovzYAyQV/1UgK
         f5M7W5Ixk3dLta4uoRi5LkpvFl++2+uWBNYbJMcoHnQRBqqSq/mlsHBEOUM6Juq66FR2
         E4dTaZdbMFbh49g3wcFYeiNzyh+k3b9zz+gWiDn1DhwAvDCN2SBe4WbxUIR/ITYsM0U5
         4htpxwvlLRHXptxdtXOuojXbhqftLDGdyfGc6fmTiIhUl93v9pWOqqUNtAS9N6siYish
         HpmjGPXZtfxJid14T35KATGAvH2XFSMxCGTUf1GfAgfrohF7dov6nUyIBq69PTiqyw1F
         dElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AS0Zs8YSOhhb3ZWY+G0dWzbQ3vHgc5+yY4J4G8oSi4I=;
        b=mgEDhJ4jldEurngPNgPIixTZJ78ZBPTnT6oqz3iM1pNMmBaw+cx3pGyCPstEMiseBM
         vySlzd8u2+cHpGixAUezAx1fiUfXAWBG8LFvYiIdwLXYUlJBH4MdPpm9BkdD7v3YZ3x4
         riGgf9QV04WdGNjorpKUmr6h26DVjEV5zyCORANLNyvYvnPqYvMrxCS54z73jqHeRJVo
         TxDCkIiwEU8w9p3nIg0f4uzfxkakeeg4PjN3PxdssRdZD+FdxG8Msw3vfLn9UZoabWKy
         CEShnAfy53vij/89PJqgLDZwoPpjFV/wivAoduCqLox7irDvDCGjc5ywNuigs0PFa98V
         klag==
X-Gm-Message-State: AOAM533MzAJMzDUPfymoCPROhgTKFw0Q39nOi8hKlfvSTVtNM+RGaGVJ
        vNkGHDK4NClLriw1pD7mIq8=
X-Google-Smtp-Source: ABdhPJwU83roEVlSTaHc2CtiDi+wpHJMujGF8Eywic/ICM2TQNtHSuk3u4zocCEzgpwyI4YD/8eYmA==
X-Received: by 2002:a19:430f:: with SMTP id q15mr11627507lfa.6.1608064746751;
        Tue, 15 Dec 2020 12:39:06 -0800 (PST)
Received: from kari-VirtualBox (ip212-226-140-26.adsl.kpnqwest.fi. [212.226.140.26])
        by smtp.gmail.com with ESMTPSA id y20sm1600346lji.86.2020.12.15.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:39:06 -0800 (PST)
Date:   Tue, 15 Dec 2020 22:39:04 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     maz@kernel.org, tglx@linutronix.de, mripard@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] irqdomain: Add documentation for irq_create_of_mapping()
Message-ID: <20201215203904.iilkgwyqsyatryln@kari-VirtualBox>
References: <20201215200747.148439-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215200747.148439-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:07:47PM +0100, Christophe JAILLET wrote:
> +++ b/kernel/irq/irqdomain.c
> @@ -858,6 +858,15 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  }
>  EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping) 
> +/**
> + * irq_create_of_mapping() - Map an interrupt
> + * @irq_data: structure of_phandle_args returned by a previous
> + * of_irq_parse_xxx() call

Start with upper case and use periods. Also next line should align.

> + * 
> + * The resources allocated by this function should be freed by
> + * calling irq_dispose_mapping() when the mapping if not useful
> + * anymore.
> + */

Maybe "mapping is not" or "if the mappign is not". There could be lot 
better wording formatting also but everyone would still understand. So
it is ok. 
