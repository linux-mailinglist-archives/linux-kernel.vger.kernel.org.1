Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3126B7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgIPAai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgIONru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:47:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7526521D24;
        Tue, 15 Sep 2020 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177647;
        bh=An8bUf+cWpAG/u+1BnVioiDw+Pkkf8LhEX7EXD3eUOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eg6ePeAPhBgUAbixIOW8IWWLC8APZSEGurkIj/fSTZexULVYQUIQk4GDVuFJrqpOk
         ui3ImEmzJPD4Rf7C2nJnjxlHlRwM7PsnG3Ik4qYvbcCVKRlXG+iCkB2Jdk/a4qRnab
         uvgI8RZosMzMQnZGtMyzaTIKhYv8kSZzH8RW8Wd0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIBIr-00C1a8-EQ; Tue, 15 Sep 2020 14:47:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 14:47:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] KVM: arm64: fix doc warnings in mmu code
In-Reply-To: <1600175890-7435-1-git-send-email-tanxiaofei@huawei.com>
References: <1600175890-7435-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <7bcb5fd9b6490e98cfa8aa22496a8a71@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tanxiaofei@huawei.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaofei,

On 2020-09-15 14:18, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> arch/arm64/kvm/mmu.c:119: warning: Function parameter or member
> 'pudp'not described in 'stage2_dissolve_pud'
> arch/arm64/kvm/mmu.c:119: warning: Excess function parameter 'pud'
> description in 'stage2_dissolve_pud'

[...]

Most of this code is being deleted. If you want to fix comments,
please look at what is in -next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
