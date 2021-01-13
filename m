Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FC2F4231
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbhAMDDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAMDDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:03:08 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:02:28 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q1so1240672ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIU1j2XymHF8RbfUlMB7PbUKKVulEEh1qeCxJlo0N5A=;
        b=m7AY5eGw3oAWurbhwhTciaLQeWqFpqzPPfBcoXniiZiaTmLa5Zt5x1SwgFJRBCf3yG
         BjNboBC5iaapZ/YW+6u6gwqsHQl4/thsnBoFdLf92wI+Sq5Ubv/t7pPlcjGjW+AII8RI
         SSpIijo+J5lU2oNen4GsP3eUCLWVMOsQqickIeEQCYzZxGsJW1tDw0zFoisOLUfVrQbc
         7ak+zBbHRaZAAtQF6fItx5CijwrDkT35+2I/0V2OPJQlvRpM1Wq+DZRkQ3n/jIVo/MAu
         loFzCZHbCo8epU9AYTgIP9hUr48jmoY5BIrqLbS7mMkT+WulIFAsZ6yiV6QNnMjOLSLO
         HR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GIU1j2XymHF8RbfUlMB7PbUKKVulEEh1qeCxJlo0N5A=;
        b=PGVwE0l8Wdge+YFeK3aOPLiabg2/JcY2/rcVm9uebJGCung8GjDCrI7C+8J1a5QQRK
         y8LO1gS8vx7x5x5RbG15OlwwKmRQqlEP5QxugdC8JyafRHksiUgZXqtPI7uURMTDOTKw
         ek2xWL3ZSH7b5oj89vHaz2lvEzqmInFEDfzLCtot9r437+4jOqK39R97to2wyKtpBh5C
         6aMg7swyFjuvybJ1gnUKJJqFGyuX9S5u6WrezDxL3ezbitQzS7BDM6mIFm0UcRN0XclP
         2ZnMqvpFJBElRGvrAtDJ6FmmJS/Is0Vm8MNpcUABNrxprVRiGn96k1MiPlbs3ozW3uBU
         Wbow==
X-Gm-Message-State: AOAM532gSenAl4wI+DUXP3pMZILt0BZZVtqvAV8zUSGEoPHxG1Lyif0W
        i+UdilMkF3ogaLeWH8d/Dyc=
X-Google-Smtp-Source: ABdhPJyI1cK4xoH3u3SxnlbOuYWHFvXquUj++v+Bdz9y82KhxI2/2U77UBkFGpsqIv3NXoi8gubb6g==
X-Received: by 2002:a05:6e02:1566:: with SMTP id k6mr149525ilu.19.1610506947684;
        Tue, 12 Jan 2021 19:02:27 -0800 (PST)
Received: from debian ([156.146.37.149])
        by smtp.gmail.com with ESMTPSA id y13sm477868iop.14.2021.01.12.19.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:02:27 -0800 (PST)
Date:   Wed, 13 Jan 2021 08:32:18 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl: Takes a letter away
 and append a colon to match below struct member
Message-ID: <20210113030216.GB28337@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
 <f20be5e1-a2a6-14d4-5813-1fb716783bb2@embeddedor.com>
 <20210113024838.GA28337@debian>
 <a6e94a78-9841-96bb-f07f-4bd01d6a6903@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <a6e94a78-9841-96bb-f07f-4bd01d6a6903@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 18:51 Tue 12 Jan 2021, Randy Dunlap wrote:
>On 1/12/21 6:48 PM, Bhaskar Chowdhury wrote:
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
>
>All of these version change logs should be in this patch, under the "---" line.
>
Point noted for future reference.Thanks.
>
>--
>~Randy
>You can't do anything without having to do something else first.
>-- Belefant's Law

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl/+YrUACgkQsjqdtxFL
KRXE6AgArr6mL5kZKKFDAzXFx+Pgzt6XKquelknOm7dIbNSMVrniT5rXjvKrzLd5
zyDIi48r+ONOzwiC4HVaimEiwpm/HVMg8mkjIxvQB3RCuXDAzNwxT4gZA4kPNuoT
ytK94ddZMeBvxoHITrwy8bOIq8kN5iOhWrDYHhBl7m78acEiSzHG/DiKqeza/oPW
VIq2UhrYYlRQg9tGZIxTRi6NC2xNQYLCoFELD/+kGsmB/liDHt2BBbjaPADhkECq
EDbJgEtMQGaTzjEWysjUzlTO0KR+Try6X1Cv0e//1Rtba543dttXzNVj2F6MGBuR
T3JW4lN7k7GX6IvBMKvZ1mOZL8mDqQ==
=VG6Z
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
