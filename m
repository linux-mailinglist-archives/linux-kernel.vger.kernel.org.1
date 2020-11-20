Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474AA2BB0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgKTQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgKTQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:52:34 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:52:34 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so9526135qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zg6zl9X6YJy4l7Imn9Y9548H4d9zP5iPhLHw2KjR81I=;
        b=KYTAe23ZfGGHGNAGHpdYB3UZEe8FVCqTVCQmDrAaYYcXWlNJH5iP+0o9R7u9ErRxc0
         8UTAiYyqjuJRoip43grTiRnshuQTsLEGjeAode6kQusufUzWWcu9lNzMRs+SLByYtcJt
         0Wcjmpr74BVpkZ7AnCaZDkUrMmpDol1ArR8LZuK45lIOENZv3uEJjL7p8IaCD9UG2lZ4
         TUTGLuu7SrwiZDu1Qx52MZrXN+igJ3dVBgYr4hDrHGE87Gw1paV6aElVEbHB5/ViuBqz
         Yl+FlX9xWX5xpbQNHtKJyEL5OyJsEbcDzUKY73y3RrF04mSR9lIjLrVS7LrX4RSucrk6
         H1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zg6zl9X6YJy4l7Imn9Y9548H4d9zP5iPhLHw2KjR81I=;
        b=pbPrXnqNwaYUv3lHaHDIoA1pSB3E4PqnQk2kgF62gXjN/DyTs2HywOMCWM4QQ3Gbi9
         JwDhhWZT4ntLmb1xaKJ21DvS6PAgB2RDQQiuhK3XZtCf8g076oSxceiHByVUOdEGP9aZ
         xY16CjrHSJ/wmD4sPiNzAx2UhMD8w8oRQQG/HqIljMIKZJmvz/5puPn5YItLc/DeUAAW
         FnBEyBk9EZWaySFjmIvM0tlTVRYTRxvYxMsoNXPMjVMFewZDnDMStnamynP69671aM2j
         jScIuXjT63BCQpVZZ8fj5CgR49C35jtOJoFfbtlzjAlqhN3sZncLoe4tancw32z5Akyu
         d2UQ==
X-Gm-Message-State: AOAM533sVdePmbHtK27575xYmdxqchlN1JPF40HI3KFGaI1d8pZPU8+X
        hEprRuPWkmlV8rIBBLnTBxo=
X-Google-Smtp-Source: ABdhPJzQXE8TGuFjICs2cksSw1/J1lR2Og/k6v3kk7zVcez12b9Lg4Iso3TVZEA0vEu0e9mBnNPnxQ==
X-Received: by 2002:a37:aa93:: with SMTP id t141mr16890603qke.400.1605891153722;
        Fri, 20 Nov 2020 08:52:33 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e6sm637759qtb.57.2020.11.20.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:52:32 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 20 Nov 2020 11:52:31 -0500
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, peterz@infradead.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH v2 08/12] x86/paravirt: remove no longer needed 32-bit
 pvops cruft
Message-ID: <20201120165231.GA1074066@rani.riverdale.lan>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-9-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120114630.13552-9-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:46:26PM +0100, Juergen Gross wrote:
> PVOP_VCALL4() is only used for Xen PV, while PVOP_CALL4() isn't used
> at all. Keep PVOP_CALL4() for 64 bits due to symmetry reasons.
> 
> This allows to remove the 32-bit definitions of those macros leading
> to a substantial simplification of the paravirt macros, as those were
> the only ones needing non-empty "pre" and "post" parameters.
> 
> PVOP_CALLEE2() and PVOP_VCALLEE2() are used nowhere, so remove them.
> 
> Another no longer needed case is special handling of return types
> larger than unsigned long. Replace that with a BUILD_BUG_ON().
> 
> DISABLE_INTERRUPTS() is used in 32-bit code only, so it can just be
> replaced by cli.
> 
> INTERRUPT_RETURN in 32-bit code can be replaced by iret.
> 
> GET_CR2_INTO_AX and ENABLE_INTERRUPTS are used nowhere, so they can
> be removed.

As a heads-up, GET_CR2_INTO_AX has been removed in tip:master already by
  31d854603305 ("x86/head/64: Remove unused GET_CR2_INTO() macro")
