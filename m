Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4A2F4212
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbhAMCti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbhAMCtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:49:36 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D361C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:48:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p187so1235493iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xh9Gh5qY1WAfz7L4MfEYD7Aza7GS1+dcuS5fdrgP5Zs=;
        b=ok8HL9qdKN721Gvq9adInmsiwTByJ9DCADst9KM39fslQGfShlJ5fOl67ILxbs8aAe
         bBEQyX6OFEtEiAuzQZ3C8bEnjLM+2XRMYnC7L5eMTTYmz0zJ92o8YH8t36WFQcxroEXI
         saZe55rNkE7zRJ9HKn0PmyCyqOhZOc+12PUtF3EF72aPHPAhu+q7Ch7c2pffpuWXMJIY
         g0DspFuR9oMNNsNiq6wf63qStbEWPODH4EzpSN9dvDiX6O+rtMeE29KgzVE4kfylIg28
         7Ib0KZQbhV0YKUhffNRcjDYSVTMq0ftloqhflPbcZDcvLr8wvbMfZti8cy39b3Ipl+Rn
         opPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Xh9Gh5qY1WAfz7L4MfEYD7Aza7GS1+dcuS5fdrgP5Zs=;
        b=CbquQKQEJO94F4MBLMQvTxIrvOKeZE9L4kF84YuTETr3axDTH0uxA1cFvGK1FvpUOt
         ySPRMMccmBC/iDdLfSOXjoEtC5I82ypBWvQhDiv8/rXOX/pnaqWeXKN4ncbwx2/TLf7g
         j5InIOnbVfEfjDiU4Pp5tttNt4wy5t4u1xMbt9JQ7Uq9uP5jNsrzhQy5OeAm0+QojSov
         Jk3UqnAFfsT4RW1qeakbYM9I+cQidnMfM8N2HJ8Cu3GAJboznqILyNL+jUbc7JaDoZa3
         //zud56DHoHVwbiwk2M1dkblck4wLi0fyEZGnzheMK9zGEQnbyVVlRGi5bxIcMxLoJk6
         2PRA==
X-Gm-Message-State: AOAM5315avxED59Su1a3FqhJJvaExsoZ498pGB6LXRMV6CzE+t+/xKiN
        1Mkq68HaCzb0wW0Rny36O5E=
X-Google-Smtp-Source: ABdhPJzgaYDdNRvB9aV7bVGtGpX1hJPGraErh0jz17HLARCeNzw5oij/vG4KWgZl60T2jM/FEhPGVw==
X-Received: by 2002:a6b:441a:: with SMTP id r26mr1843380ioa.105.1610506129873;
        Tue, 12 Jan 2021 18:48:49 -0800 (PST)
Received: from debian ([156.146.37.149])
        by smtp.gmail.com with ESMTPSA id u6sm111521ill.87.2021.01.12.18.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 18:48:49 -0800 (PST)
Date:   Wed, 13 Jan 2021 08:18:40 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        reinette.chatre@intel.com
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl: Takes a letter away
 and append a colon to match below struct member
Message-ID: <20210113024838.GA28337@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        reinette.chatre@intel.com
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
 <f20be5e1-a2a6-14d4-5813-1fb716783bb2@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <f20be5e1-a2a6-14d4-5813-1fb716783bb2@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 20:24 Tue 12 Jan 2021, Gustavo A. R. Silva wrote:
>
>
>On 1/12/21 20:03, Bhaskar Chowdhury wrote:
>> s/kernlfs/kernfs/
>> s/@mon_data_kn/@mon_data_kn:/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
>
>...and what changed from v1 to v2 and from v2 to v3?
>

Gustavo, it seems you are not following up properly ....could you please put
little more effort for know it????

There were mails....pls scan and read ..

>Bhaskar
>--
>Gustavo

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl/+X4IACgkQsjqdtxFL
KRXi6Qf6AtKuqM1Jar0S0km/FFLYoomMNG25PNptxpB3tyChaZczcezHFr/sgrSl
MRS3I8I9ggoJvm2VKjC+8h3mr6v3YOtP0F+/hW8ngRn1o4LCF5tZsXGD3zsCjUTd
RROYNV/e9kBWjyxn8fr4g+I5uBztxE81ychi/2zsARlXFFm+jMxFD5qcLD/lCDLa
igCZ3aFLF4pvdGpZubwjJYEq1ullh7vUYSkSi0lfX7sePWHvLgO0Bvmsu+F5PRmm
0gis28PfynqRecdliOTSMEwJ6NRIvqy+JYvar6jw/LA0n3eyvGZzgTnHaoGrCaGW
T1v5b/q3LF8R9gk8GWaJJjHChn72ZQ==
=NS7O
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
