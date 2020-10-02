Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BF280E2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgJBHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:39:10 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:52806 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:39:10 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kOFea-0006bL-EH; Fri, 02 Oct 2020 07:38:56 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kOFeY-0004R7-99; Fri, 02 Oct 2020 08:38:56 +0100
Subject: Re: [PATCH 3/6] docs: virt: user_mode_linux_howto_v2.rst: fix a
 literal block markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
 <ce8a23cd0f138bd69ccc196e6dbe312da1044938.1601616399.git.mchehab+huawei@kernel.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4ba279b1-7119-e3a5-3b77-6751d5ec3221@cambridgegreys.com>
Date:   Fri, 2 Oct 2020 08:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ce8a23cd0f138bd69ccc196e6dbe312da1044938.1601616399.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2020 06:49, Mauro Carvalho Chehab wrote:
> There's a missing new line for a literal block:
> 
> 	.../Documentation/virt/uml/user_mode_linux_howto_v2.rst:682: WARNING: Unexpected indentation.
> 
> Fixes: 04301bf5b072 ("docs: replace the old User Mode Linux HowTo with a new one")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index f70e6f5873c6..312e431695d9 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -679,6 +679,7 @@ Starting UML
>   
>   We can now run UML.
>   ::
> +
>      # linux mem=2048M umid=TEST \
>       ubd0=Filesystem.img \
>       vec0:transport=tap,ifname=tap0,depth=128,gro=1 \
> 

Thanks.

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
