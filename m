Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA50B2DAB72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgLOKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgLOKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:50:24 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB8C061248
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:49:10 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFPJ1Fbhz9sTL; Tue, 15 Dec 2020 21:49:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201208195434.8289-1-tyreld@linux.ibm.com>
References: <20201208195434.8289-1-tyreld@linux.ibm.com>
Subject: Re: [PATCH] powerpc/rtas: fix typo of ibm,open-errinjct in rtas filter
Message-Id: <160802920722.504444.16567596066211679066.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:49:08 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 13:54:34 -0600, Tyrel Datwyler wrote:
> Commit bd59380c5ba4 ("powerpc/rtas: Restrict RTAS requests from userspace")
> introduced the following error when invoking the errinjct userspace
> tool.
> 
> [root@ltcalpine2-lp5 librtas]# errinjct open
> [327884.071171] sys_rtas: RTAS call blocked - exploit attempt?
> [327884.071186] sys_rtas: token=0x26, nargs=0 (called by errinjct)
> errinjct: Could not open RTAS error injection facility
> errinjct: librtas: open: Unexpected I/O error
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/rtas: Fix typo of ibm,open-errinjct in RTAS filter
      https://git.kernel.org/powerpc/c/f10881a46f8914428110d110140a455c66bdf27b

cheers
