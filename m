Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5EC2A97CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKFOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:39:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:39:00 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDFC208B3;
        Fri,  6 Nov 2020 14:38:57 +0000 (UTC)
Date:   Fri, 6 Nov 2020 14:38:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4] arm64/mm: add fallback option to allocate virtually
 contiguous memory
Message-ID: <20201106143854.GH29329@gaia>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
 <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
 <4ca1e695f81b368a5487bdaa9b421a95@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca1e695f81b368a5487bdaa9b421a95@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:03:36PM -0800, Sudarshan Rajagopalan wrote:
> Did you have a chance to review this patch? It is reviewed by others and
> haven't seen any Nacks. This patch will be useful to have so that memory
> hotremove doesn't fail when such PMD_SIZE pages aren't available.. which is
> usually the case in low RAM devices.

Can you please post it again please with Will's ack? You posted a v4
which I think had the same message-id as v3. Mutt flagged it as
duplicate and I deleted it. Just to be sure (I'll queue it when we get
to -rc3).

Thanks.

-- 
Catalin
