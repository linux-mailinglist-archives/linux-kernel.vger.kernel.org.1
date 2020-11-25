Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9B2C4438
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgKYPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgKYPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:41:58 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C95C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:41:57 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so1896283qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJQ2hLwoYKnLT/mLeaSf+xgCMRB9d8OpY3uJGRpDrh8=;
        b=nuSjByGqfM0DLOPHS8807/d2MHwZyQ0oMMJcegcmic4Jy1ihsuYDkdrbQzDnrQ9q2T
         HJ0PX5wyfoeAyfEC10mav6bnWlqqySIplmsuTG7QK2JfK/URX4sdDuNt6Rr0xUtzvPtE
         Chs6DLzUgP4cJiJoOWafEYZgCKU/EZ/fFxIkkKdpBPjUKkDxMF69psIK+4VrAghS7Zek
         tfa5NJYwkr7MPK8nohTHTDXnnq/40o6x1lsycNv1fZsecnnshQpG5mvx0T4dj95UmQGk
         ljmFWunS4mOE9UvlQLw1Kpfc+L5smnqYbCx7gcLpoAPgc19ixzF2GffUHQkrEKr3C9Jw
         OYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zJQ2hLwoYKnLT/mLeaSf+xgCMRB9d8OpY3uJGRpDrh8=;
        b=CCR4Bb6toyWL+4V4jXtJFgPoJheZmgbXXCJEsSHMURfzRrhUkmuzlIAnvUWtwKkSr2
         ZTljLamm0XTPInTnET6VpQHQq0IWp/+TRzQUizJQtEUfoKuhDndmgz8wG8NdXubBex/8
         pW/1gMDUWhbO/QsEO3/3Q9Lm/8d/pkkTpA+jjIJsEJi5Q1ZNhFwTNfedhcNWYszycL6O
         cQpzSNYewfEojtOnHm3Ymc01rXZgyiuT8idvsNOtFshNYDGKXAq/eEck7mNJj75sbn4d
         WH+Wx4iglvYssUIZihVItJOk5LGmbeaBNoTh+4U7CTn+kuloM3vUvJiN2+mNERfzGwtC
         I6+A==
X-Gm-Message-State: AOAM532rq8ubWSWiiJXOU0bgZ+D0u8NpdyWvMDMKlvaN9VvZz9MMb8AH
        ozb9wOurc7J6RE4OJP830bE=
X-Google-Smtp-Source: ABdhPJzlDG5z/jwneHQe+Gy56zmcIiQjlk3cCKzARF175d58GjbcAuixAtHHERx3PCVRr/TXMWBn1A==
X-Received: by 2002:ac8:4a8c:: with SMTP id l12mr3634691qtq.7.1606318916838;
        Wed, 25 Nov 2020 07:41:56 -0800 (PST)
Received: from localhost.localdomain (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.208.110])
        by smtp.gmail.com with ESMTPSA id z88sm2800542qtd.46.2020.11.25.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:41:56 -0800 (PST)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Wed, 25 Nov 2020 10:41:53 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        catalin.marinas@arm.com, kernel-team@android.com, x86@kernel.org,
        tboot-devel@lists.sourceforge.net,
        Adrian Huang <ahuang12@lenovo.com>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is
 forced on
Message-ID: <20201125154153.GA29929@localhost.localdomain>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
 <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:05:15PM +0000, Will Deacon wrote:
> On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> > After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> > domain"), swiotbl could also be used for direct memory access if IOMMU
> > is enabled but a device is configured to pass through the DMA translation.
> > Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> > if "iommu=pt" kernel parameter is used.
> 
> Applied to arm64 (for-next/iommu/fixes), thanks!
> 
> [1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
>       https://git.kernel.org/arm64/c/e2be2a833ab5

But tboot never ran on ARM. It is a Intel specifc.

I think either me or Thomas should take this patch.
