Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C341F1C42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgFHPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:41:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:47246 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgFHPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:41:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 95FA7735;
        Mon,  8 Jun 2020 15:41:04 +0000 (UTC)
Date:   Mon, 8 Jun 2020 09:41:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: devres: add missing entry for
 devm_platform_get_and_ioremap_resource()
Message-ID: <20200608094103.1c367f61@lwn.net>
In-Reply-To: <20200527144531.9376-1-zhengdejin5@gmail.com>
References: <20200527144531.9376-1-zhengdejin5@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 22:45:31 +0800
Dejin Zheng <zhengdejin5@gmail.com> wrote:

> The devm_platform_get_and_ioremap_resource() should be documented in
> devres.rst. Add the missing entry.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 89681264ee2c..713b44deb0bf 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -314,6 +314,7 @@ IOMAP
>    devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
>    devm_platform_ioremap_resource_wc()
>    devm_platform_ioremap_resource_byname()
> +  devm_platform_get_and_ioremap_resource()

Applied, thanks.

jon
