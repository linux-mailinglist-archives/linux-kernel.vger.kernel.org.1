Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0B214F56
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 22:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgGEUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgGEUdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:33:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B7C061794;
        Sun,  5 Jul 2020 13:33:43 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 45251823;
        Sun,  5 Jul 2020 20:33:43 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:33:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] doc: add link to sparse's home page/internal docs
Message-ID: <20200705143342.0d083b59@lwn.net>
In-Reply-To: <20200629161310.89783-1-luc.vanoostenryck@gmail.com>
References: <20200629044154.GB1492837@kernel.org>
        <20200629161310.89783-1-luc.vanoostenryck@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 18:13:10 +0200
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> Sparse's home page used to be a wiki (sparse.wiki.kernel.org)
> but this wiki only contained a short intro and the release notes.
> But nowadays, sparse's main page is sparse.docs.kernel.org,
> which contains all what was in the wiki but also other documentation,
> mainly oriented about sparse's internals.
> 
> So, add a link to this in the kernel documentation.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
> 
> Changes since v1:
> * fix a typo (s/kernl/kernel/) thanks to Mike Rapoport.
> 
>  Documentation/dev-tools/sparse.rst | 2 ++
>  1 file changed, 2 insertions(+)

When I answered saying I'd applied the v1 patch, I meant I'd really
applied this one, of course...sorry for the noise.

jon
