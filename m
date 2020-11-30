Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808AC2C8FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgK3VYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbgK3VYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:24:46 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05586C0613CF;
        Mon, 30 Nov 2020 13:24:06 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 802CF735;
        Mon, 30 Nov 2020 21:24:05 +0000 (UTC)
Date:   Mon, 30 Nov 2020 14:24:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH] docs: dt: Use full path to enable cross-reference
Message-ID: <20201130142404.6ef6689e@lwn.net>
In-Reply-To: <20201123121333.59274-1-nfraprado@protonmail.com>
References: <20201123121333.59274-1-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 12:13:46 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> Use full path to reference writing-schema.rst so that it becomes a
> cross-reference.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
> 
> Hi Jon,
> 
> do you think this would be the way to go, or should we instead extend automarkup
> to work on relative paths to doc pages, so that this reference would work as is?

Sorry, I missed this before ... dunno.  I suppose that recognizing
relative paths would be a friendly gesture toward our documentation
writers and might be worth doing.

Either way, it occurs to me that automarkup should check to see whether
the file actually exists and complain if it doesn't.

For now, I'll apply this one, though.

Thanks,

jon
