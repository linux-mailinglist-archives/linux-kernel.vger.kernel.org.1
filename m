Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF428F3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgJONyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgJONyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:54:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C086C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:54:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q21so1939176pgi.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDNF42bzSbtgyhpFqjahaVnSc6t4I3jNbHicdwJNMZk=;
        b=qAVyvVppOWwoK4SGY8sXHjJIFRV3+qCLhXQXd1+QEIohJxgw6/vY4LxInmg+IkUfZ2
         nF4hhzi4YsugigoaUa03mJ5BC9lyxpXVodVthzHaN1muxTvF52PKqiahtLQWL5Xz8lM9
         7Xlv9OmDOxE2AH1asyfF4Lf6L8Kr5oTi12yGekaAiCnzSPcVbDvJ2oXo9mH/AdFI6DcI
         ZThN0JGPq1xczLSOmSqtPb+ItX/Y3niCcE1mKq++tseKLPCdXpGwrz7O1GzenT80d8oh
         9qjVGr/GId4LKKVbE5qC+W2PiGkIXYKlt15B2g4IyGm0ntrSKk+qBFtYp+guydpWOSJ6
         n5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IDNF42bzSbtgyhpFqjahaVnSc6t4I3jNbHicdwJNMZk=;
        b=BBfUARutrw0ERdhEWIy+bc8ThQSJR5rIoslAi1S3+hTrSS8cfMETyDnwFsLHQ+hmjX
         ljPoATFZUeHaXgCyT7BPHMYcRSbWamlfAQuvEHg0Efgm67VXK75pE2IZHhRdI0bBgnkw
         61ovXj00SS07Bug8lI0eKdccNG5j3fDQCxKZpJZs5TjQ8EWMGnnd8IbsAQEFOY4SB5YK
         u2jlC9At9yHMtDVDC3/rj8XYkCBet1CnlH6aynGLLlPnL39bHNis9Rod6zyaNXcgKr7Z
         W0yOG8JHYaitdLpHO4CplGNbhFrT1L3ths5xB2xN5DReAcS81aQAMYSxo2Jg1e78Mscc
         4tXg==
X-Gm-Message-State: AOAM533Yr6nOt+/Q3Tp83gPM16Fo0k2zOO+FPoPbz+zBRgoE85FDuVM2
        0ZevoVm/DmfklZyNqfo9dBs=
X-Google-Smtp-Source: ABdhPJwqEjgiu5lXhf1jHTpTQYsErpj/RqRs4A8aTtU+QoudHqM6djCnzLEnH4yQHRn11rsLc+d90g==
X-Received: by 2002:a63:b245:: with SMTP id t5mr3368126pgo.328.1602770062877;
        Thu, 15 Oct 2020 06:54:22 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id f9sm3494394pjq.26.2020.10.15.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:54:21 -0700 (PDT)
Date:   Thu, 15 Oct 2020 19:24:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
Message-ID: <20201015135407.GB1899805@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, sfr@canb.auug.org.au, wangqing@vivo.com,
        david@redhat.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com, linux-kernel@vger.kernel.org
References: <20201015132336.1770828-1-unixbhaskar@gmail.com>
 <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 06:38 Thu 15 Oct 2020, Joe Perches wrote:
>On Thu, 2020-10-15 at 18:53 +0530, Bhaskar Chowdhury wrote:
>> Fix the space in the middle in below entry.
>>
>> memry||memory
>[]
>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
>[]
>> @@ -885,7 +885,7 @@ meetign||meeting
>>  memeory||memory
>>  memmber||member
>>  memoery||memory
>> -memry ||memory
>> +memry||memory
>
>No.  Don't post a bad patch, assume
>it's applied and then post a fix to
>the bad patch as v2.
>
>Send a single clean patch.
>

Not sure what you mean...could you elaborate...don't know what is going on..>

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+IVHkACgkQsjqdtxFL
KRXDuAgAyqnA1EjtltjX9L4afZmAp+eJkvAhRoxXM8M5ly5087IFVl/8AfXS1DrW
8i//d0ANltgxP498HqF6OP9CUjjXbZwcqN0QJgJvZsYVxHYWawqQQAn1ZR8Z0THR
AHIZZFmAY+uVvRoZvLUv4tInPCjjr75YUkqrOj3CPoX4gX0FWQQuvoxFvwBRMbn0
DPtw08CeMoD9t5oPgYWXV9OVtS2yadEvHHcn6DHJTjksPhZZIpPU14eIEwxuP5Ee
lOZtOQEC/HIMpIBJQqvNzT9eSazaBBVfXZr8icehvGEOlNmhSFtxNs//RQWGnUpO
5M5T1bmrzWfX77BBGgESR2/sh/SM5g==
=Pl8S
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
