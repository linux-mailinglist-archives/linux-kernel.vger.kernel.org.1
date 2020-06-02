Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54041EB62E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFBHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 03:06:30 -0400
Received: from mout.web.de ([212.227.15.3]:56427 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBHG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591081573;
        bh=3Bmo/FstVjMESOqr4jH3BM6qBvz/63iqicZxdkKFNGE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qyHztjWrawclVP5TU0teVaC5QGxpVWb2g6+NKiL9/IJ68u4ALeAq0OAYIXHDaegb7
         d+USuaSnKKWEYUE+xaUr2Yt6cuIzmqJ4b4PMqHUL5MnKNKqaDRy7nbzi/h7ZQZ7kxN
         CbrHXYnN/TegSSr0B15wTVHVZiNfq7Zq3IvQRVXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lecda-1jCfj12P5q-00qRoz; Tue, 02
 Jun 2020 09:06:13 +0200
Subject: Re: iommu: Improve exception handling in iommu_group_alloc()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        iommu@lists.linux-foundation.org
Cc:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
 <20200602015044.GA89266@VM20190228-100.tbsite.net>
 <b31fbcd1-b5f8-992b-a994-2a950ab36b61@web.de>
 <20200602055639.GB89266@VM20190228-100.tbsite.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44b4a048-ef36-f75b-5869-22e5fe4b15d2@web.de>
Date:   Tue, 2 Jun 2020 09:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602055639.GB89266@VM20190228-100.tbsite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMosH1UTbBDIg78NfuZoHK77msPCbizRxnTp/nSwYuEzfDGJ/fO
 s4PNQOqsra3BrHoLzV5UoPaHYfjWhz6V1oPiAicIFfn5b5ymE/00p5hrvDqZEhPz6nBdaBE
 qAtzbu+inpc80YtSct0V39rUTGi69f8VXRSCtyQtU6PtbVYP595EpZxQuJbpSeT2PXbTfFG
 iLlKYw7Ry4apdO0bT0e2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8Xw11KU2Kc=:WpWb356sHDumiusM8R6Jry
 1D/cPIxGr+akDkEvm/EIHJ/o0cQZnlP0Ndgaw6u1I3gg+oe1doeU/KQ+1NSwWIs7bq0h7Ansq
 fnS91RU1rjbgl51e8iKT59mEtO3LIUJ6j7cnZ/DWQideKoMUWqUyAyZKAr2E4Y6sfKyTbKV/4
 ZoFIPp44I4YwZSRYVQk1DXGb4mvMiWHTWSjWPIAgj3Fo5VJmbMRIgOSnOOHYETWZrKnnKinjw
 IIaFoN0lwQ308fg8PIWhiMTiV6mXJ8aifouBPUaQcSSVn9KuReH2c9+TI/B6Mtc02ZWlVFK/j
 Bd2b2BFEwg8kerTdxkNRJrC48T14Sxs02I14w+MrbJSGpK/aPuuak475JOQBb6etqE0HEWhqr
 PdHCgPDoNOuowdlFTMgDj54cEkPvXGymYC1bvvGbfN8Lf+bE6lLl5jqxRxG9jh0uzVeSOooxw
 f8cxXOxlCGKevT0xGnUTlVLsXF8O3E7dCwDSH60BRPNLlNNLXbLxQmMXUwLRlrWJjopBa9lDj
 UBzhxPi8lrHLIqhnjwd7SdecFMIKAnrhYR9zNbIwddxPIoX8S1YYQy6iCblMtfkfL/RZpCW07
 Xd3msDzRJ0pvAQM4Fn5MdN2hpxSzA2fQNqqmFfUhe/J0V0ZtOuSjtts6f8CLSZyw2mjdChbCe
 2TAZCOTRm5Ag8clx58NxUDYPeRMyzetzw0pEii4QvJ0L5zlwzbxx7+gPI3qyLfPcHMKybL+/9
 /dWjq6ZXMWuw2soclLil9Rpx+PQ8FG58qhvwPV40SLYzQppaXzttzoFYBi4sf3+PdZTAURnOD
 m7gjCMEadNTife8bNZksc9S4vALbkaRo/l3YJLq4CSlhSeqPwg2jjLTu+uGZNzPlOPfsXlD9C
 Zt/bjLmvIkkj/XUAeb7hE9REWHqZAGE3EZbYM7znP9PjHJyeGbcKJDWV0yTGJKE7MG9PmGMOQ
 OXc6fYa79nU545rZfTvnNUQDWkS76mvXe1zr6DtYEy6bo/A7niqhl33A8O45LwzCmopol4yoZ
 fvUm96qCX4Upy50KuiUgXrOGj6wP/c/gb5/Z0slNG+/P7TssGscLLGpRSiJonq4E5BWdVaqj8
 KgCl61zeubhdHRYBS/LmE9vQLgJBpn4K4w5M/DV6Ww6qMPSOCJWQlYkUtllXcn6uFrRD75fGM
 hVHgVeHYj6doIZ2oNUsn2BGwCKn62BkxDF7Ly9Gmn8CUrQQPJl5juo4Q+gOlcp+udzzXRBuVB
 C0ttB/0bpcKhucMDA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do you disagree to the application of the Linux coding style then
>> for the recommended exception handling?
>
> No, that's not what I mean. My point is the exception handling in this
> patch is simple and no need to add 'goto' statement which does not help
> to improve readability.

Do we come along different programming imaginations?


> And I agree it is helpful for the cases where a function exits from mult=
iple locations
> and more same cleanup work need to do.

Can this view fit also to calls of the function =E2=80=9Ckobject_put=E2=80=
=9D?
https://lore.kernel.org/patchwork/patch/1251326/
https://lore.kernel.org/linux-iommu/8bfd018ef4add083a35a6a94a8da045cf3af51=
b6.1591063271.git.baolin.wang@linux.alibaba.com/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/iommu/iommu.c?id=3D7cc31613734c4870ae32f5265d576ef296621343#n478
https://elixir.bootlin.com/linux/v5.7/source/drivers/iommu/iommu.c#L478

Regards,
Markus
