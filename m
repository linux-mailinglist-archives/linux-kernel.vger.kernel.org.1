Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4A26D31B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 07:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIQFah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 01:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgIQFaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:30:30 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:30:30 EDT
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7195820872;
        Thu, 17 Sep 2020 05:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600320244;
        bh=UGaV4bPDAIQKtAtd9YR88RIFno2wkC9EtNA2IyAhL74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w37CBUhxXjLcNTQwpYRXoCYtiOQ253HRAqe6sUGlOiirWNiUbjy4DYLDp6ooGfDHg
         wa6WYy86p/QMso1Ub0WrRyvKVvvgfuqF5MyDIlB7NW6ILpggMyUjDuNr6+cDJjQ1aH
         UDMqkdYvN02eDQ+Z2AcJer8uQYzc1jlKS0p4TKLs=
Date:   Thu, 17 Sep 2020 07:24:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitfield.h: annotate type_replace_bits functions with
 __must_check
Message-ID: <20200917052400.GA44257@kroah.com>
References: <20200916150333.11790-1-srinivas.kandagatla@linaro.org>
 <20200916152059.GA3018065@kroah.com>
 <66657ed6-b8ef-7e8d-b77c-9fd65453f53e@linaro.org>
 <20200917040459.GU2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917040459.GU2968@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:34:59AM +0530, Vinod Koul wrote:
> On 16-09-20, 16:33, Srinivas Kandagatla wrote:
> > 
> > 
> > On 16/09/2020 16:20, Greg KH wrote:
> > > On Wed, Sep 16, 2020 at 04:03:33PM +0100, Srinivas Kandagatla wrote:
> > > > usage of apis like u32_replace_bits() without actually catching the return
> > > > value could hide problems without any warning!
> > > > 
> > > > Found this with recent usage of this api in SoundWire!
> > > > Having __must_check annotation would really catch this issues in future!
> > > > 
> > > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > ---
> > > >   include/linux/bitfield.h | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > > > index 4e035aca6f7e..eb4f69253946 100644
> > > > --- a/include/linux/bitfield.h
> > > > +++ b/include/linux/bitfield.h
> > > > @@ -131,7 +131,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
> > > >   		__field_overflow();					\
> > > >   	return to((v & field_mask(field)) * field_multiplier(field));	\
> > > >   }									\
> > > > -static __always_inline __##type type##_replace_bits(__##type old,	\
> > > > +static __always_inline __must_check __##type type##_replace_bits(__##type old, \
> > > >   					base val, base field)		\
> > > >   {									\
> > > >   	return (old & ~to(field)) | type##_encode_bits(val, field);	\
> > > > -- 
> > > > 2.21.0
> > > > 
> > > 
> > > Don't add __must_check to things that if merged will instantly cause
> > > build warnings to the system, that's just rude :(
> > Currently there are not many users for this api, found only one instance in
> > drivers/net/ipa/ipa_table.c which is also fixed with
> > https://lkml.org/lkml/2020/9/10/1062
> > 
> > > 
> > > Fix up everything first, and then try to make this type of change.
> > > 
> > > But why does this function have to be checked?
> > As this function would return updated value, this check is more to with
> > using the return value!
> > 
> > It is easy for someone to ignore this return value assuming that the new
> > value is already updated! So this check should help!
> > 
> > TBH, This is what happened when we(vkoul and me) tried use this api :-)
> 
> So the only user of this has been moved to *p_replace_bits(), looking
> back I think we should remove *_replace_bits (no users atm) and
> duplicate of *p_replace_bits(). If not adding this patch would be
> sensible thing to do
> 
> Somehow I feel former is a better idea ;-)

Yes, please remove it if there is no users.

thanks,

greg k-h
