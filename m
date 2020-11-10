Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711002ADA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgKJPgC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 10:36:02 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48837 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgKJPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:36:01 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1DB3BC001F;
        Tue, 10 Nov 2020 15:35:57 +0000 (UTC)
Date:   Tue, 10 Nov 2020 16:35:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201110163556.3e3423f6@xps13>
In-Reply-To: <20201110113827.hl5i27cpl6exo3md@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
        <20201110113827.hl5i27cpl6exo3md@mobilestation>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
2020 14:38:27 +0300:

> Hello Miquel,
> 
> A situation noted by the warning below won't cause any problem because
> the casting is done to a non-dereferenced variable. It is utilized
> as a pointer bias later in that function. Shall we just ignore the
> warning or still fix it somehow?

Do you think the cast to a !__iomem value is mandatory here?

Perhaps if you find an elegant wait to avoid the warning it would be
nice, otherwise I guess we'll let it aside as a false positive.

Cheers,
Miquèl
