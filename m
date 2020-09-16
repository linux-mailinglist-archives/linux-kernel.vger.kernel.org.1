Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1226C502
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIPQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIPQPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B7F2244C;
        Wed, 16 Sep 2020 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600269625;
        bh=nCkDr26U4SwwcHACzpgVfCrIekCSJ6m0GK/nle2iNgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VM7uIJzcusXd2vwU4Mxtp1xTudLbT5jkQjwkYCdPc6hiqEQG0d93wjcqeMx5KlACs
         d0AyU9JjCb1eVp+NFtNL6lDOo64/QunSBG4OOxk4XnorWJ9frUxzuwQgew+aAyCPyr
         KplZIXhQse2m3tDVvuI3p9AmdwzAQzaYNmSBf+gs=
Date:   Wed, 16 Sep 2020 17:20:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     davem@davemloft.net, vkoul@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitfield.h: annotate type_replace_bits functions with
 __must_check
Message-ID: <20200916152059.GA3018065@kroah.com>
References: <20200916150333.11790-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916150333.11790-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:03:33PM +0100, Srinivas Kandagatla wrote:
> usage of apis like u32_replace_bits() without actually catching the return
> value could hide problems without any warning!
> 
> Found this with recent usage of this api in SoundWire!
> Having __must_check annotation would really catch this issues in future!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/linux/bitfield.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 4e035aca6f7e..eb4f69253946 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -131,7 +131,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
>  		__field_overflow();					\
>  	return to((v & field_mask(field)) * field_multiplier(field));	\
>  }									\
> -static __always_inline __##type type##_replace_bits(__##type old,	\
> +static __always_inline __must_check __##type type##_replace_bits(__##type old, \
>  					base val, base field)		\
>  {									\
>  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
> -- 
> 2.21.0
> 

Don't add __must_check to things that if merged will instantly cause
build warnings to the system, that's just rude :(

Fix up everything first, and then try to make this type of change.

But why does this function have to be checked?

thanks,

greg k-h
