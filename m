Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C61EA745
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFAPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:46:28 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D782074B;
        Mon,  1 Jun 2020 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591026388;
        bh=gQIGfJV1ELKQM3xQFhlfWE9BDIp/KaUeNZ9QqnyXb2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeNfFGKFahHiBrjvplXSKB7bRNwwfwyuEKqn+8lZUQrLpo7iDsbuWRe3P9VHQP6Hq
         uvka17jidwhCk2ZHSWG902R/iLKRWiGrv8CI0Ljn6PEVXLFB7v49eVE17xqG/ga7LU
         8ofLq5mr6k0TRKHjgV44o/4e4TO1FV6PnAVfImEM=
Date:   Mon, 1 Jun 2020 10:51:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] audit: Use struct_size() helper in alloc_chunk
Message-ID: <20200601155130.GC10051@embeddedor>
References: <20200524205238.GA17576@embeddedor>
 <CAHC9VhRcpqs6TGoqK_soTz8Jo5BCDfhq1kqKGGJeJpbXhWZRsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRcpqs6TGoqK_soTz8Jo5BCDfhq1kqKGGJeJpbXhWZRsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:36:09AM -0400, Paul Moore wrote:
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  kernel/audit_tree.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Thanks, this looks reasonable to me, but it came in too late for the
> v5.8 merge window (I dislike taking changes past -rc5/6 unless

Sounds sensible.

> critical).  Once the merge window closes I'll merge this into
> audit/next.
> 

Thanks, Paul.
--
Gustavo
