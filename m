Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5925B440
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIBTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIBTFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:05:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846CC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 12:05:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so487988ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6R0efz9XWd+oW+lHxqck6JB8UpHV1U85RBybyhOaC4=;
        b=FFjcggiLAJRLsoGGisAB/RvYoVPa45By1Cc42PbUrHcWQfkEb/1IWBC4x6C/DCKx2v
         KqxW8Ac/K9/R38SwKfttu4rEyrBFd+8X1wsL6Lb5V0BzJhDaHCyc7DcAg0NubmArQtOS
         zH2/jL5q7snagATz4hnkvau7EI4CqWLrrliI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6R0efz9XWd+oW+lHxqck6JB8UpHV1U85RBybyhOaC4=;
        b=qCTrPskuvJ1R+//caFlHQUKL4ITnYCaWQoZ7DY+U31mJhrk5aDHm+l1+OQgbEdHJuf
         SZxxjxkiyXYJtL2UhwuIxFWcML/U8uvbQih4FxGgn9KzBh0ey8rBIx8y35mpNiXHmaqR
         69lh2/IcKMeHiQ0dZ7WKsXHDtrzwHGneS2SfO7Jlj+M6InNDJlo3tV1Tm0Ah4lXaK45U
         XQw68GqBlxn7/0ZD9/eXqui1J5dl7yjBiEwrh3mDEa3r8wnFEpTUWRCEmJDaz2ciHA3f
         eywZT/+Z2D2HEyA9/XSjxAYOh4klYqe3nAUaUOiwQ4CxN1rD1eM0D7u7Zi1eGvOCLSaj
         wWfw==
X-Gm-Message-State: AOAM532hSo3YEfdb99rdOqUhPHbD3dBd55EiC0d1cdvTUGG8PePpArFT
        0cinaGRtP2wF7b/YcT3DmFcTjoQIDjhkmg==
X-Google-Smtp-Source: ABdhPJxNMKP60wACdTGZrQr9zaypEmm8eoGl2m+TPp9QnQ3yehlq7StB2+jvifmZb6rPtbYnNWybdQ==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr3659966ljn.115.1599073512958;
        Wed, 02 Sep 2020 12:05:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b1sm101058ljp.78.2020.09.02.12.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 12:05:11 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w14so476642ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:05:11 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3829066lju.102.1599073511288;
 Wed, 02 Sep 2020 12:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org> <20200902085513.748149-2-leon@kernel.org>
 <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
 <20200902174600.GK59010@unreal> <CAHk-=whG7MPx0_6S8ATd4yRPtwKTThDNtbKQDQARHbaPp2H1Wg@mail.gmail.com>
 <20200902184449.GN59010@unreal>
In-Reply-To: <20200902184449.GN59010@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 12:04:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbijeSdSvx-Xcr0DPMj0BiwhJ+uiNnDSVZcr_h_kg7UA@mail.gmail.com>
Message-ID: <CAHk-=whbijeSdSvx-Xcr0DPMj0BiwhJ+uiNnDSVZcr_h_kg7UA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work correctly
 with kernel and user space pointers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 11:44 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> I already don't remember why, but copy_from_user() caused to second flow
> of gcov_info_dup() through gcov_event() to generate another set of warnings.
>
> As a summary, I have a workaround, but I don't know why it works and not
> proud about it.

Ok, it does sound like "let's just disable gcov for the affected
compilers" is the way to go.

If/when somebody figures out exactly what's up and how to work around
it properly, maybe we can then revisit the issue.

Thanks,

                Linus
