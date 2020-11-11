Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B62AEABA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKKIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:01:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16731C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:01:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so1568496wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJM9ckzLFNwemt4FHn77EySHwaKoxLOgcixa/TqqCLU=;
        b=OuYfz7klke51OvRxR00Uv8Am94sHIvBjVvaTG7IH6dsRglQPXKPlE/4S0IqnttXcar
         BUSgzzrFVPFk4zProjA91/zz4JPULDZB0sUPOGlkmsF7DcpOdFC0d010H3wsYJLYmQwz
         jrBOKm/Nyqg7R/IPsxmqKnLY1S/031oP76NDVhKB+FDuhNcs+ZAHMOHf7UMz/MuQvjuM
         FHip/YE7i7HWeIy3AnOueCuEzeXHw5Nm1ai/vDZX3TPBnHhn2RzHdcWJyGWzqJZvcVzP
         grNamG9JmvudwPBDbvs3ImN9nGa5ayelSltF+gD8WCiAjET2jPnLEH/Ffn+hMUiapu3c
         Tcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJM9ckzLFNwemt4FHn77EySHwaKoxLOgcixa/TqqCLU=;
        b=BcvF4cn2/rrxapKE5VwRhDPZfIMabhdPdhSysXJZ4ZrcXROjN/EI0fv3code5SP330
         nNkadCSajLHqg4XXA5BLlhbd2yj/4/FPXDx+BspVSYdZ04XdFjLZY5QTKg+9la3DnQaD
         y+8XZVikkWew5OY+i2i6/GMBSOS8sC0VmGfw2XWkvfrakFJDJntQmGUpGYSazgreluLf
         Z11wW/pB044OY+iyC07NTtF2Orzoa7ry61EHFep3LyilsAEBq/yrCb5zPBa0I9smygkk
         rFhDPqERvoJsCv+lseXz/sxUTHXQQV9oEvVsCqfmVaiH4mnQvhiNcPrsOkZ9NA8nhMFK
         HO5g==
X-Gm-Message-State: AOAM530buU0hq9QTJ8yCMHW5OhfGGfhdVj8IVKUHe0kvAL3FehqraA4y
        32JqDcvjHgmARjMtBfxiWumJ1A==
X-Google-Smtp-Source: ABdhPJy2tQy0AX6kb1GgjYoMI/5Jfs0xAhcTmCe15i+WiUJf0L8QaMezgjVlYJfzsacwQVnOUpi3dw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr27639611wrl.84.1605081697757;
        Wed, 11 Nov 2020 00:01:37 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y10sm1469618wru.94.2020.11.11.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:01:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:01:34 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com,
        Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c:412
 sun8i_ce_hash_run() warn: possible memory leak of 'result'
Message-ID: <20201111080134.GA4359@Red>
References: <20201110104737.GF29398@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110104737.GF29398@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:47:37PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   407ab579637ced6dc32cfb2295afb7259cca4b22
> commit: 56f6d5aee88d129b2424902cd630f10794550763 crypto: sun8i-ce - support hash algorithms
> config: x86_64-randconfig-m001-20201109 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Hello

Thanks for the report, I will send a patch soon.
Note that you should send this report to the maintainer also (but this time it is me with another address, so its fine).

Regards
