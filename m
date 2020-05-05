Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C51C5E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgEEQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729720AbgEEQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:59:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:59:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so2381883ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtzYgCuKkt/bmV036ncd6lENxrdBs3w2AEjDTg4Jym8=;
        b=BvfMU4FkK4+TYSxq8r2HYJ1G6i+Kwe+It8iHrrdCrMNdjvKKRvhcIByeRqpEBOhvR2
         z1Rngg1akXbqNshURhLPyo3W/aYzamFcP368MXvOl5NWCPy2QD7LKh8VVBEx+hd6Yb06
         EFAluQBX7GxsusBdl6NXz6lGmArzuIOnv0zsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtzYgCuKkt/bmV036ncd6lENxrdBs3w2AEjDTg4Jym8=;
        b=W30e18g7+J7b0E6u78gNFXNXVGiTMwl3JrVFcpTm7z6UWoZLyVsfAeB1YTv3y5c+wx
         5jDyUgkNvF2nUYuaKWDZ42ST4jBv+e8kAXGRUmNr2cal5/LqankrtbH31xcL4s17uSTp
         IsVZG+QrQ2dxajDoTfMayOtevAKS7nBgnrf7p8x9snYeUcfY6dDhUz2orcfXeh4uM9re
         RPfjvLVfbnwwwW25VRUYxBNB/brVu0UHZOlb3LTthqUXGJDo90FE9dZxOrfVo5y4Rd80
         fjUC59nPka+D6QW/F1edkH2aiPdnvq/MKH4cXIIuHed12m1lgo8Ohl6A0IZC57K1qq+3
         VRFA==
X-Gm-Message-State: AGi0PuZ0f3I4UJv4KFPtND/xabm8Lr5+4+E2P8M8DcvVppYZadsLasMI
        rEUKC6bto3X/wdQs6+YlX54ZNVfbl6c=
X-Google-Smtp-Source: APiQypLqIy++d/rxAXGaYO2z9GQz0moGb5wbUz9zfWrzYjfZ8T7j3jr3oMlAs9oDsv2Gi2Nz8Ez+gw==
X-Received: by 2002:a2e:994a:: with SMTP id r10mr2373959ljj.105.1588697954018;
        Tue, 05 May 2020 09:59:14 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v18sm3136723lfd.0.2020.05.05.09.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:59:12 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id t11so1956598lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:59:12 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr2226121lfk.192.1588697952227;
 Tue, 05 May 2020 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505143028.1290686-1-arnd@arndb.de> <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
 <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
 <1f33eec3-4851-e423-2d04-e02da25e2e6e@embeddedor.com> <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
In-Reply-To: <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 May 2020 09:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv7ummbSN1H_jFxLJtZbCD4JKAbb3XRf9xFYK54T-=nw@mail.gmail.com>
Message-ID: <CAHk-=whv7ummbSN1H_jFxLJtZbCD4JKAbb3XRf9xFYK54T-=nw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Linus, let me know if you would like me to Cc you on the other gcc-10
> warning fixes I have and possibly apply some directly.

Sure. If you have any of the "trivially correct, and doesn't make code
look worse", push them my way.

I only did the ones that looked trivial and fairly core - didn't want
to step on any driver toes etc.

                  Linus
