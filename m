Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A91BF4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD3KI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 06:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3KI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:08:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A012173E;
        Thu, 30 Apr 2020 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588241308;
        bh=xa6SpmSmz9EAdtVLWr+Oo3a8W/zi6Yh4mLHT8M/Bb5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCUHU4XQOC1NYyjmFXVXCCbulAEM7AZSTxyQ7+5I2SwHz/G+uEMnzpoE4im98LLc8
         wgr0/Gjnbc+UtBMh7+Fs0Cnj/od/q3LJ/UT4MmYDHK3a5/o+rhH2n1z5vbDrO/Is7j
         sIS1+lyZbST/U8limbFBI5yeJZYFzMq+yVAkgwWM=
Date:   Thu, 30 Apr 2020 11:08:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430100821.GC19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
> The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
> [1] summarizes some of the problems we have in making virtio work on such
> hypervisors. This patch proposes a solution for transport problem viz how we can
> do config space IO on such a hypervisor. Hypervisor specific methods
> introduced allows for seamless IO of config space.

Seamless huh? You'd hope that might obviate the need for extra patches...

> This patch is meant to seek comments. If its considered to be in right
> direction, will work on making it more complete and send the next version!

What's stopping you from implementing the trapping support in the
hypervisor? Unlike the other patches you sent out, where the guest memory
is not accessible to the host, there doesn't seem to be any advantage to
not having trapping support, or am I missing something here?

Will
