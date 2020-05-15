Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2621D589A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEOSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:04:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE8C061A0C;
        Fri, 15 May 2020 11:04:05 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82EAC72D;
        Fri, 15 May 2020 18:04:05 +0000 (UTC)
Date:   Fri, 15 May 2020 12:04:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] docs: move digsig docs to the security book
Message-ID: <20200515120404.289e2729@lwn.net>
In-Reply-To: <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/{digsig.txt => security/digsig.rst} | 0
>  Documentation/security/index.rst                  | 1 +
>  2 files changed, 1 insertion(+)
>  rename Documentation/{digsig.txt => security/digsig.rst} (100%)
> 
> diff --git a/Documentation/digsig.txt b/Documentation/security/digsig.rst
> similarity index 100%
> rename from Documentation/digsig.txt
> rename to Documentation/security/digsig.rst
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index fc503dd689a7..8129405eb2cc 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -15,3 +15,4 @@ Security Documentation
>     self-protection
>     siphash
>     tpm/index
> +   digsig

Applied, thanks.

jon
