Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3D2F8210
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbhAORUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbhAORUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:20:19 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E46C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:26 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 30so6410374pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rPLKPt0VQ4+unsIKAUL2ccIFdgHScwBa0BHWtMeCaQ=;
        b=fg1Of9Vjro2cfzgy+s6U/Y5YtzhGeyfXQxxEEyuTLVFvlxNs5UkieutRZUNDPs8xGL
         +nLzyhj/egouWIH2eKVB/SsKq1kM4Bi1yM5TRJWk06iADOwzxNn/GS+HbQI3y5KRDgDx
         8MNg0I3g4YEViiYx4ZNDxbm+WIWefyijuevLJqXWP7pWY5bueXd/fmE3Vu1wpHsUGPaY
         e1v3CTbX4jPjqK30NmBO/X+yboY2/79Zpc2LXtnORozErDvFpl5Y7Dck5Nt1ivdRzKsx
         mP5KYHzAs+bwDNFJpGgX4zWCnpJhOGej5kpwEIzxmH7Rer2WNpIDCP6G/rglJejSaeqx
         RYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rPLKPt0VQ4+unsIKAUL2ccIFdgHScwBa0BHWtMeCaQ=;
        b=m19LjpiDmttpqqZ7TuSImbY9AIMPYTzdcrVXE56h+ODeWRpJL8ug8SK/GwuG5+9sz1
         vAmuG/BStB+F/Ak174jq1H/LpaqjtefzSrcJSRikc/yfIBG8IftXycgaezfD0unfAQ5w
         QibrKPqK7bZx6uood8YsrNpxrEvUMNSnKxoy1VqVfbCNMvTkcHNL/bnoDqaDIpOvKJyR
         Iz7SLgy2ocolnzIovbdJw6BHq6OUs2dLi25o5RhvgCAYz1FyXfwCKdJMphWWTaJnehKv
         iXo+s6hy49n6/7FpxeVh1TGG+xNVGX1UGbfJ8q1UrAurYvuMPVqC9WwivkQb8WCIZbIl
         MnBQ==
X-Gm-Message-State: AOAM530vPtxjwauHIt55LFOZhHYWzUaBkUQOR9TnFe4dwa8ViBjc+TvJ
        9HLzC6GzOhZJMgrxaXKyhAWWSw==
X-Google-Smtp-Source: ABdhPJyZbsDt4afDbn1ZRQrnfAincv6Sl008N0zH+rF92bq/FDIMAxILr5SoMbayZ/XwpZDdP80EnQ==
X-Received: by 2002:a63:1602:: with SMTP id w2mr13879083pgl.128.1610731166260;
        Fri, 15 Jan 2021 09:19:26 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id bx17sm8897034pjb.12.2021.01.15.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:19:25 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:19:19 -0800
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
Subject: Re: [PATCH v2 14/14] KVM: SVM: Skip SEV cache flush if no ASIDs have
 been used
Message-ID: <YAHOl/ghOZKJcI1o@google.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-15-seanjc@google.com>
 <fa048460-5517-b689-3b82-a269e1ff8ea6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa048460-5517-b689-3b82-a269e1ff8ea6@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021, Tom Lendacky wrote:
> On 1/13/21 6:37 PM, Sean Christopherson wrote:
> > Skip SEV's expensive WBINVD and DF_FLUSH if there are no SEV ASIDs
> > waiting to be reclaimed, e.g. if SEV was never used.  This "fixes" an
> > issue where the DF_FLUSH fails during hardware teardown if the original
> > SEV_INIT failed.  Ideally, SEV wouldn't be marked as enabled in KVM if
> > SEV_INIT fails, but that's a problem for another day.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/sev.c | 22 ++++++++++------------
> >   1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 23a4bead4a82..e71bc742d8da 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -56,9 +56,14 @@ struct enc_region {
> >   	unsigned long size;
> >   };
> > -static int sev_flush_asids(void)
> > +static int sev_flush_asids(int min_asid, int max_asid)
> >   {
> > -	int ret, error = 0;
> > +	int ret, pos, error = 0;
> > +
> > +	/* Check if there are any ASIDs to reclaim before performing a flush */
> > +	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
> > +	if (pos >= max_asid)
> > +		return -EBUSY;
> >   	/*
> >   	 * DEACTIVATE will clear the WBINVD indicator causing DF_FLUSH to fail,
> > @@ -80,14 +85,7 @@ static int sev_flush_asids(void)
> >   /* Must be called with the sev_bitmap_lock held */
> >   static bool __sev_recycle_asids(int min_asid, int max_asid)
> >   {
> > -	int pos;
> > -
> > -	/* Check if there are any ASIDs to reclaim before performing a flush */
> > -	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
> > -	if (pos >= max_asid)
> > -		return false;
> > -
> > -	if (sev_flush_asids())
> > +	if (sev_flush_asids(min_asid, max_asid))
> >   		return false;
> >   	/* The flush process will flush all reclaimable SEV and SEV-ES ASIDs */
> > @@ -1323,10 +1321,10 @@ void sev_hardware_teardown(void)
> >   	if (!sev_enabled)
> >   		return;
> > +	sev_flush_asids(0, max_sev_asid);
> 
> I guess you could have called __sev_recycle_asids(0, max_sev_asid) here and
> left things unchanged up above. It would do the extra bitmap_xor() and
> bitmap_zero() operations, though. What do you think?

IMO, calling "recycle" from the teardown flow would be confusing without a
comment to explain that it's the flush that we really care about, and at that
point it's hard to argue against calling "flush" directly.

The cost of the extra operations is almost certainly negligible, but similar to
above it will leave readers wonder why the teardown flow bothers to xor/zero
the bitmap, only to immediately free it.

> Also, maybe a comment about not needing the bitmap lock because this is
> during teardown.

Ya, I'll add that.
