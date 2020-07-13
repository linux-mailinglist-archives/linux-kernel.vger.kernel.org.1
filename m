Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E21DA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgGMPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:35:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:35546 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbgGMPfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:35:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E2DDB2E2;
        Mon, 13 Jul 2020 15:35:01 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:35:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: locking: Replace HTTP links with HTTPS ones
Message-ID: <20200713093500.38315939@lwn.net>
In-Reply-To: <20200713115728.33905-1-grandmaster@al2klimov.de>
References: <20200713115728.33905-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 13:57:28 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/locking/mutex-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
> index 4d8236b81fa5..8f3e9a5141f9 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -18,7 +18,7 @@ as an alternative to these. This new data structure provided a number
>  of advantages, including simpler interfaces, and at that time smaller
>  code (see Disadvantages).
>  
> -[1] http://lwn.net/Articles/164802/
> +[1] https://lwn.net/Articles/164802/

Applied, thanks.

jon
