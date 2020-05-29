Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715381E8C20
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgE2Xg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 19:36:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728349AbgE2Xg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590795416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=md6CfLqtI7LPjDRkteKnkbJNZfQ/IdH7JmpzoB9DL+k=;
        b=VBz6JkQUsgynlniGkkj4tdS5g3Ky4yYtjCQAZzheX6617P8cpGQNpFuIvxaVAH7KeYYmd5
        LQf4g5Drsc0KiZveb6j0VjacnSjT1ehGo3kFQ2rzPA16hlUINaWSYLUFrR5BmZ7f23XjgX
        XaH0kJmzJE0edoXFfCi1kDCVKMazUQw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Kwky6JDBNhyN6QQJnc0V7Q-1; Fri, 29 May 2020 19:36:55 -0400
X-MC-Unique: Kwky6JDBNhyN6QQJnc0V7Q-1
Received: by mail-ed1-f72.google.com with SMTP id f18so1914428eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md6CfLqtI7LPjDRkteKnkbJNZfQ/IdH7JmpzoB9DL+k=;
        b=m0tIc6W5Z6jhrkvty3Cq1b+Q6g5oGWcq6oyO0kD1eP1AKEXtQLIle2BDdN0QM91Lfl
         ith4BsDRA7YgP65foIm1MwQFu4mTISUEyP8C58mfXcN86edAARpHQ52i0YMpPWsOkhw1
         j8a4/1RV0MOnLhrRZ7XVQt2S+PE3TlGMQjfz8Nvnij+d6vVmLpJWeL3Hoe/SMvXgraMm
         O+9wyUo9ovFlEdSJ6CP98KKV82SNgKwWYqC3mpPqd+aCkBz7PBSq3xHXXTl7Pqtgk4M/
         u1TsMeQubtEqKwCEzlCo3dFgJuOttoTBXf1QkBsNiz4B2tzCgfhpwOYFt67q8XU8xdg5
         f2oQ==
X-Gm-Message-State: AOAM533pHzLOVMX47WLYiPivnbHj42jskWvoDEzNq1YNNb0APs45noL7
        4D9AEMsN/yFfeEt7Lmx6tVc0aKPUNc/ZLhAvCsfUyOCdK8drJ+WasKbFn4g1RNqZemyEfbCL9Se
        dBwqJZG5MN8+0mt0OAz2K+3jsFKTuHrm343fk7LN3
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr11333203edt.120.1590795412529;
        Fri, 29 May 2020 16:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIwGKKqnMqPuPQ7q2Sglzp4Q95APYgBMFalLDW1AQ1a690dDAiEQwJOIeUF3LWpSHXB1GwbJceTl6UQP/dcKk=
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr11333194edt.120.1590795412330;
 Fri, 29 May 2020 16:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <202005300520.jjdrpDkK%lkp@intel.com>
In-Reply-To: <202005300520.jjdrpDkK%lkp@intel.com>
From:   Ben Skeggs <bskeggs@redhat.com>
Date:   Sat, 30 May 2020 09:36:41 +1000
Message-ID: <CABDvA=k15=DN+ntNtC451ysaM0BTAqFTBX=DG5Nw9q5df+0bfQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no
 previous prototype for 'lsb_header_tail_dump'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 7:00 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Ben,
>
> FYI, the error/warning still remains.
Thanks, I've got a patch in my tree.

Ben.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   75caf310d16cc5e2f851c048cd597f5437013368
> commit: 22dcda45a3d1dfe6eeb4ab0a3b9aaa2333cb649d drm/nouveau/acr: implement new subdev to replace "secure boot"
> date:   5 months ago
> config: arm64-sof-customedconfig-sst-defconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 22dcda45a3d1dfe6eeb4ab0a3b9aaa2333cb649d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no previous prototype for 'lsb_header_tail_dump' [-Wmissing-prototypes]
> 49 | lsb_header_tail_dump(struct nvkm_subdev *subdev,
> | ^~~~~~~~~~~~~~~~~~~~
>
> vim +/lsb_header_tail_dump +49 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
>
>     47
>     48  void
>   > 49  lsb_header_tail_dump(struct nvkm_subdev *subdev,
>     50                          struct lsb_header_tail *hdr)
>     51  {
>     52          nvkm_debug(subdev, "lsbHeader\n");
>     53          nvkm_debug(subdev, "\tucodeOff      : 0x%x\n", hdr->ucode_off);
>     54          nvkm_debug(subdev, "\tucodeSize     : 0x%x\n", hdr->ucode_size);
>     55          nvkm_debug(subdev, "\tdataSize      : 0x%x\n", hdr->data_size);
>     56          nvkm_debug(subdev, "\tblCodeSize    : 0x%x\n", hdr->bl_code_size);
>     57          nvkm_debug(subdev, "\tblImemOff     : 0x%x\n", hdr->bl_imem_off);
>     58          nvkm_debug(subdev, "\tblDataOff     : 0x%x\n", hdr->bl_data_off);
>     59          nvkm_debug(subdev, "\tblDataSize    : 0x%x\n", hdr->bl_data_size);
>     60          nvkm_debug(subdev, "\tappCodeOff    : 0x%x\n", hdr->app_code_off);
>     61          nvkm_debug(subdev, "\tappCodeSize   : 0x%x\n", hdr->app_code_size);
>     62          nvkm_debug(subdev, "\tappDataOff    : 0x%x\n", hdr->app_data_off);
>     63          nvkm_debug(subdev, "\tappDataSize   : 0x%x\n", hdr->app_data_size);
>     64          nvkm_debug(subdev, "\tflags         : 0x%x\n", hdr->flags);
>     65  }
>     66
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

