Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E2202B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgFUOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 10:41:07 -0400
Received: from mout.web.de ([212.227.15.14]:35305 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730147AbgFUOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592750407;
        bh=+WvfeXBts5+y/FyPiEhcOJnSZEl8xPKwH4MBAN88wqw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=I980mrpcNpQdaQPO90vkmoVpXXYBerxPudnpqpbhcR6QBexh6DULK0r2bFomOtCo6
         RZj8xR7+R/A8S1ftDjVSCIyWIcPY7y/K6L/0vU7VBbjvd28xtt+3FgD9vJ8pZZZ5sg
         3eC3mVLbT3rT7qjG38q7cIYK9y5iX+UtScjz7mPQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.145.213]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHoz-1jPWiY1ZSf-00WIot; Sun, 21
 Jun 2020 16:40:07 +0200
To:     Bo YU <tsu.yubo@gmail.com>, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/x86: Check return value from a notify_die() call
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ee99271a-6eb5-0dec-87d2-504b3ad4724d@web.de>
Date:   Sun, 21 Jun 2020 16:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EZ5eCYTNxjOgv5tA/Iq6ob4zRMloWC1ZVwV02D67frXCUdYcp+y
 +nysIjmpkQubK+Ce/uSN9GiaIr/lixAAdKhj5wlqWZXJfscJh8Rox2+y+Hi6rdRV3+QIXKY
 I1KtJ06QFEDV4AJNgV/La39J6S0EkIGVJgrduiEDsttz/2iQltm5NLYVpB/Rrb8jOYGqY9L
 6+pVJZxJn6STcrk5Yic6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x7/Ovx3O154=:LHrOXQvGBOs/yBoCJldAH+
 z0lapFvGiSJ8gEHhM6Ln/CZxoX/kivLdjrREoaSpSZr+n1j2nR97J9TzgZjv8YNIDGA1KH4VP
 0UcuAqtyNgEji7yRFLdJgv9pfMVmsc88Bng97gH4jszCcCeMYNe4lNnqI2vcbpIWFATNCDz9r
 SmazZyGaGA0e44z+rwM9+Mxw4iVeGfi6VfInBzV3Nrx1R7Tx/2kNzPB79W38HZYt1cUJFvGzX
 PfTmgwtErGAt3C606tB6/KIQdhGC3vhdmywZx7DiqYqHCDgBW+aF3Kur7FWPc+DUrAlSJFMID
 /mdUz8d16uMjtFGstHJSPjFu/ZhNjcnjkIYeG7Z9NdXraEj2yR8JJ6ztye1n3PROVBq5WNOAg
 KMbfezQkbB3ct4b5nUUeXBcygbWlTtVPhN+zmvqaXI2kjx2phhKqh/3doy2mjuohPDszaWbGb
 b+UtYZt2DFCC07qU4aKyPbpOqYuLlpN29yGalJafCVknpAAoOiQ5R8ryLezeHth1C8n7KhKKR
 N0Yeve7reQ2n7Plzlt0W+oLxtkwbYZAvwCZWa5AeHyHttBkXpI4ca0y7AXm2YuEqwF+99izgs
 rgGoZFgckh9K2PIRDu4zJznwswYXgd9Y2f457A29VRnORh9/cwFeYAqOUCvImXp+Dg6vmEZaD
 QhLuKzJp8vbcxc1efZjcFaV3J2e8oAcVa70wTrW96Ek+Qn7ngoozRUiySv2Sg1oDuGUpm+ZBu
 hkgpUf+L2TqG2WX12vYQaVBnUIezYvRuDxZTyBIDfr4xINOc7+dIXUxkNVyLerw1qWCvZ9J6f
 mrIm7hOAfl7raFB+Gk1GsxHXU0K0cuC/770FEHmFznxQd1Aw8iw8jb5p4cj58Z3yBAWpstnXX
 7korsMqT0J0W+GKdyBgiSZAjEbNicf8EzBntcHTebEWFgMhxXET00mL1ZtMwLooRgKdaKXZuh
 ovm9SvStMI+iP7BeGIepHOqt/0B6dsjtsqVxLeVbgvMv6UCZ4Y/RVvryd4jeLxzZv/t7ifjVe
 1dN4jYowwoJOcUnuz30+hOrfPN4Qg/fAKo1WCPN4RfNTE/5yulhcU6V0tI3m4WB1dGSFiEw5Q
 AfWD8cNErSKG4NAxKjFaoV0rh2PPQSUwi0zC0EPosQcfx+s9YXTPoIEoqvmqLiaHK9O4iVbRH
 Uj0Cxza/w1VUvs9i1zIgu1Hd1fgHkZLbvNXLPnas2y4JQ1ORUdI130HGRTBJea+LAq33/y+UB
 GOVEynOalkvjBw5ay
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I propose to improve the previous patch subject.


> This is detected by Coverity scan: #CID: 1464472(CHECKED_RETURN)
>
> FIXES: c94082656dac7(x86: Use enum instead of literals for trap values)

Is the following tag specification more appropriate?

Fixes: c94082656dac7 ("x86: Use enum instead of literals for trap values")

Regards,
Markus
