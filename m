Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86F2D9E34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440507AbgLNRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439430AbgLNRtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:49:25 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:48:45 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r14so17315551wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x6MJJWYnbLurSucwkvQN40DA7gXHouhO+MnPaJhZ0uE=;
        b=xOa4385hO46H8KPHEQqJaGVXnb3ulUEVMV4t2wWE2U8iWnG6Op7c7NU7kWaewyHCfF
         rnsNTQb1fwMR9GX17FCUdLIzkFr3QS+MpdAco18pwrXjRdXTI74QWiz4LGJIoGFKEeRw
         bcfJwsxxGfygKaja4+IypDw+oj92BiEL2ZS04/D9CiIBlPSAASo52uSMPHXG6c5q6BTG
         hOBK9qSSqDZQuwbHc9vBqwlNFAQUdqYwNXWfcBMGmC4aqKrvvOVdx3FdBH4K1k4ZLe/O
         eb7BTDna7o2qRJMv3QcogwO0WTqhADszeufXdd7pHYc+X+YTrgDHyKo7pu+dx78XiZ30
         2Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6MJJWYnbLurSucwkvQN40DA7gXHouhO+MnPaJhZ0uE=;
        b=mxK+jxDpc4PvvedVHcOw2VDOVfb3FsqC82yDzlrhbI5Yggl9rFaUmuhmuBVd10FnFd
         5A+3TBihguCXg1JSTlbDISiLYNxcZt3eD7xnQr0aUBiQuopQeR+Vd8srlOVKYrbyjOKu
         JOlok7Zppjf79rxtJ8OWOYuZtjDjD9hWtEdl7alo4Zv0EKkk0T5SAwHrv8mQKTJY404T
         bQW17I4+qyVTQCVZ5k/AqLRX/enOcALMeAoSf2sZkl4R+45S5RNTjyMFFWrA6KaauC59
         RTHVMfVm8CLytJOwMOYTMxFy/mG+VMqNvLL0+AVnmGwzpgdNi312Hc5rGI1vp8ciEgO+
         GtTA==
X-Gm-Message-State: AOAM530DBejbE8WuH81Hjt68S6AnZSekMRHGjDwznKGfzYrbbcAuuf1Z
        qFYIFKTfRzQogIeaETANXLYZIw==
X-Google-Smtp-Source: ABdhPJzTrk3umS/6GpkJSSULoPX1cp5IeLfFpImjzWrU7zYs2OZfyO0b2SEi/enC5dkKPppRfo4dwQ==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr30303663wrb.228.1607968123791;
        Mon, 14 Dec 2020 09:48:43 -0800 (PST)
Received: from apalos.home (athedsl-4484548.home.otenet.gr. [94.71.57.204])
        by smtp.gmail.com with ESMTPSA id q73sm33043980wme.44.2020.12.14.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:48:43 -0800 (PST)
Date:   Mon, 14 Dec 2020 19:48:40 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     ard.biesheuvel@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/libstub: Allow EFI_NOT_FOUND on LOAD_FILE2_PROTOCOL
 calls for initrd
Message-ID: <X9eleMqn6Ron/myG@apalos.home>
References: <20201214170122.4569-1-ilias.apalodimas@linaro.org>
 <aa66cc54-f987-cdcd-05a7-4b63aa8b422d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa66cc54-f987-cdcd-05a7-4b63aa8b422d@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 06:39:21PM +0100, Heinrich Schuchardt wrote:
> On 14.12.20 18:01, Ilias Apalodimas wrote:
> > At the moment the EFI stub tries to load an initrd from the
> > cmdline provided option only if the LoadFile2 protocol does not exist
> > on the initrd device path.
> >
> > This might prove problematic for EFI installers that need their own
> > version of initrd to start the installation process and the firmware
> 
> Did you hit a real world case?
> 

Yes while trying to install debian with U-boot, in which I enabled LoadFile2
protocol

[...]
> > @@ -599,7 +600,14 @@ efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
> >  				(void *)initrd_addr);
> >  	if (status != EFI_SUCCESS) {
> >  		efi_free(initrd_size, initrd_addr);
> > -		return EFI_LOAD_ERROR;
> > +		/*
> > +		 * Some firmware implementations might install the EFI
> 
> In U-Boot the filename is set a compile time. As the path may relate to
> a removable medium, it would not make sense to check the existence of
> the file when installing the protocol.
> 

Agree. That's why I am trying to change the behavior of the stub slightly
and respect the firmware's return value on this.
More over the whole idea is to load the file exactly when requested, rather
than store it in memory and wait until someone requests it.

> > +		 * protocol without checking the file is present and return
> > +		 * EFI_NOT_FOUND when trying to load the file.
> > +		 * If that's the case, allow the cmdline defined initrd to
> > +		 * load.
> 
> U-Boot's implementation could also return EFI_NO_MEDIA if
> CONFIG_EFI_INITRD_FILESPEC relates to a non-existent partition.
> 
> Why should we fall back to the command line in this case?
> 
> The whole idea of this protocol is to disallow the specification of an
> initrd via the command line.

We are not falling back in that case. We only allow a fallback if 
EFI_NOT_FOUND is explicitly returned. 

That being said my check is wrong. I need to check it on the first invocation
of load file, not the last one. I'll send a V2

Regards
/Ilias
