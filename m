Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5124868F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHRN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 09:58:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHRN6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:58:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BWCDV4wKxz9sTK; Tue, 18 Aug 2020 23:58:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <996184974d674ff984643778cf1cdd7fe58cc065.1597644194.git.christophe.leroy@csgroup.eu>
References: <996184974d674ff984643778cf1cdd7fe58cc065.1597644194.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/fixmap: Fix the size of the early debug area
Message-Id: <159775907925.1766076.11136700602764304510.b4-ty@ellerman.id.au>
Date:   Tue, 18 Aug 2020 23:58:18 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 06:03:26 +0000 (UTC), Christophe Leroy wrote:
> Commit ("03fd42d458fb powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when
> page size is 256k") reworked the setup of the early debug area and
> mistakenly replaced 128 * 1024 by SZ_128.
> 
> Change to SZ_128K to restore the original 128 kbytes size of the area.

Applied to powerpc/fixes.

[1/1] powerpc/fixmap: Fix the size of the early debug area
      https://git.kernel.org/powerpc/c/fdc6edbb31fba76fd25d7bd016b675a92908d81e

cheers
