Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEAA2C5938
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbgKZQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgKZQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:19:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1E4207BC;
        Thu, 26 Nov 2020 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606407598;
        bh=ndZG1t6GX24rtYFtgwoylSOLLR+0rulFS7DxFgbvXNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbY5++SR3vNOtbMoB4xpEm/VEC6LVzSf4wFcDTs8Ksqjw7lWuG8ErnYiM88/diAgh
         CwFHY46uwK1EMJOBTB+X0eW8BflTc4pPNZJzZL/R4rwtmB3zk81GFcfjjWlvtsGzMV
         ITl065COD8OebFRSGxHoiQDl1Q1CKrjCt/ES4hKk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kiJzw-00Dr0o-2I; Thu, 26 Nov 2020 16:19:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Nov 2020 16:19:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 00/23] Opt-in always-on nVHE hypervisor
In-Reply-To: <20201126155746.GU4327@casper.infradead.org>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155746.GU4327@casper.infradead.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <6a2a14af06232cdf2f5146cd8ec6fc35@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: willy@infradead.org, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-26 15:57, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 03:53:58PM +0000, David Brazdil wrote:
>> The hypervisor starts trapping host SMCs and intercepting host's PSCI
>> CPU_ON/SUSPEND calls. It replaces the host's entry point with its own,
>> initializes the EL2 state of the new CPU and installs the nVHE hyp 
>> vector
>> before ERETing to the host's entry point.
> 
> I hate CPU people.  This is complete gibberish to anyone who doesn't
> already have their head deep in ... whatever you're talking about.

What I hate the most is people having a go at other people because they
don't understand what is being discussed. Who is at fault there?

         M.
-- 
Jazz is not dead. It just smells funny...
