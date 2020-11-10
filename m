Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2E2AD493
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgKJLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKJLS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:18:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E5D20659;
        Tue, 10 Nov 2020 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605007139;
        bh=V+uHbdDrM/jaXwqO4pqWQzjL1Up7i3JN4LAYXoQ2Oew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yeQSXFy2W4PDXQzMfbGwukbiIgeh+NHzOf9c34dw0x4NGJg9e5KZvMMY15cajk1xm
         ONxT65MzXwgo6W4kBXUuZqMpMLY5mCqv1qEO40DLlN1ZGN/lsYxCglUAfFttmkG78k
         ymwFb968JDcgPO2dnp6FEhINlQvm8kFPsYhkbAVM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcRfs-009QfH-P3; Tue, 10 Nov 2020 11:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 11:18:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v1 00/24] Opt-in always-on nVHE hypervisor
In-Reply-To: <20201110101542.GA17572@infradead.org>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201110101542.GA17572@infradead.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b174c468e3df6dc7874b9ab886b38009@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hch@infradead.org, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com, kernel-team@android.com, lorenzo.pieralisi@arm.com, qwandor@google.com, suzuki.poulose@arm.com, qperret@google.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, tj@kernel.org, dennis@kernel.org, cl@linux.com, will@kernel.org, julien.thierry.kdev@gmail.com, ascull@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-10 10:15, Christoph Hellwig wrote:
> On Mon, Nov 09, 2020 at 11:32:09AM +0000, David Brazdil wrote:
>> As we progress towards being able to keep guest state private to the
>> host running nVHE hypervisor, this series allows the hypervisor to
>> install itself on newly booted CPUs before the host is allowed to run
>> on them.
> 
> Why?  I thought we were trying to kill nVHE off now that newer CPUs
> provide the saner virtualization extensions?

We can't kill nVHE at all, because that is the only game in town.
You can't even buy a decent machine with VHE, no matter how much money
you put on the table.

nVHE is here for the foreseeable future, and we even use its misfeatures
to our advantage in order to offer confidential VMs. See Will's 
presentation
at KVM forum a couple of weeks ago for the gory details.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
