Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740272D8BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 08:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgLMGaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 01:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbgLMGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 01:30:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8794C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 22:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NbTIjMEftFs42sa1juMJxfIePEGTtWn6mUHEhKgPvaU=; b=jgBR5dAiacmj32uFT4ffjxEgbq
        8oOxi81FNlvUSW/ILkTth80sZsi8XVXiRuXjPO887kOVnXjI01y3bFajsFIhMYKZbJdDYy/lxLKY3
        5HC8X7Ir221hbrpHS4NcpSzJsYSQbKHDbQ0LPYzLKO/t5uf0mLgC54cj8EVdKmk0OrifqB2X5OiqS
        BuvlbB7cWSPIz734S/JYmo2s7o1J5KCH7iFxkJxswZtP7upT66As6uJYNI71u1uP9hnzEoXFGBsql
        IRzim/8peA4Q5dB7SfWpzvE/VPBBSocNZaNNol6VMmzhnyHarZrQBDKa+bWiXpjKyULcmSVKN0wPo
        3Y7kG0eA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koKsh-0008UU-Mg; Sun, 13 Dec 2020 06:29:22 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: x86_32: CONFIG_PHYSICAL_START problem
Message-ID: <82a78e8c-b4e6-3eb7-01e3-286bcbb869e3@infradead.org>
Date:   Sat, 12 Dec 2020 22:29:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

background:

I was trying to debug a MIPS build error, but it wasn't MIPS-specific,
so I did this, using the MIPS .config file:

make ARCH=i386 O=xx32 olddefconfig

Little to my knowledge, this came up with
CONFIG_PHYSICAL_START=0x81000000

Then I built the i386 kernel, and got this message:
ld: kernel image bigger than KERNEL_IMAGE_SIZE

so I promptly changed many =y drivers etc. to =m
and still got the same ld error message.

Well, it must be something else, he said.

I tracked it down to this large value of CONFIG_PHYSICAL_START
and changed it back to its default value, then the kernel
built with no problems.

So far I haven't been able to track the chain of values/changes
that involve PHYSICAL_START, __PAGE_OFFSET, LOAD_OFFSET, etc.

Anyway, I would like to see PHYSICAL_START limited to some
acceptable range of values in arch/x86/Kconfig,
or at a minimum, a little bit better error message coming
from arch/x86/kernel/vmlinux.lds.S:

. = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
	   "kernel image bigger than KERNEL_IMAGE_SIZE");

so maybe:

. = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
	   "kernel image bigger than KERNEL_IMAGE_SIZE or load address is too large");
(or start address)

Comments?

thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
