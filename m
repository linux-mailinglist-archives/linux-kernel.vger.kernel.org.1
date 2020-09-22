Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA2273E28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIVJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIVJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:10:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C417C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:10:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d4so2511342wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTdxb0zAPu2kxNDHiiVz1yQGtJI5ctg2vuStvZG9n+c=;
        b=TCRaakEFzq+QJyoFn5j6BBLtygVsJDqn0uXVtI6THqIniC/Be3Z+ZeG2iQxYaulMRE
         jJlpfVoWNOlU1LhnaquN8c8z7TSVdH1ewk19xmzX0rwsHn3LSSqPKHYpbKZ2TXpSdu0p
         Bc6lkcX66yixQjcy0GMnE54nucTj/Z7LgG5hpRpV5Fu5tvw9OiQV3FyvIqsvUhBKM4K8
         b+5A7pukwm91O+JvzVR0GERlYRCjTHUL0YXQDQZkvjCnbUvoZtEGNqWyAYgziKv188Yl
         7/6FsTiASjpY1qYkKUs08dfNst6mTReFVXhlVse/vk9qvhyG2sRqzxFmpC/eLDZ7nbFQ
         gjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTdxb0zAPu2kxNDHiiVz1yQGtJI5ctg2vuStvZG9n+c=;
        b=Y3HoKEPj12umLcDA8XntWBwylz0dOn0JeGzlzGp3N7jJEnjbUg6mb8H/HjUWWk0rS4
         D24zLLW4q6Qo+q9/oUBvHUfGMYQ6WaX5jrLMt5gL70f/xxk0AGhgz5MzPAIi0KwGtMjS
         eAYEPMvalYIp62nQbLqWQNoZz0CCzhiuHxkP6s9OWl5nHekQh/DS9Ed3++72fzv7eVTd
         TED2L2/KVzaa/6C168XIsVs0LGj2tsm3/5hPLxO/WVfk1TxgQgXZccRPTqmOWh7X+JQ+
         6+SmPtxKEbrjl3L7VJeZ970l2QUA8kzcXbi7ilQV2kXOQ0jAUH+VqOdKNoTwZHtIB56C
         f2sQ==
X-Gm-Message-State: AOAM532m5M3+rZytWNoFku88GQWtpGQ79qqeHz9IXv+lUefpyMS1e4V2
        jsXDzr6ABnt/yKDMXld3T6WyNAM9FjX15Q==
X-Google-Smtp-Source: ABdhPJwHlrSXW/ckAl7IDPO3bePA4/ajKFF3Ux+50Cp/0vdT8b497QF7Kk3cJihG3d27RYwI1kiDtA==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3347723wmi.173.1600765810537;
        Tue, 22 Sep 2020 02:10:10 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id t4sm25506608wrr.26.2020.09.22.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 02:10:09 -0700 (PDT)
Subject: Re: Expose 'array_length()' macro in <sys/param.h>
To:     Ville Voutilainen <ville.voutilainen@gmail.com>,
        Jonathan Wakely <jwakely@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     gcc@gcc.gnu.org, libstdc++ <libstdc++@gcc.gnu.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        libc-coord@lists.openwall.com, LKML <linux-kernel@vger.kernel.org>
References: <946e9377-0558-3adf-3eb9-38c507afe2d0@gmail.com>
 <874knr8qyl.fsf@oldenburg2.str.redhat.com>
 <dbcf5c85-c468-72f8-0f83-92ec2a6a2991@gmail.com>
 <875z875si2.fsf@oldenburg2.str.redhat.com>
 <20200921140100.GA449323@redhat.com>
 <e734429a-d543-7e75-48e9-a8297a94b035@gmail.com>
 <20200921220443.GP6061@redhat.com>
 <CAFk2RUbEtvgFb_FZmcM9L4-g1kG_E7S2p9gveM0Z5Fe=zEDm9w@mail.gmail.com>
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <34bae433-f67e-877d-f871-928cb55d2a87@gmail.com>
Date:   Tue, 22 Sep 2020 11:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFk2RUbEtvgFb_FZmcM9L4-g1kG_E7S2p9gveM0Z5Fe=zEDm9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[ CC += LKML ]]

Thanks for all your input.  I learned some C++ :)

The following code works for all C and C++ standards:
g++ --std={c++98, c++03, c++11, c++14, c++17, c++20}
gcc --std={c89, c99, c11, c18, c2x}
With `-Wall -Wextra -Werror -pedantic -Wno-vla -Wno-sizeof-pointer-div`.
It doesn't compile when '+ __array_length(p)' is uncommented.
It compiles, and returns the correct value (18).
  With some exceptions:
c++ doesn't accept the VLA (w[]):

array_length.c: In function 'int main()':
array_length.c:101:22: error: no matching function for call to 
'__array_slength(int [y])'
   101 |   + __array_slength(w)
       |                      ^
array_length.c:38:1: note: candidate: 'template<class T, long int N> 
std::ptrdiff_t __array_slength(const T (&)[N])'
    38 | __array_slength(const T(&)[N])
       | ^~~~~~~~~~~~~~~
array_length.c:38:1: note:   template argument deduction/substitution 
failed:
array_length.c:101:22: note:   variable-sized array type 'long int' is 
not a valid template argument
   101 |   + __array_slength(w)
       |                      ^

But we can live with limited support for VLAs in C++.
So I needed to comment '+ __array_slength(w)',
and then the program correctly returns 11.

As Ville suggested, I renamed the function/macro to __array_[s]length().
However, (some) BSDs already provide nitems() in <sys/param.h>,
so it probably wouldn't be very drastic to
provide this function/macro with the name '[s]nitems()' there.

Would you like to add anything else before I write the patch?


BTW, I should note one more thing:

Linux has a macro named '__must_be_array()' with the same API,
but slightly different internal implementation,
so they should be aware of this change.
However, I don't think they include <sys/param.h> a lot,
so maybe it doesn't break anything; but they should be aware anyway.
I CC'd the LKML so they are aware and can give any suggestions.

Thanks,

Alex


------------------------------------------------------------------------

#if defined(__cplusplus)

# include <cstddef>
# if __cplusplus >= 201703L
#  include <iterator>
# endif

template<typename T, std::size_t N>
# if __cplusplus >= 201103L
constexpr
# endif
inline std::size_t
# if __cplusplus >= 201703L
__array_length(const T(&arr)[N])
# else
__array_length(const T(&)[N])
# endif
# if __cplusplus >= 201103L
noexcept
# endif
{
# if __cplusplus >= 201703L
	return	std::size(arr);
# else
	return	N;
# endif
}

template<typename T, std::ptrdiff_t N>
# if __cplusplus >= 201103L
constexpr
# endif
inline std::ptrdiff_t
# if __cplusplus >= 202002L
__array_slength(const T(&arr)[N])
# else
__array_slength(const T(&)[N])
# endif
# if __cplusplus >= 201103L
noexcept
# endif
{
# if __cplusplus >= 202002L
	return	std::ssize(arr);
# else
	return	N;
# endif
}


#else /* !defined(__cplusplus) */
#include <stddef.h>

# define __is_same_type(a, b)						\
	__builtin_types_compatible_p(__typeof__(a), __typeof__(b))
# define __is_array(arr)	(!__is_same_type((arr), &(arr)[0]))

# if __STDC_VERSION__ >= 201112L
#  define __must_be(e, msg)	(					\
	0 * (int)sizeof(						\
		struct {						\
			_Static_assert((e), msg);			\
			char ISO_C_forbids_a_struct_with_no_members__;	\
		}							\
	)								\
)
# else
#  define __must_be(e, msg)	(					\
	0 * (int)sizeof(						\
		struct {						\
			int	: (-!(e));				\
			char ISO_C_forbids_a_struct_with_no_members__;	\
		}							\
	)								\
)
# endif

# define __must_be_array(arr)	__must_be(__is_array(arr), "Must be an 
array!")

# define __array_len(arr)	(sizeof(arr) / sizeof((arr)[0]))
# define __array_length(arr)	(__array_len(arr) + __must_be_array(arr))
# define __array_slength(arr)	((ptrdiff_t)__array_length(arr))
#endif


int main(void)
{
	int a[5];
	const int x = 6;
	int v[x];
	int y = 7;
	int w[y];
	int *p;
	(void)p;
	(void)v;
	(void)w;

	return	__array_slength(a)
		+ __array_slength(v)
		+ __array_slength(w)
//		+ __array_length(p)
		;
}
