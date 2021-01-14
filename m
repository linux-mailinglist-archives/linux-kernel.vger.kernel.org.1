Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3C2F6719
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhANRNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbhANRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:13:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D6C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d4so3227128plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uF7+YDIJdbzPkf3mVtNcMBe+Aa517Jhrf7Cd5wgaCe0=;
        b=NqHhgo99bwsPMEmgsLIdj1+1y5wrwJHQKS/Nz572eS/8EogbtHZ5LsTxFoDegquG+U
         Fl4ohUIE0zUT330sDLzQOkQl9zYhbKZQWAW25uZn/VdCRIWWY+T7qPzXWztc0P//CicR
         u2rH3g69n0U+BJvpYrwXGrxkx4v9OqyxmVRu2gE5zMIVkpGOfgR2jvFgVnn81r2nq3EU
         w3lQzS+gqLViiHPoO9Qka9bS6Jlo8sdM5s87qizD9+0sIRyzljT31zFtrQ7BhguuGsdx
         CCY0iS0aUontisTjXwZdWjqa36KboOmp5GykG6PH3jrGr3rc1Wk8FA65vCeWlXm6Eprg
         izog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uF7+YDIJdbzPkf3mVtNcMBe+Aa517Jhrf7Cd5wgaCe0=;
        b=Qj+i12TFvGM6Gga7gw1EKgTnIzVgyYmj22UQmW6wecxcStWiPSy7YiOS/fSc7/NXCb
         E+AXn1+N7hTdumO7jtMRc6lruo63O366Xngotqtlr42eG57294y1G/roNB/vRpWLxlIl
         ilw6DP37s409I4aMNuv11KTPW5/iQNP9+QZCnWSNdmCYGfD7Bv01qN6D5e9b1Acpc8bM
         zlU5MfBgXgJP9iWVPk4p+JS4jYeYit1VvT+BKBqu8qrtO3kEs0xBdZtFJNa6A+X+M6u5
         nFATLVXRO+X5imGggaI130AzxH+5K/4aFyNCyI6e9rlrSWAlmbZGaN3YdMXiwosiBL08
         iiuA==
X-Gm-Message-State: AOAM5311r4x8lQNEdcmhXhwyqto5ccoz+DbfYwXXIwXQljABWBcP52v7
        x9I+P7vj6wNAuIzwU9RNz2GrJQ==
X-Google-Smtp-Source: ABdhPJwwzFrJ0+fkqtCvVI7xzPGOQ+/YVUvgQ3lMVbzIaGlq3Zm+IpK5hsuA1RtShkPZ3BQtswhe3Q==
X-Received: by 2002:a17:902:59c7:b029:de:25e7:2426 with SMTP id d7-20020a17090259c7b02900de25e72426mr8218970plj.21.1610644344830;
        Thu, 14 Jan 2021 09:12:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id f92sm6463525pjk.54.2021.01.14.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:12:24 -0800 (PST)
Date:   Thu, 14 Jan 2021 09:12:17 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2 02/14] KVM: SVM: Free sev_asid_bitmap during init if
 SEV setup fails
Message-ID: <YAB7ceKeOdfkDnoA@google.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-3-seanjc@google.com>
 <b1a6403b-249d-9e98-3a2d-7117ed03f392@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a6403b-249d-9e98-3a2d-7117ed03f392@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021, Tom Lendacky wrote:
> On 1/13/21 6:36 PM, Sean Christopherson wrote:
> > Free sev_asid_bitmap if the reclaim bitmap allocation fails, othwerise
> > KVM will unnecessarily keep the bitmap when SEV is not fully enabled.
> > 
> > Freeing the page is also necessary to avoid introducing a bug when a
> > future patch eliminates svm_sev_enabled() in favor of using the global
> > 'sev' flag directly.  While sev_hardware_enabled() checks max_sev_asid,
> > which is true even if KVM setup fails, 'sev' will be true if and only
> > if KVM setup fully succeeds.
> > 
> > Fixes: 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations")
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/sev.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index c8ffdbc81709..0eeb6e1b803d 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -1274,8 +1274,10 @@ void __init sev_hardware_setup(void)
> >   		goto out;
> >   	sev_reclaim_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
> > -	if (!sev_reclaim_asid_bitmap)
> > +	if (!sev_reclaim_asid_bitmap) {
> > +		bitmap_free(sev_asid_bitmap);
> 
> Until that future change, you probably need to do sev_asid_bitmap = NULL
> here to avoid an issue in sev_hardware_teardown() when it tries to free it
> again.

Argh, you're right.  Thanks!
