Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8585C2AEF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKKK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKKK5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:57:20 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6D5207D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605092239;
        bh=3cUrzEperZmJZPiBR0OisMLBYKRAFSIs72FijGKrXHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zasY+T96Loq7v5mhXhs9smgNUamcpczR1ufJ3IAspaK+KJ1Wl5CSZAktxY5Sjfzre
         sb1llTAyRRE2cKsYVbFMFlsdH1JPFtjJkKUV371vveNYJuyWmbKp+rna+6ukD4Vgqj
         Tsg0yUZmlb/jdvH/CzsEbV4Td/VxWvKCMfD9i87k=
Received: by mail-oi1-f171.google.com with SMTP id w188so1735023oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:57:19 -0800 (PST)
X-Gm-Message-State: AOAM530M+5p+MQx8BnsAB0XAPZ08Il7pbwPGwHP39QglpTdKwNiGN97q
        7DPoEQ5GEOX5w1vOVwDrREruiqZjXfVyDTiVjWI=
X-Google-Smtp-Source: ABdhPJwO+gAy08wl+Li6qJXH9ISAmoM1KXb5s2HvOM4ZMAlkwL/wMgtFk6KMi/gnjXIIehnz5+mv25yP1hG199ZhGZs=
X-Received: by 2002:aca:e0d7:: with SMTP id x206mr1833471oig.67.1605092238510;
 Wed, 11 Nov 2020 02:57:18 -0800 (PST)
MIME-Version: 1.0
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org> <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org> <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org> <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
 <20201111102654.GF4758@kernel.org>
In-Reply-To: <20201111102654.GF4758@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 11 Nov 2020 11:57:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
Message-ID: <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:26 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> > On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > >
> > > > To be on the safe side, we could provoke a compile-time error
> > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > >
> > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > machine has memory above 4G?
> >
> > If the fix is as easy as adding a single line in a header, I think a
> > compile-time
> > error makes it easier, no need to wait for someone to boot a broken
> > system before fixing it.
>
> Not sure it would be as easy as adding a single line in a header for
> MIPS with it's diversity.

I looked up the architecture, and found:

- The pre-MIPS32r1 cores only support 32-bit addressing
- octeon selects PHYS_ADDR_T_64BIT but no longer
  supports 32-bit kernels
- Alchemy and netlogic (XLR, XLP) have 36-bit addressing
- CONFIG_XPA implies 40-bit addressing

We should run it by the MIPS maintainers, but I think this patch
is sufficient:

--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -154,6 +154,7 @@ static inline void pmd_clear(pmd_t *pmdp)

 #if defined(CONFIG_XPA)

+#define MAX_POSSIBLE_PHYSMEM_BITS 40
 #define pte_pfn(x)             (((unsigned long)((x).pte_high >>
_PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
 pfn_pte(unsigned long pfn, pgprot_t prot)
@@ -169,6 +170,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)

 #elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)

+#define MAX_POSSIBLE_PHYSMEM_BITS 35
 #define pte_pfn(x)             ((unsigned long)((x).pte_high >> 6))

 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
@@ -183,6 +185,7 @@ static inline pte_t pfn_pte(unsigned long pfn,
pgprot_t prot)

 #else

+#define MAX_POSSIBLE_PHYSMEM_BITS 32
 #ifdef CONFIG_CPU_VR41XX
 #define pte_pfn(x)             ((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)     __pte(((pfn) << (PAGE_SHIFT + 2)) |
pgprot_val(prot))

     Arnd
