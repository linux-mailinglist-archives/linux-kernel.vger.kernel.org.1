Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43712A0683
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgJ3Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:33:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:33:57 -0400
Received: from [IPv6:2003:c7:cf1c:4d00:58b3:6683:91ae:b6a8] (p200300c7cf1c4d0058b3668391aeb6a8.dip0.t-ipconnect.de [IPv6:2003:c7:cf1c:4d00:58b3:6683:91ae:b6a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 06CB61F45FE1;
        Fri, 30 Oct 2020 13:33:54 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] docs: automarkup.py: Use new C roles in Sphinx 3
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
 <20201013231218.2750109-2-nfraprado@protonmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
Date:   Fri, 30 Oct 2020 14:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013231218.2750109-2-nfraprado@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 14.10.20 um 01:13 schrieb Nícolas F. R. A. Prado:
> While Sphinx 2 used a single c:type role for struct, union, enum and
> typedef, Sphinx 3 uses a specific role for each one.
> To keep backward compatibility, detect the Sphinx version and use the
> correct roles for that version.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
>   Documentation/sphinx/automarkup.py | 55 ++++++++++++++++++++++++++----
>   1 file changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> index a1b0f554cd82..db13fb15cedc 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -23,7 +23,21 @@ from itertools import chain
>   # bit tries to restrict matches to things that won't create trouble.
>   #
>   RE_function = re.compile(r'(([\w_][\w\d_]+)\(\))')
> -RE_type = re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
> +
> +#
> +# Sphinx 2 uses the same :c:type role for struct, union, enum and typedef
> +#
> +RE_generic_type = re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
> +
> +#
> +# Sphinx 3 uses a different C role for each one of struct, union, enum and
> +# typedef
> +#
> +RE_struct = re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> +RE_union = re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> +RE_enum = re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> +RE_typedef = re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=re.ASCII)

I use ubuntu 18.04, my default python is 2.7,
when running 'make htmldocs' with that fix I get:

AttributeError: 'module' object has no attribute 'ASCII'

Thanks,
Dafna

> +
>   #
>   # Detects a reference to a documentation page of the form Documentation/... with
>   # an optional extension
> @@ -48,9 +62,22 @@ def markup_refs(docname, app, node):
>       #
>       # Associate each regex with the function that will markup its matches
>       #
> -    markup_func = {RE_type: markup_c_ref,
> -                   RE_function: markup_c_ref,
> -                   RE_doc: markup_doc_ref}
> +    markup_func_sphinx2 = {RE_doc: markup_doc_ref,
> +                           RE_function: markup_c_ref,
> +                           RE_generic_type: markup_c_ref}
> +
> +    markup_func_sphinx3 = {RE_doc: markup_doc_ref,
> +                           RE_function: markup_c_ref,
> +                           RE_struct: markup_c_ref,
> +                           RE_union: markup_c_ref,
> +                           RE_enum: markup_c_ref,
> +                           RE_typedef: markup_c_ref}
> +
> +    if sphinx.version_info[0] >= 3:
> +        markup_func = markup_func_sphinx3
> +    else:
> +        markup_func = markup_func_sphinx2
> +
>       match_iterators = [regex.finditer(t) for regex in markup_func]
>       #
>       # Sort all references by the starting position in text
> @@ -79,8 +106,24 @@ def markup_refs(docname, app, node):
>   # type_name) with an appropriate cross reference.
>   #
>   def markup_c_ref(docname, app, match):
> -    class_str = {RE_function: 'c-func', RE_type: 'c-type'}
> -    reftype_str = {RE_function: 'function', RE_type: 'type'}
> +    class_str = {RE_function: 'c-func',
> +                 # Sphinx 2 only
> +                 RE_generic_type: 'c-type',
> +                 # Sphinx 3+ only
> +                 RE_struct: 'c-struct',
> +                 RE_union: 'c-union',
> +                 RE_enum: 'c-enum',
> +                 RE_typedef: 'c-type',
> +                 }
> +    reftype_str = {RE_function: 'function',
> +                   # Sphinx 2 only
> +                   RE_generic_type: 'type',
> +                   # Sphinx 3+ only
> +                   RE_struct: 'struct',
> +                   RE_union: 'union',
> +                   RE_enum: 'enum',
> +                   RE_typedef: 'type',
> +                   }
>   
>       cdom = app.env.domains['c']
>       #
> 
