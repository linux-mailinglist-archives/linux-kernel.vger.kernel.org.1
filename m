Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E730480E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbhAZFwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbhAYMVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:21:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C41229C6;
        Mon, 25 Jan 2021 12:19:51 +0000 (UTC)
Date:   Mon, 25 Jan 2021 12:19:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v5 10/21] arm64: cpufeature: Use IDreg override in
 __read_sysreg_by_encoding()
Message-ID: <20210125121948.GF25360@gaia>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-11-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125105019.2946057-11-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:50:08AM +0000, Marc Zyngier wrote:
> __read_sysreg_by_encoding() is used by a bunch of cpufeature helpers,
> which should take the feature override into account. Let's do that.
> 
> For a good measure (and because we are likely to need to further
> down the line), make this helper available to the rest of the
> non-modular kernel.
> 
> Code that needs to know the *real* features of a CPU can still
> use read_sysreg_s(), and find the bare, ugly truth.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Acked-by: David Brazdil <dbrazdil@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
