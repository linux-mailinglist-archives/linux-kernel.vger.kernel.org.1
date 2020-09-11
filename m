Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605F1266235
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIKPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgIKP2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:10 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D39207FB;
        Fri, 11 Sep 2020 15:28:06 +0000 (UTC)
Date:   Fri, 11 Sep 2020 16:28:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/3] arm64/mm: Remove CONT_RANGE_OFFSET
Message-ID: <20200911152803.GH12835@gaia>
References: <20200910095936.20307-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910095936.20307-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:59:34PM +1000, Gavin Shan wrote:
> The macro was introduced by commit <ecf35a237a85> ("arm64: PTE/PMD
> contiguous bit definition") at the beginning. It's only used by
> commit <348a65cdcbbf> ("arm64: Mark kernel page ranges contiguous"),
> which was reverted later by commit <667c27597ca8>. This makes the
> macro unused.
> 
> This removes the unused macro (CONT_RANGE_OFFSET).
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
