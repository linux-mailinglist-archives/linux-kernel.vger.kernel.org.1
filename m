Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655426D613
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIQIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIQIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:12:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3EC06174A;
        Thu, 17 Sep 2020 01:12:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so703549plo.13;
        Thu, 17 Sep 2020 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AsKZfKF0K+GYztJ+ZhG/AzYosqFJi2i7GJxWXTnI4Hg=;
        b=hGUafeSzoJXCQjqedkP242UDZKzWn2+gnsjU/qCNsf7AxqwS9mhceGL4luplkCvWMj
         oNl/2hxED4JQij9DbDydX7dAWcbro+tzC6XvA+fSXjvGSKRMSnqYI06TSxe380pU5mm4
         D/U+X0C5LkcLdky2S/W9KCLoV9I1Oe1905xwLhrGCxYUneMoR0Bhq4PEQqUKPznSkROj
         TWMnkbBUM5BvEerxMpiPO1Rw+Z4BXFIxMa50+jZ5sBs0vxBsfmiGy74QuB7hUJeUEjoj
         fzOj9qAQ0heT86Om0l/k92PQjMtG55kP0WXoNv+G5UmNxqLDXEZAvj1jkha8Tj0JNsKc
         +pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AsKZfKF0K+GYztJ+ZhG/AzYosqFJi2i7GJxWXTnI4Hg=;
        b=GxON6aAKbvPnxns7qiku0s44GfPvYNObO/uPCxJzctjcYdaH+SljEbKkfa4aml3agU
         w2jcIM347xEOwdK4ooNTYynqFHY78rkPkRGcodlyth8m4YmgP0/7OpIbZayCHWleGOwY
         u4i21c00E8YDaRhMtaIhwsxE+8VfIsIw5yHL2Y/RIPyhcEreGllfr1rpiATzwu3IvI85
         Lvj6FG3QjC9TNgY+M4DBP6u1pjxeLKjuxzTjOt6xLcRidotdzNUgIEqDOaRTslM3mlJp
         F8zfw9xyCsLGHZU1wZ/Y3ptXaBjHWayWgQbT4BxcpwfuD+NuOrh9bvgubAHhuZNlVKuo
         B+3g==
X-Gm-Message-State: AOAM533hFNrjhSnHS/+VljJ9ukH/xk6an2aU60Rn9YF42HsHKcustjae
        wXvQaKlCjkHJWD5mwwl3zqc=
X-Google-Smtp-Source: ABdhPJypXUD/d7P4QsNYfk4TFi5YqVJYMftn28S4Sh/eayTiTcIsw72AvjWzyN/TSFiDR4/hB/copA==
X-Received: by 2002:a17:902:9685:b029:d1:e5e7:be1b with SMTP id n5-20020a1709029685b02900d1e5e7be1bmr10369346plp.78.1600330341649;
        Thu, 17 Sep 2020 01:12:21 -0700 (PDT)
Received: from OpenSuse (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id j144sm20147121pfd.106.2020.09.17.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:12:20 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:41:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3] docs: fb: Remove framebuffer scrollback boot option
Message-ID: <20200917081158.GA19903@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
References: <20200916230150.14516-1-unixbhaskar@gmail.com>
 <20200917074747.GA3332340@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20200917074747.GA3332340@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:47 Thu 17 Sep 2020, Greg KH wrote:
>On Thu, Sep 17, 2020 at 04:31:50AM +0530, Bhaskar Chowdhury wrote:
>> This patch remove reference to this option in this document and=20
>> renumbered the sections. This is related to below commits.
>>=20
>> Commit 973c096f6a85(vgacon: remove software scrollback support)
>> Commit 50145474f6ef(fbcon: remove soft scrollback code)
>> =20
>>=20
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> This version try to correct the previous errors, proper changelog text, =
subject
>> Trying to incorporate Willy's & Greg's suggestions
>
>Better, but...
>
>This should be a patch series, properly numbered and threaded, right?
>
>The text above still has the commit ids not properly referenced, and you
>have trailing whitespace in the text too.
>
I will certainly fix that in the upcoming version.

>Writing the changelog is often times the hardest part of a patch, as you
>are finding out.
>
Yes..true.
>How about this example, for this specific patch, as a changelog text:
>
>---------
>In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
>framebuffer scrollback mode was removed, but the documentation was not
>updated.  Properly update the documentation by removing the option that
>is no longer present, and update the section numbering because of the
>removal.
>---------
Just like an pointed arrow ..perfect...cut to the cheese!
>
>Doesn't that make more sense about what is happening here, and provide
>enough information that when someone 10+ years from now goes and tries
>to find out why a boot option went away, what exactly happened and why?
>
Absolutely.

>Can you make this type of change to all 4 of these patches and resend
>them, with the proper change information below the --- line as a v4
>series?
>

Certain thing...will incorporate your suggestions in V4 and send.

>thanks,

Indebted for your and others patience for standing this long ..thank you!
>
>greg k-h

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9jGkQACgkQsjqdtxFL
KRUH8wf/ZIheAFYvmppgZeg3wK1xvppY4mlIXylSs8h9vJSQXteqacyfYmP4Z1Fl
euh7VXq8ll+swv0JsNT+hfb7MfQ9mIc4VDJQkdaIPngxLsPwzdBHy+3xJzZhbwCI
Ut48dWxUJSqkVZi/9hzFXu02FIQaodfXdq0KksqZUe/dlC5NKHzBdqP2RAYgF/6a
dI6SDqpNCOG2bQChpr9d1kzun7c7bGniLbiu0AFF1C6Ot4VDcZ/KzJmxi3B9sf1s
d9y/LxOqnANMhnmCipwQz62Tb0YOtWN0xyPMS6NYHGLDUcB9P79vW3qFUbB6I2nz
xpMCWr2JN7zP9S6kVVvykwCZjdnP5A==
=VFET
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
