Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC61DF428
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbgEWCVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 22:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgEWCVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:21:36 -0400
X-Greylist: delayed 231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 May 2020 19:21:35 PDT
Received: from mx.h4ck.space (mx.h4ck.space [IPv6:2a01:4f8:1c1c:f2f5::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 19:21:35 -0700 (PDT)
Date:   Sat, 23 May 2020 04:21:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1590200493;
        bh=Qbmux8TBIyumzPkqdTO5JW7secQMsHMFpVe42GokGHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EgDMD/AE6k40hgy8j1qnn0E97vCeVhXbdOAY1VMLREP1yJB8YAT2k8Oq6sXsKn+fE
         BSuDbZqnrqJ8KLlOJk8d0j2awkol4aIJz93Aa7uht7z2ByxfXK3ahVlZXzHcGt09gE
         w4hwXBTrJZqHyYvVEx6HIuPyV/AYvhYEhE+XqVf8=
From:   andi@notmuch.email
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200523022133.rjgu7kw2goyoj4ip@wrt>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:56 19.05.20, Brendan Shanks wrote:
> The problem is that the kernel does not emulate/spoof the SLDT instruction, only SGDT, SIDT, and SMSW.
> SLDT and STR weren't thought to be commonly used, so emulation/spoofing wasn’t added.
> In the last few months I have seen reports of one or two (32-bit) Windows games that use SLDT though.
> Can you share more information about the application you’re running?

This is basically the "minimal" reproducer for the issue I've been
observed (as by the previously linked article):

https://gist.githubusercontent.com/andir/071981717460242a1df2e0fc20836fdc/raw/0c31877aa7ee59146596fe68934f9cecb5c998ae/test.c
