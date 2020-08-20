Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43724ACDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTCMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 22:12:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHTCMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:12:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BX7TM3wDzz9sRN;
        Thu, 20 Aug 2020 12:12:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1597889560;
        bh=gPdGSuMbBr6AKJw/++doCCfD8GkVb+j4pQ8PJ3xV49A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pZigIs87s/0HJCQu3CMeGxmU0e2JIr0P58tO7g3RDssIi9EJAWo6dG2xAEOeHDFUN
         H/U0C6GQyVs1FTXIqdcuIOi1g6VWt3esLh1358kQCRaPPn3HpgPcIfg7b0MqD4lPxa
         vaedp/MpmDiMZyRDSUDUTwoIyNc2WvONX4FWrm9ApXlgHzNAHzVOQ1LWJQ6aL7VIQv
         jYci3SYKpJhI7xoajLFJH8NrnUEgQdKBtqb/Gnjb6UVVuc40f9BgYZO2HAzBFkSGh8
         Ym6AviUgzKcWLDdtvnZFf5y5fvG+orpGwMv3tCGcngvhsq4jMphAzi+hKg7TzFnQqq
         YO31FxQ3zKJzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
In-Reply-To: <20200819044351.GA19391@lst.de>
References: <20200818221126.391073-1-bauerman@linux.ibm.com> <20200819044351.GA19391@lst.de>
Date:   Thu, 20 Aug 2020 12:12:35 +1000
Message-ID: <877dtuhxpo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> On Tue, Aug 18, 2020 at 07:11:26PM -0300, Thiago Jung Bauermann wrote:
>> POWER secure guests (i.e., guests which use the Protection Execution
>> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
>> they don't need the SWIOTLB memory to be in low addresses since the
>> hypervisor doesn't have any addressing limitation.
>> 
>> This solves a SWIOTLB initialization problem we are seeing in secure guests
>> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
>> memory, which leaves no space for SWIOTLB in low addresses.
>> 
>> To do this, we use mostly the same code as swiotlb_init(), but allocate the
>> buffer using memblock_alloc() instead of memblock_alloc_low().
>> 
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Looks fine to me (except for the pointlessly long comment lines, but I've
> been told that's the powerpc way).

They're 80 columns AFAICS?

cheers
