Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942920363E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFVLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 07:54:46 -0400
Received: from mout.web.de ([212.227.15.3]:41045 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgFVLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592826881;
        bh=NOxy+VrvNGYqSANpunxTpr9ZjH2Zd5UjRCGfv7SYnqw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f1WXzCvrP4SOkPuVz+XH+GG9rIapTCqmhJ4r3ZcbRL/lvoLYhvNqUYMffvVq616tX
         iCcH4ozusAFctCZpyijY67W1EQYMAG5hw5CuazPyMs7ATZtb4rTdpTrs455TT+MCsU
         ett8HMAfC0eSHITIT6eFTwu4+LFeg+62xsK8D0O0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.81]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLxrY-1jmCyq4296-007iXC; Mon, 22
 Jun 2020 13:54:41 +0200
Subject: Re: [v3] coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
 <alpine.DEB.2.22.394.2006221321180.2531@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d23eec1d-9e5d-87bd-be8a-9e5b1c00a922@web.de>
Date:   Mon, 22 Jun 2020 13:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006221321180.2531@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K18oji8EPwM1EeYMrhBs+FB5QmwLFZByelo4iz5pyC/8l6XEk7S
 iis5NHH+vkiIeQJFnpPxvtQkGXxvW8uDpJ/hIEPJJDaakt1m75VrsNjnEJFeYdUYTePwh7l
 wLTcQlePwB44ewWrw0B96AT2uorIpFhdmDfoqxjOiSPjX4nk/FgKwQoksMpSro4OtYfiJni
 6KxWt/uev1aoybVLfmRJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JcVkfllBZt8=:S8PoYCp3L4BB26srYPE3rp
 0K1+LJlGoV2ZY7+1hDLSEJZEV+kmQmEBF2498XcUq05vuwp1OkbueW1Wsd4UMWAByL4V/rcIF
 FOPdBqZ2fSicuUcyIHpYfcNtqdHrFGsdzxYjqm17Dkzvjbm19yv7P1sHjtwSp+b70pinfA8vh
 WBVu7MG59fyEhLCPQFpBNZJmjtobiKiilPofNGiBFasWbOPJZTPOWcYWL1vyZcEVcZb/3ulr5
 Rinm23asigeQHW4nEu5WLTCFaRvmSQahv1/CzZ++4zd+OrOsLo11ezMqTbxI3nmQUnyIlZxvA
 fJSIsunXqz76v1BtbkK2At6VrAMORmjv+XRBq727NJshhvrqin9F/lcxQnzMBucugg2xjFLxs
 kNIq2sAQ2pBe+Vbe7ksFb/oJDhJRlFJpUl/rg9jT5WzpF7JYoxxx3s6ayHW62XOEA0ZTooEMf
 Ihxr7lHbzBcKRtnYu/dg1tTGshVqhTrfNUIgbyvf1yq2UY/Ev3MBybCues5CtqMATKQ8Uz72J
 Pod/ogoouwgHET1XcjlWVBrK1OCRWKP2FYl/R17osHWH9C/2K/Y/92TbQbvC3cyIt8ljoxqM0
 ivjyq0QXZFsaUi/K8g4guhWiwjPSxdK5i5mjvn7hkvMdvn+vI1LKbn2Rme/wZ0VIx6/PkKMMM
 U01eJBz7lVsIpCw1d0rU9zegXRWFLEQY8oAj55QkXui2s6famx6Dsb3bysc1ONLXeI2yjH6sX
 E6J1wL4KkoCcT88zu9b1IYUnv9cxjvVIFz2nXp6UzqqG9mTNdd+pV/Cw2hzGGers/+q5wSSzs
 Ib8ewa3Q67N/8T6/jQbbxfHchXPoN8EsDUddRI8UJeE2VrRx9mgiVdfj0wNslM1pph1Pm47mB
 0bTGCYGE+zB/Iu/pi0tVI4GLeIUuInESEfKO2L0tYRR2twVX1A2HKdfO1sCT2Mcm0wJN3XLWO
 Mb4QdntJsVrIQNgUmKnsHSGPqa/RRU96HlENRsBnowog/PwS+RCN2t3eCgVSaDG4+n5FV7DCn
 ElVLiGFWj1B1KLJIth3xWIGF5Dabq77AkCEepwhVIfNkid6NEkqoiMcGuF1Sio9XMy2CKEWvY
 1QD9hRU6ft32XJdStP4y1NNpbIhvxK1WuwAfV8bZj/GoM6+ojWzTZ+BTHgTpi04i9reR9hGbj
 LSYwUmUYN0JoK/CF4hV3ngxEkyd1+zxn1luqWNnMRZe/4youOVXcEwiWqIOVAV27128uJKr4o
 D89CtNZuUCTjzlpNL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suggest to take another look at information from the section
>> =E2=80=9C2.4.3. Formatted string literals=E2=80=9D.
>> https://docs.python.org/3/reference/lexical_analysis.html#f-strings
>>
>> This software documentation provides the information =E2=80=9CNew in ve=
rsion 3.6=E2=80=9D.
>> Will such a detail trigger any more software development consequences?
>
> Thanks foor this information.  Denis, would it be possible to express th=
e
> code in a more portable way?

Which is the last revision of the Python programming language
that you would like to support so far?

Regards,
Markus
