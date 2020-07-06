Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F5215670
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgGFLcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 07:32:48 -0400
Received: from mout.web.de ([212.227.17.12]:47239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgGFLcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594035149;
        bh=gRpai35169NN0LWLbN07VQzDnRwm2ItrPh+MTVyFv7Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GTrS6hLLgZgRYAh+ONOfLqYIpNsTtiM1Y7BcTCac7M9Rqu2I4ig6KPiepxZoqN2B5
         AB0JPcEwwARtLqYhlwRCyu5BcABLayhiFmb3JAdTlu4Nju7Qmk1kzmIk5WTKDXtU+P
         IAj4UZuhWAFlGEM1XM5UgjyiCxANOhDE0EE3i9OA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPRu-1jrr832wsM-000dOw; Mon, 06
 Jul 2020 13:32:29 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To:     Hillf Danton <hdanton@sina.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
References: <20200706104915.11460-1-hdanton@sina.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <83a37410-1740-1a50-9d2d-6ad7587b8532@web.de>
Date:   Mon, 6 Jul 2020 13:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706104915.11460-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:82wdwGxFVFkq9HL6vEh1uDc5gfmhrZSMuSqbKOkJjQAbChF8zAB
 NpHAONVorfBhFLN22r3EziqV1MyAYAQp1UnFO4voh0FG0xMlw8UZiklpjBZQg+oA/U/J9Ub
 lZhUu0uQvqOB/Pge5WyIFf64HQBCwBgfugSvijbJ6d7iomwvx4Wml2kIoCqdk/Gj7JlYDC7
 dvrHLLNCkNOguGw3DJG2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ERWNugBg3AE=:/XqPtwfCrwddDWtUo+0Gjk
 l8VnKvoPgnjUgRWON5Chcacd44vS5L0g2O89j/gNS3uOxPVA72Cx1C2bkKXHAFntjML3MltgR
 zwMqDhPZ8KrrS33IPXgFCe9rMFhzDFhhHMsbg8+Nt4sO3INJksKcL5wEI79ZWuoFR7+zXY92z
 Y8yYbDyaQHME9YFfC5Ab2RWdiO/VE4EYuNcofrI5kTs4dAAW43F0gFdsrFks+1kon+kzKSsbv
 5miVus9zVZqc32Uh70QbJ8hGCsrV9gzj5MiF9/CNv0KMrqK4vqwJ4NL5J8ev4Qr5ppgN/6VAo
 oQgb2wIlyIg8s6p2sgLrzEpMjm+jsddvcc5WR5tsIDyEv/qPpCkpRcoOLhteMKfT+lUHDV9ef
 CPAP6EIa5H89wBwPqbfrMF3ZpZnonOqVcaIl1+gf4ENCR6uIwGA4QtQIvE4ZuxD8r/t0it8fH
 3q27uhuiGvDMHrJBgzT/Is7siJFKlk4/pvmDIkca4d9EjSVanK9rJzLirjans6k81N62dRQS3
 NCSMRgKzzgz6O6U2jYiQVhb3Bfm30u56dK1w9QjqdfXKkZeB2FULIqEi3ygG3nQ8fwafJ5uSb
 yTeYDlJ9htk/TDkXLCezGTewEfShq0ZQiQOQt8iFB4TeNueFvDhoBRKTkfICnbFFDenTq4Qo7
 cTA+lFBws15jvCzMSvoncWC51E4jc4hbqQgiSOlMoDOWHsHLrIjW75zTLLZyfOqHWPrqvIXNd
 g/tPFpVqHqLyeWCBIXLnyOqFg6d6iX77HpRgGJ0BI/kuNigsUOw06whuIfllDKzsvcL8RDimq
 1AZNBPKSJieEPtkf+9iYAE4WWH2ngobllCaq1diouJX7f7nD1Y1vVGiZWW40F6GQoH0CfrAx/
 UHMi/hsqDW4KQyRIMQy4nuBbfhlEZnrWdp6ODSB34Nxq5S1MejlUYlvzomMVsKGUBFypnSM6t
 UsY/z/z3SuG53CAQm6424j6ch5Blcr31+Fm+YMV2KCEQbHeS+ICvujAzASWEnFxw8UmDY4zRI
 qm2Wu/nDEiWTE7gBJLaE5+6Vc489XL85exiCwZd3Fbitrz3J6NhOTaKKZNmzUDZQA2Hi7qUA/
 cjLyN2W7c6ko953K9xJRZdmkRiDKnduNySa+nmyM2evZykxrbGJwMsYau2wlXuTYVlXkSItWj
 WHs6wShOpGTMMOLA8QVRCLH8oM8H+/hHtkhLYE516wuF/8jzQgwM9wdczsV94P6hZZz75c1C4
 4NHK04XhsmysXuIhs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2798,7 +2798,8 @@ static int vfio_iommu_type1_dma_rw_chunk
=E2=80=A6
> -	bool kthread =3D current->mm =3D=3D NULL;
> +	bool kthread =3D current->flags & PF_KTHREAD;
> +	bool use_mm =3D current->mm =3D=3D NULL;
=E2=80=A6

Can it be helpful to convert initialisations for these variables
into later assignments?

Regards,
Markus
