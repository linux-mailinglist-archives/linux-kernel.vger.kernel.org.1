Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BB1EC7A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCDBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:01:39 -0400
Received: from ozlabs.org ([203.11.71.1]:51817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFCDBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:01:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cDFr0mZBz9sTD;
        Wed,  3 Jun 2020 13:01:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591153296;
        bh=oNX5+B3yN7rD8ZhFo8Gqpc+HpYbEV/fR85vMqUwAnmA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ezkeEDVoIrEXgihjwswT53YYSm9b7aQCc+/JKPjZpEmY1rvyJIiesqBN14sEIS1Nj
         BOp7gC6V9J6tMJj1elQfy6mN714ToP2lD9LDGXcHbBdtwSRmo6gV00sOILCOrQ4A4k
         bqUqjTvGWHvx7dwn2iD5CJjeDExgLjOr29A8ItNC1D6hjHwvCtSp/4zauh4PI30Gui
         vCLInUu5PGr4veb3dqsHKFTMiNW57iveP4Jg4hKKqJXo/qfXy2tBDnfZJvpNh3+zNo
         ofutgsqEpo3kc0rHtz+QIKbMZ/SNf4j/UCv+lmscprOxnTm1URoX1hasM2WsfeBk/N
         fSMMHk1LRk9IQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "wanghai \(M\)" <wanghai38@huawei.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
In-Reply-To: <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de> <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
Date:   Wed, 03 Jun 2020 13:02:00 +1000
Message-ID: <877dwoj1hz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"wanghai (M)" <wanghai38@huawei.com> writes:
> =E5=9C=A8 2020/6/3 1:20, Markus Elfring =E5=86=99=E9=81=93:
>>> Fix it by adding a call to kobject_put() in the error path of
>>> kobject_init_and_add().
>> Thanks for another completion of the exception handling.
>>
>> Would an other patch subject be a bit nicer?
> Thanks for the guidance, I will perfect this description and send a v2
>>
>> =E2=80=A6
>>> +++ b/drivers/misc/cxl/sysfs.c
>>> @@ -624,7 +624,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_=
cr(struct cxl_afu *afu, int c
>>>   	rc =3D kobject_init_and_add(&cr->kobj, &afu_config_record_type,
>>>   				  &afu->dev.kobj, "cr%i", cr->cr);
>>>   	if (rc)
>>> -		goto err;
>>> +		goto err1;
>> =E2=80=A6
>>
>> Can an other label be more reasonable here?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?id=3Df359287765c04711ff54fbd11645271=
d8e5ff763#n465
> I just used the original author's label, should I replace all his labels=
=20
> like'err','err1' with reasonable one.

No.

cheers
