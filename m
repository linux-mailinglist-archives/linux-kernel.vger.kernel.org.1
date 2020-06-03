Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3281A1EC9B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgFCGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:49:02 -0400
Received: from mout.web.de ([212.227.15.3]:47679 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgFCGs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591166922;
        bh=l6z6rXSohJQNxTJO4LXFLgwbQAynXIiQbBrCdIxi39U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pdkwADUMK4Y9Mf4AsxRCFGx05zcDlO9AXoiDhnMeoY9AyCAXCyhksKjigUkd5fi8e
         SCKQ8B3lOU7dHy7EIfjwi/QsMyaq7WjMPhWyq8jdVEDKYyzo7wUNvTDyN0pLl4TMF5
         obFaLhkVjFknJTFZgGedv3lfoxPZOam2Ac8306bM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1j5ek02SPO-00b3xc; Wed, 03
 Jun 2020 08:48:42 +0200
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wang Hai <wanghai38@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
 <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
 <20200603061443.GB531505@kroah.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75959fca-bb32-53b3-e5ee-ab29dfec34d9@web.de>
Date:   Wed, 3 Jun 2020 08:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603061443.GB531505@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X0otqPNLs3d4XIBvd1pCgkmsqDfodzkaPRNlENp/JNJUzuvYG1b
 uV3lHMdF5Mq3c3IxrdUXB5/Nx1wcNTLkK+kZC87ouA3O9qBgBAs79TNuqVecf3ZHrGsfu3v
 6HfIpxflhZIZcHAmp8+xNZOAwWpgktq8xjdBpY5TZSglB/VfJ2SsxU93Xi9hxTWIJagyUAF
 jVlWc/vfGJ3L1G8xqgJQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E8G8rVXCPBs=:1GHcGfcGFTiVHMfvYITnN+
 bdulW8rUD7jhSm0vW0oJyE1OKJNr2kHapH84ZE8dU2nkwQlP/36O3wmOr6qpumA55cXjFn2uz
 +5fz7kzyfQz5zP/pjH/TLYD8pf8IiaIcFdGWwzDLFrpbCTQFobG1y9nR+cP2eiF1cNxrHkrgl
 WP5iyZm75jC6Q0p9w7iMlnczSsY7h7+e50wef6rR79/AhXxZT5FKsBZyF/Bt/IiIC7DRDgL+1
 0WmuqzzEN8bIBGpP2fEjJa8Fl+2g775O4m3TajM61V5FcMJIHnbr4/BV8aU88njYz+wxPDSLC
 tDd0jhNgyZJb0LNktg8+dWrqmpafWU/HieHhTj/yDQ4wj8cnw+xo/lGRZW3KLpbKsPTjj1EYa
 bhcMAWxaIIrIhvREPBvRk2iiNGtwPKSK9RVj5FMj23wlm/1EwqB5CwUooEFM3kdDJ/NcgOnaq
 JSrv9slZIvt7IHntGr2pT8yPdcUCsquMdryKUD3BgMojSXp51mggTuiMewXVjeBKOi+jxk/tJ
 Op7HB9AU6qbBJ6IILUTtEW01EeVCk9GgSscXV3E44fapG7htfcZmOq0x0oNolMWvZDnTyNCqc
 GkbtXheCGjKzIR+tToKHzqV7OOp51Du41uhtGrkk6l9GZTMjsaFxxo62ug+7boZFeLpYFIDZ2
 TKA+dy22NpDrzYewOoM6jUYc2l870iUuyvPXHEj1uosLG2Z3vg5nDF8vLxDjq/Bu4KvVOOcl1
 RprzCMKGdJH9whUsCJFitmuJeTbLuyqQUWE0n0TLOiMCj7aMfAPRoEsvZwjdmfYXVhCL+flvf
 eXYLK7IH3BZrvsKJskB59tB3sfFl57oBP898R26ly9bll/gyBbHdLg0XInku3KeKqHC8/Mkyu
 55kRd052iZA+WJXAbXoVcp0csqsuxezXwnmlFpmMWC3Prbnvk7WvmuYOuRty1fu3gWjGfXTiZ
 65RKM/5bW1r9tOUrw3ANZ4wXD/MlLr/43XYvAsl92fnUecSG3kVZAkIC/emIoeOR3yxyf2suO
 Uqa1Ya7fOsJw10+viAX41C+B0XXwipL9P44/aaKESgBjIOKleRmJHPT8z+yxhxCQrG5UmUFsh
 Op57DxrCwDJXBGmUlBz9z846iy/fBqVHOkK7XJh8d7WsuGN7bRxpOKltLyA5HHmAxjMIM1bU4
 zx8cLalcoiNAtMThK8obOy5KGm1kgXJ0SblqURsL8dnYQK/narrmDW5jEacM1ncFA9uKfz73z
 HANuKGH37G9A9SANC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please note that you are responding to someone that a lot of kernel
> developers and maintainers have blacklisted as being very annoying

I can understand that you can occasionally become annoyed.


> and not helpful at all.

I got the impression that some contributors (including you)
found also a selection of my contributions useful.


> Please do not feel that you need to respond to, or change any patch in
> response to their emails at all.

I suggest to reconsider your responses to provided information once more.


> I strongly recommend you just add them to your filters to not have to
> see their messages.  That's what I have done.

I find such an =E2=80=9Cadvice=E2=80=9D questionable while it is generally=
 possible
to adjust the communication settings as needed.

Regards,
Markus
