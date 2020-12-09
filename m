Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6412D48A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgLISIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgLISIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:08:55 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD22C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:08:14 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t22so3525151ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Dok2Dg8TGlacaeSAxWT9P1pi2O1C9NTVB+p8kbM4WI=;
        b=h6HPKi5yzqhzOtvnkkrpaq9r4NQBJGYRD3Dwf2W7//GBglY+j4zf2PZjYJhr38VC7y
         h7VHdi5SsiKOD+OU+gixOwIY4mlkuQ0a2NsRY9JVT/FFj72jK/YaD6KIn06Jkdi/bY4e
         MlT+DNjqom65eVl5fnmry0QaMVhtjn21KrCtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Dok2Dg8TGlacaeSAxWT9P1pi2O1C9NTVB+p8kbM4WI=;
        b=VtmtuGcm8fgTGuxqXWQl0zdRq4r8t6UmcBDHOQcWxqqm7GvsrEooTE3YqPCZsEcJD7
         KW9pG8p5IbI8SrL2NvUrCK0yZIyvVClNnN/5vXZsW0homYuJvpDd8YH/rx3wCjHn9RoH
         sxtTg7/KHglkByMEO5LLxSabk+QXOKmvU/2Foqyi/6HMRPNHpP6Ill//7gOULMAC9ybX
         +r7XKSrV7O9S4PAVJeBEdst5jzQui+WX0hFDaDUcM53Yuwh78dEhhWIyKP+jidk6p8SE
         x9cIhQbck19lSBYwG4V79Aoo05pPbrzsbvQrMLbk/bPOAd80T2oxx43NSbF4ALjmTBTc
         /glg==
X-Gm-Message-State: AOAM531QykN9XkLKxHJXjnIDikAEn45gtlKLe9Z3qQYG/9jQxnQMAyDT
        vLwxcvAsezZzEMYQKBEe/dWIF8nnBo3pWA==
X-Google-Smtp-Source: ABdhPJwSZsTO0PbrvkYCSQvBYuFAyhj+a53lMQXqkiN3J6cNpVlAnLZU4j9Skbm+wdrUpI6f8614Cw==
X-Received: by 2002:a05:651c:39e:: with SMTP id e30mr1559005ljp.497.1607537285516;
        Wed, 09 Dec 2020 10:08:05 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m16sm245712lfa.57.2020.12.09.10.08.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 10:08:04 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id u18so4347325lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:08:03 -0800 (PST)
X-Received: by 2002:ac2:4831:: with SMTP id 17mr1291940lft.487.1607537283578;
 Wed, 09 Dec 2020 10:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck>
In-Reply-To: <20201209141237.GA8092@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 10:07:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
Message-ID: <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To:     Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
>
> Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
> for a fix, where the size of the interrupt remapping table was increased
> but a related constant for the size of the interrupt table was forgotten.

Pulled.

However, why didn't this then add some sanity checking for the two
different #defines to be in sync?

IOW, something like

   #define AMD_IOMMU_IRQ_TABLE_SHIFT 9

   #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
   #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)

or whatever. Hmm?

That way this won't happen again, but perhaps equally importantly the
linkage will be more clear, and there won't be those random constants.

Naming above is probably garbage - I assume there's some actual
architectural name for that irq table length field in the DTE?

         Linus
