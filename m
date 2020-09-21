Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADC272929
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgIUOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:53:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:53:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so13093150wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLIpTokF5jH+Cz9jMCvpZNnuTjedIPem/C8z7mI3oKI=;
        b=HDivceJohFIuElY1wucrL0+CCkoN3NxC4fZ2p+cpfAhTpCX8Ba1gW2mU/mb9AZnrVy
         sh5JgT47h6unJ4NIwLvXXd+mYlgzOTkWD8+V0qr254r533XNstBtXXjf2BUt0Buf/c94
         QhK6X5z4cXqkxdrcdWiT+f0jXSBZkeho3CHQfFTh/xnM+R0Zwca4UumZUkUmi9OKwKFa
         utiKl2UGXR17nPOg6w9G9eKfMfQ4F9o2VimjLOHh6XoS8VegLhy6trOFMCAQAGONr9/i
         t9IKGkdrn6clTQLtqBtZlvnvEJjYBqz9b12iH0Vj+gzNP23jYjxlfLO5q4/04R2TNUhh
         d3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLIpTokF5jH+Cz9jMCvpZNnuTjedIPem/C8z7mI3oKI=;
        b=sm2DF24fchFPxH6hwovEoUEHyfWFWKvqvsCxU1MGKMKpXIKAlhtkOfNjuGm+BI52JM
         ABM7N7seG/B2GNxi6MBaYsaxBhSHd9dlsJ1fHuSvQEwBwcYTX/UaSXYxTL+5NmmgP5tN
         unJFCovLOzxp5Ad6H7YEgjlUEbIjxXa73ITVgAs5DW7/EQ1sRRAqWbVeR4wrH5cWBHEj
         D4F+ut4ifJwZtrOI9Gsw26yYeeETnRXQUbD/tutCONFLM9hGIMDzDDn5y6ZnB51M+deQ
         QG0RXtQ/n10F3CC9LqVdvouaD3NrYmhYiJre59C+26rCu9JEenLyZkf+nPEhBRN2qhJV
         nFiQ==
X-Gm-Message-State: AOAM532WjatRvXOlfnzKoNpE2UyLtEcSxm9Vm9T3xI+F8l48cOdyBnYK
        TQE1rxc/6KsUmYX70w26lvzP0Q==
X-Google-Smtp-Source: ABdhPJzLD5pzZxn6lfDyHx+GkKqw6AZgDKziMzh+yFRg4+M/CAMHQNV666TSafzDoBpxyLcZibJWTw==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr119183wrr.235.1600700002841;
        Mon, 21 Sep 2020 07:53:22 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e5b6:fa6a:5f89:97d3])
        by smtp.gmail.com with ESMTPSA id m10sm19281942wmi.9.2020.09.21.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:53:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:53:20 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 05/11] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200921145320.2b2ipdj6w4morjc3@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-6-dbrazdil@google.com>
 <20200918090533.GE30834@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918090533.GE30834@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> Cosmetic, but I think it would be cleaner just to define two variants of the
> macro here:
> 
> #if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
> 	.macro  this_cpu_offset, dst
> 	mrs     \dst, tpidr_el2
> 	.endm
> #else
> 	.macro  this_cpu_offset, dst
> alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> 	mrs     \dst, tpidr_el1
> alternative_else
> 	mrs     \dst, tpidr_el2
> alternative_endif
> 	.endm
> #endif

Sure.

> (and should we have a shorthand __HYPERVISOR define to avoid the NVHE || VHE
> logic?)

Happy to add this but let's agree on the details.
 * name: just __HYPERVISOR or __KVM_HYPERVISOR__?
 * defined where? I'm wary of defining it in a header file because then sombody
   will forget to add it and 'ifdef HYP' will be skipped. So I'd put this as
   another '-D__HYPERVISOR' in the build rules. Do you agree?

David
