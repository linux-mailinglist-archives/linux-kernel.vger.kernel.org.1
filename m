Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE06E20DFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbgF2UlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbgF2TOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D5C00876B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:53:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so13505567ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4N3NxnIHOlrbNxccCBL6Rnaa4Jaah/lF3KoyD4lJEU=;
        b=Y5a00ORenb6fp3CAxkO2RdJhoSHYbhVhEF70f/Bopch+KginR0LyR2AYL2cW7YtzgE
         4IBv/FjDw/X3ITMn7zE1q91GX2itg9qJ9m1DAIGJ86/5nVIvAESpGJNbQXrsq5JVOY8Q
         E02Bdpx76U4cBBUxa7dA3EhR/bJGYosrKez06N2Q11o/6BTmZ2nXQj9qA1UoQ07YuyQr
         ZMQ9sNVxKVhUWhtR+8oz6o4ZpoXBu+EE8pARkgtqi8O3gLxn7g4K5ldEY4iH6/+z7nqg
         CXwAu2lLH9//ry9zSvJFNwpPG3zUVVSA+8mEmzkmKQxRlv5HRIrcnw1SNTabSrO8WFfd
         aMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4N3NxnIHOlrbNxccCBL6Rnaa4Jaah/lF3KoyD4lJEU=;
        b=iFD6YdbpSO/1eEnJJOlBjNudHg0TNqGuzmpRvuzybjB4GHmo1+3yt1guM58f7mYX2T
         VVWwL5vQXqTLDyWayaFxrnjBmfdbJU4RbPOS5yEzGMCmnA/XjYZ5DMRnrVaE+uMwaokf
         tuyjxvrk40/DK6N+dgedDPYjZS+YEndMftJR2K66xZkFrpXAydHgDCGPi4D606BgjlRV
         zIzdObdIp1/v6ep2rTY/ByXt8Ri4EqkPUlWQYzKZo94SziYIwbyGBxg4siSnsi3RTg+q
         fMIZ3lNRCiYF1DKiVGmfxOHjSej3sB1ri8g2yB8s7rJGFa9e+53/i4PCvceCes/FT2Jp
         TKvw==
X-Gm-Message-State: AOAM533nXK+EuRnjbiEvdvJfFpSm8hSATXl2ApmKzJfdMcE8pI34ZHyF
        tVva83lt81lhgGoiTLSYlPcLdYUMAViraIKGfNA32g==
X-Google-Smtp-Source: ABdhPJy1rQQ5J/jylQniMmYImqn4+s/8Ebp+FCxmpDIQBCBP4TtEoH93hKJjC0A/2GKgXMfoOCLC5zfzCmLvoKP0M2c=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr7114033ljl.55.1593420793493;
 Mon, 29 Jun 2020 01:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com> <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
 <20200623064056.GA8121@gondor.apana.org.au> <20200623170217.GB150582@gmail.com>
 <20200626062948.GA25285@gondor.apana.org.au> <20200627083147.GA9365@gondor.apana.org.au>
In-Reply-To: <20200627083147.GA9365@gondor.apana.org.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 Jun 2020 14:23:02 +0530
Message-ID: <CA+G9fYszuzVq5P+10OA1biMQHQ-4tTDtqoOBHHdVMQXrwnWFJQ@mail.gmail.com>
Subject: Re: [LKP] Re: [PATCH] crypto: af_alg - Fix regression on empty requests
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        LTP List <ltp@lists.linux.it>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 at 14:02, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jun 26, 2020 at 04:29:48PM +1000, Herbert Xu wrote:
> >
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when...")
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I have applied your patch and tested on Linux-next on arm, x86_64 and i386.
All LTP crypto tests got passed.

---
patch -p1 <  crypto-af_alg---Fix-regression-on-empty-requests.diff
patching file crypto/af_alg.c
patching file crypto/algif_aead.c
patching file crypto/algif_skcipher.c
patching file include/crypto/if_alg.h

Test output:
af_alg02.c:33: PASS: Successfully \"encrypted\" an empty message
af_alg05.c:40: PASS: read() expectedly failed with EINVAL

Test results summary:
af_alg01: pass
af_alg02: pass
af_alg03: pass
af_alg04: pass
af_alg05: pass
af_alg06: pass

ref:
https://lkft.validation.linaro.org/scheduler/job/1532020#L1413
https://lkft.validation.linaro.org/scheduler/job/1532019#L1516
https://lkft.validation.linaro.org/scheduler/job/1532026#L935

-- 
Linaro LKFT
https://lkft.linaro.org
