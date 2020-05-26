Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEA1C2826
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEBUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 16:07:20 -0400
Received: from mout.web.de ([212.227.15.4]:56729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgEBUHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588450032;
        bh=rlt8/kWHK9TLXgG4CFIAAN8BAjjjp01YCOsPy+4XtaQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HwxX2oaNwrnqabHIy0xteoHjnl6UoP6zVPlC3xDVSnRK2dPuC43Grr/51FQjzAzKl
         EpDugiuVfHUo2TrJP9bf43bSisqEA0bSKBRLd/LSDYPqIUmpwwhFLablsactgtv83I
         9Z+kfVhvaRxSCP8W73/KePgukH+ofuD802DrFUl4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.93.244]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbydi-1jlxIs0InW-00JGGz; Sat, 02
 May 2020 22:07:12 +0200
Subject: Re: [v4] checkpatch: add support to check 'Fixes:' tag format
To:     Joe Perches <joe@perches.com>, Wang YanQing <udknight@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200502185421.GB9082@udknight>
 <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
 <57b725f495e422e80c062d2edd90abe99f40fd51.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9e10afa6-937c-1fc1-7ef5-904d7d9165ea@web.de>
Date:   Sat, 2 May 2020 22:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <57b725f495e422e80c062d2edd90abe99f40fd51.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cN3K46okL094FlN4h/zD5tHaS3/hIlii6ZqocveGBOPOXrsdhd
 d6CjlJd0GF11+YqisxSYG0dQRFCV0s0gQTGJTfovU6KXmaY5CTgA/M60mCK5lyWwF3Ngq+6
 FCCeVOt4Zjgk09AjR/14QD+51MMXG2lSSvDQkYYpurpvz41YT/f6qbltZ+CS61jcxnvamWy
 C1hmVVwbbIoq2obqIMD8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R9k0pFse74U=:LVytkgU8Q2M9P8KjOGaBwk
 uDlCvNOGTUAGX2UuPIusPVllVxS2o1foen6JqL4XWh+S5SdDFzyCuPrdqsfmKu9dX4Y3+kdo0
 sSAQjirtyxguSFHTRHwkpcgNDzCOH1pKYzQ7XhdS2XDSB+HjOjaSNs1sRH58FcOR9duI9klZK
 Cj4o+LKlu+p+wRmiUK284hK+5y5VsNWvfoOvVgdymagN0FheOn3pzbsXIFXV2Wt0qbYRuGRNs
 XhZrZxO0tyRJ79TDI8ozkhCIJW4vqAWOYyTm7aCoBcml+Euf07+r1LAKR+9cZbI8unOXSg2Az
 tv6WcZ0xvITDb1yAs8HNQa+hMWPpFOioI3JewPJ8EerGibBzuYBR4l10qnhn4xHIzDfhl4iaz
 UU/STLekCuGLFuGixvt9t9Z9/SriqQURvZo2tom9orhuIZym9ky0B8Kdf49krymMSo5FomY1N
 N4hto6IKLVpQlwlz/Heu0t5CQiaDwLqEhLz+klnXLd+cQto6iLsvmC+GBTkatZQOxJpG38z75
 6LHB/JNqmDfIoaJR3TdKmOHSv7kJI1EJLXl4CrD98k/odYllNncsckeVmOtk2x3WVkC1Tdpc4
 w7P9ULW9A7rCaSthPFvBcEgOXPQOaZqLyJtvSlCh5RemOWU/WyoKG3Pvz8lRIEEp+1m5TQ4ef
 D2+Bm5OL6gEAtWVPEW/9qpiN9asOOan5iQurBt6fHlipMqxRyZXAAQlGWqiVlF72SNt5XPhFh
 Bsw7RqWmnYfLKEE9GYQ2rhI6LugxvmsNRaV3Jx05MnUDBzKdfcoZcki0IZlB1qu7USWm6rauk
 Oz2Hr1fCVGEw80Kksyl9PlM84rvU9buQxoDY2Tha0jf4MV8OXAvrMu6YG3C9FGU8b0iaAAmfF
 eb6FlJYOkF4srQmE9uO3mF55q+y2C/6X/K3PHk9LtnAIt1bXFWd3urpoNf2AkbbnmplwPDykk
 N5d30dFqAvMLu+pMyYFXZJWY0aKq6SEu2vrkgDRtI1LWZ9xXhxZoeBC+v4Zp50gSc8jX0Atdt
 TXLRtr7dEeSiGI6EPY8NM063q/4/ogGZEpwuHCexXBc8LvMDarmh9FO6sxoKrwgQDsmQlW7Rz
 kNkllbqWWCa/pDAo5FCSnvpE8pqRXEEeomDYBSfLqR/w3fWIShcXZEcmxy2ZGeMiNUdSb87CK
 pyrFtSgTN1vv1iRCRWcA/lefvfvBFQwt/rj2xxVOHn5NEmI61HxPbSWfzF4yNuIQumD/X6S0w
 LUhQ7zLAboGgGjaXV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Will the tolerance (and support) grow for such quotation character alte=
rnatives?
>
> No.

Would you prefer to achieve a restrictive data format description?


>> * Which formula do you propose for the length calculation?
>
> None.

I imagine that such a view can increase the probability for confusion.

Regards,
Markus
