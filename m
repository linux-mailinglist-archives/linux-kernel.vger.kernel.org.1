Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285FC2F48E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAMKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhAMKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:42:13 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE177C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:41:32 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r9so3075593ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DscT6ts54kXU0vTk3OFxMe15A/jm4UT4WHeWVW04qNo=;
        b=Ip7x3onjexU95VglIVS0V27raGBLJaQ5XJo+ALAKUO5GCiykKw+LZi4VNdq+n9Tbaz
         VOHZhGUIZXmjSQOi6tyaK3slFnb37yxviJ03n7IYN7Lkt74TRBG7HOIzZrnaOAVLQ/TL
         1w9V2+9f35Q81x1ojNICnhZnW+cwtqyKTXcflL4ddptL1jyHHzNvZWvespFCYpwQMWM+
         59Pnuh0j3FEKWcqapGNx3NrMBJYOxKdJHw2cjAJcx3zwgkXUUJpXQ3R5hUWhXEr8djY2
         bkdDqwBumI8UYYfCzz9LxNUHxU7iOuSjmKBCVrFWqpQe/aMvh3CR8vAbT4D5OZPZc+ya
         o6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DscT6ts54kXU0vTk3OFxMe15A/jm4UT4WHeWVW04qNo=;
        b=VMbnU0HrV/Aaq32keoQQB5uzbCkWp9EvaIzVr9LEPBws9ZXSw858fy8k+6kT2YnJ59
         f8W6iO7x1riwFwlT/jhGBFUOTl16Ayxhv6oWjbywfX5Drex5i9wJ85vuG/jLRLGmlDi7
         s3q2s3MeYXNNWTzkHjw0ZGFz7UshT/enAOpt8j9i2o/WkKx5U7hg6/hm46G7PNyexFwh
         Gv7dco+N+ztTqW7IJX+N49V1be5/f5hY4/fYXxUlLLjEjq/dKOSkk8Zc58+HNnF9Acwy
         srFmHwt9WYoTsbGmWxR0PyxC69IgqLEauE2ngdxoRtEH29TQnHxyebGrqk7Sgpp+H6K1
         bUwA==
X-Gm-Message-State: AOAM532Yrg2iaeLRZm6wQoBp52ZiCJxZ8xpiyTSPaaxOy45NKG/v/OE9
        XZvn23mU+oKarYogpBMZvSU=
X-Google-Smtp-Source: ABdhPJxU1aeKNkrAdrXw6HlyW3G5e9KqXC9cDpvH4aKIYdI8iemFstZj/Vlgq2ezYo1PStu5yXJIMA==
X-Received: by 2002:a6b:c94c:: with SMTP id z73mr1199783iof.95.1610534492156;
        Wed, 13 Jan 2021 02:41:32 -0800 (PST)
Received: from debian ([138.199.13.138])
        by smtp.gmail.com with ESMTPSA id k9sm964924iob.13.2021.01.13.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 02:41:31 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:11:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        reinette.chatre@intel.com
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl: Takes a letter away
 and append a colon to match below struct member
Message-ID: <20210113104120.GA591@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        reinette.chatre@intel.com
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
 <f20be5e1-a2a6-14d4-5813-1fb716783bb2@embeddedor.com>
 <20210113024838.GA28337@debian>
 <8aafe837-f4e9-1440-890b-f07d83eed30c@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <8aafe837-f4e9-1440-890b-f07d83eed30c@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 00:27 Wed 13 Jan 2021, Gustavo A. R. Silva wrote:
>
>
>On 1/12/21 20:48, Bhaskar Chowdhury wrote:
>> On 20:24 Tue 12 Jan 2021, Gustavo A. R. Silva wrote:
>>>
>>>
>>> On 1/12/21 20:03, Bhaskar Chowdhury wrote:
>>>> s/kernlfs/kernfs/
>>>> s/@mon_data_kn/@mon_data_kn:/
>>>>
>>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>>> ---
>>>> Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
>>>
>>> ...and what changed from v1 to v2 and from v2 to v3?
>>>
>>
>> Gustavo, it seems you are not following up properly ....could you please put
>> little more effort for know it????
>>
>> There were mails....pls scan and read ..
>
>This is my point... this is exactly what maintainers and reviewers should
>not do: to go back and read emails, trying to understand why are you sending
>a version N of your patch, because you didn't include all the previous change
>logs in the most recent version of your patch.
>

Thanks, will follow what you advice.
>--
>Gustavo

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl/+zkwACgkQsjqdtxFL
KRUMtAf/buK7qVzpzDBnnYjJG1kuZWr15ozc44biIsmPhTI7wrmWd171TZii8/dA
4KP5kC0olP2svDtVF7pRZoz/94D+QoxC1jAc+zeToPF5XZQ3/441vqH4CHqFm+YZ
eIQQ3E1AueQzGcAKckq3SbwaQa0WEwp7+e9T2CT/CJh7ykeJ+3fEai9yhrOu1E4k
nNT44A8aajjoCX2U22aQQrDDulFfWG7PGbZwzWfk9432OXSNuvhkZUBk04of+Rzv
twQopx/ew374DKwCUTJG6xTJ9uppfRJ5yuhPo+yaL0mlhPupRrwb5XF27NmjO5Dg
t/1ieL8oKRhW4tKE1IxiPmHpUHAWAg==
=oYD6
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
