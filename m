Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63F224456
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgGQTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:37:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36097C0619D2;
        Fri, 17 Jul 2020 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JdvOnIMuzRyaAgS7loyl4ohlNYZObhXoXVDyvYyDkvY=; b=SDUyObvXWk6i9ha2v5b3oEw0g5
        pdzeDVMm8gFYYJAKtri9ngzEo9bOMMnKNZKGNRGZVhDYuK1t61EXXgNMdZS7gOJTS0Wzv7b3I9egm
        7HuUwYMkZjQVGXd+KAc1fT2vmiBwoTwL5ePX4LeL6E3afC47YOVPlhGd6TGi3VT+IANgADPQUnwCS
        t8K2a6Cfndd0P5N29O9K6g/8Asndh8VclDuJkms2WoAkfQyuiWqFmiQwSwqIMcAX15b6gQe3hEfos
        Cmi/HETOHAUsanl52n5w5RBxaJZbNepC6cSOl0jTu5qHt1dlpQIT5+Ag3iddC+BandwPBKlAWe+ff
        PGKSLt3w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwWB8-0002TH-6B; Fri, 17 Jul 2020 19:37:54 +0000
Subject: Re: [PATCH 07/25] Documentation: gpio/driver.h: fix sphinx warnings
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-7-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
Date:   Fri, 17 Jul 2020 12:37:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-7-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warnings:
> 
> warning: Function parameter or member 'gc' not described in
> 'gpiochip_add_data'
> 
> warning: Excess function parameter 'chip' description in
> 'gpiochip_add_data'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Mauro has already fixed this one.

> ---
>  include/linux/gpio/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index c4f272af7af59..c11261f3c7247 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -481,7 +481,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  
>  /**
>   * gpiochip_add_data() - register a gpio_chip
> - * @chip: the chip to register, with chip->base initialized
> + * @gc: the chip to register, with chip->base initialized
>   * @data: driver-private data associated with this chip
>   *
>   * Context: potentially before irqs will work
> 


-- 
~Randy

