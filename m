Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4874623A3DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHCMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 08:12:50 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:19188
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgHCMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:12:48 -0400
X-IronPort-AV: E=Sophos;i="5.75,430,1589234400"; 
   d="scan'208";a="355856872"
Received: from clt-128-93-177-162.vpn.inria.fr ([128.93.177.162])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 14:12:46 +0200
Date:   Mon, 3 Aug 2020 14:12:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] coccinelle: api: add kvfree script
In-Reply-To: <8171ffcd-9f60-26a8-3c6a-4356297a12d1@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008031410490.27678@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200731210026.7186-1-efremov@linux.com> <8171ffcd-9f60-26a8-3c6a-4356297a12d1@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Aug 2020, Denis Efremov wrote:

> Is there a difference from cocci point of view between:
>
> ... when != !is_vmalloc_addr(E)

This will only reject cases where the ! is present.  Coccinelle doesn't
apply isomorphisms to the C source code, so it doesn't detect that eg

if (A)
  B
else C

could be rewritten as

if (!A)
  C
ese B

So when != !A would only match when the code is in the second form.
>
> and
>
> ... when != is_vmalloc_addr(E)
>
> Should the latter one be used in most cases?

This matches both a call to is_vmalloc_addr and a negated call, so it is
more general.

julia
