Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EF2DC8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgLPWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgLPWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:03:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD25C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:02:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x20so32743480lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVPDkcq2n/WLZ6yomPRY0PIIm6Y28Hu8R8ZEQci4gcc=;
        b=FfOSNMn6BfsaQpN+0851BpFCp8KONi6y8EqO2T7gy3zX6onh6L81KKExHaRYCOq9UI
         nNvh88KW0qmGG5Y/w1FOaldtFU5Wp7UMey299zWFQF8hzJSUII4VktvUdKK5z5uxjMbT
         jpKjMw3bRpbn1s2vi3Xn+obmSw4luEBTEfyR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVPDkcq2n/WLZ6yomPRY0PIIm6Y28Hu8R8ZEQci4gcc=;
        b=YEof3JonACf+fH+ZkerULAQ15mdDFj1HLGPoxnmmEoFMdB4smR2391H3ICk+HeNDjn
         qcU6YXhn8I2/U2kzyd4IppHEHcvBOqtdXqjJNcVM365ZoTnCLhbc+ULNZzWg4cqKOFbX
         fKot9S6DoXWLZMBywLaDurLB34scL4LNrc3wtYmN/nCiRjy0eGJ/Rwr1Yzk02f32AVAi
         FY+99GLhhq2eDyXtuEFyFsk5XkDcn+FG1mmsU3iaTHQCysZDtLdqNzFgl+oQngLzVDbd
         EwrE+v4j5I1JaCg+R+0gVIHMPx0u/hrQxapvNqNhbMij23qPHxMaafbRgMymhilKyult
         PqYA==
X-Gm-Message-State: AOAM530CdjN69vUf57XTluxc54pVvIFR0frWk6r/fQzNgUDyLaBywEEC
        w2V8FXNSJvKW/v4/9rzJCo31ZJk7UDmPrQ==
X-Google-Smtp-Source: ABdhPJxB0R5E3wPxHdbdMVjyNlytLwJTNyfHiFRMfzM7KKtDFnDjCSmq0n3HMWYHCLlruXiNzVLueQ==
X-Received: by 2002:a2e:920b:: with SMTP id k11mr15102378ljg.313.1608156137982;
        Wed, 16 Dec 2020 14:02:17 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r135sm368142lff.240.2020.12.16.14.02.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:02:17 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m12so52312339lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:02:17 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr16006581ljj.220.1608156136686;
 Wed, 16 Dec 2020 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20201214234518.GA14575@willie-the-truck> <20201216185352.GA16598@willie-the-truck>
In-Reply-To: <20201216185352.GA16598@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 14:02:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
Message-ID: <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU updates for 5.11
To:     Will Deacon <will@kernel.org>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:54 AM Will Deacon <will@kernel.org> wrote:
>
> I'm hoping to wind down a bit next week (ho ho ho), so I just wanted to
> check whether this had got caught in your spam filters, whether you wanted
> me to change something or whether you're just snowed under in pull requests.

No, it didn't get lost, and I just merged it. It's just that everybody
has been very good about sending their pull request early, so I've had
my hands busy, and I've gone roughly by subsystem (and today got
around to block drivers and iommus etc).

               Linus
