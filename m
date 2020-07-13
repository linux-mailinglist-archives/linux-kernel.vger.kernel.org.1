Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A896B21DECC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgGMRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:33:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:36124 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:33:33 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB2072E2;
        Mon, 13 Jul 2020 17:33:32 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:33:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] S390: Replace HTTP links with HTTPS ones
Message-ID: <20200713113331.0f71440d@lwn.net>
In-Reply-To: <20200709182742.24724-1-grandmaster@al2klimov.de>
References: <20200709182742.24724-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jul 2020 20:27:42 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/s390/monreader.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/s390/monreader.rst b/Documentation/s390/monreader.rst
> index 1e857575c113..21cdfb699b49 100644
> --- a/Documentation/s390/monreader.rst
> +++ b/Documentation/s390/monreader.rst
> @@ -146,7 +146,7 @@ start offset relative to a 4K page (frame) boundary.
>  
>  See "Appendix A: `*MONITOR`" in the "z/VM Performance" document for a description
>  of the monitor control element layout. The layout of the monitor records can
> -be found here (z/VM 5.1): http://www.vm.ibm.com/pubs/mon510/index.html
> +be found here (z/VM 5.1): https://www.vm.ibm.com/pubs/mon510/index.html

Applied, thanks.

jon
