Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D584273EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIVJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600767627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFaYWl9y6maxkGFuHtFhNugW9vc6NhhO2VDs3o2V5HI=;
        b=LWlfujQKnAhFmTDW27IbhWbKWAqZeS3p0rGGRHgknJhNr+ZF/2OUxz9LaParhE06Z7fjlo
        wYblcXogHky3SEdtrR8xW26HA7VTMfIL29MAMOV7UhSTf4nzveW5DPaCOAJhq5T3JMujR5
        bSaXWlhoJ/iiEvGTycaeggOhwltM84A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-SuCItxG2MgebvJ5vQjuOtA-1; Tue, 22 Sep 2020 05:40:23 -0400
X-MC-Unique: SuCItxG2MgebvJ5vQjuOtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4761017DC2;
        Tue, 22 Sep 2020 09:40:21 +0000 (UTC)
Received: from localhost (unknown [10.33.36.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6971810013BD;
        Tue, 22 Sep 2020 09:40:21 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:40:20 +0100
From:   Jonathan Wakely <jwakely@redhat.com>
To:     Alejandro Colomar <colomar.6.4.3@gmail.com>
Cc:     Ville Voutilainen <ville.voutilainen@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, gcc@gcc.gnu.org,
        libstdc++ <libstdc++@gcc.gnu.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-coord@lists.openwall.com
Subject: Re: Expose 'array_length()' macro in <sys/param.h>
Message-ID: <20200922094020.GS6061@redhat.com>
References: <946e9377-0558-3adf-3eb9-38c507afe2d0@gmail.com>
 <874knr8qyl.fsf@oldenburg2.str.redhat.com>
 <dbcf5c85-c468-72f8-0f83-92ec2a6a2991@gmail.com>
 <875z875si2.fsf@oldenburg2.str.redhat.com>
 <20200921140100.GA449323@redhat.com>
 <e734429a-d543-7e75-48e9-a8297a94b035@gmail.com>
 <20200921220443.GP6061@redhat.com>
 <CAFk2RUbEtvgFb_FZmcM9L4-g1kG_E7S2p9gveM0Z5Fe=zEDm9w@mail.gmail.com>
 <34bae433-f67e-877d-f871-928cb55d2a87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <34bae433-f67e-877d-f871-928cb55d2a87@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/20 11:10 +0200, Alejandro Colomar via Libstdc++ wrote:
>[[ CC += LKML ]]
>
>Thanks for all your input.  I learned some C++ :)
>
>The following code works for all C and C++ standards:
>g++ --std={c++98, c++03, c++11, c++14, c++17, c++20}
>gcc --std={c89, c99, c11, c18, c2x}
>With `-Wall -Wextra -Werror -pedantic -Wno-vla -Wno-sizeof-pointer-div`.
>It doesn't compile when '+ __array_length(p)' is uncommented.
>It compiles, and returns the correct value (18).
> With some exceptions:
>c++ doesn't accept the VLA (w[]):
>
>array_length.c: In function 'int main()':
>array_length.c:101:22: error: no matching function for call to 
>'__array_slength(int [y])'
>  101 |   + __array_slength(w)
>      |                      ^
>array_length.c:38:1: note: candidate: 'template<class T, long int N> 
>std::ptrdiff_t __array_slength(const T (&)[N])'
>   38 | __array_slength(const T(&)[N])
>      | ^~~~~~~~~~~~~~~
>array_length.c:38:1: note:   template argument deduction/substitution 
>failed:
>array_length.c:101:22: note:   variable-sized array type 'long int' is 
>not a valid template argument
>  101 |   + __array_slength(w)
>      |                      ^
>
>But we can live with limited support for VLAs in C++.
>So I needed to comment '+ __array_slength(w)',
>and then the program correctly returns 11.
>
>As Ville suggested, I renamed the function/macro to __array_[s]length().
>However, (some) BSDs already provide nitems() in <sys/param.h>,
>so it probably wouldn't be very drastic to
>provide this function/macro with the name '[s]nitems()' there.
>
>Would you like to add anything else before I write the patch?
>
>
>BTW, I should note one more thing:
>
>Linux has a macro named '__must_be_array()' with the same API,
>but slightly different internal implementation,
>so they should be aware of this change.
>However, I don't think they include <sys/param.h> a lot,
>so maybe it doesn't break anything; but they should be aware anyway.
>I CC'd the LKML so they are aware and can give any suggestions.
>
>Thanks,
>
>Alex
>
>
>------------------------------------------------------------------------
>
>#if defined(__cplusplus)
>
># include <cstddef>
># if __cplusplus >= 201703L
>#  include <iterator>
># endif
>
>template<typename T, std::size_t N>

You need to use reserved names here.

># if __cplusplus >= 201103L
>constexpr
># endif
>inline std::size_t
># if __cplusplus >= 201703L
>__array_length(const T(&arr)[N])
># else
>__array_length(const T(&)[N])
># endif
># if __cplusplus >= 201103L
>noexcept

If this is going to be part of Glibc then you can use its __THROW
macro instead.


># endif
>{
># if __cplusplus >= 201703L
>	return	std::size(arr);
># else
>	return	N;
># endif
>}

I don't see much point in using std::size here. If you're going to
provide the alternative implementation for when std::size isn't
defined, why not just use it always?

template<typename _Tp, std::size_t _Num>
#if __cplusplus >= 201103L
constexpr
#endif
inline std::size_t
__array_length(const _Tp(&)[_Num]) __THROW
{
   return _Num;
}

This only requires <cstddef>, not <iterator>.

>
>template<typename T, std::ptrdiff_t N>

This declaration is wrong, the array extent has type std::size_t. The
type you return from the function doesn't change that.

The __array_slength definition should be identical to __array_length
except for its name and return type.

template<typename _Tp, std::size_t _Num>
#if __cplusplus >= 201103L
constexpr
#endif
inline std::ptrdiff_t
__array_slength(const _Tp(&)[_Num]) __THROW
{
   return _Num;
}


>
>
>#else /* !defined(__cplusplus) */
>#include <stddef.h>
>
># define __is_same_type(a, b)						\
>	__builtin_types_compatible_p(__typeof__(a), __typeof__(b))
># define __is_array(arr)	(!__is_same_type((arr), &(arr)[0]))
>
># if __STDC_VERSION__ >= 201112L
>#  define __must_be(e, msg)	(					\
>	0 * (int)sizeof(						\
>		struct {						\
>			_Static_assert((e), msg);			\
>			char ISO_C_forbids_a_struct_with_no_members__;	\
>		}							\
>	)								\
>)
># else
>#  define __must_be(e, msg)	(					\
>	0 * (int)sizeof(						\
>		struct {						\
>			int	: (-!(e));				\
>			char ISO_C_forbids_a_struct_with_no_members__;	\
>		}							\
>	)								\
>)
># endif
>
># define __must_be_array(arr)	__must_be(__is_array(arr), "Must be an 
>array!")
>
># define __array_len(arr)	(sizeof(arr) / sizeof((arr)[0]))
># define __array_length(arr)	(__array_len(arr) + __must_be_array(arr))
># define __array_slength(arr)	((ptrdiff_t)__array_length(arr))
>#endif
>
>
>int main(void)
>{
>	int a[5];
>	const int x = 6;
>	int v[x];
>	int y = 7;
>	int w[y];
>	int *p;
>	(void)p;
>	(void)v;
>	(void)w;
>
>	return	__array_slength(a)
>		+ __array_slength(v)
>		+ __array_slength(w)
>//		+ __array_length(p)
>		;
>}
>

