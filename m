Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511532FC229
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbhASVVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbhASVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:19:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD458C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:18:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id o20so4682236pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gGc6xmmoSvdkUnPtvD2cUuU2pgqJT2sG/Kj+cTx2Ow=;
        b=E+PMbx7YyoRJxYEHCUNdVSgsLboCI+fWLaUkV1sytmlXgN8UYu3dCswTVzrsbg7LpC
         BV3Ekfxt9IrmdXx1+el7Q8BZdXc9Hp0UOueDS2AMcAEbGBNTCmt2rDlNI6xSk3bvsbP2
         VkwNueMOQxxtM29bFnjA12uxEJh9HsnosReir+V4M8mAeiurSTHAeMmez8jcdMJdMPhz
         8E5TlpZfl+TYN/3ch7JCpGJIaGXy4q0jKTc3ulFVRgf+mrv/4jUcfzTTCsu0IK0PeLD6
         96E/dUZsNqmdSdQ00XFp7J1FYjEUhTHnZDRp1EHEiRYAgSMMBqZvN3P92mXEbQRf6cXP
         F/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gGc6xmmoSvdkUnPtvD2cUuU2pgqJT2sG/Kj+cTx2Ow=;
        b=jDquKQYAUHVRldZMrknD04m86pl3q95bhRx2ojQaqIfplEAQ465hqeC9cua1r/XEtL
         29cCyepH6wUHlEvx7YzvkEzr6vbXYgLWqGR7Jf58Tsbkr8g1Bbk6v27hfbYp/K0B59/o
         w8LWjmXI2cW1yi/vybg3foAc4f+iEL/vzTesUK41k5Ae0StwuTrld2Bltq0zl26A8cGg
         0aJ9s4KYuqkLxgPbN1AR41cxA7ufWvW/of5Vg57lL6+V+TeFw38Ha2dMux4WVCxsBdMc
         cwCzUl1YCUMBcwHc75U9XdVzmzwPyRtl8u9bvEQJlo9WIbRujXApNbB5O1ee6ZRrFrKy
         svCA==
X-Gm-Message-State: AOAM532zM3CwurKHiq8iMvhr8AkvVNRvJVKm25nDHAVtsTqdy5Qtr/LE
        QtpzAtAhw87qG68bLqlLm5o=
X-Google-Smtp-Source: ABdhPJy3SLZg1jtIFvfTpuk3aSZUqemVXdTy9CFLm1+aD5deONZCpvrCaszU07SZuCFH26XTgw6HQA==
X-Received: by 2002:a62:a11c:0:b029:1ba:bab6:6b02 with SMTP id b28-20020a62a11c0000b02901babab66b02mr208112pff.51.1611091096439;
        Tue, 19 Jan 2021 13:18:16 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id e16sm53689pfj.45.2021.01.19.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:18:15 -0800 (PST)
Date:   Wed, 20 Jan 2021 06:18:14 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: io: Add missing __iomem annotation to iounmap()
Message-ID: <20210119211814.GK2002709@lianli.shorne-pla.net>
References: <20201228083328.3823431-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228083328.3823431-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:33:28AM +0100, Geert Uytterhoeven wrote:
> With C=1:
> 
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] base @@
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     expected void *addr
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     got void [noderef] __iomem *[assigned] base
> 
> Fix this by adding the missing __iomem annotation to iounmap().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed and OK.  I queued this to my 5.11 fixes branch.  I will send a PR for this
over the weekend.

https://github.com/openrisc/linux/commits/or1k-5.11-fixes

(Found this one in spam and hopefully fixed up my filters now)

-Stafford
