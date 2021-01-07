Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76C82EE7C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbhAGVpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:45:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:38876 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbhAGVpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:45:21 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6199C6150;
        Thu,  7 Jan 2021 21:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6199C6150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610055881; bh=K60OydIYvtgK28GfG8MU4SR32rFFAy+VekFr1uwRQPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HeqMFAWJtDfzsi6gbSMaHdsZQ5ym/0+hrGBN9ZZDcHQQ2yUmLwzs2iQMKOrtX9yFE
         cklWHQGoQg8SyfAxCYGGkQeUnaK1XrTYKFKk1eJ/Rreo4GeI9X27ijjYlzy7nfb8G5
         oMYH6vuIvsAaYGUTfTb0J9f1+iLoflVL/MaXJ9nPiWBKfc0EaVzRr9SIoYbDMtEYZT
         eaQ4nx1We3z3knuAYxo+qQEwDDWQWZHUZsSqsqFK4zawFD8/u09Al6in9AMH8NnzBY
         NTIxYNE07ALg9IPCJgxehEnc8QtbnynGYK9Z+ppBIU9ENOmCyBFp9D6SLrJbwSogsD
         9irrCjylRIxlw==
Date:   Thu, 7 Jan 2021 14:44:40 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/admin-guide: kernel-parameters:
 hyphenate comma-separated
Message-ID: <20210107144440.55e0b119@lwn.net>
In-Reply-To: <20210101040831.4148-1-rdunlap@infradead.org>
References: <20210101040831.4148-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Dec 2020 20:08:31 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hyphenate "comma separated" when it is used as a compound adjective.
> hyphenated.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> v2: rebase & resend
> 
>  Documentation/admin-guide/kernel-parameters.txt |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
