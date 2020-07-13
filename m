Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A821DEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgGMRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:43:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:36174 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbgGMRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:43:22 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4935860C;
        Mon, 13 Jul 2020 17:43:22 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:43:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, f4bug@amsat.org, cyphar@cyphar.com,
        davej@codemonkey.org.uk, geert+renesas@glider.be,
        ribalda@kernel.org, luis.f.correia@gmail.com,
        paulburton@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: Replace HTTP links with HTTPS ones
Message-ID: <20200713114321.783f0ae6@lwn.net>
In-Reply-To: <20200711055127.92418-1-grandmaster@al2klimov.de>
References: <20200710154630.31521104@lwn.net>
        <20200711055127.92418-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 07:51:27 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  N: Derrick J. Brashear
>  E: shadow@dementia.org
> -W: http://www.dementia.org/~shadow
> +W: https://www.dementia.org/~shadow

So while I do understand what you're trying to do, HTTPSifying something
that has become a spam site doesn't do any good to anybody.  If you
*really* want to improve this file, dealing with this sort of issue would
be a much more useful contribution.  

I agree that fixing the links in general is a mildly useful thing to do.
But this kind of mindless replacement is taking a fair amount of my time,
and I just can't bring myself to apply patches that do something like
this.  Please, slow down a bit and think about how to actually improve
things rather than polishing unseemly items like the above.

Thanks,

jon
