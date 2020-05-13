Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011661D0FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgEMKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgEMKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:30:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F261C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:30:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so12975560wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bag3tcwUumhERwus8sd0P+tasr8YFyR1BtawoF6Jv0M=;
        b=feaPsl6PXU124jWtX3dAxdhE+71zs/uCFoegBNTyi5X4xrHvVm195995//fXp+PqCv
         bZjFrRwdqqAltQjGj+LEGmdB2M4LFIzNJiyL03Jlt8sIMAUlpNoCrt89NruDMkFjSfZD
         L2ZrhZ5A025g+OZzAClsEJCSgan0edGqEFBtkyb5dwVCwVXw2xbFrsUHhmbT3Cysxmlo
         j9qXbYdZyW+nxcOP0b8yHQl+bSw65rKtZUp8Rv7Zt5qxoYqpnKDfAmAfHTIe7SyQGKmy
         gySn77IU+kPf54X9nFVVLRVpCZrGXIN73Igvj0l6ULfFpCSQUhqDQE9EbgBMF5FyLbdS
         VE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bag3tcwUumhERwus8sd0P+tasr8YFyR1BtawoF6Jv0M=;
        b=hPMe0T+Hvzsj7EgNuD9NB07SeL5Uov6bL2NTuGl+yjklhFfSAXR51grueNgol5Gk7o
         Oz4lgX+tv7+Wk5MH5eV07wQpx6xIW5cSzcZoplLpCrorjmvHsvjXM+TxPJulrrg9d27F
         pSy2YCe0CW6JreIjy15RfkT+4zf/gCepqoqgNATil4B8Zcx104hw86B8bngwtRH1yTFM
         IMBrtzrsDOcNCW2M5RnbgKcvm1LierrfNaGQ7F7zuRW0UCLOVIQ8ZhRe/qpSVCebCFHn
         ViY33dnXSsSZvWXLmGGQQLXODkjQhhhbhmzjCmLRDfSyO8RgPsUHsFQd4OCz8XNc7GWa
         u7zQ==
X-Gm-Message-State: AOAM530Mw/j0v0OxgY97IKQqq+rypW7nCPwapXwI2u9z+V328bT4flXC
        AS2s6j2f9mRfkw2iJy3Jr/OkUQ==
X-Google-Smtp-Source: ABdhPJwieEag500N253ZjLYIuWDnNCr/RP0yjgHBqAOAFRcDDDnTfLgV5ev2GxXV9li2Vw8U//ZBMQ==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr5473936wmc.114.1589365846539;
        Wed, 13 May 2020 03:30:46 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:e021:170a:2079:28ea])
        by smtp.gmail.com with ESMTPSA id 60sm3774269wrp.92.2020.05.13.03.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:30:43 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Wed, 13 May 2020 11:30:41 +0100
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm64: kvm: Unify users of HVC instruction
Message-ID: <20200513103041.ktaov2jws72itmag@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-2-dbrazdil@google.com>
 <878si3j13w.wl-maz@kernel.org>
 <20200507143633.GA169263@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507143633.GA169263@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:36:33PM +0100, Quentin Perret wrote:
> On Thursday 07 May 2020 at 15:01:07 (+0100), Marc Zyngier wrote:
> > >  /*
> > > - * u64 __kvm_call_hyp(void *hypfn, ...);
> > > + * u64 __kvm_call_hyp(unsigned long arg, ...);
> > >   *
> > >   * This is not really a variadic function in the classic C-way and care must
> > >   * be taken when calling this to ensure parameters are passed in registers
> > >   * only, since the stack will change between the caller and the callee.
> > > - *
> > > - * Call the function with the first argument containing a pointer to the
> > > - * function you wish to call in Hyp mode, and subsequent arguments will be
> > > - * passed as x0, x1, and x2 (a maximum of 3 arguments in addition to the
> > > - * function pointer can be passed).  The function being called must be mapped
> > > - * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
> > > - * passed in x0.
> > > - *
> > > - * A function pointer with a value less than 0xfff has a special meaning,
> > > - * and is used to implement hyp stubs in the same way as in
> > > - * arch/arm64/kernel/hyp_stub.S.
> > 
> > I don't think any of this becomes obsolete with this patch (apart from
> > the reference to 32bit), and only changes with patch #2. Or am I
> > misunderstanding something?
> 
> Nope, I think you're right. To be fair, this patch has changed quite
> a bit since the first version (which did change that comment a little
> later IIRC), but David has done all the hard work on top so I'll let
> him answer that one.
They have a different meaning in the three different contexts:
	1) hyp-stub HVC: hcall ID + 3 args
	2) hyp-init HVC: 4 args (no hcall ID)
	3) host HVC: function  pointer + 3 args
The patch was meant to have all three use the same HVC routine, eventually
converging on host HVCs also using 'hcall ID + 3 args' in patch 02, but it is
a bit forced at this point. I can drop this patch from the series and we can
clean this up later if it still makes sense.

> 
> And David, feel free to take the authorship for this patch -- I barely
> recognize it (for the better), so it's more than fair if you get the
> credit :)
