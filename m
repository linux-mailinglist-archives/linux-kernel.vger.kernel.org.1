Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8532327AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 00:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgG2Wor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 18:44:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:36577 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2Wor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:44:47 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 06TMiTG1009810;
        Wed, 29 Jul 2020 17:44:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 06TMiS25009808;
        Wed, 29 Jul 2020 17:44:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Jul 2020 17:44:27 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
Message-ID: <20200729224427.GI17447@gate.crashing.org>
References: <20200729133741.62789-1-vdronov@redhat.com> <20200729144949.GF17447@gate.crashing.org> <584129967.9672326.1596051896801.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584129967.9672326.1596051896801.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:44:56PM -0400, Vladis Dronov wrote:
> > > Certain warnings are emitted for powerpc code when building with a gcc-10
> > > toolset:
> > > 
> > >     WARNING: modpost: vmlinux.o(.text.unlikely+0x377c): Section mismatch in
> > >     reference from the function remove_pmd_table() to the function
> > >     .meminit.text:split_kernel_mapping()
> > >     The function remove_pmd_table() references
> > >     the function __meminit split_kernel_mapping().
> > >     This is often because remove_pmd_table lacks a __meminit
> > >     annotation or the annotation of split_kernel_mapping is wrong.
> > > 
> > > Add the appropriate __init and __meminit annotations to make modpost not
> > > complain. In all the cases there are just a single callsite from another
> > > __init or __meminit function:
> > > 
> > > __meminit remove_pagetable() -> remove_pud_table() -> remove_pmd_table()
> > > __init prom_init() -> setup_secure_guest()
> > > __init xive_spapr_init() -> xive_spapr_disabled()
> > 
> > So what changed?  These functions were inlined with older compilers, but
> > not anymore?
> 
> Yes, exactly. Gcc-10 does not inline them anymore. If this is because of my
> build system, this can happen to others also.
> 
> The same thing was fixed by Linus in e99332e7b4cd ("gcc-10: mark more functions
> __init to avoid section mismatch warnings").

It sounds like this is part of "-finline-functions was retuned" on
<https://gcc.gnu.org/gcc-10/changes.html>?  So everyone should see it
(no matter what config or build system), and it is a good thing too :-)

Thanks for the confirmation,


Segher
