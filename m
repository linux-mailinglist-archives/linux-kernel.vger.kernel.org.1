Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2814028E6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbgJNTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbgJNTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:11:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE3C061755;
        Wed, 14 Oct 2020 12:11:24 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 533DB739;
        Wed, 14 Oct 2020 19:11:24 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:11:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 2/5] docs: automarkup.py: Fix regexes to solve sphinx
 3 warnings
Message-ID: <20201014131122.52305a86@lwn.net>
In-Reply-To: <20201013231218.2750109-3-nfraprado@protonmail.com>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-3-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 23:13:17 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> The warnings were caused by the expressions matching words in the
> translated versions of the documentation, since any unicode character
> was matched.
> 
> Fix the regular expression by making the C regexes use ASCII

I don't quite understand this part, can you give an example of the kinds
of warnings you were seeing?

Thanks,

jon
