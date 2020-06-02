Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF1EB4D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgFBFCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 01:02:01 -0400
Received: from mout.web.de ([212.227.15.4]:37269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgFBFCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591074093;
        bh=rSRqzrMRlXkfuEUgD9N5R7LD1UlBMLz60V9os+TxIUY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TolpJbbEj396FLD6uW5TZaec2SPDbH7z/EMLD893Drbo7lYhr/rmmRsS/5gBoOWGb
         OXhx/FHJ2TrmQTQFych1YsZn35tl7Py2VHWIk+j7DdjwcgjLUFb24vu4dxx8zwRsit
         jGmsXUzAlsTsw49lrixUMCv+4Ar3IfsztU+ZFTSA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvOd9-1iy5jK2Z1f-010faM; Tue, 02
 Jun 2020 07:01:33 +0200
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error
 message
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Allison Randal <allison@lohutok.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Cross <ccross@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
 <87imgai394.fsf@mpe.ellerman.id.au>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a3c158fa-3829-f38a-9202-8984b5ef5f21@web.de>
Date:   Tue, 2 Jun 2020 07:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87imgai394.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tmc1YrdmCshGCD/Q5q5Xc0KQ0HVjn/UW1vFu9dTbM7TncNrhkjU
 zhDaI7SpDjgEVN4wirGuwznGU2hp3/muPxd1zdB0eNLqriXLTIyeRmLv4yQSwnQyxGtYsuT
 8NDYvmUTWfkdvFJoxTYz4Vam1jl8SVzDYhmvnnXhIG4c+vIsW9F17qyPbUMe36MtSPHpQsS
 eRW9zwhlX9NK2pjHF9dXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aGZLdZQ/QRc=:vnEqsY9dpuIRAOez5bVJ6Z
 9hKV9wXdlkwj40H0rCTKMsGWBmfM+NL5v8vTaPZXXlxGwFTI5vKb1TqTkb+9gznuO8cY9DSuT
 T4DYNNBT7j7wcLv0muLQI/G0ct6+XfNrkYAIaB0E3xh4qkzqOhy+7oP0CI/CjGjbgI1GhrPac
 2F3xIZQ49YdmGdLWQb9OPbEnOz2GQhwtjm/hejUn6wLNHM6bvv6GWrcPuVK2VEzfqLs9MJV1/
 nTc+WcNUY/HEBV+0eiuiuobczht6r5YNVj6Z4f+XwPvvBzMtcQULgDTeLolWHIqEtzFL7h/AS
 coylKDRJ1luwQSRtZCnyyzvp4L0D6qXAtXtGC3lDxFdnmn8gk30ZEArV7IgSCh/Ef2wElKJoR
 5fkUhQAs3QQCdh2vFjdplTQOcL/2ZL18+p7shAJdhMRouCymXhmA1XqGu8XGZAG3wZK5Ytyhd
 h83rB6t14Aoba9XLbGb3g5Wu7K/mcdopU4c574qUq3kTQGKVJj/oIuehvY+GAYpgYWPWAAu6V
 JnOnijz8OFKh6fBbgtiNkrbZfrbflhlG0Nmt76mptrG+ZBxfJc6aJffpbeNE1B673IT2bZ6q5
 chBOGxdUyVOVRgxadlMsFSfpRdQOzI1mPiH1yn8t/bwFkHyb6cGdDwAwu7bkAcNC+x0lYrr7P
 DW/S9Yd6oFhnLh6sZdTyN3xuTf9LoOhRfQ+5L37Ro9aufP840YoEg70cUS88c8R/0Bo6ftSFf
 Zb8j2MKwi95GoS0iL73JAdNLI5+7eLHNTSCrj64rcbpRzlnyrPuH5CXFXiLwxcTGB4LZ7SUkV
 eEXYmPKe6rqGe7cZbVIKXigRMDPz3tFEVePWO1NntMyMmLDTFc3g2joZTeAAadJJRs8VcwV0T
 tLlhGkVYDaYoYs4eS5llNEuFhUorZzdLPA5hPz27HPkMszuaRhX0iAcIKPfK1diWpGazBX1sf
 PjES5WdA04ZKjK4F6ajn0+gJNgc8z+tgra91bl4pLs5/ygbTQl/+eV5eQ2obVz/jP0doRA9l9
 COoi4LaFblAvLz+TDH+BH25vnXzfEFxxwkYWvLK0J4lbeQqOjEg1FWeyh3yzRhdK0ms3cHAFN
 VBH/pMT5HGXy8z674NKa8XraduMj27oYubODtm3MxrcMqs7bIzPTRpJJx5y8uCfNu++b7fXw0
 0uDOiI5cltYKkOba0D8PCC7qO7AfyVQ5RWU/VkMex9FXpY1g0xQah/uaIvuRylFOpYzAvohCX
 0dNtPHy8cz7jn/yCa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Please just remove the message instead, it's a tiny allocation that's
>>> unlikely to ever fail, and the caller will print an error anyway.
>>
>> How do you think about to take another look at a previous update sugges=
tion
>> like the following?
>>
>> powerpc/nvram: Delete three error messages for a failed memory allocati=
on
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-8528-d=
011-d3b8-e9355a231d3a@users.sourceforge.net/
>> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a231d=
3a@users.sourceforge.net/
>> https://lore.kernel.org/patchwork/patch/752720/
>> https://lkml.org/lkml/2017/1/19/537
>
> That deleted the messages from nvram_scan_partitions(), but neither of
> the callers of nvram_scan_paritions() check its return value or print
> anything if it fails. So removing those messages would make those
> failures silent which is not what we want.

* How do you think about information like the following?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?id=3Df359287765c04711ff54fbd1164527=
1d8e5ff763#n883
=E2=80=9C=E2=80=A6
These generic allocation functions all emit a stack dump on failure when u=
sed
without __GFP_NOWARN so there is no use in emitting an additional failure
message when NULL is returned.
=E2=80=A6=E2=80=9D

* Would you like to clarify software development concerns around
  the Linux allocation failure report any more?

Regards,
Markus
