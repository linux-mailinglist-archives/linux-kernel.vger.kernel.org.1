Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77742AD349
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKJKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgKJKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:15:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CDnrTQO3oLKsIPoRXOWKhlw6v2wORA6EgStmJKbRLyc=; b=uHCxhFHSswLZ7vAYcHATP5bd/m
        FT+iCClwmwUEk/6LfQTpnR278IY/btZYg8TEOY20uE6JtYZp9jxRJKMxXyUotRqA9KdH0W8moJ9z1
        Qy7+BivKZx7GsMNa+bXMiNXemztq0qnU18Mf3JIqDyLznHGWz6VDfQ7z2FSz8kgSa2NZhFgZ7eP4t
        Ro1PVrsDK8oAOkWRsKhC7EGufL0j2dMUP6xVaKSuEZTdEtgVfbmlVs1DQLzd3JEPG3Lh3MtU3ZFFH
        53eB7sHqkRw/FVQqvStXNAnB75H+vIfjnMzQkxUX/i7n/lFovYYPDz8BRKX03VnVipQwbkg399bXm
        Zlm92mdg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQgg-00054V-8l; Tue, 10 Nov 2020 10:15:42 +0000
Date:   Tue, 10 Nov 2020 10:15:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Mark Rutland <mark.rutland@arm.com>,
        kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20201110101542.GA17572@infradead.org>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 11:32:09AM +0000, David Brazdil wrote:
> As we progress towards being able to keep guest state private to the
> host running nVHE hypervisor, this series allows the hypervisor to
> install itself on newly booted CPUs before the host is allowed to run
> on them.

Why?  I thought we were trying to kill nVHE off now that newer CPUs
provide the saner virtualization extensions?
