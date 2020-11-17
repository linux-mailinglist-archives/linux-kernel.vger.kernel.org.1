Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22162B6D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgKQSda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgKQSda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:33:30 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA190223C7;
        Tue, 17 Nov 2020 18:33:28 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Tue, 17 Nov 2020 18:33:27 +0000
Message-Id: <160563797013.919203.6342916534242159843.b4-ty@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1602722808.git.sudaraja@codeaurora.org>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 11:56:55 -0700, Sudarshan Rajagopalan wrote:
> V1: The initial patch used the approach to abort at the first instance of PMD_SIZE
> allocation failure, unmaps all previously mapped sections using vmemmap_free
> and maps the entire request with vmemmap_populate_basepages to allocate
> virtually contiguous memory.
> https://lkml.org/lkml/2020/9/10/66
> 
> V2: Allocates virtually contiguous memory only for sections that failed
> PMD_SIZE allocation, and continous to allocate physically contiguous
> memory for other sections.
> https://lkml.org/lkml/2020/9/30/1489
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: add fallback option to allocate virtually contiguous memory
      https://git.kernel.org/arm64/c/9f84f39f5515

(figured out which v3 and v4 have the same message-id and presumably the
same patch)

-- 
Catalin

