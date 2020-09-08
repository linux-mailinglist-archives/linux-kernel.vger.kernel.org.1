Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B0261F38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgIHUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgIHPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A767D20738;
        Tue,  8 Sep 2020 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599578402;
        bh=lm+NnOQVayPnEfJs4iqkujWjjFvLWT5L8ziKCgTrRa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFiZ8vv+V5Si6pCmglsYvIxWUSs2kqEP3hyv1GibXBVKbeok5rPxfU4KaqVQBVagW
         tAho0j2ti8+0izDXZAIyHvZP2AEBCkbLAC/0d1Y/kBoKytrmcWBJR3k8v8MSbqEILh
         NTCjWqLdGKoNU1xROt4RDGhngLQbBY7m3ab6Sy38=
Date:   Tue, 8 Sep 2020 17:20:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 00/12] x86/platform/uv: Updates for UV5
Message-ID: <20200908152014.GB4114051@kroah.com>
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907185430.363197758@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:54:30PM -0500, Mike Travis wrote:
> Subject: [PATCH 00/12] x86/platform/uv: Updates for UV5
> 
> Add changes needed for new UV5 UV architecture.  Chief among the changes
> are 52 bits of physical memory address and 57 bits of virtual address space.  
> 
> 0001 Remove UV BAU TLB Shootdown Handler
>     - removes BAU TLB code being replaced by BAU APIC driver
> 
> 0002 Remove SCIR built in driver
>     - removes System Controller (monitoring) code
> 
> 0003 Update UV kernel modules
>     - update loadable UV kernel modules prior to a clash of symbols
>       (is_uv) produced by auto-generated UV5 uv_mmrs.h file
> 
> 0004 Update UV MMRs for UV5
>     - update uv_mmrs.h file and fix resultant compiler errors
> 
> 0005 Add UV5 direct references
>     - add references to UV5 specific values
> 
> 0006 Decode and Use Arch Type in UVsystab
>     - add UV ArchType field to UVsystab to remove dependency on OEM_ID
> 
> 0007 Update MMIOH references
>     - display MMIOH mapping for each MMIOH region
> 
> 0008 Adjust GAM MMR references
>     - update GAM mapping for MMR accesses
> 
> 0009 Update UV GRU references
>     - update GRU mapping to include UV5
> 
> 0010 Update Node Present Counting
>     - UV5 changes method of counting nodes present
> 
> 0011 Update UV5 TSC Checking
>     - update TSC sync check of BIOS sync status
> 
> 0012 Update for UV5 NMI MMR changes
>     - update NMI handler
> 

No diffstat?  Did you use 'git format-patch' cover letter for this?

thanks,

greg k-h
