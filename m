Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744CD1F336A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFIF3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgFIF3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:11 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955AC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:29:10 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzF9729kz9sTb; Tue,  9 Jun 2020 15:29:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nadav Amit <namit@vmware.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200518234245.200672-1-leobras.c@gmail.com>
References: <20200518234245.200672-1-leobras.c@gmail.com>
Subject: Re: [PATCH v6 0/2] Implement reentrant rtas call
Message-Id: <159168034552.1381411.5609887094437090637.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:29:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 20:42:43 -0300, Leonardo Bras wrote:
> Patch 2 implement rtas_call_reentrant() for reentrant rtas-calls:
> "ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive",
> according to LoPAPR Version 1.1 (March 24, 2016).
> 
> For that, it's necessary that every call uses a different
> rtas buffer (rtas_args). Paul Mackerras suggested using the PACA
> structure for creating a per-cpu buffer for these calls.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/rtas: Move type/struct definitions from rtas.h into rtas-types.h
      https://git.kernel.org/powerpc/c/783a015b747f606e803b798eb8b50c73c548691d
[2/2] powerpc/rtas: Implement reentrant rtas call
      https://git.kernel.org/powerpc/c/b664db8e3f976d9233cc9ea5e3f8a8c0bcabeb48

cheers
