Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158D5252476
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHYXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 19:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgHYXwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:52:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF4520706;
        Tue, 25 Aug 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598399535;
        bh=cpl2NMcCvB4e05/2Ng+vLlDNVSMOHT2mnJhujSPNZfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qKT+jfW0x0cEBaRNnmniDD+NJJv6dYtIMRh6+MAaQL7kCvhE58TBFswqwK9Al1D4L
         vzu/JEqF4MiN61wbJ1dk9vvwGVgx1L0MK73fS/ecYLbLDLBIX/0gcaJ5zFR9qmRcCm
         oCRwjE6v0kKpA1jTfNrtzQ9QmL57I8x58XPd1/g8=
Date:   Tue, 25 Aug 2020 16:52:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH mmotm] x86/numa: fix build when CONFIG_ACPI is not set
Message-Id: <20200825165214.2b5e1fbf53d68fd3714c8050@linux-foundation.org>
In-Reply-To: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
References: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 08:20:27 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when CONFIG_ACPI is not set/enabled by adding
> <acpi/acpi_numa.h> in the #else (!CONFIG_ACPI) block.
> 
> ../arch/x86/mm/numa.c: In function ‘numa_setup’:
> ../arch/x86/mm/numa.c:43:3: error: implicit declaration of function ‘disable_srat’; did you mean ‘disable_irq’? [-Werror=implicit-function-declaration]
>    disable_srat();
>    ^~~~~~~~~~~~
> ../arch/x86/mm/numa.c:45:3: error: implicit declaration of function ‘disable_hmat’; did you mean ‘disable_dma’? [-Werror=implicit-function-declaration]
>    disable_hmat();
>    ^~~~~~~~~~~~
>
> ...
>
> --- mmotm-2020-0824-1606.orig/include/linux/acpi.h
> +++ mmotm-2020-0824-1606/include/linux/acpi.h
> @@ -709,6 +709,8 @@ static inline u64 acpi_arch_get_root_poi
>  #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
>  #define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
>  
> +#include <acpi/acpi_numa.h>
> +
>  struct fwnode_handle;
>  
>  static inline bool acpi_dev_found(const char *hid)

I don't think there's anything in -next that caused this?  It's in
mainline also?

