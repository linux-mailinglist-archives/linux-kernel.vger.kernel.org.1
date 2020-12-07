Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573442D0FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgLGMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgLGMD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:03:27 -0500
Date:   Mon, 7 Dec 2020 13:02:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607342566;
        bh=T60EYM3kMV21qsg9PIdxTYnnz7M8skytCR7MJuhDXTw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=efdPqug0yRu0i0SDHuH75YtbPk/3gaFbvUNK6JT0BTy4mcIe3nENFBP+Tq5/BEhyA
         EiB1HQn78h7aOB/c/iGgD11laslcQ+hjT+uhmcfFL3SjSkSbwImBj1UwY35C3uaVO5
         a1KU9XTJ9dofSVu52IidJzv9QLfAN7qdRqX8RhzF3bFBCgkMwkvFJZIxixQcF0PX16
         pCJ4BfE9c7GmY4eglm3IPzlR7aFMHozhkxQC19d0lnvFyiQdtmHtEIxN0NQUIosU3h
         vcZQcwNf1YgUqzLGJjcCedAtT56MCm1FySAZhpR1izmkJQ/fhIEYrZPOtb3lEF3xWk
         Prsadxm2sQGjg==
From:   Jessica Yu <jeyu@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: drop semicolon from version macro
Message-ID: <20201207120242.GA14180@linux-8ccs>
References: <20201207091308.1217-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201207091308.1217-1-johan@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Johan Hovold [07/12/20 10:13 +0100]:
>Drop the trailing semicolon from the MODULE_VERSION() macro definition
>which was left when removing the array-of-pointer indirection.
>
>Signed-off-by: Johan Hovold <johan@kernel.org>

Applied, thanks!

Jessica

>---
> include/linux/module.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index ebe2641d7b0b..b63db970fd26 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -279,7 +279,7 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
> 			},						\
> 			.module_name	= KBUILD_MODNAME,		\
> 			.version	= _version,			\
>-		};
>+		}
> #endif
>
> /* Optional firmware file (or files) needed by the module
>-- 
>2.26.2
>
