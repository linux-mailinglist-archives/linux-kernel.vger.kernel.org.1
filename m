Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7328F30D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgJONRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgJONRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:17:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776D8C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:17:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so2009653pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3834EhLAqmIpiuxCngCMrj/cJx23sQc9SHHcg1zZKh4=;
        b=DWyMeJjpIQbucvBoJlE0tbsYUaBU2uoMfNSKWDVVvS50JpmcEBRI3VlJOOpf/EgI4T
         uDAjzSB0Py2IRvsIeamK2qH2ZiuN5L7OZUenUW2H7lhpKlC1WudJNOOYqYHvLD5T7IRR
         hCd6MLnDSx3XuZK5CwNedJP6kbZ/GfA1TsgfDGt49XorPebb2jBcn3bOGuHi5KAbUB01
         HgJFBDivNA6yhFBUKIqHajtvYsogzaW3yQ0oj85HWM16nJPwS66BJ3ouh75YDIGEnmfh
         yVnt+bc80xkPjOlwQYrnTT3wiwocNpljk4+61u89XCBDVKz79CxrlNeyOlmGhVyTQYd8
         +Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3834EhLAqmIpiuxCngCMrj/cJx23sQc9SHHcg1zZKh4=;
        b=Xs+9suisAV6Qk6pO1qHGWWTLPSYLnkl8QM9+HBuJWQOuFFgZ265TWGi5EjbSjPVtTo
         Znhgm4xLupxJHCXEwMw9Rh7dGouX/Z3V1OTGSQ5xAkiKo12yZN1TixWE6waxZlS76orY
         9hGWqKVwAaqwXZvsgkhcpr7RevLSG8h9lQo8tQYp4kfoJ7QJuhudbMpmGX3B9cQBgsSK
         rIiJ4Z9ZIFE0LMIHII+9ITHrXhxEbF4aaUmOsNEnn/JzBHV/8cQmuAR0+7dp62L3O8mh
         jUfEdublOHPQ0xlfqhtcyTZ/i4Xcelw1LpXd43oHENjKeCcvxaIWvhSm9cKC6KUYvam0
         tGXQ==
X-Gm-Message-State: AOAM532BovE9pSF5uf46ubwtgrUv8MvX7v4wvkH4qeGGEgBkNYdmqp62
        pnlhj1Uq+BNxLRqnSIAQ5pOtfUvPlIUPyQ==
X-Google-Smtp-Source: ABdhPJxVTEa1jPiLUuIV8k6ER2JLbxNo4oSoTzxfd0nRostYP5/RPBqV1BkNPvDDs22jdejNnuTCRg==
X-Received: by 2002:a05:6a00:15d5:b029:155:cb6f:cfe3 with SMTP id o21-20020a056a0015d5b0290155cb6fcfe3mr4056290pfu.11.1602767863047;
        Thu, 15 Oct 2020 06:17:43 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id 17sm3062541pgv.58.2020.10.15.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:17:42 -0700 (PDT)
Date:   Thu, 15 Oct 2020 18:47:27 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: Spelling:  Fix spelling memry to memory in
 /tools/nolibc/include/nolibc.h
Message-ID: <20201015131727.GA1899805@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, sfr@canb.auug.org.au, wangqing@vivo.com,
        david@redhat.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com, linux-kernel@vger.kernel.org
References: <20201015130525.381818-1-unixbhaskar@gmail.com>
 <0efd61190d00eec9c76e0ca949f3488fab1ab7c7.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <0efd61190d00eec9c76e0ca949f3488fab1ab7c7.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 06:12 Thu 15 Oct 2020, Joe Perches wrote:
>On Thu, 2020-10-15 at 18:35 +0530, Bhaskar Chowdhury wrote:
>> s/memry/memory/p
>[]
>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
>[]
>> @@ -885,6 +885,7 @@ meetign||meeting
>>  memeory||memory
>>  memmber||member
>>  memoery||memory
>> +memry ||memory
>
>Spaces are not used in these entries.
>
>

thanks...sending v2

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+IS+cACgkQsjqdtxFL
KRW3lwf5ASn0OpXBnzeHp7LETkuWgq3P791Zu5wymto/U0nhLz4mARr9gMmPE7bT
3heqGRZQo5wk5P57qtgg9liFxk3OFyJ/Fi+zZ/7mQ/PV+xzXQdzC2WchZJ047btD
0hhfnwSHD6dYeoPuq8c4CBC0z1sUbhNWaN8nq9hd0EPIEWOpSywJdIv6C+TtIpNI
pr40FKJbDyI3FpcPEyG+j1X82A/kraEB/WWHiIBYQSRCXU54SBzxLy9ujJI5YI54
fT/epLJLZOp1h61vsj29Gphlu3LXgojWN6R89oLH72hvDu2epKeILSfgHIAq38cS
L/HSz+RpN1BTFgPl8mOokB9B3cwQmg==
=fgp9
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
