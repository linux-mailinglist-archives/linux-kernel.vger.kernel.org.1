Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39343201C43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbgFSUSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 16:18:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:55564 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFSUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:18:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 86B8323B;
        Fri, 19 Jun 2020 20:18:37 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:18:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] docs: staging: use small font for literal
 includes
Message-ID: <20200619141836.3f0ef847@lwn.net>
In-Reply-To: <2657bf99f750a9c53539c1a4085492a0daaa6d10.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <2657bf99f750a9c53539c1a4085492a0daaa6d10.1592203650.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 08:50:27 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The normal font is too big to display 80 columns, causing extra
> breaks to be added at weird places.
> 
> change to the footnotesize, as this would fit a little bit
> better.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/staging/index.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
> index 8cc9d94b0a13..184e6aece0a7 100644
> --- a/Documentation/staging/index.rst
> +++ b/Documentation/staging/index.rst
> @@ -19,17 +19,41 @@ Unsorted Documentation
>  Atomic Types
>  ============
>  
> +.. raw:: latex
> +
> +    \footnotesize

Is there really no way we can avoid this?  Adding latex markup to RST docs
certainly is not a way to make them prettier...

Thanks,

jon
