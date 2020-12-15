Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AE2DAB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgLOKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:50:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53443 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgLOKti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP43BnXz9sTX; Tue, 15 Dec 2020 21:48:56 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
References: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Refactor the floor/ceiling check in hugetlb range freeing functions
Message-Id: <160802920981.504444.16317809091263529138.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:56 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 13:20:54 +0000 (UTC), Christophe Leroy wrote:
> All hugetlb range freeing functions have a verification like the following,
> which only differs by the mask used, depending on the page table level.
> 
> 	start &= MASK;
> 	if (start < floor)
> 		return;
> 	if (ceiling) {
> 		ceiling &= MASK;
> 		if (! ceiling)
> 			return;
> 		}
> 	if (end - 1 > ceiling - 1)
> 		return;
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Refactor the floor/ceiling check in hugetlb range freeing functions
      https://git.kernel.org/powerpc/c/7bfe54b5f16561bb703de6482f880614ada8dbf2

cheers
