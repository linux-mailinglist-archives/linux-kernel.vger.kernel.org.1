Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5226A20AB73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFZEqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:46:08 -0400
Received: from ozlabs.org ([203.11.71.1]:38689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgFZEp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:45:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTc4vkkz9sSS; Fri, 26 Jun 2020 14:45:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <795158fc1d2b3dff3bf7347881947a887ea9391a.1592227105.git.christophe.leroy@csgroup.eu>
References: <795158fc1d2b3dff3bf7347881947a887ea9391a.1592227105.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ptdump: Fix build failure in hashpagetable.c
Message-Id: <159314672660.1150869.14912662955490046195.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 13:18:39 +0000 (UTC), Christophe Leroy wrote:
> H_SUCCESS is only defined when CONFIG_PPC_PSERIES is defined.
> 
> != H_SUCCESS means != 0. Modify the test accordingly.

Applied to powerpc/next.

[1/1] powerpc/ptdump: Fix build failure in hashpagetable.c
      https://git.kernel.org/powerpc/c/7c466b0807960edc13e4b855be85ea765df9a6cd

cheers
