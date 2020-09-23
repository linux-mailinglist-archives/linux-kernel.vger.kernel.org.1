Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF1275387
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIWInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWInV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:43:21 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF505221F0;
        Wed, 23 Sep 2020 08:43:19 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:43:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        robin.murphy@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 0/2] arm64/mm: Enable color zero pages
Message-ID: <20200923084317.GA13434@gaia>
References: <20200923053721.28873-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923053721.28873-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Wed, Sep 23, 2020 at 03:37:19PM +1000, Gavin Shan wrote:
> The feature of color zero pages isn't enabled on arm64, meaning all
> read-only (anonymous) VM areas are backed up by same zero page. It
> leads pressure to L1 (data) cache on reading data from them. This
> tries to enable color zero pages.
> 
> PATCH[1/2] decouples the zero PGD table from zero page
> PATCH[2/2] allocates the needed zero pages according to L1 cache size

To save you (and potential reviewers) some time, please include in the
cover letter details of a realistic workload/benchmark that is improved
by this patchset, backed by numbers. Just because it's doable and the
patches aren't too complex is not a good enough reason for merging.

Thanks.

-- 
Catalin
