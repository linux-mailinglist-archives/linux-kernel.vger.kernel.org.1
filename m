Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6646B2B85C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKRUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:38:45 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE1C0613D4;
        Wed, 18 Nov 2020 12:38:45 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 819002EF;
        Wed, 18 Nov 2020 20:38:45 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:38:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference
 inside C namespace
Message-ID: <20201118133844.388d2c2f@lwn.net>
In-Reply-To: <C75JFDOJJFBC.1FPM3DRBNPIKC@ArchWay>
References: <20201117021107.214704-1-nfraprado@protonmail.com>
        <20201117064759.0c03e7cf@coco.lan>
        <C75JFDOJJFBC.1FPM3DRBNPIKC@ArchWay>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 12:30:13 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> > Hmm... do we still need to skip syscalls?  
> 
> Yeah, I see what you mean. Since you moved the syscalls in the docs inside
> namespaces, there shouldn't be any syscall definitions in the global scope
> anymore and therefore we don't need to skip them any longer.
> 
> I tried it out here and indeed it works fine without skipping them.
> 
> But I wonder if it would be a good safety measure to leave it there anyway. We
> never want to cross-reference to syscalls in the global scope, so if we continue
> doing that skip, even if someone accidentally adds a syscall definition outside
> a c:namespace, this will prevent cross-references to it anyway.
> 
> What do you think?

I put the original skip logic in there to keep it from even trying to
cross-reference common syscall names; I wasn't really even worried about
false references at that point.  I'd leave the check in unless it's
actively causing trouble somewhere...

Thanks,

jon
