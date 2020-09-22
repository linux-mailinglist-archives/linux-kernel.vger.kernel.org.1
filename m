Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F4273FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIVKfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:35:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCBDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:35:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z4so16476784wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=roOj8Ic3xVBO/rczqg6fqm0GK6U72VCqVKzFiVUYYHk=;
        b=I4rNcLriTCS2FY9k5N5lQdRa2a4PFB7HD2lX36avFJMTo+sLh9DGn5P7mOUQyOMDiH
         b8+OftoqJJHDXvlVa9qDvLGvU4uHtAiju3Tk3jH/3jU1i0L7u4pxnRg3WD9JB1lGo616
         j9X6y7I7ambmSldg+Ln9esFoAIBiqWYsBb1Wy8AGc3nHDQne6Jmdb/HsORRG6iuURI/M
         r1dXat6g52+bSfGXpGzBb7MiHcYDmNCrJI6VdDUrOeKYL4+oNjn60XNBd1thkQsWHoq8
         5Uf+uCMgbCbHn7bIWHMqu6sGrA4sLJ7Eq0FOGo8K978jDcGwaRg/k7wsFOKi8Gs1zmV/
         3jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=roOj8Ic3xVBO/rczqg6fqm0GK6U72VCqVKzFiVUYYHk=;
        b=lV+BU/C2DXXUeos4Wc6yH6LHRS1tq018Ai5eGTb7+XDRJ/363YBczfJ6NExfkb/Ss7
         Y7FjKNYVMDCjuDgLKxXUMcTDhSn+XoB4Y7t427julN4bIJmTrxu+PeY/gqVuX+cYG/WV
         srqb0/EDm08dEg0qjy8ye2iJQ5lgl9+Qi1VrTX6q5d7zjwNMa9ypI2mAeBCXLNclgxog
         UUpMD4q/Ma91exzqmveIJjIYjbnr/mXOOVz1SLGK/nsLT+pKViievMbJ3Rr7HPR60Ur7
         4wCx399K4t8UZTrLDOfgZQ7NjziSBTCGyckMxI3srG3YB2VN2dM/ILlpPsetcdwcLP6r
         /TuA==
X-Gm-Message-State: AOAM533Cuysc9yyTWOISXSmDI/nW7UR6FTH6zjftxrHmpoQSEQSFVfVq
        fkE9OWJcm2CAbDR2jhBNUos=
X-Google-Smtp-Source: ABdhPJwCY89BgE4rLoBq0MuI57v1cZmNvNbJ3Kv5eCRNH1ofAiSh4nuHUCEMtdmOjZAcBm+W7nh1uw==
X-Received: by 2002:adf:8187:: with SMTP id 7mr4675663wra.266.1600770923206;
        Tue, 22 Sep 2020 03:35:23 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id 2sm3799236wmf.25.2020.09.22.03.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:35:22 -0700 (PDT)
Subject: Re: Expose 'array_length()' macro in <sys/param.h>
To:     Florian Weimer <fweimer@redhat.com>,
        Jonathan Wakely <jwakely@redhat.com>
Cc:     Ville Voutilainen <ville.voutilainen@gmail.com>, gcc@gcc.gnu.org,
        libstdc++ <libstdc++@gcc.gnu.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-coord@lists.openwall.com
References: <946e9377-0558-3adf-3eb9-38c507afe2d0@gmail.com>
 <874knr8qyl.fsf@oldenburg2.str.redhat.com>
 <dbcf5c85-c468-72f8-0f83-92ec2a6a2991@gmail.com>
 <875z875si2.fsf@oldenburg2.str.redhat.com>
 <20200921140100.GA449323@redhat.com>
 <e734429a-d543-7e75-48e9-a8297a94b035@gmail.com>
 <20200921220443.GP6061@redhat.com>
 <CAFk2RUbEtvgFb_FZmcM9L4-g1kG_E7S2p9gveM0Z5Fe=zEDm9w@mail.gmail.com>
 <34bae433-f67e-877d-f871-928cb55d2a87@gmail.com>
 <20200922094020.GS6061@redhat.com> <87k0wmyvtt.fsf@oldenburg2.str.redhat.com>
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <ebe90ee6-b227-d1cf-c1a4-6b03b0037049@gmail.com>
Date:   Tue, 22 Sep 2020 12:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87k0wmyvtt.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again for your improvements.

I think this might be ready for a patch already.
Any more thoughts?

Thanks,

Alex

------------------------


#if defined(__cplusplus)
# include <cstddef>

# if __cplusplus >= 201103L
template<typename _Tp, std::size_t _Len>
constexpr inline std::size_t
__array_length(const _Tp(&)[_Len]) __THROW
{
	return	_Len;
}

template<typename _Tp, std::size_t _Len>
constexpr inline std::ptrdiff_t
__array_slength(const _Tp(&)[_Len]) __THROW
{
	return	_Len;
}
# else /* __cplusplus < 201103L */
template<typename _Tp, std::size_t _Len>
char (&__array_length(const _Tp(&)[_Len]))[_Len];
#  define __array_length(_Arr)	(sizeof(__array_length(_Arr)))
#  define __array_slength(_Arr)						\
	(static_cast<std::ptrdiff_t>(__array_length(_Arr)))
# endif /* __cplusplus >= 201103L */


#else /* !defined(__cplusplus) */
#include <stddef.h>

# define __is_same_type(_A, _B)						\
	__builtin_types_compatible_p(__typeof__(_A), __typeof__(_B))
# define __is_array(_Arr)	(!__is_same_type((_Arr), &(_Arr)[0]))

# if __STDC_VERSION__ >= 201112L
#  define __must_be(_Expr, _Msg)	(				\
	0 * (int)sizeof(						\
		struct {						\
			_Static_assert((_Expr), _Msg);			\
			char _ISO_C_forbids_a_struct_with_no_members;	\
		}							\
	)								\
)
# else
#  define __must_be(_Expr, _Msg)	(				\
	0 * (int)sizeof(						\
		struct {						\
			int	: (-!(_Expr));				\
			char _ISO_C_forbids_a_struct_with_no_members;	\
		}							\
	)								\
)
# endif

# define __must_be_array(_Arr)	__must_be(__is_array(_Arr), "Must be an 
array!")

# define __array_len(_Arr)	(sizeof(_Arr) / sizeof((_Arr)[0]))
# define __array_length(_Arr)	(__array_len(_Arr) + __must_be_array(_Arr))
# define __array_slength(_Arr)	((ptrdiff_t)__array_length(_Arr))
#endif /* defined(__cplusplus) */


static int a[5];
static int v[__array_slength(a)];
static int w[__array_length(v)];
static int *p;

int main(void)
{
	int aa[5];
	const int xx = 6;
	int vv[xx];
	int yy = 7;
	int ww[yy];
	int *pp;

	(void)p;
	(void)pp;
	(void)ww;

	return	__array_slength(a)
		+ __array_length(v)
		+ __array_slength(w)
/*		+ __array_length(p) */ /* Always breaks :) */
		+ __array_length(aa)
		+ __array_slength(vv)
		+ __array_length(ww) /* Not in C++ */
/*		+ __array_length(pp) */ /* Always breaks :) */
		;
}
