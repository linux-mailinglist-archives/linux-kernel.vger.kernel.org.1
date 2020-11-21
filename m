Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077CC2BBABA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKUAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgKUAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:14:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107FEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:14:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so9429988pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=U5bxGcfchBQVmEBBbdQ2iExVkYUOiZ88oTXx0NbjtJo=;
        b=lFf95V8UJCgnIR3tVTNzhQbMvHSGH4PFeD3IW3zbQXYRLFulE0tlnHgaGHzjcWqYCu
         M8hHkR/53SfKqioD8PcoDSfRujcXhIfaQV/4wscMe5p1veyQgpfnkiGNMlG/iFFlELI2
         R+jnrlb1lcIbvdAaHM80Q1jzKSH1tQNe0fSdBqV+D0J2l6PK0FnBuYUGjD0oRfCtkbWb
         yBRMmO0oU2eAqpZ68t1sLuhcE1Me2ig6IovdpGz7YsZAS6IFKYitGTBaRwTawdo2ydOr
         1RqKRPvktkKjlrAcwx+nFGdl7vDUwEmNz5ozQf5b7IvvVimu2MbKVYNGjiltrDPohpN2
         XzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=U5bxGcfchBQVmEBBbdQ2iExVkYUOiZ88oTXx0NbjtJo=;
        b=IkhJPKdaq8QzBOZyXetzjY5lQxAr8py6hgPMPK0us0OVTyYn11CXpSjFo/zyrj3m9q
         rnhpOAdSJDFcwLNm05yibGVbPYh82L7eof+4SP62cGi/M3bZg/rTcvhIa22xnZCrBoZu
         /O1wqewgVbUBQaUMmknnXlDhA2fng0EjLHFMtnJqQ0SqoPJBvSFN3C+kDLnBxNwMlddj
         QLkIwzkxgfmcDAS/gRKy1Xcy0L6OcKjynwKRmKO81gYmlk50+HwMMHCkTrpGdmkLlr6j
         F8KncGJifADxiNf47gs5zoOXSQuGrVxcCpXtkHAxd4HBG13TPauBNPMauYxKauijKly2
         aatQ==
X-Gm-Message-State: AOAM533mg+Bz28PZxhi4/zeyF3mPUxVdIpUxu/wGRfL0R8A5PFDSaT2j
        CgPt5/rRhCZ+Gbg/WN8ouc1sYw==
X-Google-Smtp-Source: ABdhPJykWdoCK3edkgyoG1Ve3dUjBWdlHpE0EPxnlt+Lx3ZCannMjWZK+ue4hlwPPCKu2iPp9+fvsw==
X-Received: by 2002:a65:684d:: with SMTP id q13mr19480014pgt.372.1605917650458;
        Fri, 20 Nov 2020 16:14:10 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k8sm5080220pfh.6.2020.11.20.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:14:09 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:14:09 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 16:13:38 PST (-0800)
Subject:     Re: [PATCH] riscv: Explicitly specify the build id style in vDSO Makefile again
In-Reply-To: <20201108203737.94270-1-natechancellor@gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, natechancellor@gmail.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     natechancellor@gmail.com
Message-ID: <mhng-f056461a-d53c-4405-b514-1d01dba13cc1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Nov 2020 12:37:37 PST (-0800), natechancellor@gmail.com wrote:
> Commit a96843372331 ("kbuild: explicitly specify the build id style")
> explicitly set the build ID style to SHA1. Commit c2c81bb2f691 ("RISC-V:
> Fix the VDSO symbol generaton for binutils-2.35+") undid this change,
> likely unintentionally.
>
> Restore it so that the build ID style stays consistent across the tree
> regardless of linker.
>
> Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index cb8f9e4cfcbf..0cfd6da784f8 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -44,7 +44,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
>  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
>  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> -	-Wl,--build-id -Wl,--hash-style=both
> +	-Wl,--build-id=sha1 -Wl,--hash-style=both
>
>  # We also create a special relocatable object that should mirror the symbol
>  # table and layout of the linked DSO. With ld --just-symbols we can then
>
> base-commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c

Sorry about that.  This is on fixes.
