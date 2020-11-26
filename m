Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27FD2C58E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbgKZP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391338AbgKZP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:57:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9237CC0613D4;
        Thu, 26 Nov 2020 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3rrtQ71q0YtViU9F1ot5BdeEltZAdYdBUvO0cmayAc=; b=FZwZ+cSjTlY++W2PqTlACC7Zcm
        0s3m3bFs39K+17ZoKkUILRrMAaHt3+Wwakbs7aeZvux4KTCJ5BzDDbnVayZmgnbMIDEDMx8HpbHdv
        zPAqxNP8urL+nYCRljUztGgpLjge8Vks7oa+D8lkhn6K/ReZvaN64vYFe/jgPeJL3tkdjPoNL56Fz
        b6J9rloVzUz1OxLJzP9NHQuQ4+q1c0iUYcP9XU1D6OKD2Rai9JfwAv6ot1DLV2QyIMXuDmyElds5w
        akkzY+mZfOV1FxpPTFywh6DHTpaceL3+G0tK3lKxidGeTkm+JpmsGmEc8jyYFHoq/7XYgTIk8AJVm
        YqyQffHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiJeU-0007oi-MN; Thu, 26 Nov 2020 15:57:46 +0000
Date:   Thu, 26 Nov 2020 15:57:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20201126155746.GU4327@casper.infradead.org>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:53:58PM +0000, David Brazdil wrote:
> The hypervisor starts trapping host SMCs and intercepting host's PSCI
> CPU_ON/SUSPEND calls. It replaces the host's entry point with its own,
> initializes the EL2 state of the new CPU and installs the nVHE hyp vector
> before ERETing to the host's entry point.

I hate CPU people.  This is complete gibberish to anyone who doesn't
already have their head deep in ... whatever you're talking about.
