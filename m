Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41C254FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgH0UO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:14:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F8C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:14:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBOHv-005kIa-9b; Thu, 27 Aug 2020 20:14:23 +0000
Date:   Thu, 27 Aug 2020 21:14:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86: Use xorl %0,%0 in __get_user_asm
Message-ID: <20200827201423.GD1236603@ZenIV.linux.org.uk>
References: <20200827180904.96399-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827180904.96399-1-ubizjak@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:09:04PM +0200, Uros Bizjak wrote:
> xorl %0,%0 is equivalent to xorq %0,%0 as both will zero the
> entire register.  Use xorl %0,%0 for all operand sizes to avoid
> REX prefix byte when legacy registers are used and to avoid size
> prefix byte when 16bit registers are used.
> 
> Zeroing the full register is OK in this use case.  xorl %0,%0 also
> breaks register dependency chains, avoiding potential partial
> register stalls with 8 and 16bit operands.

No objections, but talking about stalls is more than slightly
ridiculous - we'd just taken a #PF, failed there, flipped
pt_regs %rip to fixup section, returned from fault and are
about to fail whatever syscall that had been; a stall here
is really not an issue...
