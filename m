Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA772BC5B7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKVMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKVMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:49:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D202078D;
        Sun, 22 Nov 2020 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606049352;
        bh=KRt5IKd4MKIebZbAS8wxQObsMxbM8xgOHWkxy0s1l1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQZe9wK/u1Su49gZ3MRsLqsanFqBvlLwhjSfSrcq73hGBTOA/XFtD/vwYaW8HR3I8
         CduzeLjQQ+gdp8Sw7KQ40OipiVjRQewdlOPadiJ9gRQbszEh2iiMhFy9Jj24wAeOyD
         XucmfROLBa73sWIsLkha6paMxaVuStzn5xYzYgGY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kgonm-00ChQ9-9f; Sun, 22 Nov 2020 12:49:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Chen Baozi <cbz@baozis.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/exiu: Fix the index of fwspec for IRQ type
Date:   Sun, 22 Nov 2020 12:49:06 +0000
Message-Id: <160604929559.224131.16896313383969996215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117032015.11805-1-cbz@baozis.org>
References: <20201117032015.11805-1-cbz@baozis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: cbz@baozis.org, ardb@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 11:20:15 +0800, Chen Baozi wrote:
> Since fwspec->param_count of ACPI node is two, the index of IRQ type
> in fwspec->param[] should be 1 rather than 2.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/exiu: Fix the index of fwspec for IRQ type
      commit: d001e41e1b15716e9b759df5ef00510699f85282

I added Fixes: and Cc: stable tags for a good measure.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


