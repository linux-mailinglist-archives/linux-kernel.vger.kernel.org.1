Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C762F5207
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbhAMS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbhAMS30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:29:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:28:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m4so3163274wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oCAeIb7ECFW6QlWgtdlZyS84pPretLI5vdf+tM6RJD4=;
        b=Uibh+vbAZVnETjtRBAkiqx6q2IIG4VTxEpRIY6uh618odCokYJk2Rp/NUw7U3mbcW1
         c0tPK4C6kRxMB8tg7NnAbADmglLr3wrGuVJd15fHX2E3d3aBfjULp3XBytVT9QuCf3ZD
         9uMv+jG3r8lckQp7NEWv/Xv/fjoE1O1qB+K7aiudPgD1EWs9VA+Z5xvZyn5VUhOyei99
         NezwTAoysxwKeO53Xew9XxWLRzfG30JNyCBZSVGL/z25EOMeB38vLAo0STXqBorTf20H
         9+vSMtKPiCN2/fiXYM8SJ0jdTxSZS70B1MQr5SlM5E8Ly8x3Vyk36MYman3txbdX/h4N
         xQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oCAeIb7ECFW6QlWgtdlZyS84pPretLI5vdf+tM6RJD4=;
        b=X5nLiH3b4RS9CQ8SAa0JLtekt98OzHV25XMEevJ6QxfMbssi6taPKZt+4kA05TIa5C
         T2VqxodzjZ5AXfMfUBlCYirdtvxHK0kUuKjGM5TLo6r3Aft220QeuW0x3qxXJBj8PP0r
         fB3/6y4l5PmOugKHVaW4S2ynsEKjTPB2RTqr8KIO05NuhmgG1mKQ04r/a8BtNw6BC016
         qyHFOYWnjL+yxID6qs+Ul/znsH0zxt9SHnuPaZpUy0W03R5mrWlScBckHtEiarE4UUnD
         4yyHiFLoT/Ixcs7Gyewzj4lGGpYkoyCcFBlgm4nH8ZEg0rUX6cZvLIpINfUmZ3SEc1yn
         it1Q==
X-Gm-Message-State: AOAM533QyyniQUWANzYrnEJZhKrFh25HOKHWRMVEnd8QXsTbJQOJcwg4
        sXv23qHhhg196rKwc1rQt4P7Xg==
X-Google-Smtp-Source: ABdhPJw07pkMlp/wa7hOyU26GePo2LXD56vW96vj5Sk6xZIiiPoUrxPmL1/QeYsYtlYpnqzeZtt8VA==
X-Received: by 2002:adf:97d2:: with SMTP id t18mr3944967wrb.228.1610562524885;
        Wed, 13 Jan 2021 10:28:44 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id b14sm4485354wrx.77.2021.01.13.10.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:28:44 -0800 (PST)
Date:   Wed, 13 Jan 2021 18:28:41 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 13/26] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <X/872aaC/E4MwMa6@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-14-qperret@google.com>
 <d55643ea391f73a2297f499f3219ba8a@kernel.org>
 <X/8CR5eXGGccFjaL@google.com>
 <X/8FFKOLOVD9Ee2F@google.com>
 <e09900ba30646cf23e1683a2ed16078f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09900ba30646cf23e1683a2ed16078f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 Jan 2021 at 17:27:49 (+0000), Marc Zyngier wrote:
> On 2021-01-13 14:35, Quentin Perret wrote:
> > On Wednesday 13 Jan 2021 at 14:23:03 (+0000), Quentin Perret wrote:
> > > Good point, that would be nice indeed. Can I use that from outside an
> > > __init function?
> > 
> > Just gave it a go, and the answer to this appears to be yes,
> > surprisingly -- I was expecting a compile-time warning similar to what
> > we get when non-__init code calls into __init, but that doesn't seem to
> > trigger here. Anyways, I'll add the annotation in v3.
> 
> That's surprising. I'd definitely expect something to explode...
> Do you have CONFIG_DEBUG_SECTION_MISMATCH=y?

Yes I do, so, that doesn't seem to be it. Now, the plot thickens: I
_do_ get a warning if I remove the 'const' qualifier. But interestingly,
in both cases hyp_ftr_regs is placed in .init.data:

  $ objdump -t vmlinux | grep hyp_ftr_regs
  ffff8000116c17b0 g     O .init.data     0000000000000030 hyp_ftr_regs

The warning is silenced only if I mark hyp_ftr_regs as const. modpost
bug? I'll double check my findings and follow up in a separate series.

Thanks,
Quentin
