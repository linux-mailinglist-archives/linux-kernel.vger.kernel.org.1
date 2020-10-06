Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1090284EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgJFPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:20:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgJFPUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:20:11 -0400
Received: from zn.tnic (p200300ec2f0d6300cee9f1eb6b8e192c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:cee9:f1eb:6b8e:192c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4A9C1EC0409;
        Tue,  6 Oct 2020 17:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601997609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=22QKkbrJeWzTsKksHS4vbicwGczWEiJUoAabXc4dnIs=;
        b=Zy3ldkWx7X1LsBXSp91c+MDSPY7Gf53Jeaibgm/IoRGiRa7QMPoye1vfR9XxtveaVHNnm5
        4QK0F04Sb/VHf1nOPq5Hw8ZQ6XlltpN2KDZVg6q8+K4hEgyVK3wfSX53RdYs1pZDXhKFFQ
        5ilOejPs+fGjfCF175tVW5Pma9SJhoM=
Date:   Tue, 6 Oct 2020 17:19:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 06/13] x86/platform/uv: Add and Decode Arch Type in
 UVsystab
Message-ID: <20201006151959.GF27700@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-7-mike.travis@hpe.com>
 <20201005212135.GL21151@zn.tnic>
 <d2c7d3d8-3863-f15f-7ec6-ae41cf8b2657@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2c7d3d8-3863-f15f-7ec6-ae41cf8b2657@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 02:35:58PM -0700, Mike Travis wrote:
> 
> 
> On 10/5/2020 2:21 PM, Borislav Petkov wrote:
> > On Mon, Oct 05, 2020 at 03:39:22PM -0500, Mike Travis wrote:
> > > A patch to add and process the UV Arch Type field in the UVsystab passed
> > > from UV BIOS to the kernel.
> > 
> > What does that mean?
> > 
> 
> There have been recent cases where OEM's want to use the OEM_ID in the ACPI
> tables to brand their own product.  The UV BIOS used that field to tell the
> Linux kernel which UV arch the running system is.  The Arch Type in the
> UVsystab (also created by UV BIOS) now carries that field in systems that
> support it.

I am unclear on the whole patch passing from UV BIOS to the kernel. Are
you talking about a kernel patch here? If so, commit ID is? Or what kind
of patch are you talking about?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
