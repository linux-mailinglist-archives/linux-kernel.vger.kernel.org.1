Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB93A2F856B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbhAOT33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbhAOT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:29:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D98C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:28:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t6so5223249plq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o173Lqk2c5CIYKhQy47SbWBS4LsgYs9/wPlGKEJUhZQ=;
        b=Uxl89bKbQ0EJR0bwVVwTY620vZrEk3wZRGOZUtb7fVjLryPulQ5OtdOqb+1ATwurxm
         jaFVqeUUm7pucJzBnd01cP9RttMAcnikELQ2DYPIl6O1HzoqZbTk1xFfAKAftpvfKQ0f
         LTRlvzC1Vk9G5OXXo5JeOM+CD9AiPFP+ZCAjkd+nmchQsRtrmAWrVG9UDvvdz2bLlgab
         8326RLbVcbuBFJvj54++CN8KsAUK50CCfn5YqvMFNshYFtIj4y5+c4tYWXGCBaEvcd0X
         JiR94/XOY/Ncxv7SEmmc958sKD+oZRx3v1FtXBzBHaxpOTaS3O3KNpOgnF4v71AN3+BS
         N0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o173Lqk2c5CIYKhQy47SbWBS4LsgYs9/wPlGKEJUhZQ=;
        b=atF0jgVreMutFX/F9Uf+EDpmWXyt03F7BOe0ZeyF/s7m0TqyOCADBiO9g6HubDau96
         Mxge0YYWOLhF3XwKLOPiPDRTN/RBPPt5iYfMm+p1uPVHTsiOm6wNpzP00snCOE3TE8Xz
         G4CVRd2gGlhN2dJoEVE/gwgPrsBZ7OQ2SNU5d0zk9AT5VBZhuwfy1EVfB6hvUBRi3p9l
         f2suCORbT+wNkA7Fm45kIiVt2csXDTStkIWhsheuyXcAfYZsV106SAuhu2cYlAQnK4ce
         TrxUx2zHMf4C8Pt6mGQ0IqwhYdKzWSJBaHNznG0I4wBgel+RTJrKiJcw9wzVrIuSI7fD
         NrKQ==
X-Gm-Message-State: AOAM530Kwd2AcGIW+B5hVmTR57ADMy95eDRy3izhKMj1Kbc7jJyJgeml
        y73Uts2bQJaO+bGvkvB6QEx/Ag==
X-Google-Smtp-Source: ABdhPJwfOsX4Wx5vyNX8XtAaos1vkW6wGTM5tGYWH1S5rzy+SMeefHNe8U0GzG04aTWa3jyis9E4uw==
X-Received: by 2002:a17:90a:5581:: with SMTP id c1mr12238856pji.86.1610738927523;
        Fri, 15 Jan 2021 11:28:47 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id b6sm8319056pfd.43.2021.01.15.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:28:46 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:28:40 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/3] KVM/VMX: Use try_cmpxchg64() in posted_intr.c
Message-ID: <YAHs6KDoc+O50beV@google.com>
References: <20201215182805.53913-1-ubizjak@gmail.com>
 <20201215182805.53913-4-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215182805.53913-4-ubizjak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020, Uros Bizjak wrote:
> Use try_cmpxchg64() instead of cmpxchg64() to reuse flags from
> cmpxchg/cmpxchg8b instruction. For 64 bit targets flags reuse
> avoids a CMP instruction,

It ends up doing way more (in a good way) than eliminate the CMP, at least with
gcc-10.  There's a ripple effect and the compiler ends up generating the loop
in-line, whereas without the "try" version the loop is put out-of-line.

> while for 32 bit targets flags reuse avoids XOR/XOR/OR instruction sequence.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Reviewed-by: Sean Christopherson <seanjc@google.com> 
