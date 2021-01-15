Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F242F78D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbhAOMYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:24:34 -0500
Received: from ozlabs.org ([203.11.71.1]:44787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbhAOMYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:24:32 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DHL2G5rhcz9sVF; Fri, 15 Jan 2021 23:23:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>, mpe@ellerman.id.au
Cc:     naveen.n.rao@linux.vnet.ibm.com, maskray@google.com,
        keescook@chromium.org, ariel.marcovitch@gmail.com, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, oss@buserror.net, npiggin@gmail.com
In-Reply-To: <20210102201156.10805-1-ariel.marcovitch@gmail.com>
References: <20210102201156.10805-1-ariel.marcovitch@gmail.com>
Subject: Re: [PATCH v2] powerpc: fix alignment bug whithin the init sections
Message-Id: <161071339918.2210050.14386564633032070545.b4-ty@ellerman.id.au>
Date:   Fri, 15 Jan 2021 23:23:50 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jan 2021 22:11:56 +0200, Ariel Marcovitch wrote:
> This is a bug that causes early crashes in builds with a
> .exit.text section smaller than a page and a .init.text section that
> ends in the beginning of a physical page (this is kinda random, which
> might explain why this wasn't really encountered before).
> 
> The init sections are ordered like this:
> 	.init.text
> 	.exit.text
> 	.init.data
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Fix alignment bug within the init sections
      https://git.kernel.org/powerpc/c/2225a8dda263edc35a0e8b858fe2945cf6240fde

cheers
