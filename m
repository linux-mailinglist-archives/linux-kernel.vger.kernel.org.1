Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B21C0431
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3Rxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 13:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3Rxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:53:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B7F20836;
        Thu, 30 Apr 2020 17:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588269228;
        bh=4Xo8/1e7qaJmuQQltLTfB4vjVZPdGrjTFYT8oEPKWno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TnzHy6V0ZH7paWMDm5JrkAHnp/DaOr3pZvhvI0vYr1381WdBJTPVhmepyRnBUiLba
         o8thxzN3rCxTBpDBvcLfBQetKd7K7qWM3ZeU1eXq82INA7n961BxRiD4T+u1HNYwcZ
         dpNJGdEFn0SyLaoq3c7EWRsANA/N5cp3TcBUyYss=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jUDNb-0088YE-6h; Thu, 30 Apr 2020 18:53:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Apr 2020 18:53:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] Split off nVHE hyp code
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <73efca41e7b955db4963ff182624107d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for posting this, looks quite interesting!

On 2020-04-30 15:48, David Brazdil wrote:
> Refactor files in arch/arm64/kvm/hyp to compile all code which runs in 
> EL2
> under nVHE into separate object files from the rest of KVM. This is 
> done in
> preparation for being able to unmap .hyp.text from EL1 but has other 
> benefits,
> notably:
>  * safe use of KASAN/UBSAN/GCOV instrumentation on VHE code,
>  * cleaner HVC API,
>  * no need for __hyp_text annotations.
> 
> nVHE-specific code is moved to hyp/nvhe and compiled with custom build 
> rules
> similar to those used by EFI stub. Shared source files are compiled 
> under both
> VHE and nVHE build rules. Where a source file contained both VHE and 
> nVHE code,
> it is split into a shared header file and two C source files. This is 
> done one
> file per commit to make review easier.

Do you have any figure on how much bigger the final kernel becomes once 
this
is applied? I guess I can find out pretty easily, but this is the kind 
of thing
that would be useful to make part of your cover letter.

I'll try to review this shortly.

Thanks,

         M.
