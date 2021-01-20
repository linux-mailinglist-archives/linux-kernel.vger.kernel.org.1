Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E022FDA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbhATUI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbhATUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:07:16 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF0C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:06:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i5so15973469pgo.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQbchGQKY82wl+o4TbL309jkEN0qre7XquQdqrcnNpI=;
        b=t2WzXAXK+d5diH6v6Tf6zXB6OePNdD9FnHGfiUxFtMgNyA6M4Xrmx+jkO3oroMeOhN
         yYQLs3MNmjIW2lWg6oaiZPSa1t6wWiZpok8Vf7PmlIb1CEd4iBRUO2b2PM3fPpwGDc/g
         xa6HXupPoG6OK6eMkLW4z3JC+Cr3OCvFYx7BXghViIrlipr/aEaHswAx3fsnXwYsKgB4
         l2WKPFR849OaILDuv2bkKdyFiibD9XR60vbS2ta/v4waXomAZLk97QXiOAJZw+T7KoQc
         Pcx0KLGcrReVSeu/N632kpcbhnM6ND/aHIOsnx0SlgbVQ1iFh1tm9LMa2Pc/zBF19nEa
         SP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQbchGQKY82wl+o4TbL309jkEN0qre7XquQdqrcnNpI=;
        b=Tn12s93ONPLZNALI+AvWKt3d1F077m1wExD2XVnqbXSmnXee4GLJXdSMyaz1X6Guh6
         r2eP2fiauCK1b+CCRRUjgABetVMWCVU56amgo+a53XrJopoQLEJ5k+ULOnsp2H3UC/7o
         Xsk4DPCOOVioeuUCo0j8UOV4LWENSw1qmxNYT7zzC4qWamhnJ0ciCVOIIpuxhdOnwCj+
         5CitazWfFmLxqH6FVG9qAxu5OooWS0/AvsOAHW9zJQVWaaYPeVb+4eZp9NFT3ip0BAwM
         FsKSUrHk/TMFgiTXrz+Jp1u1UoZCYcGt3a1rZiylWdvgdfv8IfEvhXcYNzNmWqUXERJx
         yMCg==
X-Gm-Message-State: AOAM5313wabafDRX6BFmgJC/i0t+EbgiC1Auxk5MddvgV92OjB5dE3OH
        TFANgQ/8/94EFOLGyK7GFgTvsO4ZmVIz4g==
X-Google-Smtp-Source: ABdhPJzLZhyZH91lMH6g/S9TFPhw2SKyEeH5hRTVqmU/4tOHhIuZEFfwCGZWC/wQ0RURsY4LFROCOw==
X-Received: by 2002:a63:520e:: with SMTP id g14mr10767120pgb.378.1611173194845;
        Wed, 20 Jan 2021 12:06:34 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id b1sm3150314pjh.54.2021.01.20.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:06:34 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:06:27 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH 09/24] kvm: x86/mmu: Don't redundantly clear TDP MMU pt
 memory
Message-ID: <YAiNQ/SgVqg+h6WG@google.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-10-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112181041.356734-10-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021, Ben Gardon wrote:
> The KVM MMU caches already guarantee that shadow page table memory will
> be zeroed, so there is no reason to re-zero the page in the TDP MMU page
> fault handler.
> 
> No functional change intended.
> 
> Reviewed-by: Peter Feiner <pfeiner@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Sean Christopherson <seanjc@google.com> 
