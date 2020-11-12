Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E12B0E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKLTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:50:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:50:46 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so5519404pfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YUaRaySxPEyue4UKzML/9jgrZT3IPSplHwgtIcPSAiQ=;
        b=DbNYBIEl/hdGxF+OZ8m7FWFXHKu/Y8YV3xFsxg8QegmDFCfsQl1ssdgMvGcJeof77A
         AiUJ+8lqfPPcZFAMxWluGsnQysS0qCIHEl2fAgUQ67AXJTah77ij8yb+VOehuKjYlJpj
         J66ggOgdrdz1lTu9KmZkOBt9qjXiUlgG5TPRbSdyt9plJQ0qEj+iM6kR9Fx/8jOwvvWI
         JBapYP/1ahFg+Heu/bB/ZAZI8Wk7WZYgb72fWEMWh0blQZCQzqeNlF4yk4U2LopFN8Wx
         HPObb4QxbKBOJcsRHWzmjoDic2fECg2dusKzG5YCPPZA9BwznmYouUP5zAQ49kVGvOpC
         PXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YUaRaySxPEyue4UKzML/9jgrZT3IPSplHwgtIcPSAiQ=;
        b=qcJQ4uuyuR0P4ZfOSVJMCW5+Jn5ouT03i6NfPc7bbUZhJ2bj+x4vsqO60fKwsrScsL
         2/e+SC+FKbZcRO3rH2SDSt2TKsJ1ffMY58m3immlgwE/wLC1naz7ax62fIRl897V8362
         T1RBoDggoNVsSu3/aHafor+csAvC3zGBbKVke0/YhLbrSZJe9YHgkKdYgeGyv+hddHt1
         vaygL6IxdJ54RQ6BrwJ392dbogYz9pbkcHOxOB8qLjbE8O5LkvMNksmGWBW8Yyr7IxSd
         SNy7dALMBAofPMhfwp2Qn1ytGUKFgI+pDEjnPKWqXUZ5PaOcggVjSlwmJ88pSaK4QBdB
         Zj5Q==
X-Gm-Message-State: AOAM530mJrHAfual2zKEcTrOjoWDWzwwBWucjxPX4kiF0ohXky1rMBip
        zD5cZ3UpursO7HPMsAs7ASA=
X-Google-Smtp-Source: ABdhPJxQGu3fDONAAs8P2djFSF9/XjOrj9GfhSuxCn37mWSP5fNfuqbOivjWHrT1cQ4rK+/84SZdwQ==
X-Received: by 2002:a63:6243:: with SMTP id w64mr902327pgb.430.1605210645868;
        Thu, 12 Nov 2020 11:50:45 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id u10sm7442021pfn.101.2020.11.12.11.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:50:44 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 12 Nov 2020 11:50:42 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Stefan Agner <stefan@agner.ch>, ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201112195042.GB123036@google.com>
References: <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
 <20201111102654.GF4758@kernel.org>
 <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
 <20201111133945.GA12288@alpha.franken.de>
 <CAK8P3a34gW-Cj0sOGiwXHewJjgimpxPqt4mEN2Lh=MiSA_tAaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a34gW-Cj0sOGiwXHewJjgimpxPqt4mEN2Lh=MiSA_tAaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:33:18PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 11, 2020 at 2:39 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> > On Wed, Nov 11, 2020 at 11:57:02AM +0100, Arnd Bergmann wrote:
> > > On Wed, Nov 11, 2020 at 11:26 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> > > > > On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > > > > >
> > > > > > > To be on the safe side, we could provoke a compile-time error
> > > > > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > > > > >
> > > > > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > > > > machine has memory above 4G?
> > > > >
> > > > > If the fix is as easy as adding a single line in a header, I think a
> > > > > compile-time
> > > > > error makes it easier, no need to wait for someone to boot a broken
> > > > > system before fixing it.
> > > >
> > > > Not sure it would be as easy as adding a single line in a header for
> > > > MIPS with it's diversity.
> > >
> > > I looked up the architecture, and found:
> > >
> > > - The pre-MIPS32r1 cores only support 32-bit addressing
> > > - octeon selects PHYS_ADDR_T_64BIT but no longer
> > >   supports 32-bit kernels
> > > - Alchemy and netlogic (XLR, XLP) have 36-bit addressing
> > > - CONFIG_XPA implies 40-bit addressing
> >
> > MIPS32r5 might have up to 60-bit addressing according to the MIPS32 PRA
> > docuemnt (MD00090). But there is probably no chip, which implements it
> > so for now 40-bit addressing is correct.
> >
> > >
> > > We should run it by the MIPS maintainers, but I think this patch
> > > is sufficient:
> >
> > Do you want me to run it through mips tree or do you need an
> > Acked-By from me ?
> 
> I'll follow up with a proper submission for MIPS and the other
> architectures, please apply that one.

Thanks, Arnd!
