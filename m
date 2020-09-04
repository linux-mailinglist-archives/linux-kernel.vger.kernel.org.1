Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109FF25DFC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgIDQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:25:35 -0400
Received: from verein.lst.de ([213.95.11.211]:42475 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:25:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84B6A68BEB; Fri,  4 Sep 2020 18:25:30 +0200 (CEST)
Date:   Fri, 4 Sep 2020 18:25:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64
 for M-mode kernel
Message-ID: <20200904162530.GA32095@lst.de>
References: <20200904162121.279578-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904162121.279578-1-anup.patel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:51:21PM +0530, Anup Patel wrote:
> The TIME CSR is usually not present on most RISC-V systems so the
> M-mode firmware will emulate the TIME CSR for the S-mode (MMU) kernel
> whereas the M-mode (NoMMU) kernel will have to use MMIO clocksource.
> 
> Currently, the get_cycles() implementation in asm/timex.h does not
> consider the above fact so we provide alternate implementation of
> the get_cycles() for the M-mode (NoMMU) kernel which expects drivers
> to provide custom MMIO based read_cycles64() method.

Please just go back to the previous working version without all the
crazy indirections.

The whole timer and irq code has been turned into a giant maze of
indirections lately.
