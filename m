Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A325173A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgHYLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 07:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHYLPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:15:43 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8402067C;
        Tue, 25 Aug 2020 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354138;
        bh=2hpbqJGuHjiQno3XjASV22A5GOhSd7ILZrgV7g5Hy1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSacWtneFSqukptHfSoMOOie4Xt42Uba/lDththUxKnzQR0hW89Qa9I7BKcPIGUwG
         fCvcWaPEON1nQ8RMp2Nb3esasrrbtU5FP+T8neVtFpBJYfrCkEx5L4jo3cLHxx6OTi
         A8I0Na9FDnOG8LIUiLRPUBnVaSa4uO/UuWUFIHYI=
Date:   Tue, 25 Aug 2020 16:45:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     paul@crapouillou.net, dan.j.williams@intel.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] drivers/dma/dma-jz4780: Fix race condition between
 probe and irq handler
Message-ID: <20200825111533.GL2639@vkoul-mobl>
References: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 09:14, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> In probe, IRQ is requested before zchan->id is initialized which can be
> read in the irq handler. Hence, shift request irq after other initializations
> complete.

Applied, thanks

-- 
~Vinod
