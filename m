Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6372CF24A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgLDQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbgLDQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:49:37 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA82C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:48:56 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y10so1953915plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8AdjFgmyL7ev/8V3t9IYE8vKxAOr8XLB3W4oLMSs5as=;
        b=hUb+/BMQyslTyDSF1dcymxYqK4H7de1HaSTgUeemV1YId1S0iRCUMgOQ8XgL+zakEg
         tPfcgprsW0BHqR1kHcDglknHVrZ56FncBkf3oPP3Ie7lqjcHcl4hy8tDjAI3OR8uGi/T
         ZYwgLTPiAs/1kLOtB46MPCsviqyiSIyWIqRLgTfUG23RpA4Bly3AIV7/UcBV7BKLygLG
         rcYTiyNtnjb0M5BlatnbJ9bR+fCFDc104+j2l+g7sEE2Oxngn0ox+XFge0/0GZx675PM
         KkZ1kUI2owDwDGAyUQlTL4IorXlEfSx3EqpoGYSQ/E8HsiatMbet0n1zX7Z9Vg2+kOPg
         vEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AdjFgmyL7ev/8V3t9IYE8vKxAOr8XLB3W4oLMSs5as=;
        b=TMe53DbypM3Uby2HS1evji7bQEG35+z5mtoh/U+8BJQY/G905h2evcuQOsi9aLHcED
         uaeNDPGiHCOMxn3olcWOc5Yp5Q5KZVBjCuLX9kPu1LpvYKgJGdMoyQaEO9nOdMMiMSmL
         tYBVoPlqbgZtQ1vqhFq5hi7R9BaEhrVe+y0mro8oYKRWpjmLWATZeN3uBZTlnK+nfNEB
         E1hj9Bt4aJwCMg2QWiWGWCrrFCHctk6XARhggHNM38PjpzvKjKrhLESGpmreu/EXktyc
         KslRy2ZcNHdGvYeuWU6hGCmpIR1ksW/I4JvolM4Y+W3jpCYAh9DwMCL9l8XSTyeiumrY
         vYIQ==
X-Gm-Message-State: AOAM530UWX5lBPgniA+ENQ6ndCoFWZSjDRpn4oAGuXx7KhPft5vXClKY
        +YE1KFX7tkUIimJTAyXmxB189Q==
X-Google-Smtp-Source: ABdhPJwczQLTN1COgDFpa9RD9qIkFsBQuE+QyrquVeVnSqZL0RgSlRQMG9pE3v7/5e893Ph66jPgog==
X-Received: by 2002:a17:90b:3698:: with SMTP id mj24mr4700383pjb.149.1607100536352;
        Fri, 04 Dec 2020 08:48:56 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id s17sm4589354pge.37.2020.12.04.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:48:55 -0800 (PST)
Date:   Fri, 4 Dec 2020 08:48:48 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@suse.de,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        rientjes@google.com, venu.busireddy@oracle.com,
        brijesh.singh@amd.com
Subject: Re: [PATCH v8 13/18] KVM: x86: Introduce new
 KVM_FEATURE_SEV_LIVE_MIGRATION feature & Custom MSR.
Message-ID: <X8pocPZzn6C5rtSC@google.com>
References: <cover.1588711355.git.ashish.kalra@amd.com>
 <4ff020b446baa06037136ceeb1e66d4eba8ad492.1588711355.git.ashish.kalra@amd.com>
 <07c975ec-9319-dbd8-cbfe-61c70588d597@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c975ec-9319-dbd8-cbfe-61c70588d597@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020, Paolo Bonzini wrote:
> I applied patches -13, this one a bit changed as follows.

Can we hold up on applying this series?  Unless I'm misunderstanding things,
much of what you're applying is superseded by a much more recent series to add
only the page encryption bitmap[*].  I have several concerns/comments for that
series that I would like to hash out before we add a new ioctl().  I'll try to
respond next week, my time is unfortunately limited due to onboarding activities.

[*] https://lkml.kernel.org/r/cover.1606782580.git.ashish.kalra@amd.com
