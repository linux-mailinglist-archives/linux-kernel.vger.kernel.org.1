Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5834288345
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgJIHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:10:18 -0400
Received: from verein.lst.de ([213.95.11.211]:42681 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJIHKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:10:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33B1D68B02; Fri,  9 Oct 2020 09:10:14 +0200 (CEST)
Date:   Fri, 9 Oct 2020 09:10:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        will@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com,
        hch@lst.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in
 bcm2711
Message-ID: <20201009071013.GA12208@lst.de>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de> <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de> <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> Sadly I just realised that the series is incomplete, we have RPi4 users that
> want to boot unsing ACPI, and this series would break things for them. I'll
> have a word with them to see what we can do for their use-case.

Stupid question:  why do these users insist on a totally unsuitable
interface?  And why would we as Linux developers care to support such
a aims?
