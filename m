Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F02B7206
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKQXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:15:31 -0500
Received: from ozlabs.org ([203.11.71.1]:39259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKQXPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:15:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CbMHP2tSgz9sSn; Wed, 18 Nov 2020 10:15:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, oss@buserror.net,
        natechancellor@gmail.com, ndesaulniers@google.com
In-Reply-To: <20201116120913.165317-1-mpe@ellerman.id.au>
References: <20201116120913.165317-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Drop -me200 addition to build flags
Message-Id: <160565490600.491761.10215082379059532791.b4-ty@ellerman.id.au>
Date:   Wed, 18 Nov 2020 10:15:29 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 23:09:13 +1100, Michael Ellerman wrote:
> Currently a build with CONFIG_E200=y will fail with:
> 
>   Error: invalid switch -me200
>   Error: unrecognized option -me200
> 
> Upstream binutils has never supported an -me200 option. Presumably it
> was supported at some point by either a fork or Freescale internal
> binutils.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Drop -me200 addition to build flags
      https://git.kernel.org/powerpc/c/e02152ba2810f7c88cb54e71cda096268dfa9241

cheers
