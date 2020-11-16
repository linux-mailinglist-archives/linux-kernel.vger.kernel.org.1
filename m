Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F442B41B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgKPKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgKPKqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:46:37 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47FD52068D;
        Mon, 16 Nov 2020 10:46:34 +0000 (UTC)
Date:   Mon, 16 Nov 2020 10:46:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "liwei (CM)" <liwei213@huawei.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGFy?=
 =?utf-8?Q?m64=3A_mm=3A_fre?= =?utf-8?Q?e?= unused memmap for sparse memory
 model that define VMEMMAP
Message-ID: <X7JYhyr2a4H6D+cQ@trantor>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com>
 <20200903120558.GB31409@gaia>
 <eacfa2bb19df4126a476566512d93dab@hisilicon.com>
 <f34d3387368a406582bce36627cdc29c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34d3387368a406582bce36627cdc29c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 08:42:17AM +0000, liwei (CM) wrote:
> I have changed SECTION_SIZE_BITS to 27 in our products, but I don't
> have to submit it.

Well, if you send a patch, I'm happy to merge it.

-- 
Catalin
