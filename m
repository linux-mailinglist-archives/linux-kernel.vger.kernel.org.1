Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153972A66F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgKDPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730454AbgKDPAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604502022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6diWzy+RGM557EqcQ+SeKoKVh3DtYLPPbyK6Q8TIW0=;
        b=RUP6H9OxV9hzZ9zIwZG9GKedC1rIBDfgRH0wnMiFjP7k5uUfW7/N1VrE0giq9bdgriPQGI
        TqAKGUxKVc0sWveykkfmr6aWRJFbEaQbq8MB/CqRYgWsSTF0k7B1+rM6hfxTGaDRExPI7G
        n9Mr+COMNV2Te8j3N5G4ARKOGbzxaIM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-pKUn04bANHS_QXXtsXcvGQ-1; Wed, 04 Nov 2020 10:00:21 -0500
X-MC-Unique: pKUn04bANHS_QXXtsXcvGQ-1
Received: by mail-qv1-f71.google.com with SMTP id b13so12990544qvz.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6diWzy+RGM557EqcQ+SeKoKVh3DtYLPPbyK6Q8TIW0=;
        b=bk1pFsDI1V0v1DGz+vcQrfAwGldK1ggjVQaiKLwy3Q/q6DFY5lvkEJEsc7+s/jUUR9
         O/5CrgE9NROy3hNhA4V6Lhopvlx3drcPdGtrPlBu+kScO6ogdhm2GJsYD3COue/F1D9s
         wwodqinIkKfVRFm1sVPhgjp6cq7kKF42XwG+A9fNxE3Q7FC0sH2/u7cnLkYQicuqLMAf
         q+wSU5VghOZRQkun4x4qSQ5hEQ/doYfziia/iDwQ1N2sqDRHJnW+otZIbV+HO3/AmhyD
         hWOQuYSbRVjDyIPj+DN14l2iekKVWlYapolsLdoZUoyFGBkXed+U/Yvvb657bWYXmjvA
         qtNA==
X-Gm-Message-State: AOAM530l9E90VKiK+D676s7rtjkqZh5TyGNBx1S3LBoudlOaTYrsf99b
        skufuURT2/2N0/nTAUd76qz3Fmaeo/7/UHSxZha0myCjBYblM3QmT7D3NiRvlnljyf/tIhTNxi+
        wgtrgV7kFe0uJyL+/LULxOIOe
X-Received: by 2002:a37:8107:: with SMTP id c7mr25368845qkd.361.1604502019954;
        Wed, 04 Nov 2020 07:00:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2eY3k9i5ObOPHDM5/bO3oV4U3c5htFt8p/dm3ffz6awRll55ijhfh7CVBUmgdIdzrQQk4og==
X-Received: by 2002:a37:8107:: with SMTP id c7mr25368827qkd.361.1604502019710;
        Wed, 04 Nov 2020 07:00:19 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id g13sm266060qth.27.2020.11.04.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:00:18 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:00:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 2/5] KVM: selftests: Factor code out of
 demand_paging_test
Message-ID: <20201104150017.GN20600@xz-x1>
References: <20201103234952.1626730-1-bgardon@google.com>
 <20201103234952.1626730-3-bgardon@google.com>
 <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 01:16:31PM +0100, Andrew Jones wrote:
> If you don't mind I'd like to try and cleanup / generalize / refactor
> demand_paging_test.c and dirty_log_test.c with a few patches first for
> you to base this work on. I can probably get something posted today
> or tomorrow.

Drew,

Would you consider picking up the two patches below in the dirty ring series if
you plan to rework the dirty log tests?  I got your r-b so I am making bold to
think I'm ok to ask this; I just want to avoid another potential conflict
within the series.

Thanks!

[1] https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/
[2] https://lore.kernel.org/kvm/20201023183358.50607-12-peterx@redhat.com/

-- 
Peter Xu

