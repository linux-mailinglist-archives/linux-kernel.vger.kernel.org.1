Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7228F2FC89D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbhATDSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbhATCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:44:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 18:43:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f63so5772302pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoAS2iYBLHsRua0ToD9jNwcwJKOxvef2a5weUgRGbk0=;
        b=payUoMdP99ddV95PcEbXHC19WExfJT6yZ/S4Ppoq/PLGAFbIoNn7Ocr9I+rvAyWbCp
         vl8P28OthlrC8/YP790veImXuigRJQ+FCsfMuvuUXkcuWlHIm3ORZYgnSOfFBWVqwrsx
         etQUHaMuNXSZiBSaJug8IAPdQ9Y3kmvOKMD0epVjkDWIzoTugBJ/UJsLq6QRvOCAMGks
         52gEg7tfjfjS/5IPrbkLmpMxaXgQ8LA6lTT+oUp4pmz1yte+4ljxAX1G0rCyimsvXUrJ
         kSRn7OSiizNM1UAmaUFSCvMIBFfNTpucrCHH8toBTyzLLoxOk4H4/MXbBVrxQMm75Y9g
         le8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoAS2iYBLHsRua0ToD9jNwcwJKOxvef2a5weUgRGbk0=;
        b=DmnjcWEECxsOLgLR8M0BZdEOrW/AjfwF4F0rZgg5aQ7Uu832JFYlzTLOrAemy3+8Qf
         tOMB1/1G+ZcwvMG2W9KJ/cuQCmobsyGF4w/muYehbC+kW6uA9w8HGBtxWQEi15oGgDUR
         8g0y1ig+tewOn3WsiDwekmS/bjnYbNcEf62PHAWMwUkWohB4ex19efoSSBnmVv2kGmLr
         bGyA1NDrwLJFhk/MvbWbd9koZQTl8TDUNz+cgM2ssnbdk6BreXNk+hMfh9faI7poLbqJ
         kf0CWxg3cPd8MLkZFxWZ/8fDO/xBy2EOVleh5GkMstFave30t/vtWtlx2PdR3dycG/F1
         O8iw==
X-Gm-Message-State: AOAM532ujcSUQRL5UE6LFPPBpYQ9MPeWEfgjbSNQg1iY28TjV9MZOF/W
        JtfrucxR40KbUeLetShtkVyoqOscG/1jHU2tbdElLw==
X-Google-Smtp-Source: ABdhPJyP9xx5n3cq0nmNCglbjFT0ogHH0SdoaQC66nze3RSq1u6CYmEK3xfrrNQ97XJvAtKZ+TGeZvsQyiie386D8S0=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr7252992pgm.10.1611110628633;
 Tue, 19 Jan 2021 18:43:48 -0800 (PST)
MIME-Version: 1.0
References: <1611042978-21473-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1611042978-21473-1-git-send-email-yangtiezhu@loongson.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 18:43:36 -0800
Message-ID: <CAKwvOdkXGx-WogH0o5iuNnEe07sqRfxMpOg5fEEnTWcOfBrbAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] samples/bpf: Update README.rst and Makefile
 for manually compiling LLVM and clang
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:56 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The current llvm/clang build procedure in samples/bpf/README.rst is
> out of date. See below that the links are not accessible any more.
>
> $ git clone http://llvm.org/git/llvm.git
> Cloning into 'llvm'...
> fatal: unable to access 'http://llvm.org/git/llvm.git/': Maximum (20) redirects followed
> $ git clone --depth 1 http://llvm.org/git/clang.git
> Cloning into 'clang'...
> fatal: unable to access 'http://llvm.org/git/clang.git/': Maximum (20) redirects followed
>
> The llvm community has adopted new ways to build the compiler. There are
> different ways to build llvm/clang, the Clang Getting Started page [1] has
> one way. As Yonghong said, it is better to just copy the build procedure
> in Documentation/bpf/bpf_devel_QA.rst to keep consistent.
>
> I verified the procedure and it is proved to be feasible, so we should
> update README.rst to reflect the reality. At the same time, update the
> related comment in Makefile.
>
> [1] https://clang.llvm.org/get_started.html

There's also https://www.kernel.org/doc/html/latest/kbuild/llvm.html#getting-llvm
(could cross link in rst/sphinx).

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>
> v2: Update the commit message suggested by Yonghong,
>     thank you very much.
>
>  samples/bpf/Makefile   |  2 +-
>  samples/bpf/README.rst | 17 ++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 26fc96c..d061446 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -208,7 +208,7 @@ TPROGLDLIBS_xdpsock         += -pthread -lcap
>  TPROGLDLIBS_xsk_fwd            += -pthread
>
>  # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
> -#  make M=samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
> +# make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
>  LLC ?= llc
>  CLANG ?= clang
>  OPT ?= opt
> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> index dd34b2d..d1be438 100644
> --- a/samples/bpf/README.rst
> +++ b/samples/bpf/README.rst
> @@ -65,17 +65,20 @@ To generate a smaller llc binary one can use::
>  Quick sniplet for manually compiling LLVM and clang
>  (build dependencies are cmake and gcc-c++)::
>
> - $ git clone http://llvm.org/git/llvm.git
> - $ cd llvm/tools
> - $ git clone --depth 1 http://llvm.org/git/clang.git
> - $ cd ..; mkdir build; cd build
> - $ cmake .. -DLLVM_TARGETS_TO_BUILD="BPF;X86"

Is the BPF target not yet on by default?  I frown upon disabling other backends.

> - $ make -j $(getconf _NPROCESSORS_ONLN)
> + $ git clone https://github.com/llvm/llvm-project.git
> + $ mkdir -p llvm-project/llvm/build/install
> + $ cd llvm-project/llvm/build
> + $ cmake .. -G "Ninja" -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
> +            -DLLVM_ENABLE_PROJECTS="clang"    \
> +            -DBUILD_SHARED_LIBS=OFF           \
> +            -DCMAKE_BUILD_TYPE=Release        \
> +            -DLLVM_BUILD_RUNTIME=OFF
> + $ ninja
>
>  It is also possible to point make to the newly compiled 'llc' or
>  'clang' command via redefining LLC or CLANG on the make command line::
>
> - make M=samples/bpf LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
> + make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
>
>  Cross compiling samples
>  -----------------------
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/1611042978-21473-1-git-send-email-yangtiezhu%40loongson.cn.



-- 
Thanks,
~Nick Desaulniers
