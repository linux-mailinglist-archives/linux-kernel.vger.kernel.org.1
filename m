Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5B2405B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHJMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgHJMS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:18:59 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06D820709;
        Mon, 10 Aug 2020 12:18:57 +0000 (UTC)
Date:   Mon, 10 Aug 2020 13:18:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gregory Herrero <gregory.herrero@oracle.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: Fix build failure on non arm64
Message-ID: <20200810121855.GD9480@gaia>
References: <5ca1be21fa6ebf73203b45fd9aadd2bafb5e6b15.1597049145.git.christophe.leroy@csgroup.eu>
 <20200810091730.GA3099@ltoracle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810091730.GA3099@ltoracle>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:17:30AM +0200, Gregory Herrero wrote:
> On Mon, Aug 10, 2020 at 08:48:22AM +0000, Christophe Leroy wrote:
> > Commit ea0eada45632 leads to the following build failure on powerpc:
> > 
> >   HOSTCC  scripts/recordmcount
> > scripts/recordmcount.c: In function 'arm64_is_fake_mcount':
> > scripts/recordmcount.c:440: error: 'R_AARCH64_CALL26' undeclared (first use in this function)
> > scripts/recordmcount.c:440: error: (Each undeclared identifier is reported only once
> > scripts/recordmcount.c:440: error: for each function it appears in.)
> > make[2]: *** [scripts/recordmcount] Error 1
> > 
> > Make sure R_AARCH64_CALL26 is always defined.
> > 
> Oops, thanks for fixing this.
> 
> Acked-by: Gregory Herrero <gregory.herrero@oracle.com>

Thanks. I'll queue it via the arm64 tree (as I did with the previous
fix) but I'll wait a bit for Steve to ack it.

-- 
Catalin
