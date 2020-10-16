Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36A28FC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 02:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgJPAZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 20:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgJPAZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 20:25:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D39C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:25:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so419168pfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UxtsBGSGwNjzSj8yYCxj7NEqWqSlTd7zaXgi6xi2GM=;
        b=ZyQbjNqSLLeS0aTKY99f3gC+Sro9RcmWf/RnsJF+jiE4aBM+eqrZUBKN0spSxeIpYm
         KLJrsm+XZnC7VhAzM3GKHq4s2ZKh8E+lXXD+AwvH5vqbhMSrFhto76rgSDhzGiMrLiHE
         GnAoI5v0SdMx6AX/uIaNOMwpQj4DGal1Ftqu76rRkxXGD6hF73uLEzdPyQi6SIKUysDX
         NqPb6qNreaZ3Jcz+iQKFHcSZVohtoAP5xIf/X3Ee05OQxSVOQUQiQD7UVpwOP/mtBKyh
         tJ14RFPDMziXIkpG7vd1BP4Xk7foUrNcnezB950Z/1KOQSEgpvs0fRaz+umTj0T9UZqD
         JjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UxtsBGSGwNjzSj8yYCxj7NEqWqSlTd7zaXgi6xi2GM=;
        b=LGLIR13SKR9hn9YVRzF3KV8z+K1nzSB960TwqG7pLgYWX0CgGXqF8iuw8nWp0xHo/I
         Nb0TMLi0CYkkWIyw7Q7sd3D1wL+gyBRpA9gj3cqN7RFpJipKi99hmPwps7mM8w9nkLOy
         wKYUSxGXcyHQ+bPTkGtOq5kNuBewkEkajq5q3iRWnUfWzNdHYdwFDALledMfJujOQSkW
         8Zy0wZ4pS7NNmPiMxkS8tszkUCXzA9ewTNVYljUc6P9GWRJNQ2Qo4z/YivoGSoyC7dvh
         AV33G22Coll1Pdu9kpCJEIWwy3tgX1koSgROZLmQHLlSkkx7hLeH0uEMLNz4LwP7VHA1
         sF6A==
X-Gm-Message-State: AOAM5329kvHOw5CH83CLtqlJnOx8MRko3sl2a1C49JEe3q8yrv3us3sg
        IJcuB31oXNuPESkGD8f86Dg=
X-Google-Smtp-Source: ABdhPJz3tnzpr+xwKV4AdKcSgsGhigbeR44dtzhfZejNEB7xp0069Hy+kmO/EhVTWKnfMf+nmdSXIQ==
X-Received: by 2002:a62:6dc3:0:b029:13c:1611:658d with SMTP id i186-20020a626dc30000b029013c1611658dmr1143294pfc.10.1602807951229;
        Thu, 15 Oct 2020 17:25:51 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id c4sm515076pjq.7.2020.10.15.17.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 17:25:50 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:25:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, rajekumar@google.com,
        amosbianchi@google.com, joaodias@google.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] zram: support a page writeback
Message-ID: <20201016002547.GA2412725@google.com>
References: <20201012071452.1613131-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012071452.1613131-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/12 00:14), Minchan Kim wrote:
>  
>  With the command, zram writeback idle pages from memory to the storage.
>  
> +If admin want to write a specific page in zram device to backing device,
> +they could write the page index into the interface.
> +
> +	echo 1251 > /sys/block/zramX/writeback
> +

May be we can make it more explicit?

	echo "page_index=123" > /sys/block/zramX/writeback

Just in case of future extensions. E.g. someone might want to
have something like

	echo "idle_nr=123" > /sys/block/zramX/writeback

which would write_back 123 idle pages max.

	-ss
