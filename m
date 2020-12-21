Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8E2DFE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:55:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:47046 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLUQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:55:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1C06C559;
        Mon, 21 Dec 2020 16:54:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1C06C559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608569666; bh=9XJ8KrR1hCVXYRat2iIzBqt10pLg8DdJpdzABKLdGqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HwlXAeg0eM1sVlsIKdVtMrvuN1U0/yVZQaXH+8p0lUdqy7l1hnW1n1YkpsE51oR3R
         3nzgSSX+Wv76qEMK7eI8keAss5s82r2GiM7fxdJrw8tywWBO17DfSseMGZblLX0em2
         voOTXVYayrFpKNaty/ebOFV+lNYWuU4xbls9d/LUvLkOQrSw2GXihsTQU0R986QArx
         NXo0xBdWvEnt3fPA0DIMbDqxJagqw4Xr1P7IREcR8wJ1HnBjR+TPD40TDMjhJlatb8
         NcWmjmx9K/RhZTZVWppHO5uNx82DBUCfLwg4OZpJBzq9QpFCtJ4GCYfY0N+SofniYb
         P/BSZBDPrvTwA==
Date:   Mon, 21 Dec 2020 09:54:25 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Document the SoB
 chain
Message-ID: <20201221095425.6da68163@lwn.net>
In-Reply-To: <20201217183756.GE23634@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 19:37:56 +0100
Borislav Petkov <bp@alien8.de> wrote:

> ok, let's start slow and with something that should not need a whole lot
> of bikeshedding. We have been repeating that a lot of times in the past
> which means that, especially new submitters, do not know it. So here it
> goes.
> 
> Btw, pls let me know when you start queueing the patches, on which tree
> you do that so that I can send you the following ones ontop.

Given that there was indeed a lack of bikeshedding, I just went ahead and
applied this to docs-next; will ship it Linusward in the near future.

Thanks,

jon
