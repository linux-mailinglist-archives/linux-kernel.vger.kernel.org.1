Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3EB30484E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbhAZFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbhAYMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:16:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C16F42231F;
        Mon, 25 Jan 2021 12:15:35 +0000 (UTC)
Date:   Mon, 25 Jan 2021 12:15:33 +0000
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
Subject: Re: [PATCH v5 09/21] arm64: cpufeature: Add global feature override
 facility
Message-ID: <20210125121532.GE25360@gaia>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-10-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125105019.2946057-10-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:50:07AM +0000, Marc Zyngier wrote:
> Add a facility to globally override a feature, no matter what
> the HW says. Yes, this sounds dangerous, but we do respect the
> "safe" value for a given feature. This doesn't mean the user
> doesn't need to know what they are doing.
> 
> Nothing uses this yet, so we are pretty safe. For now.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Acked-by: David Brazdil <dbrazdil@google.com>

That's more readable with a single pointer.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
