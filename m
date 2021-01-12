Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BC2F37CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbhALR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbhALR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:59:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:59:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v3so1788545plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=grXql6ibUJFOsCgtiRD1gKx//WLo/yRlRDyQOiQvVj4=;
        b=HU93kS0VfrnUI+tcG+vRe6W7nDUOyWH/9TdtVxsVCRqWG7n8tIQRVWZ9WG4veZlt1O
         gsm1lt07Z7IFk/Utb+uNMs8YZaOfyb8dR/ywreYh4T2eWgGCuG6E5Ooi97eWUbjoEtGb
         whuZa22zC76oOq8NtrbQMVvw+Af8ZLg91CPTcVoqwkFsa7FHZOeIgEHqCOtb23LAq0Fh
         Oj8nnFe+PerADiRocKkt6UOvd/ssBbPU0ra1OrMo2D6OGyM2/0yWopdBlwODGYC4h+CL
         YXe393PqZBH6Dsi41LJHZBjiHU269eENnBU3sG5CmIcR4nYyTDDDYtQy6EAjBk/6Ioh6
         0p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grXql6ibUJFOsCgtiRD1gKx//WLo/yRlRDyQOiQvVj4=;
        b=IPBZgNV70+yT0P2l/8QExhC/nkqJ0zfIGe9wlHaEfL0uCgrki/ltUf6Qo9UVHCBvcP
         RveYD8/7eti1CFeXHbFea0nwWY0yZn1wkvObRmnKWSAzGXokMK4xlR89IWymxRLhfTb1
         7MQU2NMQCQASHczSRRtoN6CEdp1FLSjwohh7LEm6s8czpN0GQMIiEu7jy00vALaNCxIY
         XKRDJoHzoUYkApISb84wZxyeO6dv3wX8R9AvTbudgbKbLXrht16BXOv8X4LbekYmDStQ
         BnNRKW7++g/y4tjX4RygYQSuqT3BMrfsZUtfnr2nouyS+NwdI4yy6rTiACRR6ckalOkA
         pLyA==
X-Gm-Message-State: AOAM5324xohNA5n6FtYbjr4q0LrXYAiR+5FcOgDplPexZd5hQHRF40m9
        79qZN325Ov4NWecVafQw+ZoIqA==
X-Google-Smtp-Source: ABdhPJxfijRpNhp3G6Q7Jadv95T1ELKq2e8/4gf6kFHXotmqdFYy53ncCHlWzum82AmZEe4Qh7dl0g==
X-Received: by 2002:a17:902:f552:b029:de:1d8c:51e5 with SMTP id h18-20020a170902f552b02900de1d8c51e5mr172967plf.8.1610474353890;
        Tue, 12 Jan 2021 09:59:13 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id c3sm4029239pfi.135.2021.01.12.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:59:13 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:59:06 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH 1/2] KVM: x86: Add emulation support for #GP triggered by
 VM instructions
Message-ID: <X/3jap249oBJ/a6s@google.com>
References: <20210112063703.539893-1-wei.huang2@amd.com>
 <X/3eAX4ZyqwCmyFi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/3eAX4ZyqwCmyFi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021, Sean Christopherson wrote:
> On Tue, Jan 12, 2021, Wei Huang wrote:
> > From: Bandan Das <bsd@redhat.com>
> > 
> > While running VM related instructions (VMRUN/VMSAVE/VMLOAD), some AMD
> > CPUs check EAX against reserved memory regions (e.g. SMM memory on host)
> > before checking VMCB's instruction intercept.
> 
> It would be very helpful to list exactly which CPUs are/aren't affected, even if
> that just means stating something like "all CPUs before XYZ".  Given patch 2/2,
> I assume it's all CPUs without the new CPUID flag?

Ah, despite calling this an 'errata', the bad behavior is explicitly documented
in the APM, i.e. it's an architecture bug, not a silicon bug.

Can you reword the changelog to make it clear that the premature #GP is the
correct architectural behavior for CPUs without the new CPUID flag?
