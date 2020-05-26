Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A291C5CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgEEP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:56:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:50282 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgEEP4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:56:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB73431A;
        Tue,  5 May 2020 15:56:15 +0000 (UTC)
Date:   Tue, 5 May 2020 09:56:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:locking: remove info about old behavior of
 locktorture
Message-ID: <20200505095614.0db67ed2@lwn.net>
In-Reply-To: <20200426211429.29133-1-federico.vaga@vaga.pv.it>
References: <20200426211429.29133-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 23:14:29 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> It is not useful to know what was the default at some point in the
> past: remove the information.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/locking/locktorture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
> index 5bcb99ba7bd9..8012a74555e7 100644
> --- a/Documentation/locking/locktorture.rst
> +++ b/Documentation/locking/locktorture.rst
> @@ -110,7 +110,7 @@ stutter
>  		  same period of time.  Defaults to "stutter=5", so as
>  		  to run and pause for (roughly) five-second intervals.
>  		  Specifying "stutter=0" causes the test to run continuously
> -		  without pausing, which is the old default behavior.
> +		  without pausing.

Sure...applied, thanks.

jon
