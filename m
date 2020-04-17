Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011451AD718
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgDQHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:10:03 -0400
Received: from verein.lst.de ([213.95.11.211]:56051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbgDQHKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:10:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12BF968BFE; Fri, 17 Apr 2020 09:09:59 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:09:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [patch 4/7] dma-direct: atomic allocations must come from
 atomic coherent pools
Message-ID: <20200417070958.GB19153@lst.de>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2004141703510.68516@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2004141703510.68516@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The subject should say something like "atomic unencrypted allocations.."
as many other atomic allocations are fine.  Which brings up that with
the codebase in this patch we can't really support architectures that
require both an atomic pool for uncached remapping for just some devices
and unencrypted for others.  We don't have such an archicture right now,
and I hope we don't grow one, but we probably need a little safeguard
with a BUILD_BUG_ON if both options are set.  I can send an incremental
patch for that if that is ok with you.
