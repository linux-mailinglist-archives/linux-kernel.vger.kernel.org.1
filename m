Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A56200795
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgFSLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 07:16:23 -0400
Received: from mout.web.de ([212.227.15.4]:58235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgFSLQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592565357;
        bh=zrGN2/4FMUrTh6i8ulXHhVkLqpabsZXVXUk0EsEVmyE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WjEdVGPrY37EQTtjT1Z1gP4xUwbycB19ga9GReJ7s9bGyB7Ahct6PSV5TLyTGIcQM
         PW0hgXC/510gtbEJVliGoqgHc3rKBTbinUx5kI5T1JyKgMErSLAbXqx1S/097gJsqw
         RUBIVeDw6PgxXhMOwrUXUKPBh73ifXBx0P1kPwM4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.139.231]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Melaj-1jC4tt3fSn-00apC6; Fri, 19
 Jun 2020 13:15:56 +0200
Subject: Re: Coccinelle: Improving convenience for message exchange
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
References: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
 <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9d59e035-c348-d61b-0206-d9e33094c605@web.de>
Date:   Fri, 19 Jun 2020 13:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FchTfQ/IvuPtD5FC8vGxz+IvKjRiYq9XB2ZGr3afxpWRUMEoh3K
 6c+63I22c/ZsF7Vdp6UE3qX5mxNsXqIw09BCM3Vd7y7RaMlTJ4xq3yzdrn3Jo/yQigBkxYn
 iZ4yKKXk4dsLvcQ/G5BxaJR50bRgaa+nIyh5/V5ks6IW60Y8Fqt/uVHRg4bMQoYnTRrm7CJ
 V3jdsgk0amga+ta2mqI2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9LfeHfE41nU=:ZoS9CyYVx4yVjgCcmCydXx
 gjTnrOKdtCTKirN9ogNfWvkCGxP8W5R8jZlELJXYBOdgxBJ2VTpGVTaW4VWg31wmfn6Ok96IO
 m+keu8OHRDmgLl/lKo2PrCmIY6CAMuY/jgARqxjIlSc8Kgp7IyLFX8VGKx+dMgBjft71t9rPn
 Y/PxN3HRKSoG0dsR/NMzagIs59BXk1POuu+U8pFdABnH+z8eGgUbjRpklYRm/Lq+MzKhzvXjk
 myOSCDl/DQyFzUgcHqL5XT7f/PcZOkmcuOVa16L4IY+X5sbjw0tjBGgarWXCbWy7qsKLRhA5x
 uZpsi1G3PUMyqJhle1e/t8bT5LmGCI5wHIAyqUt2SU2T+1ANcrHej2PsR7VRc+ORkGlFrXXLx
 mjbVunuXrg/9yyYkGGdVPlsgVXR6R6NoFuHFqCRaMbcJIZ0X+E0iI5SEFcU1z1xABo24tBnPu
 9ua3HOCTq8OFNQxw3ZCmb0ScLWSghm3v2XP6161BqWCx1mXsU1Y1bVx0jFOYIEiIUfOcLrMJu
 5rLLzo6nq7UG6X+mC+9fgQjXu4Ac8nOJtwK65+u3nSN/CpcdnVc9Iu5ANY4VHhTDMWzublkRi
 S+bX5omDDJbWWkFxaGsyU4qD5IG4Fp6sBywC7W4z3FXRaV9yUG+G9yGAbeIsH1G+XBwDpSUpc
 wDl+qDmhw+khE3T8yOa+BVbbNuhPUS0jAIi9Nc1KCLSHXDyD3TsSh6lfQoUyhnM1EHQomxYNX
 mcL6TZfrQcKmZYDoH/RnbDaUksQ6cO/cx0VplcUNB4+sRxWGLc/XfSjCA+RIm1VScZV6bOXpw
 JS7XD5EYm8lsxye263JsppGDyu7JkxDAlSd3ep9QuMNgruupyibZdvjwILttUh/qk7F1BzCPc
 gn4uDxqrk1eReTGGPRiRSoscrq/yt1Wn9dBYLMYYtJIP+S/kfJvohXLVVLPrONmlhikIe81uC
 K+bpB69UgaUa/yOUYIT16MXmqJDZgnP2PeXRw8j3Wlx1bRXFj6ZEbg9J9R2PBS6xe5zKq3j1R
 hOt7EG0kvKgP9a0aw2ilEff5RAEGKc0ejjpgcWSXwHUyWZCC/Bi/iKrYrqeDTG5v+oV5idbpu
 srCXUsmo0xyw/jT5JLTkus9/EIoT4GcE4QsufvvDyN06huf1eu+WSyIVBP3kVO+WgOmid2YwX
 npahz0G94UON9lfm0ZA0/NCE51s2zyLZUdmWbjvC+Szr+h0lBteaGM00M2spmmObc6SP3LGBX
 sp4nL1aqYwOcUZv9C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't handle your suggestions

I hope that you can work with provided information to some degree.


> because your mails constantly break the threads.

Would you like to take another look at reasons for such an effect?


> I just can't find them

Please try again.
Were relevant data stored in usable message folders?

https://systeme.lip6.fr/pipermail/cocci/2020-June/thread.html
https://lore.kernel.org/cocci/


> after due to missed/wrong In-Reply-To headers.

How do you think about to influence the situation in ways
which can improve the desired data processing considerably?

Regards,
Markus
