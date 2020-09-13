Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00AA267EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgIMJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgIMJIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:08:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFA6207BB;
        Sun, 13 Sep 2020 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599988126;
        bh=MRJOeOx2UA9wo/E2Ks+iu5fjJ1am4t2P+rW1mi+Dt04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EQWcCLhR5F2i/bMKBRc+gCex8KBvwuY857K3mJV/ygSS3aNrbytrZqHec9QHkSp4y
         4JoBmpg2KvOts06itHaukwUZSIhu15Z0DDlFFKZ+/TcyXBc3XITlhMvQkgO9WskvNE
         lnh9VVxNXVCGYxRGLf86PkVM1rdtxnBZq4wQXMzk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHO04-00BOju-Mz; Sun, 13 Sep 2020 10:08:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 13 Sep 2020 10:08:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, jason@lakedaemon.net,
        catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org,
        yuzenghui@huawei.com
Subject: Re: [PATCH v2 2/2] irqchip/gic-v3: Support pseudo-NMIs when
 SCR_EL3.FIQ == 0
In-Reply-To: <ca41885f-1d86-be38-1680-6847079efaf2@arm.com>
References: <20200819133630.527243-1-alexandru.elisei@arm.com>
 <20200819133630.527243-3-alexandru.elisei@arm.com>
 <87k0wzkxvz.wl-maz@kernel.org>
 <ca41885f-1d86-be38-1680-6847079efaf2@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <f8b805d29096158f83783e1417776d55@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, jason@lakedaemon.net, catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-12 14:34, Alexandru Elisei wrote:
> Hi Marc,

[...]

> Have you tested the series using the PMU NMI branch from the cover
> letter? If so, would you mind giving a Tested-by tag for that series 
> [1]?

I haven't had a chance, but that's next on my list once I've gone
through some other bits of review that have been lingering in my
inbox for too long...

         M.
-- 
Jazz is not dead. It just smells funny...
