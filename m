Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5C2B7A53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKRJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKRJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:25:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0BC061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:25:52 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so2280924wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X6ZFH7heqse89aEGvMmhzcbSi20z75OlSQMAgPLbESY=;
        b=qsrid+z+rmZ3dQS0wbdI0bNgj4M5MSLp+gEMgXV6pD107XERnbrCeb4fuwBhnXhhMC
         KXHYWC1kNKIJwZf7/xLoXfFqgCbE7c7yJinhL5z2ssGTC0kKTYOLhj2uVu+wJGWo5dvF
         bKfxyw2bfxI+GEnta7thOy7XNgPTU7LaBgO2AVpLbhmzaG4wPNFDr2QN527GIGPTo0Q1
         3jFoNmlWzG5xyLLI4l21CFDARG//t9l5aIqjFYnqj8/1USJfj1/jNHLBXFv2Zbu82e2H
         bDyce1abLLvAKmygjJypUQPKmCk40uitrOiVVix8cWwFTz6HsQiLudWBBn5aw365LAWr
         1Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X6ZFH7heqse89aEGvMmhzcbSi20z75OlSQMAgPLbESY=;
        b=QhpP/JZ9RwwG8z7kMK8Yl8+XLZ6bC3rwK900QZkpOlTaJ7RXugrwFPbsTcgLH00ZaH
         APEq3jALzgZietwLceQNeZKXpykRIK6fEl4rF8XPFKetBbZx2f2HUuI5H+9a30ULLXBb
         Ih+fnxufUv03xdOAuLLhFy5ejr4PZIobIZlPXV7J+sJJFW9bnCapzem5X7Jzqlvcrtky
         TgB4pSYelgUPCa99qwSAkWrYmkhQwLIthpGViGkb47PazZFZd7gvw9qq41IFKbRV4IDr
         L/8xQhhr/361cUCPV9kuBVr2473/sKfQeszPrwzRTQN7m3OBnNUQ8JPGZ2ipn0nPPo++
         OnMw==
X-Gm-Message-State: AOAM531hMrgMWbiKsqUTqWeNzTfVaooYI2UOSWel6t9qj1aT6AlAY2b5
        sGRkFu4dkCB+j96P8P9x69XIBQ==
X-Google-Smtp-Source: ABdhPJyzHPcv8qy3yk+iw5C1CfQhs0U063gy6g1/i2mGk7ekBPYQXw+3gsJbk8sWoUnBUh/4KANvSQ==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr3370259wmi.124.1605691551308;
        Wed, 18 Nov 2020 01:25:51 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id t136sm2716518wmt.18.2020.11.18.01.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:25:50 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:25:47 +0000
From:   Quentin Perret <qperret@google.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        android-kvm@google.com
Subject: Re: [RFC PATCH 15/27] of/fdt: Introduce
 early_init_dt_add_memory_hyp()
Message-ID: <20201118092547.GA2031536@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-16-qperret@google.com>
 <CAL_Jsq+xAy9+HjH6vqfmaAEKBe9MMm+wWvUtiz5dFnHmMneqNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+xAy9+HjH6vqfmaAEKBe9MMm+wWvUtiz5dFnHmMneqNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tuesday 17 Nov 2020 at 13:44:53 (-0600), Rob Herring wrote:
> Can this be done right after we add all the memblocks using the
> memblock API?

Possibly, but the thing I'm a bit worried about is the way 'no-map'
regions are removed from memblocks early on.

The EL2 object needs to know about these parts of memory too (and in
fact we may be able to enforce the 'no-map' attribute at the host stage
2 level as well). It's also possible we'll need to have portions of the
guests payload preloaded (and verified) by the bootloader into reserved
memory regions, possibly no-map, to make sure the host does not mess
with them in a normal use-case. So, I couldn't find a much better place
than this one but suggestions are very much welcome.

I'll have a go at the memblock stuff to see if I find a way to make it
work from that angle.

> I thought EFI would also need to be handled, but looks
> like it just calls early_init_dt_add_memory_arch(). That's odd
> especially for ACPI systems...
> 
> I don't really like putting what looks like an arm64 only hook here,
> but then I don't want an arm64 version of
> early_init_dt_add_memory_arch() either. We're almost to the point of
> getting rid of the arch specific ones. But I don't have a better
> suggestion currently.

Ack, the ugly truth is that this is likely to remain arm64-specific. I
figured this was simple enough that we might want to consider it,
though.

Thanks,
Quentin
