Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28821C5C57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgEEPqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:46:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:50200 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbgEEPqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:46:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A864E31A;
        Tue,  5 May 2020 15:46:33 +0000 (UTC)
Date:   Tue, 5 May 2020 09:46:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, akrowiak@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] docs: s390: Fix wrong label Guest2 instead of Guest3
Message-ID: <20200505094632.0d34f72b@lwn.net>
In-Reply-To: <20200430221238.101838-1-vitor@massaru.org>
References: <20200430221238.101838-1-vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 19:12:38 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> This fixes:
> 
> Documentation/s390/vfio-ap.rst:488: WARNING: duplicate label s390/vfio-ap:guest2, other instance in /home/iha/sdb/opensource/lkmp/linux_doc/Documentation/s390/vfio-ap.rst
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  Documentation/s390/vfio-ap.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
> index b5c51f7c748d..367e27ec3c50 100644
> --- a/Documentation/s390/vfio-ap.rst
> +++ b/Documentation/s390/vfio-ap.rst
> @@ -484,7 +484,7 @@ CARD.DOMAIN TYPE  MODE
>  05.00ff     CEX5A Accelerator
>  =========== ===== ============
>  
> -Guest2
> +Guest3
>  ------
>  =========== ===== ============
>  CARD.DOMAIN TYPE  MODE

Applied, thanks.

Note, though, that while the patch does "fix" the warning, what it really
fixes is (as suggested in the subject) an incorrect heading; the warning
was just a symptom.

jon
