Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39E24A4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHSRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 13:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHSRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:22:15 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757FC206FA;
        Wed, 19 Aug 2020 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597857734;
        bh=ns3QqN1GE86TyATblzqVP/NCI85PrE0w52RqoEnvbBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=biwztO1ihUXf4Euv72Qr3Rri8ht6NKWGwsqFXckg/nbkuURUNgmIs3mw3wg/xmvKp
         w9LlJlTBn2g0nRd+NYSiFy0nwZv5mnv3/883shiNjSOxvRLMBKParaJI2R4PnvHTDc
         /AmICpbuSNWIxMgrOgeuPRS+J1+c+LrZZxUiSOoE=
Date:   Wed, 19 Aug 2020 10:22:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Doug Berger <opendmb@gmail.com>, Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
Message-Id: <20200819102214.32238093b116ab6f1c5c7b73@linux-foundation.org>
In-Reply-To: <e22cbcdc-e9ce-50b7-aa88-6a3579ffd509@gmail.com>
References: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
        <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
        <e22cbcdc-e9ce-50b7-aa88-6a3579ffd509@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 10:15:53 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:

> >> In many cases the difference is not significant, but for example
> >> an ARM platform with 1GB of memory and the following memory layout
> >> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
> >> [    0.000000] Zone ranges:
> >> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> >> [    0.000000]   Normal   empty
> >> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
> >>
> >> would result in 0 lowmem_reserve for the DMA zone. This would allow
> >> userspace to deplete the DMA zone easily.
> > 
> > Sounds fairly serious for thos machines.  Was a cc:stable considered?
> 
> Since there is a Fixes: tag, it may have been assumed that the patch
> would be picked up and as soon as it reaches Linus' tree it would be
> picked up by the stable selection.

It doesn't work that way - sometimes a fix isn't considered important
enough to backport.  It could just fix a typo in a comment!



