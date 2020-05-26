Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41C1BA17A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD0Kix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 06:38:53 -0400
Received: from mout.web.de ([212.227.17.11]:48319 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0Kiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587983904;
        bh=woZ/2CyQJdO+sZ77S3XgZwoofyUa1t3wQRHp1c/DWEg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=JCHUpYFd+nAVdchgNmdwp8lVIT5WXOFwl17pTEAoPlFSjrV9swBjpWOF3m04GPE5E
         LnEKxIDq89gqy3Eg9WC17KWO6bL/BQf9Le3ROw0nS+sM0fZSnyUUM2X/STaUaRwvA6
         4AbcHNHyzDVhxs6UKXZNx+YH185k++jWwb9Cih3A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Lg-1iqKsu2aoW-00puSo; Mon, 27
 Apr 2020 12:38:24 +0200
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: Avoid double lock for cp_rwsem during
 checkpoint
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <07a820a2-b3b3-32ca-75ce-ceaca106d2c6@web.de>
Date:   Mon, 27 Apr 2020 12:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++/Oc5KfkHwauMmC/4Wo1AxKxEs6Q9CoodqX2ixa/jol188TefC
 a2CZdNSc7sKz4v38wKY+WextH9VZpFAAY378DQeaI/gHEJGrTnZ5OG1rHLLXxsREAl0nRsF
 iTg7lfily2eryNJZ97qqMmRu29ri1oRZZaGtIXnrMZr+wHPKrgwqR8nKgnJyf5uWC/KKKfg
 x5/TgR02PQaG+DuRYHa8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cxhf14tGBdE=:JfaUdP9YQJOeuT6d+qHLHu
 ikGONHg/ZjR90X4HWPHvVLTuNrJoXjtEfsDnFTldOwuxqrmruX94F7vr7F+sJI4qHjIortKcQ
 KD5oRTV+fn/MQDtSFX/EiAdbfKzAss7f7vCvS+9IQDUn8RMMy3aDrMYOjGRfGAZilSwLQkRar
 2lzwqgNgELZDXleA/sKq76EynInym9nM56GCsWfaE3Viv0hISj/f6rn9VvXJiC6sH0YEY3E0H
 Hr79qECXrRhmcNBInmN85ockdTuPix18Kn2cpuZHJ4A/sGyz1YxabAPP3rnB1ZZ2FJc1AC6KE
 BZDTjm0LT8bjMOoAtrf5/OxA2U+kIfz9OaP8OaUl+eQsYQjMTGu1bJmbt9gVDdhoSKAYvJVme
 IjYzPajVXWRIi5uHf5sOFXkM1pinhCDhyzl+npQL1h+qVhXCqiok7c2uc4O9N99Ug0TiuyTxg
 itI8BEgRRjVtedZRY9HfkRozaNuvPB1JXm9DTvL/Bm1VO8nR1mtr2yjpESbW/KPbY+y7MnyBV
 3lBJ74O6UOTz/eyDI85bBPyw45sMTZ7dELozm8t7mf6iJnTq5L4ocnuoiU1mKsXgWEDaqWDLJ
 KmFFHxuf3uVrfEsbTwGlxVh+sMX/jBmPG2ZqsMfUQM5iPW31lrFHcUxBGWTIpjvbDPlOTTw++
 GJF5J+c5YP4zyck2qioaSL5x00ckHsqqcxE6UqGgs1fE4heImCrIA5GzZXyyzlZU7LwiWXrhH
 6zGBgFikNd9MYPLr26URsMhCoFXxSfVrkXy6mIgEA+b+kXO0rnnD9qd4GeICuPDFlldahPnR2
 i76QZQfWu9m5j+lsPS5cbdQFdVPwAXCP5ElEndghTBN64PUsNp5PXD/iHnCP+VKvdmJ2XYZZH
 JTAahS3CsKVqeJ3kwJc06i3hVd9oaOqa4WtE3z4QE+tjdCP6VuStdocnpinHCcQ0gzZFpx7yA
 dRjbIs0mpx0CF0AGcHBCnVD81TnqMDvW2p76JTw6gd3qnxFf8vBYp3012Paz6I9M3NXX6oqUv
 kO7is79PRs0bevWVu7UKkkCpWl3t6A8CuNKcLqw12CW07MEL3AsytVUCluAiNobPw4ykL3g3N
 CwAXSmzKMTsDocDi3l8JUOrxZlGj7sDJrIW0kfGNzG9P/HjT6WYouKVuxr6GdLH/2YhMc4h37
 M3H91Xb3+O/PhyPRK7hKBGAn7l8aV/qZ6lLQA6TVDK7OqbEa1qs63d/Jeaj50pQPBZWayksP+
 uC4GsorXEuE9jLEhl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 This results in deadlock as
> iput() tries to hold cp_rwsem, which is already held at the
> beginning by checkpoint->block_operations().

Will another imperative wording become helpful besides the provided inform=
ation
for this change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D6a8b55ed4056ea5559ebe4f6a4=
b247f627870d4c#n151

Would you like to add the tag =E2=80=9CFixes=E2=80=9D because of adjustmen=
ts
for the data synchronisation?

Regards,
Markus
