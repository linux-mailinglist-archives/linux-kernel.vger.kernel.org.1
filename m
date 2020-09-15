Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF62D269DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIOFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:42:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:44927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgIOFmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600148561;
        bh=r3Zy9HlAL4mX3fNk1dKMHZdu3L7YVwrK+wA+gsCULAU=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:To:CC:From;
        b=cC4W0GCc3Yb9QMdMJ09cedgWewbzFaSKrnbUvugrL5pmVVwRzDQB/I8d/2J1i7BvL
         lBv+RJ3zhUahX/IAMukCfA3clntSoDGDSprcglRlvYbtWnow2J4khMTZ0QbFwvkcZa
         oDdlpDl9kjrgxDAHJkdjvS2esOrxsx5J/7PuoJpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([80.208.209.101]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1kD9Op2W7C-00CfLB; Tue, 15
 Sep 2020 07:42:41 +0200
Date:   Tue, 15 Sep 2020 07:42:38 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com>
References: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03> <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [question] KBUILD_OUTPUT and modules install (with INSTALL_MOD_PATH)
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <27B16959-58F6-4190-8A65-88FFD2A49452@public-files.de>
X-Provags-ID: V03:K1:9aRRb6YdF+92yGClFII+wr0BXl8PGUkGZCa85D7xavt1AuuOVq8
 WJ2D23uxwi8DsgArZJbUEpkeVE3J3eDjNqtGoTuoGgUGpGHIzPWYxSWaM1+Hsq5ouoz17/B
 LxWTL9FNADRNFfe+reyUYvEtY2kmxXXSQ8XxwIiCCBom0ZYoJclNX3bURZMO7C9hyIwZ50X
 ZYHELE+xDVS0gUcN8xstQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dKy2BiNc+Q=:zQG0Ytb/6w/JmgO+XCWLDe
 dy/k0EqFfPmmnxHv33hN9w6jC7yk+FiNR8/lu1ndS1QXlqgk6RmXTNULjiBARH2NZz18h/REe
 LiSHhG8dOilmxmOh8Uy0yY1RcKB1HEH34HocbJDfgPheTzQW9XXr5TBbZFUWJsqgkN/s/ligL
 V2Z1o/vvDJEOoD0dqSkveau6g32MKnb6ySlm/mwsp+FI9KswtFeL7lO7jSr1Qr6psJ9rJTsbt
 buKuK4juqeDNJlV4IVXdbiYMKbkWtDjHyH4XC92iDfBngtYMIYCPZpC2zKoTsqINIXHyaJr/z
 SliM0stwBfXOmuqMuZolEFZ6YDDI5oKVdn42OX0jSNVpOwkKuXLdrgA4vO7rpNej5lB0SM1+d
 PyTMMNoO8rq87Jv520JnLwiuoB+XrM7B65xVKqEe0lwAciRdsVdRxW1Q0lYI50Qbbi3FJ/LeD
 LorCaukb6JBSVwsVolXl4bfpJzFVsOtBXuc1ac6pYpKXvgFET0S2XbJLo8bgSqihDV99/rjEp
 HaBN4w8cbp/o04vCVMKX7gG2kWmVEcfLqigbvIR79AvYP/EWswaipKsjf9qqWcLwf7UaezWOF
 mUkEtFG3/Q/RVdcsQ/mb3o/+uftmcxNWVDF9plIlxxg6RjbDXNMn2qxtvsbvzpNCJnecOj19G
 cIUc4V2aZwJkiktlUnCiB/+X7tB5h3j8o4F2q0GpS/RRENT6lAoO0Aq3M0zsaH97OiB67+knb
 MqiLLr+RQzgF3239ARHGYcZk0eXJX6K0fg97/PlqVV3y16ZGhVDgGziVHL+8Own2WWLXOZ0F4
 7kdKYBXJZnAJWmPvYCzkrricpbPXKqI+hzQ9hpw1zIkhbIcwa+H0v0BKzRIpaAYd1jOmYNvKr
 QE5IilNkYXzXRN/UH949qjAGBksKwhSbSd7SwJj3SDlkRa+ls8Ae4Bj/0jIyKnNsUm03GJBzd
 ZIy7ohGMKeXpAJYgmSvrS5BVjTlvXVrb3jYUFT37h3NhvttvreS71NwRgGuEs2N/qEmLfPWhv
 2KP8wdK4PrQlYDAHmrHRVeQ924JgMuKt/z4hy3/X2IVeoAuIwGlFFFAzeuXj8lbeJ4f8Jo5YM
 ZaDNB4uVkIb1WW8QHyXFOG3WqEWaSPww0drijfQObhjSk633XDPwA4bul3jtuGZMfwv8cOt3+
 A8l732lh/ic+XgXwJdeEsY2HB/hwMUEjesewCEC9PdRM+oFeaQonN2Y+h8mMz7OLcQcZFUIrE
 /YYTGcsG6L7yy2hk1q0ESeZ5nCjMnaQQA0qK6iA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15=2E September 2020 04:56:55 MESZ schrieb Masahiro Yamada <masahiroy@ke=
rnel=2Eorg>:
>On Tue, Sep 15, 2020 at 2:57 AM Frank Wunderlich

>> i try to use modules_install target after building kernel with
>KBUILD_OUTPUT set
>>
>> KBUILD_OUTPUT: /media/data_nvme/git/kernel/build #kernel source is in
>/media/data_nvme/git/kernel/BPI-R2-4=2E14
>>
>> kernel is build successfully, but i fail on running the make
>modules_install target
>>
>>   ERROR: Kernel configuration is invalid=2E
>>          include/generated/autoconf=2Eh or include/config/auto=2Econf a=
re
>missing=2E
>>          Run 'make oldconfig && make prepare' on kernel src to fix
>it=2E
>>
>> Makefile:648: include/config/auto=2Econf: No such file or directory
>> make: *** [Makefile:719: include/config/auto=2Econf] Error 1
>>
>> it looks it is ignoring the KBUILD_OUTPUT variable, as both files are
>present
>
>
>KBUILD_OUTPUT is an environment variable=2E
>
>Did you set (export) it
>before doing 'make modules_install'?

Yes i exported it before use at beginning of my script [1] and modules_ins=
tall used inside install function [2]=2E It works with build-function [3]=
=2E
As the script is big i linked the relevant parts=2E=2E=2Ei checked KBUILD_=
OUTPUT at beginning of install function so i'm sure it was set

>> $ ls /media/data_nvme/git/kernel/build/include/config/auto=2Econf
>> /media/data_nvme/git/kernel/build/include/config/auto=2Econf
>> $ ls /media/data_nvme/git/kernel/build/include/generated/autoconf=2Eh
>> /media/data_nvme/git/kernel/build/include/generated/autoconf=2Eh


[1] https://github=2Ecom/frank-w/BPI-R2-4=2E14/blob/5=2E9-rc/build=2Esh#L7=
5
[2] https://github=2Ecom/frank-w/BPI-R2-4=2E14/blob/5=2E9-rc/build=2Esh#L3=
68
[3] https://github=2Ecom/frank-w/BPI-R2-4=2E14/blob/5=2E9-rc/build=2Esh#L5=
78
regards Frank
