Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C947F2EB231
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbhAESMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbhAESMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:12:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8337C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:11:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so79590wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mjqlslKFhpl22OyaBmZj4g0pgc3R4DrFenh6jY+/zlg=;
        b=WceI8HFVOa997U2MI9Eu+Y9unaMOTxYbhBh/MhqEdqkgwWwQJ6rWBSaEGbvHAe1Vy1
         6nGQzLG62RxWw/agkbe2xbsI53w3IFEvvqowXhO+3rihVDjtRJtTURpxEyeEobZOCBkm
         EmBV5HxCYPYsW40Lc8uG6uWch4S6eG6falaA3YHCskpbLSie5ISDYfHHU0TpxGiL5eHh
         KSS4TEUZwQ07CeyupKPGmemU01xTbUN1jE85gE/4LbS2SLtWQ3GI+35sR58V/rPvIu26
         hXOFlDnQBaEj1lsz/jIMVh8nnc5DqaOffLRP+6Qcoi62Ol/r7LBBbig1x+nlRiku62J5
         3qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjqlslKFhpl22OyaBmZj4g0pgc3R4DrFenh6jY+/zlg=;
        b=S9KrBc7R4gwIfoq/0Rkbrlx40FctpYnwy865rBlVpBYaIgMef5ypkuhG4G3aDMKYzz
         0/m2G2TO12SdYKiEdxfajbB4BFD31l30I5LU2ri8H9665e35YH4t3onegk2oBx3HpFDi
         mqVvblPSCS7UEc6x1XPhODPbFAW8aVYwVxAzW59xcRKgD0Ser1OFSNHvrox9B5hA6QPT
         nvxgXwAwJlnmsVlMudXBSj9HKUZiSeLrFIr+EQVFQdY4ca8h317Ld7/JvTZD1d/p6zWW
         fxG62N8KOZiZ1oNtaW/hzKB++Yvw/E0oEhcK1i0SYp0+T4fzFVrgRBn0YYJGLcL7bG1+
         1s7w==
X-Gm-Message-State: AOAM532p20tRxrglBbn1dlG5SFShsTwsjHGCwqexX300bCvQTDX7DZbD
        cANLLmIgjrMCK1U/PxecwEN/8A==
X-Google-Smtp-Source: ABdhPJx6VD7nDs8Gm2IFloVRnDknFmlhKooLwrehv3pDL6GURFqITyiF9lVEfWxiy1mVLC3jjqtwAg==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr762040wrc.99.1609870286389;
        Tue, 05 Jan 2021 10:11:26 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id w8sm710160wrl.91.2021.01.05.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 10:11:25 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:11:24 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Remove unused variable in arch_show_interrupts
Message-ID: <20210105181124.tmhzqo2lywt2zjuf@google.com>
References: <20210105180314.64613-1-dbrazdil@google.com>
 <20210105180835.GF11802@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105180835.GF11802@gaia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 06:08:35PM +0000, Catalin Marinas wrote:
> On Tue, Jan 05, 2021 at 06:03:14PM +0000, David Brazdil wrote:
> > Commit 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in
> > arch_show_interrupts()") removed the only user of variable `irq`.
> > Remove the unused variable.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> 
> Please search the list for similar patches. I can count 5-6 and the
> number is growing ;) (and I queued one already).

Sorry, my bad. Need to get my email client out of the kvmarm list once in a
while. O:)
