Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1804C19E681
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgDDQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 12:49:48 -0400
Received: from mout.web.de ([212.227.17.11]:52471 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgDDQts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586018963;
        bh=J0oWo+Q4hnyC2+1o/98GJnXQvZ4I23dI0QM2+3KpwEE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UPocKbv+Lxgw6ChSKAPmghjzfBVA0mlpSsjPnzEH7BiL8AIYtLBWn0rzeqb67EchV
         lexvFqG7jz+Yzk3VGR2FkCvuYX1O73jNVbte4qoqjemWUCJY4BL6JgTIIQU1ybEcsV
         /ZWlul09YUOxGOjzlgk0fsTN/9umxtn2A/YQKisA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.181.229]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8Kj-1jL36A283t-000KVW; Sat, 04
 Apr 2020 18:49:23 +0200
Subject: Re: hwrng: omap - Delete an error message in
 of_get_omap_rng_device_details()
To:     =?UTF-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <eae7170c-4371-4865-7b85-589c0ed2b5b6@web.de>
 <2020040423261552036811@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e71d56f1-6fce-5e2d-9719-1385ef3b0811@web.de>
Date:   Sat, 4 Apr 2020 18:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2020040423261552036811@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x1TzdgK/cyAcROSlikObSpiEQzArUYfMSnn3HAWpnSQfh8wFUTb
 qTCDXFxm4ODwTJeopG2Kely/aqb/FrBke9PyYzZDxYX3uUyxMyRvv2NSJ6gociIkfso5Hky
 6cxlPGKiuQuDS5b2rfQ6YgsmXaQlBOXBDrTc8ZN31qoWxbJUypBd9nu5QYGgxwsZ5ra9Kru
 WUEqigKOFix5co4CkfPyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0hY97yl25E=:Z0Daf9YNi8FN9c2Eea1njT
 vR/WO1cXM3lYKtU2pxkSytPq21lHgMfrPVVFJMIN91dE29tJ5KNNDB07JurKb/BVZ/7lhdwE7
 2bxWi9XYp8wWR1c5yP+0SQvXk8/wIbZ0ujPv+fs5O9wCqozD7cP1+CpuTB9mbqNt7G66QNdp5
 Upp3ZD8BnWGWkdDFooRaVxCYaHFdJpKJGtS7srs5VUugIXoUuvJNyBMe53/oUrIpdXb1jJ0pU
 J+0qIHsAWvVR2zSG7m9y2a/TwxBM8wnfuN+D13yxAVUAnbxdddj55Os5X18jPwP+LAAM5INfl
 MYetH/zLfPqBJwa57OUYetXNSmYHgasYUaNUZa37B/Mn6b7qQeV8Y9EV6k2IHMIT7vAV8A9jX
 /5sFCw7VC/BVO4TKYc5Tk3SVck5qxPTSUQvxERr8OT7EIrz8zZhwuaD0LfaKhslO1AQxVMBup
 MkMUgkd1vZbQwPB8yPvQ4EHOFAAoDFgSFfPoCSv/qwYGVI8jtufnaxBADVlAtBfWVPZVFv+9t
 fj0V0rCamfyGe5JSbXEPegt9S5RtM+8UVlcDCH5hcR2rhAhlBMiqZeIEATok4OGmtabcdYceD
 CU9Y8eqquMTn4C/g6RcI70dusCdnVzQm8qY9FLhDbbprbDObS6DNM48xxpk37L8sd8eE0vE2p
 LJy2yEjShs/p0JvVs5vqbDG86ScWdqzmq0Tur9V2Sw1QJB5kDN8nYClgoyas9yY9fIeINiBdc
 TzXz5CjsFNsNly+csafyC5u7VNY+ppGYCeIShcsTYhbTJUMkLRY4gltb/gbxvY3gzgoeBp2bi
 eTf8rk3gx0aPULd+OtdnbrtY/bJ5XolV2VtJ95dMlorq4tylG4BjrJv1GxVbNbImFlaZKNMA/
 M6bqAojxEIZiyf4NFEcVawuQ4gAOu4PmxC9m3TXhmzRkghcg/nCDL5POAh0wxooMaEDz9V1JS
 tI5Xe//fSoJmSi6ohJPuGUBt1W26tIcEVIDq6dkHt4Jr/wTLbHp2Pf0oUNAoqO46bnOFKL0oE
 2Nw2QXjc2Ck72pI+GwkblnOVAyNgBReRwPvXuv96sYY9ly2osVJ5nvyQCDuwnJ1qoPu0P4PfR
 O4r2tB3UYQ4JwXIijsacGS26n46pEGq+lliZSEJCl/cRR2JZ4IDa9XurkmJFkPenlk6E9JFQ0
 ky6NCCH70mn6Si0PhtLzdrwDjPMlPGjAdGmEziK8rJXG31FqIKLjocZNxqDYaCylJIUTkQCfF
 b/gEe/bOUm4i89OjM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know why you always cc me in your patch
> which is similar type  I have submitted=E3=80=82

I noticed your selection of possible changes (and corresponding patch revi=
ews).

* Thus I assumed that you are interested in further software evolution
  to some degree in such a design direction.
  Do you want that I omit your mail address from my patches?

* I picked also a few of your change ideas up for their application
  together with development tools I am familiar with.


> Let me study

I hope so.


> to thank you ?

This possibility can also be occasionally nice.


> You are a senior,

Such a view might be appropriate.


> I have thanked you for your instruction,

I hope that our collaboration will evolve further in constructive ways.


> and I have understand what your question:

Would we like to achieve a better common understanding?


> How do you think about to change any more source files in a systematic w=
ay?

Advanced source code analysis can point several update candidates out.
An execution of a script for the semantic patch language (Coccinelle softw=
are)
indicates change possibilities around calls of the function =E2=80=9Cplatf=
orm_get_irq=E2=80=9D
in 74 source files of the software =E2=80=9CLinux next-20200402=E2=80=9D a=
t the moment.
Source code search patterns can be extended after some clarification.

Regards,
Markus
