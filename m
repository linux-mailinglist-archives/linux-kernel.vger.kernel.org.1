Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22EA3011B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbhAWAaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhAWAaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:30:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:29:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 31so4202645plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYV4rqk7TIJOls4aIYOUfgRgv+FJ3Bybe0z5zvt0O7Q=;
        b=El3nUfopMydRnCl9GOyvd5cxCak0al5FXcbT6BiVzxoyts5vmsuAa4eUFOTzbUIlp6
         GVZzkro3xnR49VaHW3drFk4t+/eTDBPxIjl2nOT+xZuAUlCe/B3SHZcdpSaqwXDL6ykg
         7mG55vp4pb0wuZPlFnuhZswUdQMi/EAN2WTlOT52gAcWuhs18ENKphCjt8ZjDAR92x23
         pkT/xCeFIoZKW074PTlX7eKG4SfBVFwwAFKg7sgZRJa/Q3rtMD6P3FbVGkvlrD2iC3Pf
         ZEkBHjaSvF+Ql1/7LKzJAkGxyd6jjZNx4EYGtkRUs9dRdm8Kk70rZ8oHGX5INX0JbOLb
         PsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYV4rqk7TIJOls4aIYOUfgRgv+FJ3Bybe0z5zvt0O7Q=;
        b=DyWPho7aYMARbykTfCBENQsIa5p4xm1+Sk8+vzkWSSWTLgHbcmzQyLk6cKM0xsKV7I
         UwncLAodzuKrwV20+aChnO8oJVI0RpOzgkegUA57uEKMbEcLH1F3erkOZbnFIDDWlydS
         fH2Fe4s+FwbFJ37kIZVU1BH3JyY5LBmdHKjr9wkqLVt3d538XP1fIUk10zHyGa1APx+Z
         3Bl3LbpPi3Ln2Mw7hnueokneUEl/wBgaYDqGBh3Hqr7STZAbcc+2igypfA+SxCYHFvF5
         Gz7IZS6FOQ/XC31SR0TkqxnuYDerdHuEV0gc02Kx5Nh+scPFoyIGr6ld+sEqosrhpVKS
         OF5g==
X-Gm-Message-State: AOAM532XTmY7jAVC6ZXouJL6jwxbzh6kjFlBpu4ldzXvaZV0CUSYlgSZ
        +la9tSHHj4zjwx9k7RioOPBNaA==
X-Google-Smtp-Source: ABdhPJyoONkEm2J9ITe4V6jvZN8X3b2s30ELlnoOthsB+837AdhIk2k9C1PL1ntyue/tv/K7/zZibA==
X-Received: by 2002:a17:90b:313:: with SMTP id ay19mr2089571pjb.184.1611361766735;
        Fri, 22 Jan 2021 16:29:26 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id x125sm9323072pgb.35.2021.01.22.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 16:29:26 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:29:19 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 3/3] KVM: SVM: Sync GPRs to the GHCB only after VMGEXIT
Message-ID: <YAtt38s4GLG9cviK@google.com>
References: <20210122235049.3107620-1-seanjc@google.com>
 <20210122235049.3107620-4-seanjc@google.com>
 <0d8e9d63-1fe9-af08-dae9-edd80083e940@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8e9d63-1fe9-af08-dae9-edd80083e940@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021, Tom Lendacky wrote:
> On 1/22/21 5:50 PM, Sean Christopherson wrote:
> > Sync GPRs to the GHCB on VMRUN only if a sync is needed, i.e. if the
> > previous exit was a VMGEXIT and the guest is expecting some data back.
> > 
> 
> The start of sev_es_sync_to_ghcb() checks if the GHCB has been mapped, which
> only occurs on VMGEXIT, and exits early if not. And sev_es_sync_from_ghcb()
> is only called if the GHCB has been successfully mapped. The only thing in
> between is sev_es_validate_vmgexit(), which will terminate the VM on error.
> So I don't think this patch is needed.

Ah, nice!  Yep, this can be dropped.  Thanks!
