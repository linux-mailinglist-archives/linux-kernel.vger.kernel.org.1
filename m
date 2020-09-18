Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E626FBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIRMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgIRMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:00:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D332072E;
        Fri, 18 Sep 2020 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430450;
        bh=I3H/gm1g/hyAxhRCcYKSEHmYZeKOlQUJYHZFfgz+YQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6FJM1GR9moczcLCnPkVOGoJiHnqyJJNElwhuj4HWhIp7YN+fwrBtRu/GdLjJoBn4
         3W17b9y4SjtpGZ9+kyBtboSyqiGjpfJMAtrdnV4+Yg0RG4TNwRrz9BG+hMJSnQ3tL7
         wIc9awOFCRUGttRK8ruoYtiyksBJoNq5aTvNpD2Y=
Date:   Fri, 18 Sep 2020 13:00:44 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/11] kvm: arm64: Mark hyp stack pages reserved
Message-ID: <20200918120044.GC31096@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-10-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-10-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:37PM +0100, David Brazdil wrote:
> In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
> stack using new helpers which automatically mark the pages reserved.

Given that this series doesn't get us that the point of having a stage-2 for
the host, I don't see why we need this part yet.

Will
