Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC51B2911
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgDUOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:09:47 -0400
Received: from ozlabs.org ([203.11.71.1]:41591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgDUOJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:09:46 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49656b64Szz9sSx; Wed, 22 Apr 2020 00:09:43 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8d0ea29db5aefd0d94fa4b6ca6124c68998f3c6a
In-Reply-To: <1587016720.2275.1047.camel@hbabu-laptop>
To:     Haren Myneni <haren@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     mikey@neuling.org, srikar@linux.vnet.ibm.com,
        frederic.barrat@fr.ibm.com, ajd@linux.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, hch@infradead.org,
        oohall@gmail.com, clg@kaod.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v11 01/14] powerpc/xive: Define xive_native_alloc_irq_on_chip()
Message-Id: <49656b64Szz9sSx@ozlabs.org>
Date:   Wed, 22 Apr 2020 00:09:43 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 05:58:40 UTC, Haren Myneni wrote:
> 
> This function allocates IRQ on a specific chip. VAS needs per chip
> IRQ allocation and will have IRQ handler per VAS instance.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d0ea29db5aefd0d94fa4b6ca6124c68998f3c6a

cheers
