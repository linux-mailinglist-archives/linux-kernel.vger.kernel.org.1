Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9323417A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgGaIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 04:48:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42996
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731648AbgGaIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:48:09 -0400
X-IronPort-AV: E=Sophos;i="5.75,417,1589234400"; 
   d="scan'208";a="355689753"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 10:48:07 +0200
Date:   Fri, 31 Jul 2020 10:48:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH v4] coccinelle: api: add kvfree script
In-Reply-To: <dda490e5-35c8-f097-af2a-e42e7ba21ae0@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007311045490.2439@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200730140751.8635-1-efremov@linux.com> <alpine.DEB.2.22.394.2007302235000.2548@hadrien> <dda490e5-35c8-f097-af2a-e42e7ba21ae0@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Do the checks for the opportunities for kvmalloc really belong in this
> > rule?  That issue is not mentioned in the commit log or the description of
> > the semantic patch.
>
> I added this at the last moment. It was easy enough to add it based on existing
> patterns. I will add description for this warnings. Or do you want me to single
> out this warning to a separate rule?

It seems like a different issue.  A separate rule might be better.  Also,
there is no patch variant, so if one runs the patch mode on this script,
where the patch mode is useful, then one will miss the kvmalloc
suggestions completely.  Coccicheck has a mode where is first tries patch
and then report; I think 0-day uses this.

julia
