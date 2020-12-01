Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373162C98E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgLAINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgLAINO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:13:14 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE572085B;
        Tue,  1 Dec 2020 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606810353;
        bh=Z6X+2VoHJAosAAjJT7DTwYdijnr/89BVlCnGqrnFM8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0xmINYyQGQW9jIvFybDJdPdPo3TpdhEWKsgqj/hOJN9l4MbJ589ZJ4E+6I9WRXSIP
         UqKY8aFeVA9xn7YCTTeZ2Cnn3uk+ONJC4uzJYLRCUVWw85dQhTXytso1+J32uFnK8w
         liQ5h9DoFk9PrqZPTp8V+Pw0s1T+KcFQkvGpgWg8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kk0lz-00ExH2-4S; Tue, 01 Dec 2020 08:12:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 08:12:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     wangrongwei <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
In-Reply-To: <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rongwei.wang@linux.alibaba.com, catalin.marinas@arm.com, will@kernel.org, bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com, geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org, michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 03:09, wangrongwei wrote:
> Hi
> We have validate this driver in vm and physical machine, and works 
> fine.

But what does "work fine" mean? None of these system registers are 
supposed
to be accessible from userspace, so please explain *what* you are trying 
to
do with this, other that introducing security holes and general system
instability?

> Actually, we used existing interfaces to realize this driver, likes
> aarch64_insn_read and aarch64_insn_patch_text.

Sure. At that stage, you could also directly expose the linear mapping 
to
userspace and start writing to it, it would probably be a fitting 
addition...

> These existing intefaces had validated a CPU.

If CPU validation is your goal, I suggest this is kept out of tree, as 
the
kernel is hardly a validation tool for the arm64 architecture.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
