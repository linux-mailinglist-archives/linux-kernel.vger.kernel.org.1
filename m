Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A781CAE24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgEHNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:07:07 -0400
Received: from mout.web.de ([212.227.17.12]:44349 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgEHNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588943173;
        bh=IchlK3MqS+7/2Jq7h0H+ek/8N0WfpAh6R3bv1mvSmU8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T3eYU+necfQB2VdfTn9hzozuTZsmTtnm6aE8E+jdjQM8itLBp4j+7F/XMyZgOgmUv
         kkeapphU/5q9qdR08nM9DTpZh/whqrENlNpnonkQJm9xiADGyfMf/44CyH37gGzF06
         1D+j3qaSE3sDJEgH6y9bcnOSyWM7KKf1vfnHRnno=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtFQN-1j9DP41AWB-012pz1; Fri, 08
 May 2020 15:06:13 +0200
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
 <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
 <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
 <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
 <20200508090053.430d28d7@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0d7ee4cb-5d26-3c20-4e19-ef57c29a74b4@web.de>
Date:   Fri, 8 May 2020 15:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508090053.430d28d7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:xVJ54ITxrkOnvUyQy7xU3+d/K1NAf3jH2TTBeqlZaL6N63eGAHa
 ZzVWAZaOvnARGhw9JrgH0D15G9bO3Vrn1S/NlVdUm/9RWqHuIlNKKqr9oiFPMpkXKPXjcNu
 DdtMJjQAI7AK9FS56XRtI2ypHDi1o5hXrJei+4yK0VJKLMszYi745o7BKhNfoHbNUpBwdl/
 kk03zQau4NtHwpah5OVBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMwlhQ7L2SA=:K8Ty3g2Gqsfc+uMhuqat32
 LgwYaiJer867+rcNQMoZWgkU1B8vuxYhJTsAOcd4mRcdfL3AEbWMAlFNxoOeiv/z3ItUsVGgF
 3s6SLcaZ9olv8Gx9uqPKlzBsp7WTUl717aJRsLsFv2gEiMI17yAuv99M0e+wyrBX6VApIO+iX
 nnCfLJH4b4OfmEPwBYM0WeGEmHZYYgZa1TBkIz80RZBlV9wdRPq4a1tIIh/7PAzYHqQPcM8Aj
 K8h18SU9tAf4W75QpiAdK7NFWPLodt/U2lxE0ZngHY/4PWtUpM6oxDwshdA2WjdlJyPpP+rbL
 BtSF6sWSSU9SL1oHz+pXiUcEK6JqoB7HMjv6FAikwSWLqrlgCXFJcWjIC2YTCGq4jpiq+pQ+j
 lJPB8LHmhUAUaGPLZRZf1IVAvTP7g0ne/mED8pklyH9CbIrOpiqLmdJnfJwfxXdVFHElBa3rf
 qZFUTug9Qi73SQbEJdG/DXia4KKAouO6HNYeNsf/v2DIITN6SBwnVWW5E9fVSvCmd1hnPcf48
 vV7NAHsRVrNG4xSjGcDyebeGhd6Q5nHjU+qB1C1DNn5NERfpDGHHUDpqTFTR4HUuTuLF9t47E
 qARbpLNWSXHFlqGjfRQ9yx8A9x4pqEt9IyfZqPd/B2BkfydxEKTQnCG68cKSffAT+owITUjp8
 OypCI5vR4vfvXWkeEdc8aOo/lpsM1PHULp+2ZrlviV89TbkfVe7nyTq7O0t3/JS6uZWuNDISP
 F99Mj4L85s1fqQeObgoVnVZZJBOkRGnazA8Al5XnFlGarpBw6ebDrAL9L0B8mvJ9c6X9tDZNq
 ZJSbkLEIMWUXyJK9exQ9NAHyMc5SlLNO33pix12fj3XolYG6cDFE/6RHWONY2Z3xUo/ybdFwI
 fsyFr6Ioj7VCcns/Dd1x+aofJKHOaOznAFwbzx6NqIlbGHEpO7NHtf20GCZP1n3UobqafeRa9
 kivwpu7gG6V31dHJmh6FhNi3kM9oeXI9h9lYBGK6Gr52+L+EhG3aqs5oVjhpTShThGUIe2e2M
 D8GNVHgG6qzg3tSiUJNawZX/8ceybk3Z1UY6sNzuTRu6/COhKAq41JSUpHYErCeFpee6AmgiJ
 KXaUc9SNYpqBuDlYA2i/ZpfrIsKBSx3ry7aPnm4r42r+qV7YstoC0Z+nBM+dBiYI6gU9K+C0l
 jzztaw2SfUFzO/32TBkqs099KtEyx0ilFDzLYflkg45gbbaDq6x467gTFve+Q2uk+xIFAtEUg
 k4U/cwFmMBrQ+X7ir
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Markus please stop! Your suggestions are just your preferences that are not
> required for the kernel.

Do our imaginations and expectations differ for a good commit message?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=79dede78c0573618e3137d3d8cbf78c84e25fabd#n102

Regards,
Markus
