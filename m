Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60C428E7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgJNUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgJNUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:16:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E5C061755;
        Wed, 14 Oct 2020 13:16:18 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 96878739;
        Wed, 14 Oct 2020 20:16:17 +0000 (UTC)
Date:   Wed, 14 Oct 2020 14:16:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 2/5] docs: automarkup.py: Fix regexes to solve sphinx
 3 warnings
Message-ID: <20201014141616.63082d5d@lwn.net>
In-Reply-To: <C6CVK7V449HT.12X5MRPR3R7TK@ArchWay>
References: <C6CVK7V449HT.12X5MRPR3R7TK@ArchWay>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 20:09:10 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> One I had noted down was:
> 
> WARNING: Unparseable C cross-reference: '调用debugfs_rename'
> 
> which I believe occurred in the chinese translation.
> 
> I think the problem is that in chinese there normally isn't space between the
> words, so even if I had made the regexes only match the beginning of the word
> (which I didn't, but I fixed this in this patch with the \b), it would still try
> to cross-reference to that symbol containing chinese characters, which is
> unparsable to sphinx.
> 
> So since valid identifiers in C are only in ASCII anyway, I used the ASCII flag
> to make \w, and \d only match ASCII characters, otherwise they match any unicode
> character.

OK, this all makes sense, as does your fix.  The one thing I would ask
would be to put that warning into the changelog for future reference.

Thanks,

jon
