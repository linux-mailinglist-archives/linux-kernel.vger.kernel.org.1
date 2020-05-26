Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D551B121E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDTQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 12:44:32 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42970 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDTQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:44:32 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jQZX1-0008Cn-Qh; Mon, 20 Apr 2020 10:44:29 -0600
To:     Abhishek Sahu <abhsahu@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200420082231.4202-1-abhsahu@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <02c40a96-b9dd-14d8-57f4-426322b76bf2@deltatee.com>
Date:   Mon, 20 Apr 2020 10:44:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420082231.4202-1-abhsahu@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, dan.j.williams@intel.com, akpm@linux-foundation.org, abhsahu@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] x86/mm: fix compilation error for unknown type name
 pgprot_t
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-04-20 2:22 a.m., Abhishek Sahu wrote:
> commit 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
> added the function __set_memory_prot() which uses pgprot_t in
> function prototype. The currently included header files in
> <arch/x86/include/asm/set_memory.h> do not include type name
> pgprot_t. The pgprot_t is defined in <asm/pgtable_types.h>.
> 
> Fixes: 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>

I assume this is only hit with a specific driver or something that
includes set_memory.h without including pgtable_types.h before hand.

It certainly compiles fine for me and the kbuild robot has had lots of
time to test it with random configs.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
