Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D019F720
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDFNkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:40:40 -0400
Received: from mout.web.de ([212.227.17.11]:42175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgDFNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586180427;
        bh=jQKfo/mA6LXeQourdE1dynf7cXrRhXMFCXJz48fqqug=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T1tP24hIkiTBo9pFvMaOwuZEUaYXrtUdTmYrPTuu32yalu6uSCFGui9TTl5G4rjVC
         f0nOM9nnje9VRzJzGAiIVLUnhHBxZ6JEj0p8gBXFP5fFs9sqjcjbiiZO82i7RWgkbT
         aDg2qRQclN6Yx5nQHmrRWISQfQRx1fPo5Z5+nKrQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.176.200]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ltnmz-1jDeRy0vfJ-011CKp; Mon, 06
 Apr 2020 15:40:27 +0200
Subject: Re: [PATCH v5 1/2] powerpc/powernv: Remove two unnecessary variable
 initialisations in opal_add_one_export()
To:     Qiujun Huang <hqjagain@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200406125242.4973-1-hqjagain@gmail.com>
 <20200406125242.4973-2-hqjagain@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <da577413-30ac-c95e-292d-60625ae04124@web.de>
Date:   Mon, 6 Apr 2020 15:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406125242.4973-2-hqjagain@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:U0B3vaE2PTY7fYvmScB/HkMqci4NdTjOSnAfqAvFJILctu/tglQ
 NJXioyV28ZlVZZ8IqVpX/y+7IRa6xJ5+j4c+zJk0S24mx/3fmb5bny+lUauFdukxsqwDHvc
 FReEp76ZZuzdirsiThpvdUd2H3mfiBTBd+Qrg/4vLYgCFlz+t3UnuGggQcVBZc/nKeM+OfM
 pWBMwbk4sMTbl/bQ3pQQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cjnvYshkAew=:sRzBBrsaGpZJRL6+Zeggyo
 FhR7yB0bI/8ql/Tzwzx3p4Jec+/PO25tdt6fsw5xs9dJuqbJQeA5aUe4IGxDyV9w4j7FR6sJ7
 DcjcbQWYsALgQj1wCa09qB8XTYEqiIP/8Tm1CwtJdAQVk8aUloHK0KhYgonIT67sv7DO1aT82
 iWfuRKjn7JOitF6EAFpdTvmJ09lSRNhnRs6Xf4/T4I5IRs0/YWcQNLJkftsUhzFKpZz1MjTCz
 mK/4sZxkAD+8HFY8Op6VW0GAZ1eH94YOTXNeH3j1tNapc/brJQivlTp3en0h+VKNMaMFUWgMw
 UfCvbwBYgPZ2wYt5GBA157er/azSgVb9FOij7mQgbWl4RxDXRF8zjrhARLFYWl5R/eFrMwbFS
 to/+iPCwuliYqVe+0O5Ha3akZNQEdN2bjBBZBiaB8yv6OvTYvHMbBs29vVovKvtWw9IKEIm1P
 eT0nY8U3bd6Chatxl9CsMbGkdjKbk3LYM7l3xaPI1YYv69etwoSb6ClCtAkIliWQ24hjLp89g
 ilTS1p0cy4eSwvA4DWwCaYm2XY5wCK0zeGXFQiHEOFtjUtbBzavXSFCzLCLRsyqm8sAVgs3JU
 7w/uWN7BGPutJCJgdnt6fKJxiH7Zhkv3rSxaRJQhQOsO/HM6LiLHChSXlsJX7qvn4CU1AHcbQ
 dZEY1yqy3spLaDG5SqFVVecf9UET9ix54yLBr1MXaPed6RJN/mSMPVL9Uspt9imQpTa4NO+g0
 If3dP/EaSG/MnApXOmzVnvkOAJWSguUPB3p0FOEYsPq/o4HopxppJpW6syh0oPLA3WcxYOqlH
 UyoYhPjnlA02Y9REP0D+qX7yelZujaRgmX3K9N9+KVoTu6cmwojeqQYdgUIjlKsYY69Brv8FF
 mWRTOdH3ubGaLTnN+jAGva/r/b1XU6BweeRDUx5JYAsmCSV/oZyLQJdWMKU7vEp+TShTMb4Kz
 QY0SihJzVKVT4fWgOMEWiC7Jl8fZU31C+2beajD1yt9kvko3WJZ3ehamFXuOd23dWsbMzbUJe
 NA62Ucb4TJ3asORgsm527WH/F7YtdhTcezg3T5ZN7Ahcz3b0bnFDvRiDDCiZREpw4Fpej932b
 PayatjPURelYKB50E1Td+nh/X+Ao/rku5JpuHSl+qz1NwsGT51fJFsp9msrXylXcSgp9Oq/Ld
 scwZADgX12t0FusCOgR9XNeABgQPGJLHcvNFfrjU53YP94bcBUAZnqmpsGhr7cRSYZrd1Gxl7
 9C2Db5gShWSYCgq/0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And we can remove the redundant assignments to attr and name.

How do you think about a wording like the following?

   Two local variables will eventually be set to appropriate pointers
   a bit later. Thus omit their explicit initialisation at the beginning.


Regards,
Markus
