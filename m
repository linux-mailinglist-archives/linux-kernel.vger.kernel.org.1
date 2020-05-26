Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382841BC1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgD1OuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgD1Ot6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:49:58 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF962082E;
        Tue, 28 Apr 2020 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085398;
        bh=1rcl6RVUXtaqTUMRMhsdjnJSI5mjkOq9ry5jOgm75jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjL239eeuBNz09MW1L4kBBhhmodZkR15xQ2vVTLeyS/wE7KH1vWVKerDlJfu27A0w
         A6sxVXvXikOjj/X+yoIoRDwxA3wpxNfSXKmKueYxA+KnxyhxUZej7luDe5rUc7+wP+
         kN7kuy5pNf0ymMNi09Cv95/7jpyn60bNC7GCOCfM=
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v2] arm64/mm: Use phys_to_page() to access pgtable memory
Date:   Tue, 28 Apr 2020 15:49:38 +0100
Message-Id: <158807947318.210571.1093507749687250902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427234655.111847-1-gshan@redhat.com>
References: <20200427234655.111847-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 09:46:55 +1000, Gavin Shan wrote:
> The macros {pgd, pud, pmd}_page() retrieves the page struct of the
> corresponding page frame, which is reserved as page table. There
> is already a macro (phys_to_page), defined in memory.h as below,
> to convert the physical address to the page struct. Also, the header
> file (memory.h) has been included by pgtable.h.
> 
>    #define phys_to_page(phys)      (pfn_to_page(__phys_to_pfn(phys)))
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Use phys_to_page() to access pgtable memory
      https://git.kernel.org/arm64/c/68ecabd0e680

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
