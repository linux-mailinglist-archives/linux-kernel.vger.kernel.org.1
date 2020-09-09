Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74A92634D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIIRlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:41:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B45C061573;
        Wed,  9 Sep 2020 10:41:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3BEF17C0;
        Wed,  9 Sep 2020 17:41:37 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:41:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     poeschel@lemonage.de
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] Documentation: iio: fix a typo
Message-ID: <20200909114136.1bae2ac2@lwn.net>
In-Reply-To: <20200904091911.269715-1-poeschel@lemonage.de>
References: <20200904091911.269715-1-poeschel@lemonage.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Sep 2020 11:19:11 +0200
poeschel@lemonage.de wrote:

> Rename function name to the actual name referenced in
> struct iio_sw_trigger_ops.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  Documentation/iio/iio_configfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
> index 6e38cbbd2981..3a5d76f9e2b9 100644
> --- a/Documentation/iio/iio_configfs.rst
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -53,7 +53,7 @@ kernel module following the interface in include/linux/iio/sw_trigger.h::
>  	 */
>    }
>  
> -  static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
> +  static int iio_trig_sample_remove(struct iio_sw_trigger *swt)
>    {

Applied, thanks.

jon
