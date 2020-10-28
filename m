Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25A629D297
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgJ1Vde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40739 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgJ1VdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so624986wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jxN7dwqApdR1ej5dh2h2T4IB4++cE/G2cOg1rxvC1QU=;
        b=bVgcOJNDYGFVmRhLRE5zDu1fTUWAdDMpxxBtb+q8OcZmy5i6QdU4+VmbQQKjjt02SU
         uf+n3paPdIQPEufyNwNrkkSC8uRV5UHdGk5fL6iKJwhxXsfK007LvehHdsIdkYD/vkwl
         MF3RqolRLeULiKOhMAJ+KtH4XAyC9l0aOO7dY+oMvzchh72LIch6SRcr3Vxxsiv3d969
         uDyHgZZ+lku4criVmIJ6F7ax7e0vb4zW8oy/yvd9pKD0qr2YNoiStv1aeVEOFH2HYLQn
         wVKirUiTe5QH1258QCNhLvWqHrZcdPSYKgZ4+nJ/3pDnQkxtFLkkLZRNBYOwTuiN6lMe
         tHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxN7dwqApdR1ej5dh2h2T4IB4++cE/G2cOg1rxvC1QU=;
        b=hp2QtE0qFCgUe50y50VhQZAzpjIZmdkf3o5DLoO1XFo/R9+ZESZ6Cn2s1Rh6r3xXSA
         VmPzLoQVWK8iWuDxeRAKMw5PaLzmF9GcU1oz3D/bJQUxYnv9jooeLIrJiHOIzUPLpClW
         7DAVueoko8cqV0U1AX7X0RczVwb6wVKbEjUvB6kDtjCjMxWMBwhFVvjEinml5KOAuf2G
         QLhBk8aqH76kFm+4x98cvFw3grx8dn2Mk4vH65QPLKKHR6Rq2Vx6Gx0vnJRt+xZ0E4me
         4JSqgpJ8RjoD4J+pH7eXbLUmlh2ibrgMd9PVveDJEXr0Cnsvsr0y/CklOoObmKpBSApX
         0OcQ==
X-Gm-Message-State: AOAM531OdQuVzeAGnbPSL2mR2EJRWsf8hi3ycyJuGyZw/lSdM1lpMMG+
        Myg2uoQaNyfox2bqjnZG7ETxbFvz+FLz/w==
X-Google-Smtp-Source: ABdhPJxugL/06UijjpouyBtDh42aboeAqgIFcJ7a1QLSdDZlftvXVGOyggzHDRsaGqPXkkSDAVWXnQ==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr6483756wmg.147.1603899975882;
        Wed, 28 Oct 2020 08:46:15 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p4sm7367869wrf.67.2020.10.28.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:46:15 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:46:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame
 size of 13472 bytes in function 'ltv350qv_power'
Message-ID: <20201028154613.fue7ilxdihj2cado@holly.lan>
References: <202010260230.VivTG0Gb-lkp@intel.com>
 <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 12:17:08PM -0700, Andrew Morton wrote:
> On Mon, 26 Oct 2020 02:15:37 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d76913908102044f14381df865bb74df17a538cb
> > commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
> > date:   3 months ago
> > config: arm64-randconfig-r005-20201026 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1c8371692dfe8245bc6690ff1262dcced4649d21)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame size of 13472 bytes in function 'ltv350qv_power' [-Wframe-larger-than=]
> 
> That's a lot of stack.
> 
> >    static int ltv350qv_power(struct ltv350qv *lcd, int power)
> >               ^
> >    1 warning generated.
> > 
> > vim +/ltv350qv_power +192 drivers/video/backlight/ltv350qv.c
> 
> Odd - the code looks pretty normal.  It is possible that your compiler
> is (crazily) inlining ltv350qv_write_reg()?

Certainly could be.

Same config compiled with gcc-9 gives ltv350qv_write_reg() a stack usage
that is large but not crazy: 768 bytes and dropping to 480 bytes with
the sanitizers disabled. With the sanitizers enabled then even the 
cumulative stack usage of ltv350qv_power() through to ltv350qv_write_reg() is
still less than 1k.


Daniel.
