Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B171A2569EA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgH2TsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 15:48:15 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35513 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbgH2TsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:48:13 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="465221526"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 21:48:12 +0200
Date:   Sat, 29 Aug 2020 21:48:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci
 script
In-Reply-To: <489164b541e344f254b70429e4f6d467e1602931.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008292146170.3629@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>  <alpine.DEB.2.22.394.2008292133360.3629@hadrien> <489164b541e344f254b70429e4f6d467e1602931.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Aug 2020, Joe Perches wrote:

> On Sat, 2020-08-29 at 21:36 +0200, Julia Lawall wrote:
> >
> > On Wed, 12 Aug 2020, Denis Efremov wrote:
> >
> > > Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> > > commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> > > removed uninitialized_var() and deprecated it.
> > >
> > > The purpose of this script is to prevent new occurrences of open-coded
> > > variants of uninitialized_var().
>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Signed-off-by: Denis Efremov <efremov@linux.com>
> >
> > Applied, without the commented out part.
> >
> > I only got three warnings, though.  Perhaps the others have been fixed?
>
> uninitialized_var does not exist in -next

OK, if it seems better, I can remove it.  Out of the threee reported, one
was a completely unnecessary initialization.

julia
