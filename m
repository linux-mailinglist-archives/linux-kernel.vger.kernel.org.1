Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959A6274474
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIVOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:39:37 -0400
Received: from thoth.sbs.de ([192.35.17.2]:49103 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:39:37 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 10:39:36 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 08MEW4xx001606
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 16:32:04 +0200
Received: from [139.22.130.132] ([139.22.130.132])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08MEW2GL031527;
        Tue, 22 Sep 2020 16:32:03 +0200
Subject: Re: [PATCH] scripts/gdb: fix list_for_each
To:     George Prekas <prekageo@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>
References: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2516a051-306f-670b-1f9e-d46fc577c7f8@siemens.com>
Date:   Tue, 22 Sep 2020 16:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 16:28, George Prekas wrote:
> If the next pointer is NULL, list_for_each gets stuck in an infinite
> loop.
> 
> Signed-off-by: George Prekas <prekageo@amazon.com>
> ---
>   scripts/gdb/linux/lists.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
> index c487ddf09d38..424a91c1aa8b 100644
> --- a/scripts/gdb/linux/lists.py
> +++ b/scripts/gdb/linux/lists.py
> @@ -27,6 +27,8 @@ def list_for_each(head):
>           raise TypeError("Must be struct list_head not {}"
>                              .format(head.type))
> 
> +    if head['next'] == 0:
> +        return
>       node = head['next'].dereference()
>       while node.address != head.address:
>           yield node.address

Obviously, infinite loops are bad and should be avoided. But NULL is 
bug, isn't it? Shouldn't we report such a corruption?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
