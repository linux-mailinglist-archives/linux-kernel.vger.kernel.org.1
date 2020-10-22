Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE7296502
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369885AbgJVTFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369878AbgJVTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:05:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95895C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:05:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d24so3586884lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RHdOKnSFcmE4zwfEi1VqTCH5ZuvXulyjgMDpnhPLB6Y=;
        b=hUGyXHYYdtlbJJf+AU9knmsUsbMZbJtOiuqwErtwfvkLAGzUD75NIEedu5oUU4iJlp
         Nykl4MK8Usl27VeBe2TuHD3i+xBlrFaW6kOhV5jNl/J01q2SsiKWljIlT4bd4x53w1VR
         oDVw3Ia/afusI99eUOeWITdwYmYUYQ8z3F5ZMnelmIyL16ZWSY83QG04oy9LNE8/KUwk
         CVS/L59iiY/De0tuSvzFGqcTCk4ujA4KJlLyjwddFOXj3K//vHy4+BWqPdBwEaENjOco
         z+c2Jffc7fsKQnDDHc0IxUPtd0c3gB7j2VLmdwwsHC7JAqIKmJoYfdggM6a1qWjKRKyV
         vCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHdOKnSFcmE4zwfEi1VqTCH5ZuvXulyjgMDpnhPLB6Y=;
        b=OrruXDUtobNBS0tk4TY6SMxlOCQfL0hIRAzShnUucyYjLdxkHgejHSccBpD9J28U2Y
         9rCArdbktAxL/I0u/ILCdKZqYvJPYnGOERTcmebqMJUGzgYy7WnxZx2Y/WP6khSZEnN2
         WMehF0G2XaxAHHtmbxxloLpP/tU4d6YM/La21frYx3fWVPjo3K+uAa85qtxpGImP+t6x
         bfk1HJTa+QLYP60dgc9OMpodYwm6M6fTsN/ylX1NjgCcYDNf0u2z1IIJqjKlq9C/iSCj
         Vqih9Pw712Z680/cv+Z8sFUGMUXX99GMNb8yGcfNO4yQUL9WrfsKEgsM5ZvkDkmIXRY5
         Tqyg==
X-Gm-Message-State: AOAM530bq5XPBRwOFO89i8afGVAY+Uf+kBJRKuhMPhUMFtFASeKEfsSG
        OmxGr0fc08ney+XjOJwRihQ=
X-Google-Smtp-Source: ABdhPJwE3Rf805Tcxe1SMLKFhVVAMBJ7vl3UVYbTu4Ay+w7npZtb17qOI9rTGL9WOCjXCI6Jg7vhAQ==
X-Received: by 2002:a19:ccc2:: with SMTP id c185mr1448443lfg.322.1603393531147;
        Thu, 22 Oct 2020 12:05:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id 18sm425054ljq.0.2020.10.22.12.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 12:05:30 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
 <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk>
 <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk>
 <53e78602-6370-aeb1-398b-5c065dd562f8@gmail.com>
 <20201022173843.GR1551@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <39e453c8-fc4c-6c78-3f07-8f74690b1ef0@gmail.com>
Date:   Thu, 22 Oct 2020 22:05:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022173843.GR1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.10.2020 20:38, Russell King - ARM Linux admin пишет:
...
>> But the two line change isn't portable to stable kernels as-is, isn't it?
> 
> Why not?
> 

I assume we will need to define a new section, no?
