Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919EB2B96C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgKSPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgKSPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:45:53 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:45:53 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gj5so8554143ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45e0VgNBbvYnn00UZUV/75YCSw3FH7awq7f1yZmGnIA=;
        b=yd+dDD5sCyrZHocr/ApiPlXl8Vodq1TGFhwOHBFO8f6IhOtQwsioH35yKK7UONHdH5
         TitQsHK6lA8fYRer+u4YnGR1szOVLD1j7PQF214pS7Ce6d2fyplN4xEO63Z0fMf+eo5F
         +D7s7HaiYkc1/gXas5BwAL1r0YHLx3mzjYUBJ3VVkquNN71MOzWoSStwN2EHOedXyFIr
         Ro9F1WQY4P81qMbCgNbC/Ev/imG/WmHAd4i9hs/qUPN2WgCzFgjiXtJGT7k0K/b08nuD
         3c0yMqnN3mBXKuySRziRYw0DuO4lMXk7AGWqZHMjPIhhmOGjOj8ao0ADRhK4NexKY+xa
         jw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45e0VgNBbvYnn00UZUV/75YCSw3FH7awq7f1yZmGnIA=;
        b=bs0PFlO9f0X5rgSHbODPC6qDLIIdOKwhysTh0XL6qQapidZCP1WiVoaBhyPJiNgf51
         G/I07P7C2l8zwSmY54g/8z66tO7LiVJCC5lnuqJlK1OPmrnSlZfW+CnxV8J8qx9mqK5P
         MIOAqqXSLp8wgwBfUM4v4s8TWeNnYEuojGEehCCNBJTUkxsoQ6gK20kCMqWYEgZsWR1O
         nMyXfF3f2YFdS6XDUbONf1t4NwBpWpndcGw1cy0HVX7tNVFuHzeCIbtJ7HqK92Lf3nER
         U/0fjMtCuemZY0XyTSuHv/eKmgfQV89OFotTZaEsq6MQ17Gzxlkt5adxrapNpROe7V2p
         KxEg==
X-Gm-Message-State: AOAM531qkC5b7YP8PgHmi92qpm88p+k5WP9QNLcIUXLnHSlJ7uoU3mJw
        e+JpGzlP/1m2hI5cNxGPQOeDvBQQYK/R2BXLpb5K6A==
X-Google-Smtp-Source: ABdhPJwerYJJayn5lWpV2YdXL6eFXH1urcMvWimgMV3daCqtLlvmtu4pEM2RJAtpVko5A8pZi6+uXKrICI4dBfpc4FU=
X-Received: by 2002:a17:906:6896:: with SMTP id n22mr30365553ejr.56.1605800751989;
 Thu, 19 Nov 2020 07:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com>
In-Reply-To: <20201119153901.53705-1-steven.price@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 19 Nov 2020 15:45:40 +0000
Message-ID: <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
> This series adds support for Arm's Memory Tagging Extension (MTE) to
> KVM, allowing KVM guests to make use of it. This builds on the existing
> user space support already in v5.10-rc1, see [1] for an overview.

> The change to require the VMM to map all guest memory PROT_MTE is
> significant as it means that the VMM has to deal with the MTE tags even
> if it doesn't care about them (e.g. for virtual devices or if the VMM
> doesn't support migration). Also unfortunately because the VMM can
> change the memory layout at any time the check for PROT_MTE/VM_MTE has
> to be done very late (at the point of faulting pages into stage 2).

I'm a bit dubious about requring the VMM to map the guest memory
PROT_MTE unless somebody's done at least a sketch of the design
for how this would work on the QEMU side. Currently QEMU just
assumes the guest memory is guest memory and it can access it
without special precautions...

thanks
-- PMM
