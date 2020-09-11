Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E526623A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIKPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgIKPaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:30:20 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7402B221EB;
        Fri, 11 Sep 2020 15:30:19 +0000 (UTC)
Date:   Fri, 11 Sep 2020 16:30:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 3/3] arm64/mm: Unitify CONT_PMD_SHIFT
Message-ID: <20200911153016.GJ12835@gaia>
References: <20200910095936.20307-1-gshan@redhat.com>
 <20200910095936.20307-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910095936.20307-3-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:59:36PM +1000, Gavin Shan wrote:
> Similar to how CONT_PTE_SHIFT is determined, this introduces a new
> kernel option (CONFIG_CONT_PMD_SHIFT) to determine CONT_PMD_SHIFT.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
