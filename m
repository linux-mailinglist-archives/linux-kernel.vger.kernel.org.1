Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B93269F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIOHJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIOHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:09:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9CC06174A;
        Tue, 15 Sep 2020 00:09:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so2307777pju.1;
        Tue, 15 Sep 2020 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLrRZhIWR36lzz+4IO5F1AXgaKn6rMyA/pDBQuPcJ6k=;
        b=r9mfSwkY2ut4xyz1dOoM88IQB2fIdwZPa3jVC7kTeOqebAe0mVJzbSKbI01BhbTVcD
         g6R9eL4/GIdfOyb5whrtveZdv1D+81wg8XCaOLAzjI9p93fKNsC8ljlO/NYAltxEaiA7
         oq0NvGwJjK2Y5lIMzU9HIJJkQ43uAXXdMEoYMWNfVXjR70qBqjGf9wUEIyD/E8O78pG6
         coMc5OBVemfwt5BUa1nwAofdH9NYfdt10ubnMtggfgvrXaWNNbpS70P+4bIbah0cj0rV
         SoVjdOjuqoW0kJ7r+WqX0TqNZQx1CXy01liFHKTHwuWg3Vqj1Ge9Bb6XrpoWNCSsyKDH
         HH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fLrRZhIWR36lzz+4IO5F1AXgaKn6rMyA/pDBQuPcJ6k=;
        b=WXxm/s6ESv4b0BTJQ3qtmJ0WcgVf4Oh7A/JIGPKwPDS6sVPJqvoDq/r9h790Aw2E8F
         qhnId7ZbTf2z4rLC/I0pf9SzusqzgWjd31WELKCV4khoP+j9qF9NBZW7f5jjQmlS9GZv
         Nx7QYDxW7hLAedBteef9jsibj+zAOdYnQHmHygtxb048mtCqpPZvuoRw+7uVVmzgxBKH
         oh2Rxmyl/mrE1Fw6GVTe6BLlyuskP2K9qRcyXa6/N1I238qIBnRBPXyXBSQl+mc0ncDF
         8H/SIp6kFbGejsiysm0L1ozZw6HY+sUIFw2B/cwGD/2Rfmob/Zq9WR1XXA1B69taD7Zy
         8YAQ==
X-Gm-Message-State: AOAM533l9t4krn+6U4xAp5FDsKju/HndPHucVllEGz4+kI0lalVnrG85
        NwWVLYeDDPDA+jZ8L29xYhQ=
X-Google-Smtp-Source: ABdhPJzvf4kGL61A7K3M8emYd9vMQ3ZgNithLLO+tnNjDNJG/3TbiXm/9CG9ZB7+u9ztLBWSQeYKqg==
X-Received: by 2002:a17:90a:481:: with SMTP id g1mr2828179pjg.157.1600153744823;
        Tue, 15 Sep 2020 00:09:04 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id u10sm12424569pfn.122.2020.09.15.00.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:09:03 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:38:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2] docs: fb: Remove the stale boot option for
 framebuffer i.e scrollback
Message-ID: <20200915070848.GC25365@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
References: <20200915063721.30065-1-unixbhaskar@gmail.com>
 <20200915065312.GB3622460@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20200915065312.GB3622460@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08:53 Tue 15 Sep 2020, Greg KH wrote:
>On Tue, Sep 15, 2020 at 12:07:21PM +0530, Bhaskar Chowdhury wrote:
>> And adjusted the numbering for boot options too.
>>=20
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> This version corrected the previous version's mistake,subject line fix,m=
ore
>> changelog information.
>>  Documentation/fb/fbcon.rst | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>
>You sent 2 v2 patches with different changelog texts :(


Postponing for the time being ....sometimes later in the day ...sorry to bo=
ther all of ya
=2E..  :(=20

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9gaH0ACgkQsjqdtxFL
KRWJzgf8CfLJupVnuO8o2rG5qMcDbimP9gj7J4mQgqfJQocylXidHtwT1twVESEq
br70opaX/omdPb7pgKIkTFHPHz1JfPWsyBx+hWFFu5m3t9swji1N5p2WiXCEsnXI
o10sGPc6IB8AowQ7HFgrATVJ0GY789oFD9exFM55z/umDdQjdMHDP40lYQWp3OdH
PiDbsKrouikd+SuvU/wJ6isnwiZvbHI8/SHFIxf75Bv2ea4v+h3UiyTCFObGQMDq
5fYvRpAqmznYFDNZW2AffuPkhTHbP0toZL0D0YVm6qilgA4Fz/SM5ArsptFH4c1Y
q6hl/mqb/uiHR61K7O0Wsp3yuQn++Q==
=ihqa
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
