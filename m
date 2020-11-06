Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29F2A9B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKFSBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFSBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:01:18 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:01:18 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b18so1861166qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q71DOcgxQ/FG+0xRI5ty6ibPA0LopqgeTgo5KPl0sXI=;
        b=BFXZEyu0IJx/Eo1PAWDnU1E+j+u2xlC+giK0SSSSmSwwyQ7JfBDuPZt5o+4CCPJMnW
         /hvbt4kvErDT3iza/KDi032qxXMwKG4Nu7cgikuhMa9LoMwcJP6qXYaIG54/rBFRS9uM
         bXXsDoqRFpKmbwJ83PJL+wwVRVaPJrPyB8qM6IP3w1+HRFyNoaE4LsTfLQpjsnc5kUqG
         9uzH2odBeM17XZchQptnC1H7HRXBTkbjJCP/QME4wcYx4VZ5H5wJA648x6NFEKPLVzIV
         ngJTwswU4MyALzXeuQ++Mp9Vuju3354k2/pfGE/9IHa36EP4nf+bGJ8VEI114kVoRMJj
         dDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q71DOcgxQ/FG+0xRI5ty6ibPA0LopqgeTgo5KPl0sXI=;
        b=DIGsZgyomp9Hu1W6C4cuZps/y/+a8AEGMeWs9tUc29DaUE7ryCgxntQ9ScRv+czzKk
         ycCpK0AfriVqPqEDTpAtzmfBcncetQF4f2y0Y0Hz02pPKi3/M4NVjStfjHBgEhZ42DHN
         RkVONidHS4lNZN9/M/meocOHPGoOxOjPvlGhehVcT9xw8FKrqTowB7/I02qoT65nKBXA
         P9RcThJ5JBG//pM4JHefCsm2SgHKDAO+l78foJPF49gbSHvqz39qT8n2AFzCPFqoojXD
         QetYFl5gCcxMWkRAC9Si2hrOz+RVeeEmzUjOWbg5mjKQ/Wz8pMsCHu0dsL3uvSOBojoy
         C8Zg==
X-Gm-Message-State: AOAM533a84u5DMlVKE6PQntwREWmGgdrASStU/HrCPmwqVhjBMXfYy4U
        Ws+VvIsef1pw1YbQlKhGIkc=
X-Google-Smtp-Source: ABdhPJzvM8vj7aDUG+FeZM5sY4sQwhD207HCFkuHpBTU8KLpOk2Rgfvm3t9JJxM9oRVgotbiAHiHlg==
X-Received: by 2002:a05:620a:22f5:: with SMTP id p21mr2452964qki.13.1604685677742;
        Fri, 06 Nov 2020 10:01:17 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 66sm993396qkd.81.2020.11.06.10.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:01:16 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:01:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201106180115.GB2959494@ubuntu-m3-large-x86>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnyyvh56.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Nov 06, 2020 at 01:50:13PM +0200, Adrian Ratiu wrote:
> I tested Arnd's kernel patch from the LLVM bugtracker [1], but with the
> Clang v10.0.1 I still get warnings like the following even though the
> __restrict workaround seems to affect the generated instructions:
> 
> ./include/asm-generic/xor.h:15:2: remark: the cost-model indicates that
> interleaving is not beneficial [-Rpass-missed=loop-vectorize]
> ./include/asm-generic/xor.h:11:1: remark: List vectorization was possible
> but not beneficial with cost 0 >= 0 [-Rpass-missed=slp-vectorizer]
> xor_8regs_2(unsigned long bytes, unsigned long *__restrict p1, unsigned long
> *__restrict p2)
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=40976#c6

Ack, thanks for double checking!

> In my opinion we have 3 ways to go regarding this:
> 
> 1. Leave it as is and try to notify the user of the breakage (eg add a new
> warning). You previously said this is not a good idea because the user can't
> do anything about it. I agree.
> 
> 2. Somehow work around the compiler bug in the kernel which is what the LLVM
> bugtracker patch tries to do. This is a slippery slope even if we somehow
> get it right, especially since multiple Clang versions might be supported in
> the future and we don't know when the bug will be properly fixed by the
> compiler. In addition we're enabling and "hiding" possibly undefined
> behaviour.
> 
> 3. Disable the broken feature and once the compiler bug is fixed enable it
> back warning users of old compilers that there is an action they can take:
> upgrade. This is exactly how this was handled for GCC previously, so there
> is a precedent.
> 
> This implements the 3'rd scenario which is also the first thing Arnd
> suggested in the original patch. :)

I agree that number three is definitely the most robust against the
future. I know that I periodically grep the tree for "bugs.llvm.org"
because we always file something on LLVM's bug tracker when we have to
work around something in the kernel. I think this patch is totally fine
as is, hopefully we can get it fixed in LLVM sooner rather than later.

Cheers,
Nathan
