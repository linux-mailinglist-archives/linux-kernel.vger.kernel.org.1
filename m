Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71D1DA794
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgETBzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:55:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:55:47 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g20so627642qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ghTZqejRfgfS5fU2jVg75uMDbgGX4TrDcdfAaAdauPM=;
        b=ZOSedoTXRdCITrmaNoTnIMCXK7FvETKzbgoMB6JrmV4a5WGgI4bUyJioFolzQmGVrq
         o84jZ9Q029nIsm59ickCSKRAQ01KYsQEUK+O0c4WczRv54WM0OVp426vCrLLCpKR37Mw
         m5+8b6DcRSebQJ0RTOCsPoR2ZIbKjuquYzCasav1Nxy8+/U0kUkQUoatHY5OrIxy9YtL
         yAVmCyNuLc+1DjGAfNtUnT7YgFJbNpFsbuQn2zlgnGL6qXiPYNQ0+P32QGnABRJpe8HR
         nVBWLJcjfkd+mQxUSjqqoCgfYXpimBamkomH/UGmqkYwxDWuFhnC7r08aRZk4wq13M7K
         eJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ghTZqejRfgfS5fU2jVg75uMDbgGX4TrDcdfAaAdauPM=;
        b=n3tBGyOqWrIWo5OEB8Y0ObyNNBH1Teqgbqe9fYUomHL7LUSwXYCabyPfpQ+iFYwMZv
         uID98L1/ETeswZIgYF/W/RoyaPczY5l4g7AMK87KOHzcAkh/mR2z463iByhlsjRU1jmA
         NxzoY0UwNNw5Er0eMRCpvxkbtzVKDJRzrMjBRRcee55CBDHSD3iB9oTF5Nz87621lYsz
         I3TT7ugK0C4yr692uRRWx8Wt3ahToFRRmNoWVexY+X1pxzzh57ZOI/x3wU1GZoosYlHl
         YfshO9JbmSeOUynzV5t2KSs/0544BAlOkuxwviQ5UU/n/d4igtuB7MMo8fEyr+JUjFkS
         Wq3w==
X-Gm-Message-State: AOAM530IXX4T7o92MR3xzUcsqXu3FI3udoEKFFpVCE/tAD1tNCSA4hKV
        ReGzBYzyoQ5Okac4dYFUbBU9xA==
X-Google-Smtp-Source: ABdhPJyy1uyJk+Gqjg5bwcSBKIbQNOr6J5nfgaVGYYnWbcx1hDrSKyd/Hr8zTt2MLIvCkn1/+n7iIQ==
X-Received: by 2002:ad4:466f:: with SMTP id z15mr2750441qvv.101.1589939746442;
        Tue, 19 May 2020 18:55:46 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j3sm1007064qkf.9.2020.05.19.18.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 18:55:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: UBSAN: array-index-out-of-bounds in kernel/bpf/arraymap.c:177
Date:   Tue, 19 May 2020 21:55:45 -0400
Message-Id: <FE7742FF-713E-4310-95E7-9B217662E53E@lca.pw>
References: <CAEf4BzZKCh7+2TL8GVetxrOKYCoL0U7jTGsO5CbDExs7Px+bYQ@mail.gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
In-Reply-To: <CAEf4BzZKCh7+2TL8GVetxrOKYCoL0U7jTGsO5CbDExs7Px+bYQ@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 19, 2020, at 7:23 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>=20
> I agree, it's bad to have this noise. But again, there is nothing
> wrong with the way it's used in BPF code base. We'd gladly use
> flexible array, if we could. But given we can't, I'd say the proper
> solution (in order of my preference) would be:
>=20
>  - don't trigger false error, if zero-sized array is the member of union;
>  - or have some sort of annotation at field declaration site (not a
> field access site).
>=20
> Is that possible?

I am not a compiler expert, but with my experience with all those compiler i=
nstrumental technology like KCSAN, KASAN and UBSAN, it seems both options yo=
u prop need to modify compilers, i.e., -fsanitize=3Dundefined=
