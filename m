Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6B1B5C25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgDWNH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 09:07:56 -0400
Received: from mout.web.de ([212.227.15.14]:34041 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgDWNHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587647241;
        bh=j/OsVSvjW5GF9AuYYuwF5RlUVMErv99o/kA5yjCWrWo=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=mfRRuifwJT7Bj/K6pADSvQr+883txqe5FBJvTy5Yo4cBgi+Tmj66/04jAJjfoBi6R
         qYvtJT8wR5CxDY47VuTwivBQ3ARf2fgXlMhzRw8kFMy8zbIE/71qZpQaoZViKgWsWe
         yM0fK4E6zyPdQFoHJT6ybyyL9EHl9dKpWbfz2iNA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.235]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6bn-1ipGQg0yql-00oYl8; Thu, 23
 Apr 2020 15:07:21 +0200
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: Avoid double lock for cp_rwsem
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8f311cd7-bf6d-21a4-c085-6b2feec39717@web.de>
Date:   Thu, 23 Apr 2020 15:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:plDI/7mUFknNQx3zJvAn9hmUnw2+ZJUwoltk3Xy9Y1Vcn1vvEja
 wI4U6Mk2OOIt89U9phh32tnq0Ql2s3fqgPRaiBPuPhLi68pFX1LYUEc6o0QbsXCU0VAx1+C
 Vh3wS9FXXrPvU9bk3ZLhIHV7WDE9D/2cU5yV8NAea7V+X6ORECS/y/+cAxxipmv4X49iKYP
 HRRXnQ/M5dAx0M39pD7dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ZDr+S14qw8=:coy8ntUcgaQb7c+zRmUddy
 upHm3NUKxwDrFkIHy+9wbkiQl30IoDHX1twYUYhnMlcqhiMRJWeyeG0JD3WUGmq4Jm+YFgh1z
 JJfxVbE/wCOLOFjAC+96oGVkvlE1/A426iT8Q8kKpZNKwEQOJMX8gnpYMNUJJhtD3RK1BUlwi
 1pq6YeQEp65yn5qbpK6H5fRHsHhaEgsy3nsJAELxE/2iOq7ddqUijjWHDuvfcDLycBJZRfu6m
 +sqt9nRtIe+dhcbsetXqoFlEI4pPD0g4lcfL+OYlDx+bJZWtM929gGEXXNeB/u9AXy++wVrLD
 sdx7ETM/fuYh6H08IPdgy27CEC8jqtBr88SHGYqk4gci4aKq20Q7NH3++6WbWl0EurDDn9Eaw
 XSdxRsQT3XI1xh2mx2o4Nj5LRudotcWmRKXcZnHP7EE/EFmF1Xl6GGANeNnNhXBATDeIbI6If
 reuiGamMlBhNwKYsRijElBRVuYzGbFlLjzThR3E8uTJAYAAde4rSReOkpk49fKA89eggvWfqo
 +j64dWGJJY4TJRX7+JZXksI0h3gGJ8tZmq5QCpewc6RAcVrBUS/nwC3hpymKT5zjaNpXodqg6
 vpwUtfVoow0HTzwhphFlJghJJfhBbBi9dWrF7ntNtMEJLAxu6tCZhZ82Dnum2XqKrkEWhMw2u
 s8d8FA1V9GDbCq0s8iw2IrFVqB2nXMp2zCiiKIcPmM1aaNOeq43bdKI+E+jOQhSFZeJOWSd+c
 xvwBY2GclQBZ6EK3qRGrU/mewrqhpEAkGjSnmArmaeRr2WEOEajvHiucruS1prMzGmOX7J77e
 7n985y8Nq8uV6TjNHdJmgmESSuzq+G7tAvxbXLL9cfJ8ueqa8Zi/injpyY4YqmN4nmpFgoy1E
 PbvV4gakAAQR4ssxTHoeQSPILG59bKjuDbi2PD0hmRA7c+42EeX4rn7q8ofI58c1VYHJc9+Uw
 zocaU51BgEo1n5zD05cT8g7vRPFC3YlF5qmVkmJ2Me6ZN51G15O4gmbguvASTeVtmCc61LMzZ
 QnajuUnZ9EABkik9oRmsz04mUN7gEv9HJbWX/w6MadNhuIFwnzC/uJKr2swMsIbxRaPauWvwc
 wwu+i3O7wfyAii7gtdBaoHPrZSEiwSWXSGMPITcAa3fea940ETcWEK+91MyzcGFdqawqNjH2M
 eURB1CaeKM9+13XAfGYNXKbPMds9FK432ebyJz9HCK88wvKFgwRONRmLPLQ2JlyVNGtTJNmGD
 swcDFAvu9Bg/bSvHB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Call stack :
> f2fs_write_checkpoint()
> -> block_operations(sbi)
=E2=80=A6

Will another imperative wording become helpful besides the provided inform=
ation
for this change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dc578ddb39e565139897124e74e=
5a43e56538cb33#n151

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of a=
djustments
for the data synchronisation?

Regards,
Markus
