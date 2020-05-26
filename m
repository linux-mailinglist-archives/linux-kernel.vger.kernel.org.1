Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1F1BF3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD3JAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 05:00:38 -0400
Received: from mout.web.de ([212.227.15.14]:54273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD3JAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588237216;
        bh=T07bRhShktcbk/3lm3d+/ljB7VcvVOvAHGkNMfRfgKY=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=WDSPCjvgj9NkcbNOOCmfpyDwhMNA+2ema1wXYj82DXWbQs24TSfm6BpKt3SFlI2XN
         Bc5/iDX7n8769VPj76/G7zJXnMT7kRj3Gb7bxMT7ZwoifUZbIYXxrUNoYjqhVWiLPz
         8he1qXziFrZOyaRo3LgII1JUdiBjlk3a9RlxXBq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.175.216]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lfipe-1incQU0SU6-00pPu7; Thu, 30
 Apr 2020 11:00:16 +0200
To:     Xu Wang <vulab@iscas.ac.cn>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] ZYNQ: platsmp: Return -ENOMEM after a failed ioremap()
 call in zynq_cpun_start()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9cf516c9-3a29-fb39-8943-49c906b3eea7@web.de>
Date:   Thu, 30 Apr 2020 11:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MkAn8sGoCY4NjJFBk34Jt/ezhBfs1X9l/SNmrUIwFVwkNNJCxtn
 kaFFcRFwaJd8KXzM74jRzAv+4r7Yk3582LUW3COPg4l3bT4L9KGQitwnXrApPRwTcSMST4D
 CE5893CosxF/ZzntzkW2/t/3uzTQ7LVuwqGyw20hd/9p0vloIV2oKfouB9+YBDVLSlw8P26
 2/yf3BYRR4fgSc9hfUSRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Yvp3yO0fnM=:FbVB9vZdaXMJEDYrNnF7cQ
 ueRbFAPL/ynqvSC+TVNHARZYXVGmLY9IfBm6bM3vfRuxxIegXSeJ6rOYdoCKXrZ+B5giFb4TA
 Wbh1tmgtYEw4XWCg/uTfYjw4nRbN31KEtV8kDiDobBPPlo7QpewIWd3PQfwr+Iw196ZIeEnct
 nFv9PUvgi0W80cd8ax4bFCYyHiJh1NuZoLMHqSat5ogsXv6ZJ77aiUxJKK7u5+2TG38ExuT/M
 uo3z6ozWOfTFPT9ILiBSiru9XIxidyPCqneaSTbZcIOahT9yE1CVVuAQBQ6HvxDuopH8l5BZt
 H5zPh1SHKttltQr3WAzcnquEDuCPEAm5FFwBfdkRr6QjpRH4d8UaPeWbqGjvtqASsXne9FaV1
 fxjRLP773BWRlLvJvm4AA467SihGzwOMRXg0w3exjSUtxYNNhSNlaH9yHrGTIBk+frSVBsfdj
 koircz/aUr9ghxl3u9uZmS2DOAAA9sx7DuJOIrkzKt35ONddlVRJUfFW0hLX6sDKlKKMtpHlC
 bj/c6mvPGm71XbRbAbXb/IJvACRuK10d6/LIoI24x/CFn7woZ/hamZ2DNzwTgnKqrRxwVdo/d
 cu1C88EtUWIM14bkuq1LpPSCY2Hp5zseZ7f+N7Jrd566qQ/Tqu6LW55OHP+ypkbIYtsPdQFCN
 va06H3KAn+YseZXSK6/AH9LnOSTPvqYlFMWiSizlsbbxudBjWbO2nwyYoXJ4ljPtDzTuNtae5
 Hef9w2EunseMihRtSGdwtqfad95y55Fee0r1HYeZbWwPo5HCMGUNMLEId+/OdwFMlQSBb97qa
 i/JNAeH5vzwtF2VTZ9kiN15vW1GoF80og07UyZ7A3oiM69HQ3lz4gOGnK+Eet50UwfKx67HdM
 s5IXTn+iHMagpDR7kpUOBXRAx4Fw80YfNu4lje/tqzxiYyeybf45nDA7rXXUbH75w9/n1XLL3
 7NaeXXm3R5i+KKzIOWaIaqstqqisgfKszJsroTDqOJ9RVSKyCJZRDRqPJhMabym4asSkvWV2e
 SwrG9d5bDnbBQfWfjpoN8tAZKl7ZXRftXsS/vkNNfnJ1WgXqP0HdJH6Zw9ITW8b6ZAA8Z08ZF
 ZjGYGu7Z8jSsGsmfHrqN1q/JCJNQ9qrrA8No+bgsc86DtwqMCYIOPRv4LEtO62N4DYOGM+qV3
 yldxntrksXwi4aBwhbTFDiIt7SWT1yY4pPXD49D+v6dgR2lyAllOa9qcYOP90L+NFGBrMjYIH
 +xSP7k/4PLqNW6DMk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In ioremap we should return -ENOMEM when it reports an
> memory allocation failure.

I suggest to improve this change description.

Will the tag =E2=80=9CFixes=E2=80=9D be relevant because of the adjusted e=
rror code?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D1d2cc5ac6f6668cc15216d5105=
1103c61467d7e8#n183

Regards,
Markus
