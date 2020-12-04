Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42F2CF314
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgLDRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbgLDRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:24:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40DC061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:23:45 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i38so3909618pgb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WouF/R4Cd2LyxxV7z86Vkq7nHzH5U4tjeGKOIdAOSZI=;
        b=vCa7we0T8LoPDRbZGF6HCVnz4ZQ70vNQ3HMzMqFRO07cgdW1jfX2BFcCSCO+stmuHg
         +R2n8wHxuNuHeNDvhUQmrxjv7bcsn22FR0jv4/rnY8bxFC6eQn9RFiwL7vM8++YKCerE
         TmyTwPD5NXSCsurvYmBIQINgnhZAIeH9WfEEbaaB7mcofomJmSRd9HGaZCfrYwO5I1P3
         YIpLu/5knUyerjicE4+FI0dfTeh0SEX9b9gfj3MOepDGp7IWf4m6r6QNXuVtAqLkm93O
         0OzAMhzWYy4CDqEpstL7lbozrr1M0KYbPAOSvDuy4g62ZeeL0ydYi6+5LkdE7qTjzlgW
         +t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WouF/R4Cd2LyxxV7z86Vkq7nHzH5U4tjeGKOIdAOSZI=;
        b=MWe0zfg26fJb4A3RBLVxX/XJktz8JxpDkCE/EINmyCccVkZM8n8uHbpR+CxQ4fhD3M
         IVZe+UPf4TWG4FNTvWxUzeQXmsBueeqe4AWee9P7fqAZJBNkbTMAYhumO0xfhKoaQDeU
         qgQLYE7T1aDfvS7zGMtIDmE7d1AaJDNZ5jiHmV3aonvDUrxjxYjIQhIq9W9Fvdky79ET
         LRAyFiRhXzDwbjgNwBvOkIHIjCZ7a3KYtQ5kLrMld072zVsOCRFvm7/L/tQTtxPj+7v4
         OEnRWEULyfUr0WFLy43iiT1v6ZSePHg54jUal09FaF1xLy5jyNvKN03bV6/3V/N+adz/
         dbdQ==
X-Gm-Message-State: AOAM530EuWaBippdV8/yj5xw9D5TF05aXcFg/pjWBo+HgwIHE8FHDUQB
        AFb6jDJxj/CBa0mPv08atcbNUg==
X-Google-Smtp-Source: ABdhPJwaGb1XnvsKSRn1ldFwBL+xmrZuZeZk2d9iZbLwsayrfg6eOUnrJbqLDppNT+4vndT+shzYiQ==
X-Received: by 2002:a62:7d90:0:b029:19d:917b:6c65 with SMTP id y138-20020a627d900000b029019d917b6c65mr4815006pfc.28.1607102625291;
        Fri, 04 Dec 2020 09:23:45 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id q21sm4386288pgk.3.2020.12.04.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:23:44 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:23:38 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Thomas.Lendacky@amd.com, bp@suse.de, brijesh.singh@amd.com,
        hpa@zytor.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rientjes@google.com, srutherford@google.com,
        tglx@linutronix.de, venu.busireddy@oracle.com, x86@kernel.org
Subject: Re: [PATCH v8 13/18] KVM: x86: Introduce new
 KVM_FEATURE_SEV_LIVE_MIGRATION feature & Custom MSR.
Message-ID: <X8pwmoQW6VSA2SZy@google.com>
References: <X8pocPZzn6C5rtSC@google.com>
 <20201204170855.1131-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170855.1131-1-Ashish.Kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020, Ashish Kalra wrote:
> An immediate response, actually the SEV live migration patches are preferred
> over the Page encryption bitmap patches, in other words, if SEV live
> migration patches are applied then we don't need the Page encryption bitmap
> patches and we prefer the live migration series to be applied.
> 
> It is not that page encryption bitmap series supersede the live migration
> patches, they are just cut of the live migration patches. 

In that case, can you post a fresh version of the live migration series?  Paolo
is obviously willing to take a big chunk of that series, and it will likely be
easier to review with the full context, e.g. one of my comments on the standalone
encryption bitmap series was going to be that it's hard to review without seeing
the live migration aspect.

Thanks!
